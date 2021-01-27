Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D123066FD
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 23:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbhA0WFM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 17:05:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:5578 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235066AbhA0WEZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Jan 2021 17:04:25 -0500
IronPort-SDR: CMYQ2hmg0ZGB52R86tcZ5jBt0eO3f0HNWGUtNiITpPuvi+Ls1G8E14DvpPYk2zVTIAvSK+MxVz
 4Bwev6VElrDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="241669756"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="241669756"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 14:02:31 -0800
IronPort-SDR: i6F2gvM/6kh4rOtFpRty7DdNRR50gCxMPh7CIJN3lr4amk2x6aV+e5xOImusTA0cvWFdaxJKC4
 EWZ6/3SWpDxQ==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="430259811"
Received: from sschwenc-mobl.amr.corp.intel.com (HELO [10.209.87.195]) ([10.209.87.195])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 14:02:30 -0800
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux
 5.10
To:     =?UTF-8?Q?Marcin_=c5=9alusarz?= <marcin.slusarz@gmail.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com>
 <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
 <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com>
 <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <709fa03c-43b7-45e4-3ddc-aae0d8f4ced4@linux.intel.com>
Date:   Wed, 27 Jan 2021 16:02:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 1/27/21 1:18 PM, Marcin Ślusarz wrote:
> śr., 27 sty 2021 o 18:28 Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> napisał(a):
>>> Weird, I can't reproduce this problem with my self-compiled kernel :/
>>> I don't even see soundwire modules loaded in. Manually loading them of course
>>> doesn't do much.
>>>
>>> Previously I could boot into the "faulty" kernel by using "recovery mode", but
>>> I can't do that anymore - it crashes too.
>>>
>>> Maybe there's some kind of race and this bug depends on some specific
>>> ordering of events?
>>
>> missing Kconfig?
>> You need CONFIG_SOUNDWIRE and CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE
>> selected to enter this sdw_intel_acpi_scan() routine.
> 
> It was a PEBKAC, but a slightly different one. I won't bore you with
> (embarrassing) details ;).
> 
> I reproduced the problem, tested both your and Rafael's patches
> and the kernel still crashes, with the same stack trace.
> (Yes, I'm sure I booted the right kernel :)
> 
> Why "recovery mode" stopped working (or worked previously) is still a mystery.
> 

Thanks Marcin for the information. If you have a consistent failure 
that's better to some extent.

Maybe a bit of explanation of what this routine tries to do:
when SoundWire is enabled in a system, we need to have the following 
pattern in the DSDT:

     Scope (_SB.PCI0)
     {
         Device (HDAS)
         {
             Name (_ADR, 0x001F0003)  // _ADR: Address
         }


         Scope (HDAS)
         {
             Device (SNDW)
             {
                 Name (_ADR, 0x40000000)  // _ADR: Address

The only thing the code does is to walk through the children and check 
if the valid _ADR 0x40000000 is found.

You don't have SoundWire in your device so there should not be any 
children found. I don't see anything in the DSDT that looks like 
_SB.PCI0.HDAS.<something>, so in theory we should not even enter the 
callback.

The error happens in acpi_bus_get_device(), after we read the adr but 
before we check it, so wondering if we shouldn't revert the checks. Can 
you try the diff below? I am not sure why there is a crash and we should 
root-cause this issue, just trying to triangulate what is happening.

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index cabdadb09a1b..6bc87a682fb3 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -369,13 +369,6 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle 
handle, u32 level,
         if (ACPI_FAILURE(status))
                 return AE_OK; /* keep going */

-       if (acpi_bus_get_device(handle, &adev)) {
-               pr_err("%s: Couldn't find ACPI handle\n", __func__);
-               return AE_NOT_FOUND;
-       }
-
-       info->handle = handle;
-
         /*
          * On some Intel platforms, multiple children of the HDAS
          * device can be found, but only one of them is the SoundWire
@@ -386,6 +379,13 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle 
handle, u32 level,
         if (FIELD_GET(GENMASK(31, 28), adr) != SDW_LINK_TYPE)
                 return AE_OK; /* keep going */

+       if (acpi_bus_get_device(handle, &adev)) {
+               pr_err("%s: Couldn't find ACPI handle\n", __func__);
+               return AE_NOT_FOUND;
+       }
+
+       info->handle = handle;
+
         /* device found, stop namespace walk */
         return AE_CTRL_TERMINATE;
  }


