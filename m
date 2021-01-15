Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094042F6FB9
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 01:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbhAOAvF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 19:51:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:23796 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbhAOAvF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Jan 2021 19:51:05 -0500
IronPort-SDR: UjksUBTRA6D8cXayADgN4xyAjko/ZEGVjhS5jVpM982Tvvz1hvUtuIT7uSd8I1S5VX2kwuKdrk
 pbrWYWojcmrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="178621991"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="178621991"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 16:49:18 -0800
IronPort-SDR: Ny+OMpEp9ARenQIrU7vKWrxwDSHsbuS4D2oMd/aFvwYl98w47Pt8J8i1FZe2+eKEuFXJJpqVIA
 qpUAhCdViOhQ==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="382468188"
Received: from vartikad-mobl1.amr.corp.intel.com (HELO [10.209.161.204]) ([10.209.161.204])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 16:49:18 -0800
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
To:     Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
 <f5dae2aa-ffcb-1af1-726f-2362cb4fe470@redhat.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1bb7f766-4f29-55b1-882c-3d70cca0912f@linux.intel.com>
Date:   Thu, 14 Jan 2021 18:49:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f5dae2aa-ffcb-1af1-726f-2362cb4fe470@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks Hans for your reply, much appreciated.

> Pierre-Louis, can you see if the following hack helps? :
> 
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1939,7 +1939,6 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
>   		/* Bail out if the number of recorded dependencies is not 0. */
>   		if (count > 0) {
>   			acpi_bus_scan_second_pass = true;
> -			return AE_CTRL_DEPTH;
>   		}
>   	}
>   
> @@ -1948,8 +1947,7 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
>   		return AE_CTRL_DEPTH;
>   
>   	acpi_scan_init_hotplug(device);
> -	if (!check_dep)
> -		acpi_scan_dep_init(device);
> +	acpi_scan_dep_init(device);
>   
>   out:
>   	if (!*adev_p)

Yep, those 'hacks' solve the boot problem on my device. I tried multiple 
times and it's completely reproducible.

> And can you collect an acpidump from the device and either send it to me and Rafael
> offlist, or upload it somewhere and send us a link ?

will do

