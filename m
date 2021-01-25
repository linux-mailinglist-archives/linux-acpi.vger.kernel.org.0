Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C06303185
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 02:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbhAYT3S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 14:29:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:32117 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731885AbhAYT2T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:28:19 -0500
IronPort-SDR: 4lhUEB5TGtOBA0ofmr2YM1/niq99NpVYiMwHW9Vlr5hZOoTxAdoVWk+5woZw4T4A0eSQoJvno1
 fiP6hNRC2gMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="167463005"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="167463005"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:26:26 -0800
IronPort-SDR: i0giKRscpjDIzWE8QSyp/tHZLHCQLXmt1z//xPjprBTAb7DxkFQCIoJxRjQ2jQ1LCJG8MhYsRx
 Kh6JLFqH0r9A==
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="572656872"
Received: from rrusnak-mobl2.amr.corp.intel.com (HELO [10.212.246.231]) ([10.212.246.231])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:26:25 -0800
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux
 5.10
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?Q?Marcin_=c5=9alusarz?= <marcin.slusarz@gmail.com>,
        Kubo Hiroshi <hkubo@jiubao.jp>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com>
 <YA8QM98xrHyefa7g@eldamar.lan>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fb2808ba-d5e5-8d8f-1ba2-c7a94be805e8@linux.intel.com>
Date:   Mon, 25 Jan 2021 13:26:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YA8QM98xrHyefa7g@eldamar.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


>>>> Linux 5.10 fails to boot on my IceLake laptop, where 5.9 worked fine.
>>>> I'm not sure whether it's a bug in ACPI or Soundwire subsystem, so I'm
>>>> sending this to both
>>>> lists. The W taint flag is because of an unrelated nouveau failure (It
>>>> was busted on 5.9, and is
>>>> still on 5.10). Full kernel log down below.
>>>> It's from a distro kernel, but I can build my own kernel with patches if needed.
>>>
>>> Please try to add a check for handle against NULL to
>>> snd_intel_dsp_check_soundwire() after
>>>
>>> handle = ACPI_HANDLE(&pci->dev);
>>>
>>> and see if this makes any difference.
>>>
>>> This should check handle against NULL anyway, even if it didn't crash later on.
>>
>> Is there a way you can share the DSDT?
>>
>> The only thing we do in that sdw_intel_acpi_scan() function is check for an
>> _ADR and read two _DSD properties. I think it's been 2 years since we wrote
>> it and never had an issue, never say never I guess...
>>
>> If you want to bypass this problem for the time being, you can add a kernel
>> option in /etc/modprobe.d/alsa-base.conf
>>
>> options snd-intel-dspcfg dsp_driver=1
>>
>> that will force the use of the HDaudio legacy driver and bypass the driver
>> autodetection.
> 
> A user in Debian,  Kubo Hiroshi reported what seems to be the same
> issue in https://bugs.debian.org/981003 .

Thanks for connecting the dots.

I can only suggest the following patch, similar to what Rafael suggested 
but this time done inside of the sdw_intel_acpi_scan() function which 
has multiple users.

I still don't see what happens though, the code in drivers/acpi seems to 
already check for bad pointers?


diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index cabdadb09a1b..91f57f75a9e2 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -405,6 +405,9 @@ int sdw_intel_acpi_scan(acpi_handle *parent_handle,
  {
         acpi_status status;

+       if (!parent_handle)
+               return -ENODEV;
+
         status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
                                      parent_handle, 1,
                                      sdw_intel_acpi_cb,
