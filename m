Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684447762B5
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 16:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjHIOkv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 10:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjHIOkt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 10:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55187210D
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691592002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QE78PQ7iVBej15oB5yPppMhS2FGb0gwiYPKV6kLIcTg=;
        b=Lst/9E26VHKP7VdSGH1/6tMkjKXsdxaJ5O0sLVEyLTS3SYixLDMwmin7GAun6Qp0nvb5nl
        NjRhF6/CrfMNai6camsQmFNKDND8kRfHIycyWVc0cpEok21I3WITBItMMThNoTb8P1cUOr
        92RJozs6WEvqFDqu5av17iH13ziiq5U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-cdm7bfKaMe-engcVDi27wg-1; Wed, 09 Aug 2023 10:40:01 -0400
X-MC-Unique: cdm7bfKaMe-engcVDi27wg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-993c2d9e496so464623066b.0
        for <linux-acpi@vger.kernel.org>; Wed, 09 Aug 2023 07:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691592000; x=1692196800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QE78PQ7iVBej15oB5yPppMhS2FGb0gwiYPKV6kLIcTg=;
        b=kMcml0zO2DRPQcaFGEIEKELuXnNRPOqQua5+QRygNCUG/0E0iMbI9XfG1w1iWI6DeS
         1i954CvcQLHp1ZyvRYEBB6XzNfetZ7qzTeUNr0Zlf94crdBRJ0eXmggFu+bfltY/XPXx
         /O8fg6Z0HUttssmHdQC7kuxRCUErlsVv5b6SrFgFiAEqxAL8Pa6pdgMo24kRpGbWbxNw
         4m4AaJIk7QakrWxBoLObBaV+n1yW1bf2Z5C8EZ21fthpyLJb6peWT6Bud4yqXddj65AC
         OUVqWpY12NcMTu4G8dr78EUMue54/NN/FYNoBXOA+bHhcRGu9n4iFF9UkApoY+OynxUc
         QfSA==
X-Gm-Message-State: AOJu0YxUEEYNDsAKaRpshzYhIDTaBC6ejf67HoB3AJoNv529TZQDbAiS
        oK+cotKvAJVGu6VdPUW4S6kPS0Abq/CqlgeU1W4QZG1/k75oD2p/F5gGx3WUc32BB94fL9Avql0
        70sNA1vMAMK950eH9i3VlNQ==
X-Received: by 2002:a17:906:19b:b0:992:a90a:5d1f with SMTP id 27-20020a170906019b00b00992a90a5d1fmr2538412ejb.68.1691591999923;
        Wed, 09 Aug 2023 07:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxOAkAnR+lsG01THkgi5DLnNo2B4fwxuzOvrIqPnpF+a2p0A5CIujpmCmKQg1GWF9uB6lJCA==
X-Received: by 2002:a17:906:19b:b0:992:a90a:5d1f with SMTP id 27-20020a170906019b00b00992a90a5d1fmr2538402ejb.68.1691591999648;
        Wed, 09 Aug 2023 07:39:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906430f00b0099b76c3041csm8181983ejm.7.2023.08.09.07.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 07:39:59 -0700 (PDT)
Message-ID: <3fe197da-c26e-e826-4ea2-c13d2880046d@redhat.com>
Date:   Wed, 9 Aug 2023 16:39:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] ACPI: resource: Honor MADT INT_SRC_OVR settings
 for IRQ1 on AMD Zen
Content-Language: en-US, nl
To:     Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        August Wikerfors <git@augustwikerfors.se>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
References: <20230809085526.84913-1-hdegoede@redhat.com>
 <20230809085526.84913-4-hdegoede@redhat.com>
 <f133d401-1975-6c85-47c5-f9464d5ef06f@kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f133d401-1975-6c85-47c5-f9464d5ef06f@kernel.org>
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

Hi,

On 8/9/23 11:20, Jiri Slaby wrote:
> On 09. 08. 23, 10:55, Hans de Goede wrote:
>> On AMD Zen acpi_dev_irq_override() by default prefers the DSDT IRQ 1
>> settings over the MADT settings.
>>
>> This causes the keyboard to malfunction on some laptop models
>> (see Links), all models from the Links have an INT_SRC_OVR MADT entry
>> for IRQ 1.
> ...
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ...
>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>> index 21b542a6866c..b88e5e0135ab 100644
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -52,6 +52,7 @@ int acpi_lapic;
>>   int acpi_ioapic;
>>   int acpi_strict;
>>   int acpi_disable_cmcff;
>> +int acpi_int_src_ovr[NR_IRQS_LEGACY];
> 
> So why not to use bool to make it clear this is not an irq number, but a state?
> 
>>     /* ACPI SCI override configuration */
>>   u8 acpi_sci_flags __initdata;
>> @@ -588,6 +589,9 @@ acpi_parse_int_src_ovr(union acpi_subtable_headers * header,
>>         acpi_table_print_madt_entry(&header->common);
>>   +    if (intsrc->source_irq < NR_IRQS_LEGACY)
>> +        acpi_int_src_ovr[intsrc->source_irq] = 1;
> 
> And "true" here.

Ack that would indeed be better.

Rafael, can you fix this up while merging or do you want a v4 series ?

Regards,

Hans



