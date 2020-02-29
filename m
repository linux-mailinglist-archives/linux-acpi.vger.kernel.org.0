Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1599A17489F
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Feb 2020 19:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgB2SOf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 29 Feb 2020 13:14:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54597 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727314AbgB2SOf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 29 Feb 2020 13:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583000074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hoU8K7lmVxB2DxULfOjJQYORwunWEmNAqcyibntU0Kg=;
        b=iIWeQ1bVI3ow68SdX7s/ePsdoj5vg9ewH5dwaBFQWyAQ/smcO9lMbgrUbkpM1VzCXEbM/b
        //ncC5fTamg/ZyFhDfF9GqyGz7wjrwzh502ysJEqsOA+Zr6EVbUibhFt76EAoiWFiXpXFM
        d9QedW+5yyr5LcOYSBkb5Ms0aUyTfZM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-9nU_KWNYPe2RgFi2VaJW0w-1; Sat, 29 Feb 2020 13:14:31 -0500
X-MC-Unique: 9nU_KWNYPe2RgFi2VaJW0w-1
Received: by mail-wr1-f72.google.com with SMTP id u18so3145441wrn.11
        for <linux-acpi@vger.kernel.org>; Sat, 29 Feb 2020 10:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hoU8K7lmVxB2DxULfOjJQYORwunWEmNAqcyibntU0Kg=;
        b=ZBic8SV7qTrexyiiMn7RekGLmsdp7ZoNu9lhMqobDxnbEVeZNOnqp38HLdCiTaiTHy
         ciQfVx5W1EbwUNtkKx4iTXyG1SblfeWKAybtlws6p6zRPRG6Xxjv0yzXkRdoUqha0DXu
         SNJ8Xr1ZQ52Uhhomyn+yRzxUqbrGi/jg8S63lu8gC3sU3ZgWCHEbQxlR8lj5BC6XTHVp
         9yEQLDOSGi+M6RMnirx9iKM8TsFMH98MEOv2hbsatmMdk0hVuFaKiiCSk8ZemzfZQwCf
         I7BoUEGZTfVJC9XBfdjEtFQxFwgiMgMA9ZDvL4tbnRBrrXzrIZJ0f5FwnWMAmoq+dk0a
         Nnjw==
X-Gm-Message-State: APjAAAWobQcLLxMZUK8pbA4dPhlw3RrlxfHOcDjl/uJEvIZn/UG5C4c4
        LOyvN31tKyyyQlEq2MWvQG+p6IvulGK4x6Fq/ZisKHNYSS46gf5+sX/JvCCLCRfKk7TrUC7oDH0
        PhXewmC91P52qg1TVyqT+kA==
X-Received: by 2002:adf:e542:: with SMTP id z2mr12193162wrm.150.1583000070084;
        Sat, 29 Feb 2020 10:14:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqwewR/nz74BPPb/ljig/lJrvBCI32Bq+jkBuhoNyB4A/Bz349qUg566eVEzjX+g6m2Zn/vfTg==
X-Received: by 2002:adf:e542:: with SMTP id z2mr12193149wrm.150.1583000069857;
        Sat, 29 Feb 2020 10:14:29 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id w19sm6941566wmc.22.2020.02.29.10.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 10:14:29 -0800 (PST)
Subject: Re: [PATCH resend 1/3] gpiolib: acpi: ignore-wakeup handling rework
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marc Lehmann <schmorp@schmorp.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20200225102753.8351-1-hdegoede@redhat.com>
 <CACRpkdb3W=fL3VnNSep2MFnihqEj5GwWsN6BdWRSWckZBMHAOg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <80cc50cf-68e6-5208-36aa-97dbecc38b8f@redhat.com>
Date:   Sat, 29 Feb 2020 19:14:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb3W=fL3VnNSep2MFnihqEj5GwWsN6BdWRSWckZBMHAOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

On 2/28/20 11:54 PM, Linus Walleij wrote:
> On Tue, Feb 25, 2020 at 11:28 AM Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> The first patch just updates the comment describing why we are ignoring
>> GPIO ACPI event wakeups on HP x2 10 models.
> 
> OK
> 
>> The second patch is more interesting, in the mean time I've learned their
>> are actually at least 3 variants of the HP x2 10, and the original quirk
>> only applies to the Cherry Trail with TI PMIC variant (and the original
>> DMI match only matches that model). We need a similar quirk for the
>> Bay Trail with AXP288 model, but there we only want to ignore the wakeups
>> for the GPIO ACPI event which is (ab)used for embedded-controller events
>> on this model while still honoring the wakeup flags on other pins.
>>
>> I'm not 100% happy with the solution I've come up with to allow ignoring
>> events on a single pin. But this was the best KISS thing I could come up
>> with. Alternatives would involve string parsing (*), which I would rather
>> avoid. I'm very much open to alternatives for the current approach in the
>> second patch.
>>
>> Since sending out the first 2 patches of this series I've received
>> positive testing feedback for the quirk for the HP X2 10 Cherry Trail +
>> AXP288 PMIC variant, so here is a resend of the first 2 patches with
>> a third patch adding a quirk for the third variant of HP X2 10 added.
> 
> I'm waiting for some ACPI person to say yes to this,
> Mika ideally but the other Intel guys like Andy also works :)

In the mean time Anday has reviewed the series and as somewhat expected
he did not like the second patch very much. I'm working on an updated version
fixing Andy's concerns.

Regards,

Hans

