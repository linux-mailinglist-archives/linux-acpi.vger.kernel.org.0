Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33D62F7F1A
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 16:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbhAOPKz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 10:10:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:45721 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbhAOPKz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 10:10:55 -0500
IronPort-SDR: QSO87n7qx17SJWpj8KCgxdhiYOsIiaruuqpug9mlsnI9JIDP+oiGkzmvgfkuH2/VVH1p1Zth7D
 mJgQYbfOgw3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="175979849"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="175979849"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 07:09:08 -0800
IronPort-SDR: lsLaKNfM1a2mlZdYlAnKgxBIQnZQsj23CM3yyHc3GLqIE50X9hoJJ1huW4vByCiQSHTVY3tXqq
 ae0/CnacrtWA==
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="364605352"
Received: from kshimanx-mobl.amr.corp.intel.com (HELO [10.212.104.192]) ([10.212.104.192])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 07:09:07 -0800
Subject: Re: ACPI scan regression -> Boot fail on Cherrytrail w/ 5.11-rc3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <792c89fd-88f2-b243-50df-21f3be1cc20c@linux.intel.com>
 <f5dae2aa-ffcb-1af1-726f-2362cb4fe470@redhat.com>
 <1bb7f766-4f29-55b1-882c-3d70cca0912f@linux.intel.com>
 <2473340.5W3TeCB90J@kreacher>
 <b56e75b7-2cdb-dd82-e9eb-f05414b8a970@linux.intel.com>
 <CAJZ5v0i63MsXX18rat7XfxUHBsc_OKD1nZvdv07WytgNP7+mtQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c27b98bf-c829-e128-cb74-149b14028a22@linux.intel.com>
Date:   Fri, 15 Jan 2021 09:09:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i63MsXX18rat7XfxUHBsc_OKD1nZvdv07WytgNP7+mtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org




>>> In addition to what Hans asked for, can you please build the kernel with the
>>> debug patch below applied (instead of the Hans' debug patch), try to boot
>>> the affected machine with it and see what is missing with respect to booting
>>> the kernel with the two problematic commits reverted?
>>
>> Sorry, not following. Are you asking me to apply the patch below as well
>> as revert the two problematic commits? Or just the patch below?
> 
> Just the patch below.
> 
>> the boot process is stuck without the reverts and I don't have a serial link to
>> see what happens (closed form-factor).
> 
> The point is that the patch below may unstuck it, in which case it
> should be possible to find out what is missing with respect to the
> full successful boot.

No luck. I tried twice with the patch below only, and the device is 
still stuck after the 'Loading initial ramdisk ...'.

>>> Also please send me the outout of "dmesg | grep "Enumeration" from the debug
>>> kernel if possible. >
>>> ---
>>>    drivers/acpi/scan.c |    2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Index: linux-pm/drivers/acpi/scan.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/scan.c
>>> +++ linux-pm/drivers/acpi/scan.c
>>> @@ -1951,7 +1951,7 @@ static acpi_status acpi_bus_check_add(ac
>>>                u32 count = acpi_scan_check_dep(handle);
>>>                /* Bail out if the number of recorded dependencies is not 0. */
>>>                if (count > 0) {
>>> -                     acpi_bus_scan_second_pass = true;
>>> +                     acpi_handle_info(handle, "Enumeration skipped\n");
>>>                        return AE_CTRL_DEPTH;
>>>                }
>>>        }
>>>
>>>
>>>
