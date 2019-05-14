Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3174A1D15F
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2019 23:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfENVhQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 May 2019 17:37:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:28426 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfENVhQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 May 2019 17:37:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 14:37:15 -0700
X-ExtLoop1: 1
Received: from pavankka-mobl.amr.corp.intel.com (HELO [10.254.107.28]) ([10.254.107.28])
  by fmsmga008.fm.intel.com with ESMTP; 14 May 2019 14:37:13 -0700
Subject: Re: [alsa-devel] [PATCH v2] ACPI / device_sysfs: change _ADR
 representation to 64 bits
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        jank@cadence.com, Joe Perches <joe@perches.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
References: <20190501125322.23791-1-pierre-louis.bossart@linux.intel.com>
 <20190502045817.GZ3845@vkoul-mobl.Dlink>
 <CAJZ5v0i+M8y3ddr+Z5o5af8OatMXq3xqCF5CUg5PjnANrTOSHw@mail.gmail.com>
 <1683867.ro8ObbCUgW@kreacher>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <05820f12-de32-c5bb-0780-75c43557e677@linux.intel.com>
Date:   Tue, 14 May 2019 16:37:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1683867.ro8ObbCUgW@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


>>>> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
>>>> index 8940054d6250..7dda0ee05cd1 100644
>>>> --- a/drivers/acpi/device_sysfs.c
>>>> +++ b/drivers/acpi/device_sysfs.c
>>>> @@ -428,8 +428,10 @@ static ssize_t acpi_device_adr_show(struct device *dev,
>>>>   {
>>>>        struct acpi_device *acpi_dev = to_acpi_device(dev);
>>>>
>>>> -     return sprintf(buf, "0x%08x\n",
>>>> -                    (unsigned int)(acpi_dev->pnp.bus_address));
>>>> +     if (acpi_dev->pnp.bus_address > 0xFFFFFFFF)
>>>
>>> Would prefer to use U32_MAX instead of 0xFFFFFFFF
>>
>> I would.
>>
> 
> I have made that change manually and applied the patch.
> 
> Thanks!

Thanks, much appreciated.
