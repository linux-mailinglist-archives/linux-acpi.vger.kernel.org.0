Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A177448F035
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jan 2022 19:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243565AbiANS4K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Jan 2022 13:56:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243468AbiANS4J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jan 2022 13:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642186568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=51ImlDEadEsctg6nVH5bEBazgwQXCgp/FsQbc0BxjHM=;
        b=TXwiIDFvsUZmxqS8YtaR4O58vY1s2m195rtKKzGxQlhx24rOPJfzJ1YNR9HaXniRkUVhf9
        I2Ltlc/h5N7heS/dJckyfTbHGpw1R+6ytyHStToqyhTGp0Y3cVAzN07fo7YYl50DwBh95D
        wAzYixajvbSl84CMYs67o5cMsGm9XCA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-yFfeuK3WMoWMC7lptXuPNQ-1; Fri, 14 Jan 2022 13:56:07 -0500
X-MC-Unique: yFfeuK3WMoWMC7lptXuPNQ-1
Received: by mail-ed1-f71.google.com with SMTP id z8-20020a056402274800b003f8580bfb99so8916603edd.11
        for <linux-acpi@vger.kernel.org>; Fri, 14 Jan 2022 10:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=51ImlDEadEsctg6nVH5bEBazgwQXCgp/FsQbc0BxjHM=;
        b=BKLx72D2hPR99OCae4KWQQJNBehEVw6GaIIM3Ns4apEVIHOeHUh/WmTCKhdbRwTCc7
         1Ju26fzxF6DCXrl3htnEFruK65rIHa9XBpXf/AD2a/uF6ghmzolsfpll5wBcNapd3Odu
         X9Qr+rQDx7D26HsV+stDNESzAITFg92wnDap/KR3fDuEAOIUo66ZvPGFPE2La0YQNU1V
         SMGW2XGEG+xvrUiwUFba01msskNDgDCo54w+jyjhpOqIWriTY8i68Alh7Bm4Qdoz7RtP
         GQXYajW0z8jUg7FW4Ihx+Gv70LcP92bFXoH79qwOBXjZLsL6u0/0h96RYZLlcHGIFBkq
         PCeg==
X-Gm-Message-State: AOAM533LAc6/pEHeAYWZ2xxBZwxFV8M5s3qKm4tal66cfgwoegz+hd5O
        hToeKrkeOTbGAxFtoWzLJ+9lE/ryDFXQKzj4/lf8SP17l8rWshiC/PBNm9cOZKM7xmg/dt0EFQH
        gXyyo+9UtdPPZauHgDQnHzg==
X-Received: by 2002:a05:6402:217:: with SMTP id t23mr7399934edv.283.1642186566036;
        Fri, 14 Jan 2022 10:56:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAnjfubbtpBrUe4OTbYQbUw+9LhVVYNB3cYNRwnppOgGUs9iR9DDM+srSbwA1kCbdnuGSAoA==
X-Received: by 2002:a05:6402:217:: with SMTP id t23mr7399910edv.283.1642186565843;
        Fri, 14 Jan 2022 10:56:05 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id hd16sm2000023ejc.62.2022.01.14.10.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 10:56:05 -0800 (PST)
Message-ID: <55cb8127-65e2-4d56-5127-2722c5bfe11f@redhat.com>
Date:   Fri, 14 Jan 2022 19:56:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 5/5] ACPI / scan: Create platform device for CLSA0100
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220113170728.1953559-1-tanureal@opensource.cirrus.com>
 <20220113170728.1953559-5-tanureal@opensource.cirrus.com>
 <s5hee5a47et.wl-tiwai@suse.de>
 <CAJZ5v0ijGWNd9s-4mrFgK-QbPDhnj2K3DF+Z45t7ckV6ET0hpQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0ijGWNd9s-4mrFgK-QbPDhnj2K3DF+Z45t7ckV6ET0hpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/14/22 18:51, Rafael J. Wysocki wrote:
> On Fri, Jan 14, 2022 at 5:19 PM Takashi Iwai <tiwai@suse.de> wrote:
>>
>> On Thu, 13 Jan 2022 18:07:28 +0100,
>> Lucas Tanure wrote:
>>>
>>> The ACPI device with CLSA0100 is a sound card with
>>> multiple instances of CS35L41 connected by I2C to
>>> the main CPU.
>>>
>>> We add an ID to the i2c_multi_instantiate_idsi list
>>> to enumerate all I2C slaves correctly.
>>>
>>> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
>>
>> I think it's better to merge this from sound git tree together with
>> others in the patch set, presumably for rc1.
>>
>> It'd be great if ACPI people can take a review and give an ack/nack.
> 
> Hans, what do you think?

This patch (5/5) applies on top of:

https://lore.kernel.org/linux-acpi/20211210154050.3713-1-sbinding@opensource.cirrus.com/

Which still needs some work and which really should be merged
through the ACPI tree. IMHO it would be best to simply drop
this (5/5) from this series and move it to the v3 of the
series which I've linked to above.

1-4 can be merged through the alsa tree independently of 5/5 AFAIK.

Regards,

Hans




> 
>>> ---
>>>  drivers/acpi/scan.c                          | 2 ++
>>>  drivers/platform/x86/i2c-multi-instantiate.c | 8 ++++++++
>>>  2 files changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>> index c215bc8723d0..2a68031d953e 100644
>>> --- a/drivers/acpi/scan.c
>>> +++ b/drivers/acpi/scan.c
>>> @@ -1753,6 +1753,8 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>>>        */
>>>               {"BCM4752", },
>>>               {"LNV4752", },
>>> +     /* Non-conforming _HID for Cirrus Logic already released */
>>> +             {"CLSA0100", },
>>>               {}
>>>       };
>>>
>>> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
>>> index 4956a1df5b90..a51a74933fa9 100644
>>> --- a/drivers/platform/x86/i2c-multi-instantiate.c
>>> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
>>> @@ -147,6 +147,12 @@ static const struct i2c_inst_data int3515_data[]  = {
>>>       {}
>>>  };
>>>
>>> +static const struct i2c_inst_data cs35l41_hda[] = {
>>> +     { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
>>> +     { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
>>> +     {}
>>> +};
>>> +
>>>  /*
>>>   * Note new device-ids must also be added to i2c_multi_instantiate_ids in
>>>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>>> @@ -155,6 +161,8 @@ static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
>>>       { "BSG1160", (unsigned long)bsg1160_data },
>>>       { "BSG2150", (unsigned long)bsg2150_data },
>>>       { "INT3515", (unsigned long)int3515_data },
>>> +     /* Non-conforming _HID for Cirrus Logic already released */
>>> +     { "CLSA0100", (unsigned long)cs35l41_hda },
>>>       { }
>>>  };
>>>  MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
>>> --
>>> 2.34.1
>>>
> 

