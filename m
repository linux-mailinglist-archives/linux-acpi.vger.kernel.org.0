Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED367C248
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2019 14:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfGaMxg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Jul 2019 08:53:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:52492 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbfGaMxg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 Jul 2019 08:53:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 512F7AFEC;
        Wed, 31 Jul 2019 12:53:35 +0000 (UTC)
Date:   Wed, 31 Jul 2019 14:53:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] drivers/acpi/scan.c: Fixup "acquire
 device_hotplug_lock in acpi_scan_init()"
Message-ID: <20190731125334.GM9330@dhcp22.suse.cz>
References: <20190731123201.13893-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731123201.13893-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed 31-07-19 14:32:01, David Hildenbrand wrote:
> Let's document why we take the lock here. If we're going to overhaul
> memory hotplug locking, we'll have to touch many places - this comment
> will help to clairfy why it was added here.

And how exactly is "lock for consistency" comment going to help the poor
soul touching that code? How do people know that it is safe to remove it?
I am not going to repeat my arguments how/why I hate "locking for
consistency" (or fun or whatever but a real synchronization reasons)
but if you want to help then just explicitly state what should done to
remove this lock.

> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/acpi/scan.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index cbc9d64b48dd..9193f1d46148 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2204,6 +2204,11 @@ int __init acpi_scan_init(void)
>  	acpi_gpe_apply_masked_gpes();
>  	acpi_update_all_gpes();
>  
> +	/*
> +	 * We end up calling __add_memory(), which expects the
> +	 * device_hotplug_lock to be held. Races with userspace and other
> +	 * hotplug activities are not really possible - lock for consistency.
> +	 */
>  	lock_device_hotplug();
>  	mutex_lock(&acpi_scan_lock);
>  
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
