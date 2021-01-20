Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DC42FDD78
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 00:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbhATX4b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 18:56:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:60581 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387955AbhATWaM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Jan 2021 17:30:12 -0500
IronPort-SDR: Y/qLBTK+kIc+AJ7cL9+XXO0ain3Hlt39v9bn7nYsJW1DK+nqkmCvs/2ARm6+xqSwWtgrKkxKgk
 AK3L5JQMb2TA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="176612702"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="176612702"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 14:28:26 -0800
IronPort-SDR: A3l+tWrwWD2lDdIHZ9JWJZ3mi0uI5w+xME/wG0yHTwQSnfHvUyJXlZ1Iok3hN6IWeVOo8LrCfu
 aLZ3Uc8uqs2g==
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="356220083"
Received: from bmetsx-mobl1.amr.corp.intel.com (HELO [10.209.108.15]) ([10.209.108.15])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 14:28:25 -0800
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux
 5.10
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?Marcin_=c5=9alusarz?= <marcin.slusarz@gmail.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Len Brown <lenb@kernel.org>
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com>
Date:   Wed, 20 Jan 2021 16:28:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org




>> Linux 5.10 fails to boot on my IceLake laptop, where 5.9 worked fine.
>> I'm not sure whether it's a bug in ACPI or Soundwire subsystem, so I'm
>> sending this to both
>> lists. The W taint flag is because of an unrelated nouveau failure (It
>> was busted on 5.9, and is
>> still on 5.10). Full kernel log down below.
>> It's from a distro kernel, but I can build my own kernel with patches if needed.
> 
> Please try to add a check for handle against NULL to
> snd_intel_dsp_check_soundwire() after
> 
> handle = ACPI_HANDLE(&pci->dev);
> 
> and see if this makes any difference.
> 
> This should check handle against NULL anyway, even if it didn't crash later on.

Is there a way you can share the DSDT?

The only thing we do in that sdw_intel_acpi_scan() function is check for 
an _ADR and read two _DSD properties. I think it's been 2 years since we 
wrote it and never had an issue, never say never I guess...

If you want to bypass this problem for the time being, you can add a 
kernel option in /etc/modprobe.d/alsa-base.conf

options snd-intel-dspcfg dsp_driver=1

that will force the use of the HDaudio legacy driver and bypass the 
driver autodetection.
