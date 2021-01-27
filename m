Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B983066D8
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 22:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbhA0VyQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Jan 2021 16:54:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:47142 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236464AbhA0VyH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Jan 2021 16:54:07 -0500
IronPort-SDR: pPJdJ7OhKGWm/xDgx8dJSJJgooMULYk+mJ6eAz0oe9fHCI5d/qMqmcNVJPKscHYn4QG1XkwRxz
 SdaWOFZJc8yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="180217730"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="180217730"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:52:24 -0800
IronPort-SDR: gteFvDl2CjPds7XthdSGQbmnnQ47OwYTSe9MJotOb61g2jPaf+hF8uIX/AdjyjLuhRyjeLARr5
 OvCaX20Yu77A==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="357204084"
Received: from johaleryn.amr.corp.intel.com (HELO [10.209.174.152]) ([10.209.174.152])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:52:22 -0800
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
Message-ID: <ee468703-8e36-52dd-ac7a-d2560997a98c@linux.intel.com>
Date:   Wed, 27 Jan 2021 15:52:20 -0600
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

ok, well if you have a consistent failure that's better to some extent.

Maybe a bit of explanations of what this routine tries to do:
when SoundWire is enabled in a system, we need to have the following 
pattern in the DSDT


