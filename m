Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA231FC37A
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 11:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfKNKAm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 05:00:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33251 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726254AbfKNKAm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Nov 2019 05:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573725641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8YWe8yK+T1KdpozhYe48rwSiMeJJznKbthAkqCF0LQ=;
        b=RCyEtYKVZhUkvUw5oq5eXhT99WduVRH1ySJUNopwzBcYn/mYTcQqts5/GAc2iw1mdb6lKN
        Gdp65L3P9nYsaQbv+nRIcg+2b/YCmkutdf8LGBG7EKrVi6xqWjKgRpcSxi4LaHnR/klGme
        BfdPXZ8/U+ISWoD67adVByN4v7LCa5I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-fe3Z3vpHM6apr24ZU0cqEw-1; Thu, 14 Nov 2019 05:00:40 -0500
Received: by mail-wr1-f69.google.com with SMTP id e3so4083097wrs.17
        for <linux-acpi@vger.kernel.org>; Thu, 14 Nov 2019 02:00:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+4GFx2q9fN2h3EdrJtju3tt8akWWsgPxZJ2KeupG3js=;
        b=Esq9iELckopkg0QZGzvMTpfgOwfM9pDobDd/H/euxWrSr+rTV6g6byXhRKV+qj2Xpy
         qAbvRwZDUkkr85l+flvQgpB8/xcxGc3ZoUqoq86J6PcqWAZf+hYMNiAfr7QPgL2ldFNU
         QjziRZ6kGku5MzlBG4g9MG4j3A+PWFLhArS1i4dbjc+Xv10jFBXBaKoZo0yS4z2jbREZ
         HqAC3hCCP3Rclxt6hyiDOt1FtEnbm/SPl7bGXFmPiWH/brCNcstLtDNsIbOGmyQCIZX4
         nx3FJz5ykAhxUjMUZRzJU1Z+gODt/KsBJejzEbQLCl7SzK5PJDBvBoBv97ry5Yna6oy7
         6MQw==
X-Gm-Message-State: APjAAAVajEhCsdFXqU0GYHZgAh6W5fOza+ymEYAqGl9JFKr2zJC7zUjg
        S83cSr8ValZBG/k8N9/hdSJKg3EHl6SNIAQ0T4aDTnTRptiK9h7J4wT5Q3VsOd+qWn3H1lwOc24
        TKxUO4RX+UqFuf/zMhj/xWg==
X-Received: by 2002:a1c:544b:: with SMTP id p11mr7309468wmi.46.1573725638538;
        Thu, 14 Nov 2019 02:00:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZ21GFvErXeJ1vGEJsYCgDUDxccSjuUAoJajJT+I+IBYExwp8sW/BN7+QAzVKccYFVuxyqdw==
X-Received: by 2002:a1c:544b:: with SMTP id p11mr7309445wmi.46.1573725638303;
        Thu, 14 Nov 2019 02:00:38 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id z11sm8286936wrg.0.2019.11.14.02.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 02:00:37 -0800 (PST)
Subject: Re: [PATCH v3 3/3] pinctrl: cherryview: Pass irqchip when adding
 gpiochip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20191113190520.305410-1-hdegoede@redhat.com>
 <20191113190520.305410-3-hdegoede@redhat.com>
 <20191113192722.GK32742@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ee61eaa1-320c-964c-711c-407b7dec8311@redhat.com>
Date:   Thu, 14 Nov 2019 11:00:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191113192722.GK32742@smile.fi.intel.com>
Content-Language: en-US
X-MC-Unique: fe3Z3vpHM6apr24ZU0cqEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 13-11-2019 20:27, Andy Shevchenko wrote:
> On Wed, Nov 13, 2019 at 08:05:20PM +0100, Hans de Goede wrote:
>> We need to convert all old gpio irqchips to pass the irqchip
>> setup along when adding the gpio_chip. For more info see
>> drivers/gpio/TODO.
>>
>> For chained irqchips this is a pretty straight-forward conversion.
>>
>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
>>   =09struct irq_chip irqchip;
>>   =09void __iomem *regs;
>> +=09unsigned int irq;
>>   =09unsigned intr_lines[16];
>=20
> This will conflict with our for-next.

Ah, I did cherry-pick intel-pinctrl for-next into my tree a couple of days
back, but I see there is a new "pinctrl: cherryview: Missed type change to =
unsigned int"
commit there which causes this conflict. I have cherry picked this new
commit into my tree and I will send out a v4 which should not conflict.

>=20
>> +=09if (need_valid_mask)
>> +=09=09chip->irq.init_valid_mask =3D chv_init_irq_valid_mask;
>> +=09chip->irq.init_hw =3D chv_gpio_irq_init_hw;
>> +=09chip->irq.parent_handler =3D chv_gpio_irq_handler;
>> +=09chip->irq.num_parents =3D 1;
>> +=09chip->irq.parents =3D &pctrl->irq;
>> +=09chip->irq.default_type =3D IRQ_TYPE_NONE;
>> +=09chip->irq.handler =3D handle_bad_irq;
>>  =20
>>   =09if (!need_valid_mask) {
>>   =09=09irq_base =3D devm_irq_alloc_descs(pctrl->dev, -1, 0,
>=20
>=20
> Perhaps now it makes sense to
>=20
> =09if (need_valid_mask) {
> =09=09chip->irq.init_valid_mask =3D chv_init_irq_valid_mask;
> =09} else {
> =09=09irq_base =3D devm_irq_alloc_descs(pctrl->dev, -1, 0,
> =09=09...
> =09} >
> ?

Ack good one, will also change this for v4.

Regards,

Hans

p.s.

About upstreaming this, I know this has a pre-requisite on the new add_rang=
es
callback stuff, but how about Linus Walleij creating an immutable branch
of his tree with the first series which adds the add_ranges callback in
there and then you merge that branch into pinctrl-intel/for-next and then
we just upstream all of this for 5.5 ? That seems easier then spreading
it out over 2 cycles. Just my 2 cents.

