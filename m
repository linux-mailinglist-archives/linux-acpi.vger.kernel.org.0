Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62E7479418
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Dec 2021 19:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbhLQS0z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 Dec 2021 13:26:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236790AbhLQS0z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 17 Dec 2021 13:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639765614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfxK0ejkXXY8vtQyFEY/7KMOpPsxa0viz0432kyxpNQ=;
        b=I3HULvLJpbL5ibZCJvAjLdEao9iTZRK3A/Xn4U21PaYBqkofke+gJZtnv9SQEFZ7WtOSqu
        KrE2zkyUJd82r7PJZ5xU223vz5Rx22DRfSWyoHlQN+unTDmRIDEGek1mpg1EipuFn7+Ck8
        /nJCRUeF1EiZWqV5tNFHHPXRFHuyY1Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-oUwF3H-5OA-S2RdmkfUDDg-1; Fri, 17 Dec 2021 13:26:53 -0500
X-MC-Unique: oUwF3H-5OA-S2RdmkfUDDg-1
Received: by mail-ed1-f71.google.com with SMTP id w10-20020a50d78a000000b003f82342a95aso534079edi.22
        for <linux-acpi@vger.kernel.org>; Fri, 17 Dec 2021 10:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KfxK0ejkXXY8vtQyFEY/7KMOpPsxa0viz0432kyxpNQ=;
        b=3gtNeFnM4EQkf0l5dZqQ1zlE290EqEokKEzlKtZvoVp411jM1LguKFfOyp+NMk7O/3
         g13bcBtSijaEcrPGKtWqLsptQ3JcdLbj5yExD3WDv4lr6sfNXZZAuy8x9zLhDTQH41ci
         z5yGEUyAKA/qc+upu5Ig03sXylStD8eZPCLwczTSDsQNrxg9s5uyjinIc5trVLVML7Ub
         PTpWDHnkPkxSl9nNhnhOG1RysK1A3Zbim9wBNJg/MM2vrf2cAIumlG7b6iIgmRBBR/ej
         dbjafgjDGMU5nivZ6nmwe7xT7rWzFwJwXjSloPkCHDfnLHRvIoPCmJXE46nIsQvzsuxQ
         gmQQ==
X-Gm-Message-State: AOAM531YGBmYj5kLr2xug4DGssGK3yIr5aRSpobXwAbvCmmjAOA9T0Fw
        VlRVbeJvbQNgcJb9RmsMJvjTeZDL3k/uLkBz2xuHphSFd3kD75vTWKq9YBeYfueUZ8pJ7xnU/DQ
        RQe634BzhaHUX0N3MDBZyOQ==
X-Received: by 2002:aa7:c5ca:: with SMTP id h10mr3889467eds.401.1639765612422;
        Fri, 17 Dec 2021 10:26:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymzvx+9sN5uu3fOWCecyuooYD36PdLfEQ4rkNgUaVC2uS7EjeLyEo6xpsbKMtNHdFq3cZCYg==
X-Received: by 2002:aa7:c5ca:: with SMTP id h10mr3889448eds.401.1639765612171;
        Fri, 17 Dec 2021 10:26:52 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id cs15sm3032506ejc.31.2021.12.17.10.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 10:26:51 -0800 (PST)
Message-ID: <4b5506b1-20c6-3983-d541-86dc2388b2a7@redhat.com>
Date:   Fri, 17 Dec 2021 19:26:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 08/10] ACPI / scan: Create platform device for CLSA0100
 and CSC3551 ACPI nodes
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        patches@opensource.cirrus.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211217115708.882525-1-tanureal@opensource.cirrus.com>
 <20211217115708.882525-9-tanureal@opensource.cirrus.com>
 <CAJZ5v0jTELqFeO6q6w_mYNo_yf1R9SX66RrEz0ZSe27w7E6kog@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0jTELqFeO6q6w_mYNo_yf1R9SX66RrEz0ZSe27w7E6kog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/17/21 18:19, Rafael J. Wysocki wrote:
> On Fri, Dec 17, 2021 at 12:57 PM Lucas Tanure
> <tanureal@opensource.cirrus.com> wrote:
>>
>> The ACPI device with CLSA0100 or CSC3551 is a sound card
>> with multiple instances of CS35L41 connectec by I2C to
> 
> "connected" I suppose?
> 
>> the main CPU.
>>
>> We add an ID to the i2c_multi_instantiate_ids list to enumerate
>> all I2C slaves correctly.
>>
>> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> 
> This requires an ACK from Hans.
> 
> If you receive one, please feel free to add my ACK to it too.

One problem which I see here is that this change conflicts with
this series:

https://lore.kernel.org/all/20211210154050.3713-1-sbinding@opensource.cirrus.com/

I have reviewing that series on my todo list.

One interesting question for you (Rafael) about that series is
that i2c-multi-instantiate.c, which after the series also handles
spi devices,is being moved to drivers/acpi .

This is fine with me, but I wonder if it would not be better
to keep it under drivers/platform/x86 ? Since the new SPI
use-cases are also all on x86 laptops AFAICT.

But back to this series, as said the 2 series conflict, since
both are being submitted by @opensource.cirrus.com people,
it would be good if the Cirrus folks can decide in which
order these series should be merged.

It might be best to just move this one patch to the other series?
Thus removing the conflict between the 2 series.

Regards,

Hans



>> ---
>>  drivers/acpi/scan.c                          |  3 +++
>>  drivers/platform/x86/i2c-multi-instantiate.c | 11 +++++++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index b7a6b982226e..8740cfa11f59 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1712,8 +1712,11 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>>         static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
>>                 {"BSG1160", },
>>                 {"BSG2150", },
>> +               {"CSC3551", },
>>                 {"INT33FE", },
>>                 {"INT3515", },
>> +               /* Non-conforming _HID for Cirrus Logic already released */
>> +               {"CLSA0100", },
>>                 {}
>>         };
>>
>> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
>> index 4956a1df5b90..a889789b966c 100644
>> --- a/drivers/platform/x86/i2c-multi-instantiate.c
>> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
>> @@ -147,6 +147,14 @@ static const struct i2c_inst_data int3515_data[]  = {
>>         {}
>>  };
>>
>> +static const struct i2c_inst_data cs35l41_hda[] = {
>> +       { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
>> +       { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
>> +       { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
>> +       { "cs35l41-hda", IRQ_RESOURCE_GPIO, 0 },
>> +       {}
>> +};
>> +
>>  /*
>>   * Note new device-ids must also be added to i2c_multi_instantiate_ids in
>>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>> @@ -154,7 +162,10 @@ static const struct i2c_inst_data int3515_data[]  = {
>>  static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
>>         { "BSG1160", (unsigned long)bsg1160_data },
>>         { "BSG2150", (unsigned long)bsg2150_data },
>> +       { "CSC3551", (unsigned long)cs35l41_hda },
>>         { "INT3515", (unsigned long)int3515_data },
>> +       /* Non-conforming _HID for Cirrus Logic already released */
>> +       { "CLSA0100", (unsigned long)cs35l41_hda },
>>         { }
>>  };
>>  MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
>> --
>> 2.34.1
>>
> 

