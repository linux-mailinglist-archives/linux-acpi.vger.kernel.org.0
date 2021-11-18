Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EEB456490
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 21:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhKRU7U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 15:59:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229905AbhKRU7T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Nov 2021 15:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637268979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29keOWINh9ySKUeYwc3es/vFRv61MxyNUwkXnbTagyQ=;
        b=eqnEJy0MsnPcwAb4CK6J4khuGpO+2HNdBQZ/ALPgEPV5EFC3ZUwIH3Gu7S+dTW3oo6y/x+
        bratH+ZjaLBhua/9ZaysxfHH3Ns+FENthzPekkgVHJrisN+EHk6GhTbepJB3BCkq5uGIoa
        hZcrutrTx+dPqVJtiz6PFFouyXId9h0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-T206QUlLM6eXpF1l--hBmQ-1; Thu, 18 Nov 2021 15:56:17 -0500
X-MC-Unique: T206QUlLM6eXpF1l--hBmQ-1
Received: by mail-ed1-f70.google.com with SMTP id v1-20020aa7cd41000000b003e80973378aso4878036edw.14
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 12:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=29keOWINh9ySKUeYwc3es/vFRv61MxyNUwkXnbTagyQ=;
        b=28Uvsn4pGDXe89I9Ew6mcdycoFrjgPco3eTH8x40gL3SZkNvfEzqMbZ8zaW1VjkjIy
         2JFYcbOhbC3IuZRy8cRlAn4rmvENG9fId5eXqE5zFM4+kp0hzsuc5IAnQOYHGQPz/rNL
         bcdTLeu4HF/7AtFITA2aOXc5j6Q2TfWdIKh9MgSlZjkJQWb77eddUMLzLXZGaf4rWAzJ
         UObxVAuDbz736uBj6VvZ5T1oR9TQmF4inkfLufQ558Pk4UhiuOquxaSuRuFJAO3ywSpg
         kF3ZwYEiaLt0KGrM2OsaqqIyrlzkx7mG4nqW/OmNtLmC3SROz/YhY0QcfP+Af4794I63
         y4sA==
X-Gm-Message-State: AOAM530KlHK69fSHELJvPOKNnCVw6xowGluumtg9oeISW+B4f6lSjBsM
        UQNa1rCcMds7QE5cqjhL2smVK/wIlKs7DJx82oBu2HWW+0bpPX1srYt1xIDVdlWPY5GiF4r89x3
        +O/Jhq4QZKGdvFY4LId6ODQ==
X-Received: by 2002:a05:6402:2026:: with SMTP id ay6mr15706482edb.202.1637268976485;
        Thu, 18 Nov 2021 12:56:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJws+VE29QbWq7lI2Dec12W1vdheK6gd+7AgJpDDNMFYmtuh3TygiBKuosIRDsXFQkxD5NzF/w==
X-Received: by 2002:a05:6402:2026:: with SMTP id ay6mr15706451edb.202.1637268976325;
        Thu, 18 Nov 2021 12:56:16 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q7sm485820edr.9.2021.11.18.12.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 12:56:16 -0800 (PST)
Message-ID: <bf374007-c40b-f59d-010c-d68fc520790f@redhat.com>
Date:   Thu, 18 Nov 2021 21:56:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] ACPI / x86: Revert: Make PWM2 device always present at
 Lenovo Yoga Book
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20211113135206.5384-1-hdegoede@redhat.com>
 <YZABGfarFQoxpf1R@jeknote.loshitsa1.net>
 <CAJZ5v0gcJ_Ke6Ppw78Qv9n_Pws20+YBPJX8j0Pa_U=OLHmELfA@mail.gmail.com>
 <CAJZ5v0iufQMJgybSxfek13+034LuyYpj51ybD-Ke0kj4zRa4MQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0iufQMJgybSxfek13+034LuyYpj51ybD-Ke0kj4zRa4MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/18/21 19:54, Rafael J. Wysocki wrote:
> On Tue, Nov 16, 2021 at 8:25 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Sat, Nov 13, 2021 at 7:17 PM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
>>>
>>> On Sat, Nov 13, 2021 at 02:52:06PM +0100, Hans de Goede wrote:
>>>> It turns out that there is a WMI object which controls the PWM2 device
>>>> used for the keyboard backlight and that WMI object also provides some
>>>> other useful functionality.
>>>>
>>>> The upcoming lenovo-yogabook-wmi driver will offer both backlight
>>>> control and the other functionality, so there no longer is a need
>>>> to have the lpss-pwm driver binding to PWM2 for backlight control;
>>>> and this is now actually undesirable because this will cause both
>>>> the WMI code and the lpss-pwm driver to poke at the same PWM
>>>> controller.
>>>
>>> Acked-by: Yauhen Kharuzhy <jekhor@gmail.com>
>>>
>>>>
>>>> Revert commit ff6cdfd71495 ("ACPI / x86: Make PWM2 device always present
>>>> at Lenovo Yoga Book"), removing the always-present quirk for the PWM2
>>>> ACPI-device, so that the lpss-pwm controller will no longer bind to it.
>>>>
>>>> Cc: Yauhen Kharuzhy <jekhor@gmail.com>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> ---
>>>>  drivers/acpi/x86/utils.c | 4 ----
>>>>  1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
>>>> index cb988f9b23a1..bfcb76888ca7 100644
>>>> --- a/drivers/acpi/x86/utils.c
>>>> +++ b/drivers/acpi/x86/utils.c
>>>> @@ -54,10 +54,6 @@ static const struct always_present_id always_present_ids[] = {
>>>>       ENTRY("80860F09", "1", X86_MATCH(ATOM_SILVERMONT), {}),
>>>>       ENTRY("80862288", "1", X86_MATCH(ATOM_AIRMONT), {}),
>>>>
>>>> -     /* Lenovo Yoga Book uses PWM2 for keyboard backlight control */
>>>> -     ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
>>>> -                     DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
>>>> -             }),
>>>>       /* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control */
>>>>       ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
>>>>               DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
>>>> --
>>
>> Applied as 5.16-rc2 material, thanks!
> 
> I've decided to make this change in 5.17.

That is fine, the WMI driver won't land before then anyways.

> It would be good to put the patch under a different subject too,
> because the way it is may confuse someone to regard it as a fix.

Ack, I will send a v2 with a commit msg which makes it less likely
this gets picked into a stable series.

Note if it does end up in a stable series that is fine too, there
were plans to use the LPSS PWM driver to driver the kbd backlight
but those were never fulfilled so the ACPI PWM device getting
its default _STA return of 0 back on older kernels will not
matter.

Regards,

Hans

