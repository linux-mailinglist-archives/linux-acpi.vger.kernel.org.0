Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB22647258
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 15:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiLHO7u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 09:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiLHO7t (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 09:59:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D0E391D1
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 06:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670511524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJ2M+SWbJkDBWeLHT4aFSyx3tAwlEr/XF5JIMn6YIGs=;
        b=KRhTJWoUQI/chAY+qsOaLbGiJhL5Cg20I1ZO5pLSbT6HsmrrzLSi23fjc/RnFbwpEcdRVL
        BZeK1s2I3fhFVJn/ApfXYyo1JhOF6VkJ6OwRL6N1cMvezYPE8dSbltxfXNlqwM9TlXrq48
        bpUeT6YIQys962tzK2c6uF4MsoXbT/g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-228-xnmVeE-6MdSgqVkUXP7tWg-1; Thu, 08 Dec 2022 09:58:37 -0500
X-MC-Unique: xnmVeE-6MdSgqVkUXP7tWg-1
Received: by mail-ed1-f69.google.com with SMTP id g14-20020a056402090e00b0046790cd9082so1062124edz.21
        for <linux-acpi@vger.kernel.org>; Thu, 08 Dec 2022 06:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ2M+SWbJkDBWeLHT4aFSyx3tAwlEr/XF5JIMn6YIGs=;
        b=DcYZICXqZDnbXIwxm4usV9E1rmQEcp57topoTVDTSbqvHps0kFo0LKMV0XtoO7xMe9
         S3VmALgOghcSWCEt1VUqra/UrphE7bZcRyHdhzMx4oP/6ef2wyf+DZXka1czLDEcV5ji
         j59NeuzQKHECa/aTkzgOKKTNEkBDZQjcCkt6LdR5X/yRkLVonGl1RzLVLvf7Gvml2u4F
         /J6YM/wzUjC8CvAMIoMmrw0woBEQIwzy/L85L04G/nZSfS8AowNsjFcWTCaVOwTfmpKG
         8G6FIlva7tW+Q12rWVPZ9DDRB9BK6Zr0hFiva/RzwEEuQrhQaY9HJRVgmc/+fm+mUFnK
         UiTg==
X-Gm-Message-State: ANoB5plNunYK7xXzdpj2DJKKIhJA8igPJUI4Ce0sjYHdBtpIGYJf02JP
        Sq1tAkbX6eipfAS2+VrEeKWHYzyM0TIQb5gxmIN+afDbhiiBt6McEPFSNtJrGqI1ikYI1pkKNM2
        Wr8si3SPybWxmz005vrOupw==
X-Received: by 2002:a05:6402:883:b0:46c:a1f7:d9ac with SMTP id e3-20020a056402088300b0046ca1f7d9acmr2566665edy.8.1670511516450;
        Thu, 08 Dec 2022 06:58:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf73CUao696nl23/u+m4b3bYq3bl9ZuuaC9r7LCnG0vMZWtlBnm87muNWSm2YYxz3f4fKhdPPw==
X-Received: by 2002:a05:6402:883:b0:46c:a1f7:d9ac with SMTP id e3-20020a056402088300b0046ca1f7d9acmr2566655edy.8.1670511516229;
        Thu, 08 Dec 2022 06:58:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id a19-20020aa7cf13000000b00463c475684csm3502436edy.73.2022.12.08.06.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 06:58:35 -0800 (PST)
Message-ID: <011776d4-4829-9c06-b619-cc65d2abc04e@redhat.com>
Date:   Thu, 8 Dec 2022 15:58:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] ACPI: x86: Add skip i2c clients quirk for Medion
 Lifetab S10346
Content-Language: en-US, nl
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20221208110202.107326-1-hdegoede@redhat.com>
 <CAHp75VdADDeXbu6ERc8ng8AdacHK4=uZeqb5jy0Vx_z3_=ZQmQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VdADDeXbu6ERc8ng8AdacHK4=uZeqb5jy0Vx_z3_=ZQmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/8/22 14:00, Andy Shevchenko wrote:
> On Thu, Dec 8, 2022 at 1:02 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The Medion Lifetab S10346 is a x86 tablet which ships with Android x86 as
>> factory OS. The Android x86 kernel fork ignores I2C devices described in
>> the DSDT, except for the PMIC and Audio codecs.
>>
>> As usual the Medion Lifetab S10346's DSDT contains a bunch of extra I2C
>> devices which are not actually there, causing various resource conflicts.
>> Add an ACPI_QUIRK_SKIP_I2C_CLIENTS quirk for the Medion Lifetab S10346 to
>> the acpi_quirk_skip_dmi_ids table to woraround this.
> 
> workaround
> 
> 
> Both look good to me,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks. I have merged 2/2 into my review-hans branch now.

> Side note. We adding a lot of DMI matching information here and there
> in the drivers and often it gets duplicated in handful of times, Maybe
> at some point we can create a global enum and matching table, let's
> say driver/platform/x86/dmi-platforms.c with
> include/linux/platform_data/x86/platform.h with global enum of the
> platforms?

Maybe, I'm not sure atm the table in x86-android-tablets.c is
__initconst so it gets free-ed. So resident code-size wise
it would not matter.

And it would require replacing the dmi_system_id table
in x86-android-tablets.c with another way to map the enum
values (replacing the DMI matches) to driver_data for
the specific models. Which at best would also be an
__initconst mapping table...

Regards,

Hans


