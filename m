Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616F87C4A6
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2019 16:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfGaORG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Jul 2019 10:17:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:50484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726308AbfGaORG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 Jul 2019 10:17:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23B6BAE5C;
        Wed, 31 Jul 2019 14:17:05 +0000 (UTC)
Date:   Wed, 31 Jul 2019 16:17:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] drivers/acpi/scan.c: Document why we don't need the
 device_hotplug_lock
Message-ID: <20190731141704.GW9330@dhcp22.suse.cz>
References: <20190731135306.31524-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731135306.31524-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed 31-07-19 15:53:06, David Hildenbrand wrote:
> Let's document why the lock is not needed in acpi_scan_init(), right now
> this is not really obvious.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> 
> @Andrew, can you drop "drivers/acpi/scan.c: acquire device_hotplug_lock in
> acpi_scan_init()" and add this patch instead? Thanks
> 
> ---
>  drivers/acpi/scan.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 0e28270b0fd8..8444af6cd514 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2204,6 +2204,12 @@ int __init acpi_scan_init(void)
>  	acpi_gpe_apply_masked_gpes();
>  	acpi_update_all_gpes();
>  
> +	/*
> +	 * Although we call__add_memory() that is documented to require the
> +	 * device_hotplug_lock, it is not necessary here because this is an
> +	 * early code when userspace or any other code path cannot trigger
> +	 * hotplug/hotunplug operations.
> +	 */
>  	mutex_lock(&acpi_scan_lock);
>  	/*
>  	 * Enumerate devices in the ACPI namespace.
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
