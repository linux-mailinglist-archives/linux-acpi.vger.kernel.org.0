Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307767E064
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2019 18:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfHAQmo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Aug 2019 12:42:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:27139 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729082AbfHAQmo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Aug 2019 12:42:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 09:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,334,1559545200"; 
   d="scan'208";a="324299006"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.145.65]) ([10.249.145.65])
  by orsmga004.jf.intel.com with ESMTP; 01 Aug 2019 09:42:37 -0700
Subject: Re: [PATCH v1] drivers/acpi/scan.c: Document why we don't need the
 device_hotplug_lock
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190731135306.31524-1-david@redhat.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <cf1b5664-af9f-2c0e-3c84-473dd18cb285@intel.com>
Date:   Thu, 1 Aug 2019 18:42:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731135306.31524-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 7/31/2019 3:53 PM, David Hildenbrand wrote:
> Let's document why the lock is not needed in acpi_scan_init(), right now
> this is not really obvious.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> ---
>
> @Andrew, can you drop "drivers/acpi/scan.c: acquire device_hotplug_lock in
> acpi_scan_init()" and add this patch instead? Thanks
>
> ---
>   drivers/acpi/scan.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 0e28270b0fd8..8444af6cd514 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2204,6 +2204,12 @@ int __init acpi_scan_init(void)
>   	acpi_gpe_apply_masked_gpes();
>   	acpi_update_all_gpes();
>   
> +	/*
> +	 * Although we call__add_memory() that is documented to require the
> +	 * device_hotplug_lock, it is not necessary here because this is an
> +	 * early code when userspace or any other code path cannot trigger
> +	 * hotplug/hotunplug operations.
> +	 */
>   	mutex_lock(&acpi_scan_lock);
>   	/*
>   	 * Enumerate devices in the ACPI namespace.


