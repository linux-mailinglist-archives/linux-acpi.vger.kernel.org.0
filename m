Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980E1DECCC
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2019 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfJUMwV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Oct 2019 08:52:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31334 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727256AbfJUMwU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Oct 2019 08:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571662339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v0q/2r1staKsQqPYNqdrvoxSoEvvpK1J/Oj8MMto9ec=;
        b=fDSrS7QRTWeSFQSr5DGOBzRimcK6c6tfMU+zSImOnhoE1aU9ffaJuFB6kOS8a9KMq83aBv
        COefdcjKh4YgEeNGE6udy34u4pjRu56arFfCIGgZMCq19NjB21Wf+yaTrxmxPy/A4Owaag
        VAj3A6llqxDuxkqTEUerpyR0/HD1Gk8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-iaxRIaBcOLabdbMfBor5eg-1; Mon, 21 Oct 2019 08:52:18 -0400
Received: by mail-wm1-f70.google.com with SMTP id z205so5927906wmb.7
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2019 05:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L3a2L4n50fLugXvRAz4YfEyDEkIb5FdOOCPTaoR8O7E=;
        b=rnqngW12+OQBm2ukz4aM/XcZrIegVhsZdEw9BmYZEV7Y8WE9yi/CN6CfbRRThrFcUn
         LprwRrucbTVVml73dXsL1w+V/Wo49LsYIfdDAgkNDFUsynGrZKx5+K1848lrJOI6ryX5
         KdOn27gt779EjlonLKd6G+kw06q6HFE0LwCGAtNrhgwt9DsJ5yIxSfDn+EtlP8UKMB42
         wr18hMS29wXqqQCTjUs/Ktav9XH+MPnFwFZzd+R1IblSvGg6xoI+PmTwbGcClX19HqoM
         gCBpcniy1SrjxyiAuprUWcsdFwV+1+iGrZtGRJq1E2NibhGcmpKjJjby1XeEXVelEzXn
         R63g==
X-Gm-Message-State: APjAAAXBmaWPICVuLv2Dm4citv9W3NeY1e72kmC1q3svjEhJ/nROid4Y
        POu04qwI8tnoIXGmzAovRRIlfgt72HbUOBmLQmtDY4zKqEDxriS7bI0R77/H3cbpRMwS44A3Mnn
        awfJPBeRA1Jvvr0uYJL9Rzw==
X-Received: by 2002:a1c:a751:: with SMTP id q78mr7163549wme.129.1571662336981;
        Mon, 21 Oct 2019 05:52:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwh+9X9yUCNJ47ZHE6Aj3Otv40L+iJkSA4CdOIMemhpWoReytWc3J4znlr0MqYoA863d7pzuw==
X-Received: by 2002:a1c:a751:: with SMTP id q78mr7163534wme.129.1571662336794;
        Mon, 21 Oct 2019 05:52:16 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id c21sm13265212wmb.46.2019.10.21.05.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 05:52:15 -0700 (PDT)
Subject: Re: [PATCH] gpiolib: acpi: Print pin number on
 acpi_gpiochip_alloc_event errors
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20191018195208.94405-1-hdegoede@redhat.com>
 <20191021091124.GK32742@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f3294033-8105-8c26-a8e2-3ced55276fdb@redhat.com>
Date:   Mon, 21 Oct 2019 14:52:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021091124.GK32742@smile.fi.intel.com>
Content-Language: en-US
X-MC-Unique: iaxRIaBcOLabdbMfBor5eg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 21-10-2019 11:11, Andy Shevchenko wrote:
> On Fri, Oct 18, 2019 at 09:52:08PM +0200, Hans de Goede wrote:
>> Print pin number on acpi_gpiochip_alloc_event errors, to help debugging
>> these.
>=20
> I'm not sure which one is better decimal or hex, perhaps Mika can help me=
, in any case

They are listed as hex in the dis-assembled DSTD.

Regards,

Hans




> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/gpio/gpiolib-acpi.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
>> index 609ed16ae933..2911dd6f2625 100644
>> --- a/drivers/gpio/gpiolib-acpi.c
>> +++ b/drivers/gpio/gpiolib-acpi.c
>> @@ -230,19 +230,22 @@ static acpi_status acpi_gpiochip_alloc_event(struc=
t acpi_resource *ares,
>>   =09desc =3D gpiochip_request_own_desc(chip, pin, "ACPI:Event",
>>   =09=09=09=09=09 GPIO_ACTIVE_HIGH, GPIOD_IN);
>>   =09if (IS_ERR(desc)) {
>> -=09=09dev_err(chip->parent, "Failed to request GPIO\n");
>> +=09=09dev_err(chip->parent,
>> +=09=09=09"Failed to request GPIO for pin 0x%02X\n", pin);
>>   =09=09return AE_ERROR;
>>   =09}
>>  =20
>>   =09ret =3D gpiochip_lock_as_irq(chip, pin);
>>   =09if (ret) {
>> -=09=09dev_err(chip->parent, "Failed to lock GPIO as interrupt\n");
>> +=09=09dev_err(chip->parent,
>> +=09=09=09"Failed to lock GPIO pin 0x%02X as interrupt\n", pin);
>>   =09=09goto fail_free_desc;
>>   =09}
>>  =20
>>   =09irq =3D gpiod_to_irq(desc);
>>   =09if (irq < 0) {
>> -=09=09dev_err(chip->parent, "Failed to translate GPIO to IRQ\n");
>> +=09=09dev_err(chip->parent,
>> +=09=09=09"Failed to translate GPIO pin 0x%02X to IRQ\n", pin);
>>   =09=09goto fail_unlock_irq;
>>   =09}
>>  =20
>> --=20
>> 2.23.0
>>
>=20

