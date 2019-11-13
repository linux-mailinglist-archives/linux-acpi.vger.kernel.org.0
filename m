Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242F0FB81A
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2019 19:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfKMSxI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Nov 2019 13:53:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24486 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727216AbfKMSxI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Nov 2019 13:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573671187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+HAHo4BNOqRrUG4b1K5kwYbPMXRPwWPUh+sV4jx464=;
        b=V4LzwybXDUIiuwJ5MPSSHGrpiNcj+O7cEILOf2lfJhiehOQC4niyaRtcyw4w2jWUmm2IPR
        dGEPGd2r3dsXZdzbvHocEaDE7Alyo+bMi94YU3/tL+k5RnA9HTeJTHZwbO8kYwXJVRsifi
        DtCKfJQIGVpP/NL8UM+/6kFBhCoDW5c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-TNV5CqJINX21-8PcgjzkOw-1; Wed, 13 Nov 2019 13:53:02 -0500
Received: by mail-wr1-f70.google.com with SMTP id w9so2224048wrn.9
        for <linux-acpi@vger.kernel.org>; Wed, 13 Nov 2019 10:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lOcI/zp+bxBnYkB4CrKpl1njMNwmC2784UB3qltnyqw=;
        b=okE1WWR4DDVOFSP4KQgwfelTDnt+rW7wuQ7u0kcQ4KTssE2Oj1RAt0CXQDLC9Umnoy
         Do9gllBP8x3+AphLYw8Dk/L7F43BAqnJjhvMOADVADilARTcrJvNj1XSWGjybtZONFIU
         4c2SGnLrruDpp30EIdaFNIBgetWURJcx/9osurt7k+Nk2h+5IvACJLHel1Ebz0vgFJKM
         VHIhL7ED5174Ev3QzkJnjrrNU4aWzYbxVQ2i/tu1feeAUln4uq4LJrjBr1sWh/ZXWLfv
         +K8im27RO0Vni7SbgtyFVSfz1+ZeJolM3VsgSYJ56XC3pHu2fsOZXPkyFxIsg2qAo5he
         nFYg==
X-Gm-Message-State: APjAAAU25LNJG+b8cHRb7kRkAPAFJcBAmNH24lc2ZWFmOfptr5y5yL5L
        afhnAjNNKkNl/m7UCw5enM5Wikn1OrhE86ujG60CUmyZTDd60uMJfZFYcovHaZqG/CmmTNlJDLw
        A+cGNjSY5pWPe34KdnWYLEg==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr1072829wrq.70.1573671181471;
        Wed, 13 Nov 2019 10:53:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFyZKber1u3LPbNRbr1/dl4EJ6L4KuzEpLv31MGG9lKn4KkBDLP10DXdNtzZYAKEzXmOkqUg==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr1072814wrq.70.1573671181302;
        Wed, 13 Nov 2019 10:53:01 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x8sm3942716wrm.7.2019.11.13.10.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 10:53:00 -0800 (PST)
Subject: Re: [PATCH v2 3/3] pinctrl: cherryview: Pass irqchip when adding
 gpiochip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20191106154715.155596-1-hdegoede@redhat.com>
 <20191106154715.155596-4-hdegoede@redhat.com>
 <20191106161622.GM32742@smile.fi.intel.com>
 <20191106161753.GN32742@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <46a5e93d-b6d9-8c8d-647b-5a74840cea3d@redhat.com>
Date:   Wed, 13 Nov 2019 19:52:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191106161753.GN32742@smile.fi.intel.com>
Content-Language: en-US
X-MC-Unique: TNV5CqJINX21-8PcgjzkOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 06-11-2019 17:17, Andy Shevchenko wrote:
> On Wed, Nov 06, 2019 at 06:16:22PM +0200, Andy Shevchenko wrote:
>> On Wed, Nov 06, 2019 at 04:47:15PM +0100, Hans de Goede wrote:
>>> We need to convert all old gpio irqchips to pass the irqchip
>>> setup along when adding the gpio_chip. For more info see
>>> drivers/gpio/TODO.
>>>
>>> For chained irqchips this is a pretty straight-forward conversion.
>>
>>> +=09chip->irq.chip =3D &pctrl->irqchip;
>>
>>> +=09if (pctrl->need_valid_mask)
>>> +=09=09chip->irq.init_valid_mask =3D chv_init_irq_valid_mask;
>>
>> I just realize we probably may assign here unconditionally
>=20
> Continuing...
>=20
>>
>>> +=09chip->irq.init_hw =3D chv_gpio_irq_init_hw;
>>> +=09chip->irq.parent_handler =3D chv_gpio_irq_handler;
>>> +=09chip->irq.num_parents =3D 1;
>>> +=09chip->irq.parents =3D &pctrl->irq;
>>> +=09chip->irq.default_type =3D IRQ_TYPE_NONE;
>>> +=09chip->irq.handler =3D handle_bad_irq;
>>>  =20
>>>   =09if (!pctrl->need_valid_mask) {
>=20
> And here turn it back to NULL and check the pointer against NULL instead =
of
> additional variable.
>=20
> What do you think?

I think that first setting it and then clearing it again is not
very pretty. But ...

I do think you are on to something, we can use pctrl->chip.irq.init_valid_m=
ask
instead of storing the dmi quirk in the chv_pinctrl struct.

Then we can leave the dmi handling as is, and replace later checks for
the dmi quirk (in callbacks) with a check for pctrl->chip.irq.init_valid_ma=
sk
I do believe that that is better then adding a need_validmask member to
the chv_pinctrl struct, I will prepare a v3 of the series with this change.

Regards,

Hans

