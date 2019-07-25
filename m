Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E247499C
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2019 11:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390246AbfGYJLI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 05:11:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62047 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389193AbfGYJLI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jul 2019 05:11:08 -0400
Received: from 79.184.253.188.ipv4.supernova.orange.pl (79.184.253.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 487a086af6bce042; Thu, 25 Jul 2019 11:11:05 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v1] ACPI / scan: Acquire device_hotplug_lock in acpi_scan_init()
Date:   Thu, 25 Jul 2019 11:11:05 +0200
Message-ID: <2247325.5bJu2Pzk7V@kreacher>
In-Reply-To: <20190724143017.12841-1-david@redhat.com>
References: <20190724143017.12841-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, July 24, 2019 4:30:17 PM CEST David Hildenbrand wrote:
> We end up calling __add_memory() without the device hotplug lock held.
> (I used a local patch to assert in __add_memory() that the
>  device_hotplug_lock is held - I might upstream that as well soon)
> 
> [   26.771684]        create_memory_block_devices+0xa4/0x140
> [   26.772952]        add_memory_resource+0xde/0x200
> [   26.773987]        __add_memory+0x6e/0xa0
> [   26.775161]        acpi_memory_device_add+0x149/0x2b0
> [   26.776263]        acpi_bus_attach+0xf1/0x1f0
> [   26.777247]        acpi_bus_attach+0x66/0x1f0
> [   26.778268]        acpi_bus_attach+0x66/0x1f0
> [   26.779073]        acpi_bus_attach+0x66/0x1f0
> [   26.780143]        acpi_bus_scan+0x3e/0x90
> [   26.780844]        acpi_scan_init+0x109/0x257
> [   26.781638]        acpi_init+0x2ab/0x30d
> [   26.782248]        do_one_initcall+0x58/0x2cf
> [   26.783181]        kernel_init_freeable+0x1bd/0x247
> [   26.784345]        kernel_init+0x5/0xf1
> [   26.785314]        ret_from_fork+0x3a/0x50
> 
> So perform the locking just like in acpi_device_hotplug().
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/scan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 0e28270b0fd8..cbc9d64b48dd 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2204,7 +2204,9 @@ int __init acpi_scan_init(void)
>  	acpi_gpe_apply_masked_gpes();
>  	acpi_update_all_gpes();
>  
> +	lock_device_hotplug();
>  	mutex_lock(&acpi_scan_lock);
> +
>  	/*
>  	 * Enumerate devices in the ACPI namespace.
>  	 */
> @@ -2232,6 +2234,7 @@ int __init acpi_scan_init(void)
>  
>   out:
>  	mutex_unlock(&acpi_scan_lock);
> +	unlock_device_hotplug();
>  	return result;
>  }
>  
> 




