Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7642F7FD9
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 16:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733158AbhAOPkN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 10:40:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:53935 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbhAOPkN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 10:40:13 -0500
IronPort-SDR: s4UpF3H+/GA2C1naRdDOVZXzja1dxRTwrw9dxSFL+BKp4Nf3TH95s1PymsZsbl56Fhstjw5zvk
 7fzWrDXO60Pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177786594"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="177786594"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 07:38:19 -0800
IronPort-SDR: P4KPIAr93gd+4KB6o4nh4Mu2DwYpbC4gwymI77auN/jfgVWf+QMzX/JO4SxRpMgvctBunTD8MF
 kXs8jTxYMF5g==
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="364613431"
Received: from kshimanx-mobl.amr.corp.intel.com (HELO [10.212.104.192]) ([10.212.104.192])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 07:38:18 -0800
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
 <CAJZ5v0i63MsXX18rat7XfxUHBsc_OKD1nZvdv07WytgNP7+mtQ@mail.gmail.com>
 <c27b98bf-c829-e128-cb74-149b14028a22@linux.intel.com>
 <10742637.M1KgVVZ4YP@kreacher>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8ca863bc-f312-8757-5f03-5364a691a860@linux.intel.com>
Date:   Fri, 15 Jan 2021 09:38:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <10742637.M1KgVVZ4YP@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


> This means that skipping the enumeration of a certain device alone is
> problematic which is a surprise of sorts.
> 
> Let's see what device that may be.
> 
> Because the machine booted with the debug patch from Hans, it should also boot
> with the one below, so please do that and send the output of
> 
> $ dmesg | grep Dependencies

Yep, boot success with that patch :-)

root@plb-Zotac:~# dmesg | grep Dependencies
[    0.426722] ACPI: \_SB_.PCI0.SDHB: Dependencies found
[    0.427927] ACPI: \_SB_.PCI0.SDHB.BRCM: Dependencies found
[    0.431863] ACPI: \_SB_.PCI0.SDHC: Dependencies found
[    0.433128] ACPI: \_SB_.PCI0.SHC1: Dependencies found
[    0.466328] ACPI: \_SB_.PCI0.I2C1.BATC: Dependencies found
[    0.478490] ACPI: \_SB_.PCI0.I2C3.TIDR: Dependencies found
[    0.479851] ACPI: \_SB_.PCI0.I2C3.ABAT: Dependencies found
[    0.480756] ACPI: \_SB_.PCI0.I2C4: Dependencies found
[    0.482605] ACPI: \_SB_.PCI0.I2C4.CA10: Dependencies found
[    0.484464] ACPI: \_SB_.PCI0.I2C4.CAM9: Dependencies found
[    0.485769] ACPI: \_SB_.PCI0.I2C4.CAM3: Dependencies found
[    0.487187] ACPI: \_SB_.PCI0.I2C4.CAM4: Dependencies found
[    0.490563] ACPI: \_SB_.PCI0.I2C6.TCS0: Dependencies found
[    0.492673] ACPI: \_SB_.PCI0.I2C6.SYN1: Dependencies found
[    0.494923] ACPI: \_SB_.PCI0.I2C7.PMI1: Dependencies found
[    0.496528] ACPI: \_SB_.PCI0.I2C7.PMI2: Dependencies found
[    0.498111] ACPI: \_SB_.PCI0.I2C7.PMI5: Dependencies found
[    0.499909] ACPI: \_SB_.PCI0.I2C7.PMIF: Dependencies found
[    0.500891] ACPI: \_SB_.PCI0.I2C7.PMIC: Dependencies found
[    0.502822] ACPI: \_SB_.PCI0.I2C7.BMDR: Dependencies found
[    0.504333] ACPI: \_SB_.PCI0.I2C7.WIDR: Dependencies found
[    0.505689] ACPI: \_SB_.PCI0.I2C7.BATC: Dependencies found
[    0.509734] ACPI: \_SB_.PCI0.AMCR: Dependencies found
[    0.510715] ACPI: \_SB_.PCI0.TIMC: Dependencies found
[    0.516336] ACPI: \_SB_.PCI0.BRCM: Dependencies found
[    0.517490] ACPI: \_SB_.PCI0.LNPW: Dependencies found
[    0.531940] ACPI: \_SB_.WLCH: Dependencies found
[    0.532866] ACPI: \_SB_.WCH2: Dependencies found
[    0.533927] ACPI: \_SB_.FLDM: Dependencies found
[    0.541033] ACPI: \_SB_.BTNS: Dependencies found
[    0.543079] ACPI: \_SB_.TBAD: Dependencies found
[    0.549169] ACPI: \_SB_.UBTC: Dependencies found

I can run more tests as needed.

> ---
>   drivers/acpi/scan.c |    9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -1950,10 +1950,8 @@ static acpi_status acpi_bus_check_add(ac
>   	if (type == ACPI_BUS_TYPE_DEVICE && check_dep) {
>   		u32 count = acpi_scan_check_dep(handle);
>   		/* Bail out if the number of recorded dependencies is not 0. */
> -		if (count > 0) {
> -			acpi_bus_scan_second_pass = true;
> -			return AE_CTRL_DEPTH;
> -		}
> +		if (count > 0)
> +			acpi_handle_info(handle, "Dependencies found\n");
>   	}
>   
>   	acpi_add_single_object(&device, handle, type, sta);
> @@ -1961,8 +1959,7 @@ static acpi_status acpi_bus_check_add(ac
>   		return AE_CTRL_DEPTH;
>   
>   	acpi_scan_init_hotplug(device);
> -	if (!check_dep)
> -		acpi_scan_dep_init(device);
> +	acpi_scan_dep_init(device);
>   
>   out:
>   	if (!*adev_p)
> 
> 
> 
