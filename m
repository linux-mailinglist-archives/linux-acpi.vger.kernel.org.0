Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B307771BBB
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Aug 2023 09:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjHGHpD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Aug 2023 03:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHGHpC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Aug 2023 03:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC1310F4
        for <linux-acpi@vger.kernel.org>; Mon,  7 Aug 2023 00:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691394254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JCQZR3EjBoY9Gn4OenyJbbS8uuNzlYA3xL1UGjbFk8=;
        b=g/COw+gCGSxhsMoxgpM1lEAVFZxT+bp81/IFhdZbAozCEnq5wyLEnzX7u4mVBGDgO8/Ph1
        Q6ufIv+SMNPkvVsOxMn57diw9gMyraJLC8GuhnXORP4Oj4HC1dk0np4LL32m96t6vSkP3E
        vpYYF7wHFL2gziyOSiL7JtKqGc15oXA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-LO6xMTcUOg2kNOPPIvpuCg-1; Mon, 07 Aug 2023 03:44:12 -0400
X-MC-Unique: LO6xMTcUOg2kNOPPIvpuCg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99bc8f1290eso284897766b.3
        for <linux-acpi@vger.kernel.org>; Mon, 07 Aug 2023 00:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691394251; x=1691999051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+JCQZR3EjBoY9Gn4OenyJbbS8uuNzlYA3xL1UGjbFk8=;
        b=hcj6OqwP/7vu6z93mACk/xuFnob0chOjZlaoUtm1Wvhv5mFm6KsXSu+lm3japGnwdl
         Eqd+HLOF39hJD07Rru2OoQmMn4NUXWOvgi6KXQb9/5sNIecUlLh24ML2K9gqRWmdaCdo
         bEYXdALm9CU0AR3JNLPD76u4lStOGb0AOC8NKdbvwXEVFUXKooF1ZKuQc/e+4a28iZK5
         UOlED5QZ2g0IexAftkydvZAAG4sT6tj6kbYP6kdJV565B1pIid3g+ijVpAwRfV+IZWzJ
         SFpZ250uSLMwa7tWxOcOK+IZGcfp3olElgnlPQkEJSppfrv+rP0hd2BXMlhoHQeH/nhp
         dOvw==
X-Gm-Message-State: AOJu0Yw7bHr7u38HHYtQ95x5hbGqopxNhLLxyhKy11F1VDvlcePdgNzb
        /aFkU8965wEEMqUTrbv8GqhvilBWO9oF2ewmASeb8kZ5QKgD3LObo58e8glypvJlMM8higfqtsy
        hSb2a1xsWBZf8hl2Epw0EbkHvYnSgKQ==
X-Received: by 2002:a17:906:20d4:b0:99b:dd38:864d with SMTP id c20-20020a17090620d400b0099bdd38864dmr8099633ejc.23.1691394251066;
        Mon, 07 Aug 2023 00:44:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH27Jk3o0JkT1Qn89ig8DIvZy4Jj3QOpj9dFlYjkRBqwquGiVyvEtoEs50WICuQkk6YN7gpDg==
X-Received: by 2002:a17:906:20d4:b0:99b:dd38:864d with SMTP id c20-20020a17090620d400b0099bdd38864dmr8099620ejc.23.1691394250738;
        Mon, 07 Aug 2023 00:44:10 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id p27-20020a170906229b00b0099bd8c1f67esm4814187eja.109.2023.08.07.00.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:44:09 -0700 (PDT)
Message-ID: <8f0cbe61-99aa-8c45-c29e-69c27ba96d81@redhat.com>
Date:   Mon, 7 Aug 2023 09:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ACPI: resource: revert "Remove "Zen" specific match and
 quirks"
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, August Wikerfors <git@augustwikerfors.se>
References: <20230806151453.10690-1-hdegoede@redhat.com>
 <130cb2e0-90b4-7d7b-1633-3469c859b30f@amd.com>
 <b37098da-4437-ef5b-53ae-a536f550df08@redhat.com>
 <0c1cb09a-2e78-65ad-61c1-174e5226d08e@amd.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <0c1cb09a-2e78-65ad-61c1-174e5226d08e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 8/7/23 06:38, Mario Limonciello wrote:
> On 8/6/23 13:20, Hans de Goede wrote:
>> Hi Mario,
>>
>> On 8/6/23 19:13, Mario Limonciello wrote:
>>> On 8/6/23 10:14, Hans de Goede wrote:
>>>> Commit a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and
>>>> quirks") is causing keyboard problems for quite a log of AMD based
>>>> laptop users, leading to many bug reports.
>>>>
>>>> Revert this change for now, until we can come up with
>>>> a better fix for the PS/2 IRQ trigger-type/polarity problems
>>>> on some x86 laptops.
>>>
>>> Reverting it is going to help a bunch of machines but cause regressions for others.  How do you prioritize which to fix when it comes to a regression?
>>
>> I understand where you are coming from. But we are dealing with a lot of bug reports from users of recent kernel versions (so not on LTS distros) where things used to work fine. Which is pretty much the definition of a regression.
>>
>> OTOH the do not override IRQ on Zen behavior has been with us for a while now, so things which are broken by it have been broken for a while and have only started working since 6.4.7.
>>
>> So to me it is clear that we first need to revert to the old state, so that users for which everything was working fine get back to a working system.
>>
>> I realize this will unfix some very recently fixed systems, but notice the very recently bit here most users are no in 6.4.7 or .8 yet, so most users will not even have gotten the fixing effect OTOH many users are seeing breakage now.
>>
>> So IMHO we should first get back to the known bad state, instead of introducing a new unknown bad state like a9c4a912b7dc did.
>>
>> If there are known systems which will need an override with a9c4a912b7dc reverted, then we should probably add those to the override table right away.
>>
>> And I think what we also need is a way to specify an IRQ trigger-type override for IRQ 1 on the kernel commandline, so that we can easily ask users to try a different trigger-type without them needing to build a kernel with an updated quirk table.
>>
>> As Linus mentioned already, we really need to find a proper fix for this, but for now my main priority is to stop the influx of new Fedora bugzilla and bugzilla.kernel.org bugs caused by a9c4a912b7dc, counting the extra bug links added in this thread it seems we are up to 6 known bug reports for this and that likely is just the tip of the iceberg.
>>
>> Regards,
>>
>> Hans
>>
>>
> 
> We haven't even given a try to fixing it; I think the revert is still hasty.
> 
> I don't have a machine that can reproduce this failure, but I did confirm that my keyboard still works with this:
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 1dd8d5aebf678..b74d7d8cc8630 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -19,7 +19,7 @@
>  #include <linux/dmi.h>
> 
>  #ifdef CONFIG_X86
> -#define valid_IRQ(i) (((i) != 0) && ((i) != 2))
> +#define valid_IRQ(i) ((i) > 2)
>  static inline bool acpi_iospace_resource_valid(struct resource *res)
>  {
>         /* On X86 IO space is limited to the [0 - 64K] IO port range */
> 
> Can we perhaps see if that works instead for some affected people?

That does not just skip the override stuff, it will make the kernel return irqresource_disabled(res, 1) for the kbd IRQ:

static inline void irqresource_disabled(struct resource *res, u32 irq)
{
        res->start = irq;
        res->end = irq;
        res->flags |= IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
}

Now not much code seems to actually check the IORESOURCE_DISABLED | IORESOURCE_UNSET flags, so this might still work but it does not seem like the right thing to do.

Regards,

Hans






> 
> If it does we should be able to throw away the entire quirks table.
> 
>>
>>>
>>>>
>>>> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
>>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229165
>>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229317
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217726
>>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>>> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>    drivers/acpi/resource.c | 60 +++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 60 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>>>> index 1dd8d5aebf67..0800a9d77558 100644
>>>> --- a/drivers/acpi/resource.c
>>>> +++ b/drivers/acpi/resource.c
>>>> @@ -470,6 +470,52 @@ static const struct dmi_system_id asus_laptop[] = {
>>>>        { }
>>>>    };
>>>>    +static const struct dmi_system_id lenovo_laptop[] = {
>>>> +    {
>>>> +        .ident = "LENOVO IdeaPad Flex 5 14ALC7",
>>>> +        .matches = {
>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
>>>> +        },
>>>> +    },
>>>> +    {
>>>> +        .ident = "LENOVO IdeaPad Flex 5 16ALC7",
>>>> +        .matches = {
>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
>>>> +        },
>>>> +    },
>>>> +    { }
>>>> +};
>>>> +
>>>> +static const struct dmi_system_id tongfang_gm_rg[] = {
>>>> +    {
>>>> +        .ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
>>>> +        .matches = {
>>>> +            DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
>>>> +        },
>>>> +    },
>>>> +    { }
>>>> +};
>>>> +
>>>> +static const struct dmi_system_id maingear_laptop[] = {
>>>> +    {
>>>> +        .ident = "MAINGEAR Vector Pro 2 15",
>>>> +        .matches = {
>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
>>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
>>>> +        }
>>>> +    },
>>>> +    {
>>>> +        .ident = "MAINGEAR Vector Pro 2 17",
>>>> +        .matches = {
>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
>>>> +            DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
>>>> +        },
>>>> +    },
>>>> +    { }
>>>> +};
>>>> +
>>>>    static const struct dmi_system_id lg_laptop[] = {
>>>>        {
>>>>            .ident = "LG Electronics 17U70P",
>>>> @@ -493,6 +539,10 @@ struct irq_override_cmp {
>>>>    static const struct irq_override_cmp override_table[] = {
>>>>        { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>>>>        { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>>>> +    { lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>>>> +    { lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>>>> +    { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>>>> +    { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>>>>        { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>>>>    };
>>>>    @@ -512,6 +562,16 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>>>>                return entry->override;
>>>>        }
>>>>    +#ifdef CONFIG_X86
>>>> +    /*
>>>> +     * IRQ override isn't needed on modern AMD Zen systems and
>>>> +     * this override breaks active low IRQs on AMD Ryzen 6000 and
>>>> +     * newer systems. Skip it.
>>>> +     */
>>>> +    if (boot_cpu_has(X86_FEATURE_ZEN))
>>>> +        return false;
>>>> +#endif
>>>> +
>>>>        return true;
>>>>    }
>>>>    
>>>
>>
> 

