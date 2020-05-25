Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146721E066E
	for <lists+linux-acpi@lfdr.de>; Mon, 25 May 2020 07:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgEYFhq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 May 2020 01:37:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:53367 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgEYFhq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 May 2020 01:37:46 -0400
IronPort-SDR: tOBUyPM3SVUX5mNMEQ7+Hpdhb+XAMP0opzEk0JB0ofpO/rpiZT7KZjIM3eBNzuqpwuaIkJBA/o
 lraVb46279FQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 22:37:45 -0700
IronPort-SDR: AcVv4NNkPGvbxc5a6d3hBCYUPSCcrYoZQXZJN8VUjxqjPNT+Fvg3Bn2t4bGw2cTV/t91GASekL
 1FWM7JzFoNtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,432,1583222400"; 
   d="scan'208";a="467861247"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by fmsmga005.fm.intel.com with ESMTP; 24 May 2020 22:37:42 -0700
Subject: Re: Low Latency Tolerance preventing Intel Package from entering deep
 sleep states
To:     "larsh@apache.org" <larsh@apache.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "David E. Box" <david.e.box@linux.intel.com>,
        "ibm-acpi-devel@lists.sourceforge.net" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <1505028180.591737.1589564161284.ref@mail.yahoo.com>
 <1505028180.591737.1589564161284@mail.yahoo.com>
 <CAHp75VfC0NdyyR1zXbk47G_9y5ResrpV+w3cOntDqP_naocuvQ@mail.gmail.com>
 <2952287.p5mUHPKNZq@kreacher>
 <d0022af356cf9bd5b544187d9a396734d85a76b3.camel@linux.intel.com>
 <193598853.2172716.1590128099214@mail.yahoo.com>
 <CAHp75VcQSECZeK-5OhJqXaZdW0r8gnvt_PBSKGK4+BKpa9D9KQ@mail.gmail.com>
 <1499931432.2309073.1590164195855@mail.yahoo.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <c41ea748-feb7-3be2-abd8-5b8f891c602b@intel.com>
Date:   Mon, 25 May 2020 08:37:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1499931432.2309073.1590164195855@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+ Ben Chuang <ben.chuang@genesyslogic.com.tw>

It does not look like that driver allows runtime pm.


On 22/05/20 7:16 pm, larsh@apache.org wrote:
> Relevant logs:
> 
> May 21 23:05:31 host kernel: sdhci-pci 0000:53:00.0: SDHCI controller found [17a0:9755] (rev 0)
> May 21 23:05:31 host kernel: sdhci-pci 0000:53:00.0: enabling device (0000 -> 0002)
> May 21 23:05:31 host kernel: mmc0: SDHCI controller on PCI [0000:53:00.0] using ADMA 64-bit
> 
> 
> 
> On Friday, May 22, 2020, 1:59:08 AM PDT, Andy Shevchenko <andy.shevchenko@gmail.com> wrote: 
> 
> 
> 
> 
> 
> +Cc: Adrian
> 
> On Fri, May 22, 2020 at 9:15 AM larsh@apache.org <larsh@apache.org> wrote:
>>
>> Thanks David!
>>
>> With this I tracked down the SD Card Reader (Genesys Logic, Inc Device 9755) as the culprit.
>> These are standard in many ThinkPads.
>> The curious part is that resume from suspend (S3 or S0iX) also fixes the problem.
>> Looks like the driver is not initializing correctly at boot time.
>>
>> Transcript:
>>
>> $ cat /sys/kernel/debug/pmc_core/ltr_show | grep SOUTHPORT
>> SOUTHPORT_A                            LTR: RAW: 0x88018c01            Non-Snoop(ns): 1024            Snoop(ns): 32768
>> SOUTHPORT_B                            LTR: RAW: 0x0                  Non-Snoop(ns): 0                Snoop(ns): 0
>> SOUTHPORT_C                            LTR: RAW: 0x9f409f4            Non-Snoop(ns): 0                Snoop(ns): 0
>> SOUTHPORT_D                            LTR: RAW: 0x88aa88aa            Non-Snoop(ns): 174080          Snoop(ns): 174080
>> SOUTHPORT_E                            LTR: RAW: 0x0                  Non-Snoop(ns): 0                Snoop(ns): 0
>>
>> $ lspci -t
>> -[0000:00]-+-00.0
>>             +-01.0-[01]--+-00.0
>>             |            \-00.1
>>             +-02.0
>>             +-04.0
>>             +-08.0
>>             +-12.0
>>             +-14.0
>>             +-14.2
>>             +-15.0
>>             +-16.0
>>             +-1c.0-[53]----00.0
>>             +-1d.0-[02]----00.0
>>             +-1d.6-[52]----00.0
>>             +-1e.0
>>             +-1f.0
>>             +-1f.3
>>             +-1f.4
>>             +-1f.5
>>             \-1f.6
>>
>> $ lspci | grep 53
>> 53:00.0 SD Host controller: Genesys Logic, Inc Device 9755
>>
>> $ cat /sys/bus/pci/devices/0000\:53\:00.0/power/control
>> auto
>>
>> $ echo 1 > /sys/bus/pci/devices/0000\:53\:00.0/remove
>> 1
>>
>> $ cat /sys/kernel/debug/pmc_core/ltr_show | grep SOUTHPORT
>> SOUTHPORT_A                            LTR: RAW: 0x8010c01            Non-Snoop(ns): 0                Snoop(ns): 0
>> SOUTHPORT_B                            LTR: RAW: 0x0                  Non-Snoop(ns): 0                Snoop(ns): 0
>> SOUTHPORT_C                            LTR: RAW: 0x9f409f4            Non-Snoop(ns): 0                Snoop(ns): 0
>> SOUTHPORT_D                            LTR: RAW: 0x8c548c54            Non-Snoop(ns): 2752512          Snoop(ns): 2752512
>> SOUTHPORT_E                            LTR: RAW: 0x0                  Non-Snoop(ns): 0                Snoop(ns): 0
>>
>> Cheers.
>>
>> -- Lars
>>
>>
>>
>>
>>
>>
>>
>>
>> On Tuesday, May 19, 2020, 9:03:53 AM PDT, David E. Box <david.e.box@linux.intel.com> wrote:
>>
>>
>>
>>
>>
>>>>> Does anybody know what's going on or how to debug this further?
>>>>> As stated above, I was able to work around this problem by
>>>>> ignoring SOUTHPORT_A via /sys/kernel/debug/pmc_core/ltr_ignore.
>>>>> There has to be a better way, and I'm sure I'm not the only one
>>>>> running into this.
>>
>> ltr_show shows the PMC's (Power Management Controller) view of SoC
>> devices and busses. The SOUTHPORTs are the PCIe root ports on your
>> system. When you run lspci they are the PCI bridges. Generally, the
>> bridges are enumerated in the same order as the SOUTHPORTs, so
>> SOUTHPORT_A is your first bridge and the device attached to it (shown
>> in lspci -t) is the device that was blocking deeper PC states according
>> to your debug.
>>
>> Determine what this device is on your system. If the ltr was low it's
>> because that is what the device requested. You should first check that
>> runtime pm is enabled for the device. To do this, check the control
>> file in /sys/bus/pci/devices/<SSSS:BB:DD.F>/power, where SSSS:BB:DD.F
>> is the enumeration of your device as shown in lspci. If it is 'on' then
>> runtime pm is disabled. To enable it echo 'auto' into the file with
>> root privileges. Enabling runtime pm should allow the driver to reduce
>> functionality of the device when idle. This should lead to a larger
>> latency request on the PCI bus which should be reflected in ltr_show.
>> You can see if the device is actually runtime suspended and how much
>> time it's been suspended (or active) by reading the associated files in
>> the power folder.
>>
>> If this doesn't work, then it's possible that your device doesn't
>> support runtime pm. This may be purposely for reliability reasons or
>> the driver may just lack support. Check forums discussing issues with
>> the device and look for possible options in the driver to force pm
>> support (generally this will be centered around enabling ASPM).
>>
>> You can also download powertop to see the package c-state residencies
>> more clearly as percentages of time. powertop also has a tunables tab
>> that will show the status of runtime pm on all devices on the system
>> and allow you to enable them individually.
>>
>>
>> David
> 
>>
> 
> 

