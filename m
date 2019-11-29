Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC810D4A5
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2019 12:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfK2LWZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Nov 2019 06:22:25 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51527 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2LWZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Nov 2019 06:22:25 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id b29f2c71f89a9fef; Fri, 29 Nov 2019 12:22:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Francesco Ruggeri <fruggeri@arista.com>
Cc:     lenb@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH] ACPI: only free map once in osl.c
Date:   Fri, 29 Nov 2019 12:22:22 +0100
Message-ID: <8856261.HbOvkYAHpl@kreacher>
In-Reply-To: <20191120054728.0979695C0FE4@us180.sjc.aristanetworks.com>
References: <20191120054728.0979695C0FE4@us180.sjc.aristanetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, November 20, 2019 6:47:27 AM CET Francesco Ruggeri wrote:
> acpi_os_map_cleanup checks map->refcount outside of acpi_ioremap_lock
> before freeing the map. This creates a race condition the can result
> in the map being freed more than once.
> A panic can be caused by running
> 
> for ((i=0; i<10; i++))
> do
>         for ((j=0; j<100000; j++))
>         do
>                 cat /sys/firmware/acpi/tables/data/BERT >/dev/null
>         done &
> done
> 
> This patch makes sure that only the process that drops the reference
> to 0 does the freeing.
> 
> Fixes: b7c1fadd6c2e ("ACPI: Do not use krefs under a mutex in osl.c")
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> ---
>  drivers/acpi/osl.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index a2e844a8e9ed..41168c027a5a 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -374,19 +374,21 @@ void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
>  }
>  EXPORT_SYMBOL_GPL(acpi_os_map_memory);
>  
> -static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
> +/* Must be called with mutex_lock(&acpi_ioremap_lock) */
> +static unsigned long acpi_os_drop_map_ref(struct acpi_ioremap *map)
>  {
> -	if (!--map->refcount)
> +	unsigned long refcount = --map->refcount;
> +
> +	if (!refcount)
>  		list_del_rcu(&map->list);
> +	return refcount;
>  }
>  
>  static void acpi_os_map_cleanup(struct acpi_ioremap *map)
>  {
> -	if (!map->refcount) {
> -		synchronize_rcu_expedited();
> -		acpi_unmap(map->phys, map->virt);
> -		kfree(map);
> -	}
> +	synchronize_rcu_expedited();
> +	acpi_unmap(map->phys, map->virt);
> +	kfree(map);
>  }
>  
>  /**
> @@ -406,6 +408,7 @@ static void acpi_os_map_cleanup(struct acpi_ioremap *map)
>  void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
>  {
>  	struct acpi_ioremap *map;
> +	unsigned long refcount;
>  
>  	if (!acpi_permanent_mmap) {
>  		__acpi_unmap_table(virt, size);
> @@ -419,10 +422,11 @@ void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
>  		WARN(true, PREFIX "%s: bad address %p\n", __func__, virt);
>  		return;
>  	}
> -	acpi_os_drop_map_ref(map);
> +	refcount = acpi_os_drop_map_ref(map);
>  	mutex_unlock(&acpi_ioremap_lock);
>  
> -	acpi_os_map_cleanup(map);
> +	if (!refcount)
> +		acpi_os_map_cleanup(map);
>  }
>  EXPORT_SYMBOL_GPL(acpi_os_unmap_iomem);
>  
> @@ -457,6 +461,7 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
>  {
>  	u64 addr;
>  	struct acpi_ioremap *map;
> +	unsigned long refcount;
>  
>  	if (gas->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
>  		return;
> @@ -472,10 +477,11 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
>  		mutex_unlock(&acpi_ioremap_lock);
>  		return;
>  	}
> -	acpi_os_drop_map_ref(map);
> +	refcount = acpi_os_drop_map_ref(map);
>  	mutex_unlock(&acpi_ioremap_lock);
>  
> -	acpi_os_map_cleanup(map);
> +	if (!refcount)
> +		acpi_os_map_cleanup(map);
>  }
>  EXPORT_SYMBOL(acpi_os_unmap_generic_address);
>  
> 

Applying as a stable-candidate fix for 5.5, thanks!



