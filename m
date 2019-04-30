Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2138FFAC
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2019 20:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfD3SXl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Apr 2019 14:23:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:4149 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfD3SXl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Apr 2019 14:23:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 11:23:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="144938228"
Received: from cng16-mobl.amr.corp.intel.com (HELO [10.252.205.95]) ([10.252.205.95])
  by fmsmga008.fm.intel.com with ESMTP; 30 Apr 2019 11:23:39 -0700
Subject: Re: [alsa-devel] [PATCH] ACPI / device_sysfs: change _ADR
 representation to 64 bits
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        jank@cadence.com, Joe Perches <joe@perches.com>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Len Brown <lenb@kernel.org>
References: <20190415151857.25531-1-pierre-louis.bossart@linux.intel.com>
 <20190416032923.GQ28103@vkoul-mobl>
 <CAJZ5v0jOkQ7aWn6B_yVTYd7y+78mpGSzBoGuWe3uCdzDRNE94Q@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <eda0ed4e-fc36-a53a-225f-e7d54bb73413@linux.intel.com>
Date:   Tue, 30 Apr 2019 13:23:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jOkQ7aWn6B_yVTYd7y+78mpGSzBoGuWe3uCdzDRNE94Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 4/16/19 3:09 AM, Rafael J. Wysocki wrote:
> On Tue, Apr 16, 2019 at 5:29 AM Vinod Koul <vkoul@kernel.org> wrote:
>>
>> On 15-04-19, 10:18, Pierre-Louis Bossart wrote:
>>> Standards such as the MIPI DisCo for SoundWire 1.0 specification
>>> assume the _ADR field is 64 bits.
>>>
>>> _ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
>>> released in 2002. The low levels already use _ADR as 64 bits, e.g. in
>>> struct acpi_device_info.
>>>
>>> This patch bumps the representation used for sysfs to 64 bits.
>>>
>>> Example with a SoundWire device, the results show the complete
>>> vendorID and linkID which were omitted before:
>>>
>>> Before:
>>> $ more /sys/bus/acpi/devices/device\:38/adr
>>> 0x5d070000
>>> After:
>>> $ more /sys/bus/acpi/devices/device\:38/adr
>>> 0x000010025d070000
>>
>> This looks fine but the sysfs file is an ABI. Not sure if we can modify
>> the value returned this way.. Though it should not cause userspace
>> reading 32bits to break...
> 
> Well, IIRC using "08" instead of "016" in the format field would
> preserve the existing behavior for 32-bit values, wouldn't it?

yes, but it makes the 64-bit address not aligned depending on the number 
of leading zeroes, see below. I get a migraine just looking at the results.

Maybe add a test to use 08 for values that are below 0xFFFFFFFF and 16 
for addresses who really need the full range, typically because of an 
encoding?

w/ value-dependent format:
/sys/bus/acpi/devices# cat */*/adr

0x00160000
0x00140003
0x000d0000
0x000d0002
0x000d0003
0x00070000
0x00070001
0x00070002
0x00070003
0x000010025d070100
0x000110025d070100
0x000210025d070100
0x000310025d070100
0x000010025d070000
0x000110025d070000
0x000210025d070000
0x000310025d070000
0x00000000

w/ 0x08 only:

0x00160000
0x00140003
0x000d0000
0x000d0002
0x000d0003
0x00070000
0x00070001
0x00070002
0x00070003
0x10025d070100
0x110025d070100
0x210025d070100
0x310025d070100
0x10025d070000
0x110025d070000
0x210025d070000
0x310025d070000
0x00000000
0x00000000

