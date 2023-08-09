Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6137755C3
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 10:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjHIIqT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 04:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjHIIqS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 04:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6511BD9
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 01:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691570731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lTRo6Ome7sqVUyF4PGEpdld0LyBjesDzlOLgeHp1kxk=;
        b=Hga9dlEcYKGoA5MwNcUBARd+w0Oj4fpj4BNKQPIlbgWrNh2pBEJ1Y6Bkx9VZz3mRCL18OR
        WOkCdOhO7W85OTfEFInk4fCZnOFYOS/LZjIW67hvfgRw2M9sS319pBVcUQ1uQvDNk3nvly
        22l4QkcgQl6exOOQe+IYbaQ+tCpwUuc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-zg_P356LMZixAZl6NLVoXQ-1; Wed, 09 Aug 2023 04:45:30 -0400
X-MC-Unique: zg_P356LMZixAZl6NLVoXQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-993eeb3a950so473026966b.2
        for <linux-acpi@vger.kernel.org>; Wed, 09 Aug 2023 01:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691570729; x=1692175529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTRo6Ome7sqVUyF4PGEpdld0LyBjesDzlOLgeHp1kxk=;
        b=Ks4Dm7rTwAoWdAfiMOWwgxk7xLRq6NPwNJuccoFonfXxcYujxos/VUiXwb0AIKhnvS
         UeE3DIuVUB4DXLDQrXGoj+RnbfrNTDj5naN516LuU64Be9hP0Gaj2BUXtGaTg2jHB+U9
         Dp3YgUlPQnsW6ba2O1YU2PH4FvAqy8YFaWtvarf9dNizxGTA96KhYsjybfV5LlU3w2FS
         y50lRjFE1pU2xfjWVDKR7Bph/Z5hKL3rR2kBCAQMXjICr3ZU04ZRPndc6a/2TgwG12P3
         4cFEjW5HyVJqnNUYW/VfzQw9UIjy7Mls9CIgzty4g5h7BFbPA4oyXOqNkVxK99FUyOVQ
         heYg==
X-Gm-Message-State: AOJu0YyGvPpFk43rgmF1oLNPSKqAldXr1qk/Xztpmh4F84w8PYh6yZ7B
        mJX/pk54PW6TfR86NNLzSddDjHkjdf9CGnL0dVQu+CYfMV2eV+Z63Fga65sdPhy4sJ63kvfkVXj
        XUOy2vR5zIEHziuLSSJDKXQJ9REoUTA==
X-Received: by 2002:a17:906:8a4b:b0:992:7295:61c9 with SMTP id gx11-20020a1709068a4b00b00992729561c9mr1527131ejc.69.1691570728879;
        Wed, 09 Aug 2023 01:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvU/lh8ziAkKsu93hMd2qSm0cJhzw5VFwrmSiSrXH+lPgfvmyx4xKPTshowyUEyd955julKQ==
X-Received: by 2002:a17:906:8a4b:b0:992:7295:61c9 with SMTP id gx11-20020a1709068a4b00b00992729561c9mr1527114ejc.69.1691570728559;
        Wed, 09 Aug 2023 01:45:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709063e9700b00993150e5325sm7753768ejj.60.2023.08.09.01.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 01:45:27 -0700 (PDT)
Message-ID: <10fe8a58-7609-feee-4c3c-6924862f24a8@redhat.com>
Date:   Wed, 9 Aug 2023 10:45:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] ACPI: resource: Always use MADT override IRQ
 settings for GSI != 1
To:     August Wikerfors <git@augustwikerfors.se>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
References: <20230808103335.95339-1-hdegoede@redhat.com>
 <20230808103335.95339-3-hdegoede@redhat.com>
 <abaad492-6aea-4edf-891f-f57bc2b86781@augustwikerfors.se>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <abaad492-6aea-4edf-891f-f57bc2b86781@augustwikerfors.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi August,

On 8/8/23 22:31, August Wikerfors wrote:
> On 2023-08-08 12:33, Hans de Goede wrote:
>> All the cases, were the DSDT IRQ settings should be used instead of
>> the MADT override, are for IRQ 1 (the PS/2 kbd IRQ).
>>
>> Simplify things by always honering the override for GSI != 1
>> (for non DMI quirked cases).
>>
>> This allows removing the DMI quirks to honor the override for
>> some non IRQ 1 IRQs on some AMD ZEN based Lenovo models.
>>
>> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/acpi/resource.c | 28 ++++++++--------------------
>>   1 file changed, 8 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 0800a9d77558..840b938a5fb0 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -470,24 +470,6 @@ static const struct dmi_system_id asus_laptop[] = {
>>       { }
>>   };
>>   -static const struct dmi_system_id lenovo_laptop[] = {
>> -    {
>> -        .ident = "LENOVO IdeaPad Flex 5 14ALC7",
>> -        .matches = {
>> -            DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -            DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
>> -        },
>> -    },
>> -    {
>> -        .ident = "LENOVO IdeaPad Flex 5 16ALC7",
>> -        .matches = {
>> -            DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -            DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
>> -        },
>> -    },
>> -    { }
>> -};
>> -
>>   static const struct dmi_system_id tongfang_gm_rg[] = {
>>       {
>>           .ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
>> @@ -539,8 +521,6 @@ struct irq_override_cmp {
>>   static const struct irq_override_cmp override_table[] = {
>>       { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>>       { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>> -    { lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>> -    { lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>>       { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>>       { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>>       { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>> @@ -562,6 +542,14 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>>               return entry->override;
>>       }
>>   +    /*
>> +     * Always use the MADT override info, except for IRQ 1 for IRQ1
>> +     * the DSDT IRQ settings should sometimes be used otherwise
>> +     * PS/2 keyboards will not work.
>> +     */
>> +    if (gsi != 1)
>> +        return true;
>> +
>>   #ifdef CONFIG_X86
>>       /*
>>        * IRQ override isn't needed on modern AMD Zen systems and
> 
> I don't think this will work for the Lenovo ThinkPad neo 14 because according to https://bugzilla.kernel.org/show_bug.cgi?id=217731 it needs the override to also be skipped for IRQ 12.

You are right, thank you for catching this. I'll submit a v3 of
the series with the check changed to:

    if (gsi != 1 && gsi != 12)
        return true;


I'll update the Link: tags in the revert to add more bugreports
Links including the 217731 bugzilla.

Regards,

Hans


