Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674FE45AB5A
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 19:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbhKWSjJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 13:39:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232492AbhKWSjJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 13:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637692560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z5k6zTG4KRWbGgN3rihRDKhTPbVU4ZF9XdZlS05EGq0=;
        b=U64J9KT/VDuxU6o97ld8jW27+a7VJ3AqA0v6dcnIkQQw+/L2b5MCDyVnmrtWQC9j5lmezA
        LLjQClhCQF4LaCvNdHs6GtN7wrFkROTxpxYGJDNfj2H65oBij4qZ/MCbcFFbqh8LNrwDL+
        s+/gRJP7u+GBFwyBx8PZy9uQ1eoSf6c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-DKjiveyxNYGriEzKo-HqOA-1; Tue, 23 Nov 2021 13:35:58 -0500
X-MC-Unique: DKjiveyxNYGriEzKo-HqOA-1
Received: by mail-ed1-f69.google.com with SMTP id v22-20020a50a456000000b003e7cbfe3dfeso18578638edb.11
        for <linux-acpi@vger.kernel.org>; Tue, 23 Nov 2021 10:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z5k6zTG4KRWbGgN3rihRDKhTPbVU4ZF9XdZlS05EGq0=;
        b=0JCSK7/kG5fwoRGNqEVfyxG/SrbcVnkiDnY03WYG65g/3jSGg4Hmi+2XsQz6DvA0e5
         Ae5qkgW/q7sfPvd2XYABcYVurlODwPEjBcoOvzSgPI0wdepteCzXQOLEJnQ/ODrRu3Uj
         3p4g+crhKmNPy0sNFqsb6/X2aMyWW1+wIq+ugKOBWeU7DvD0H7Cdp9PwKgaJpssebRPT
         wTgXhSIxeMXWvQtaPI0fCTJH7RY49tbZOnoc1mf8FTSk8xNo9K3/4d/nzPLnFz86Hh+J
         zzKoak1zEPvmEj7linGGTgetmn9Du0osyRsuokwxytPzM9rcSD8q30pUNBiPVeKGB4LS
         by/w==
X-Gm-Message-State: AOAM5300Tf1aujPuW6MJKE4WTihIZyailOfdOoIj8Ktp5+1ObCMqCO7K
        s6rrd7cdzK8ApjT2WnK8eUzMWfMKIF2uyDSVAkTXOLExY/RgDqD0sSuH9WTDihSaAMJ0kdkkONo
        Lt1kCiaNDGL2/lnBqqLtIjQ==
X-Received: by 2002:a50:c446:: with SMTP id w6mr12781940edf.137.1637692557238;
        Tue, 23 Nov 2021 10:35:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUEZ9mmoxlVEliHny2DZXCv4YHhMo0Z9nYbdF9XbP1qCPsXkZcVzsMr3MWrgS3oizeCWcDog==
X-Received: by 2002:a50:c446:: with SMTP id w6mr12781899edf.137.1637692557030;
        Tue, 23 Nov 2021 10:35:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id yd13sm5601817ejb.39.2021.11.23.10.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 10:35:56 -0800 (PST)
Message-ID: <1605be8d-0913-4b52-32e2-8076fff01d30@redhat.com>
Date:   Tue, 23 Nov 2021 19:35:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 11/11] ACPI / scan: Create platform device for CLSA0100
 ACPI nodes
Content-Language: en-US
To:     Lucas tanure <tanureal@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc:     Jeremy Szu <jeremy.szu@canonical.com>,
        Hui Wang <hui.wang@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Sami Loone <sami@loone.fi>, Elia Devito <eliadevito@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jack Yu <jack.yu@realtek.com>, Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org,
        patches@opensource.cirrus.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
 <20211123163149.1530535-12-tanureal@opensource.cirrus.com>
 <87af37a2-dc02-2ae0-a621-b82c8601c16c@redhat.com>
 <756f813c-cc3e-7ddf-e5db-cf6c874f907e@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <756f813c-cc3e-7ddf-e5db-cf6c874f907e@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/23/21 18:11, Lucas tanure wrote:
> On 11/23/21 17:05, Hans de Goede wrote:
>> Hi Lucas,
>>
>> On 11/23/21 17:31, Lucas Tanure wrote:
>>> The ACPI device with CLSA0100 is a sound card with multiple
>>> instances of CS35L41.
>>>
>>> We add an ID to the I2C multi instantiate list to enumerate
>>> all I2C slaves correctly.
>>>
>>> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
>>> ---
>>>   drivers/acpi/scan.c                          | 1 +
>>>   drivers/platform/x86/i2c-multi-instantiate.c | 7 +++++++
>>>   2 files changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>> index 2c80765670bc..16827a33e93b 100644
>>> --- a/drivers/acpi/scan.c
>>> +++ b/drivers/acpi/scan.c
>>> @@ -1708,6 +1708,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>>>           {"BSG2150", },
>>>           {"INT33FE", },
>>>           {"INT3515", },
>>> +        {"CLSA0100", },
>>>           {}
>>>       };
>>>   diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
>>> index 4956a1df5b90..ed25a0adc656 100644
>>> --- a/drivers/platform/x86/i2c-multi-instantiate.c
>>> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
>>> @@ -147,6 +147,12 @@ static const struct i2c_inst_data int3515_data[]  = {
>>>       {}
>>>   };
>>>   +static const struct i2c_inst_data clsa0100_data[]  = {
>>> +    { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
>>> +    { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
>>
>> This suggests that both amplifiers are using the same GPIO pin as shared
>> IRQ, is that correct ? Can you share an acpidump of the laptop's DSDT tables ?
>>
>> Regards,
>>
>> Hans
>>
> 
> DSDT attached.
> Yes, both amps share the same IRQ gpio.

Thanks, this patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> 
>>
>>
>>
>>> +    {}
>>> +};
>>> +
>>>   /*
>>>    * Note new device-ids must also be added to i2c_multi_instantiate_ids in
>>>    * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>>> @@ -155,6 +161,7 @@ static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
>>>       { "BSG1160", (unsigned long)bsg1160_data },
>>>       { "BSG2150", (unsigned long)bsg2150_data },
>>>       { "INT3515", (unsigned long)int3515_data },
>>> +    { "CLSA0100", (unsigned long)clsa0100_data },
>>>       { }
>>>   };
>>>   MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
>>>
>>

