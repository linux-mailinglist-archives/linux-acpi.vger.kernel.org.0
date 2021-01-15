Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20052F7EA2
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 15:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbhAOOyl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 09:54:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:8787 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbhAOOyk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 09:54:40 -0500
IronPort-SDR: d7lLysapGMcgvycqAHejactvKHX+QdmZv0RzmZYlc9a98kUgLkEN6DhNdD8aMFs08NF2TLJ2kt
 uv7oOrN2oO5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="165642430"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="165642430"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 06:52:54 -0800
IronPort-SDR: gCB9JG1048TU9p7aPAL+ZFO040M4t5L5Ucft7L6K2SrIjEiO+oWVa/17W3jonvu03UfQVyJloV
 aRQCCFcI0Luw==
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="364602100"
Received: from kshimanx-mobl.amr.corp.intel.com (HELO [10.212.104.192]) ([10.212.104.192])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 06:52:53 -0800
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
 <f5dae2aa-ffcb-1af1-726f-2362cb4fe470@redhat.com>
 <1bb7f766-4f29-55b1-882c-3d70cca0912f@linux.intel.com>
 <2473340.5W3TeCB90J@kreacher>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b56e75b7-2cdb-dd82-e9eb-f05414b8a970@linux.intel.com>
Date:   Fri, 15 Jan 2021 08:52:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2473340.5W3TeCB90J@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


>> Yep, those 'hacks' solve the boot problem on my device. I tried multiple
>> times and it's completely reproducible.
>>
>>> And can you collect an acpidump from the device and either send it to me and Rafael
>>> offlist, or upload it somewhere and send us a link ?
>>
>> will do
> 
> In addition to what Hans asked for, can you please build the kernel with the
> debug patch below applied (instead of the Hans' debug patch), try to boot
> the affected machine with it and see what is missing with respect to booting
> the kernel with the two problematic commits reverted?

Sorry, not following. Are you asking me to apply the patch below as well 
as revert the two problematic commits? Or just the patch below? the boot 
process is stuck without the reverts and I don't have a serial link to 
see what happens (closed form-factor).

> Also please send me the outout of "dmesg | grep "Enumeration" from the debug
> kernel if possible. >
> ---
>   drivers/acpi/scan.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -1951,7 +1951,7 @@ static acpi_status acpi_bus_check_add(ac
>   		u32 count = acpi_scan_check_dep(handle);
>   		/* Bail out if the number of recorded dependencies is not 0. */
>   		if (count > 0) {
> -			acpi_bus_scan_second_pass = true;
> +			acpi_handle_info(handle, "Enumeration skipped\n");
>   			return AE_CTRL_DEPTH;
>   		}
>   	}
> 
> 
> 
