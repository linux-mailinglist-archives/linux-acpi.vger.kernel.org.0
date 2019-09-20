Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 287F5B8D30
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Sep 2019 10:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405475AbfITIub (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Sep 2019 04:50:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43084 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405396AbfITIub (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Sep 2019 04:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568969429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMQmh6bt7SEPSQlVPTv16Vvaa2lPPh/g7BO6VdZsR2I=;
        b=VxAHyfmTJDhX1mMjkc9zcOdtdeiOR0aEtguSEV5XJrD+tWR5UELnRsB/A02oZzKqfEnzLD
        23Y3mmLJTd988Abb3Qu/bGPCsMgINwhsphfFbjs4WadTcEou2YWPvA6bf8SXjVF862kXYM
        AmcMcRnxq2LUyvKwaxhgVG9jGhU28ao=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-YGGhnYVQPriGMu0czvbDvw-1; Fri, 20 Sep 2019 04:50:28 -0400
Received: by mail-ed1-f72.google.com with SMTP id l9so946320edi.8
        for <linux-acpi@vger.kernel.org>; Fri, 20 Sep 2019 01:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uphOpbAgrdy43BfB/41YtawX2S+90uCA4NiyJq9P2Bw=;
        b=bR4hhEQWLtkjlCbI5AZsQKXo7NdkHEdj96AFYt765MfOZq6LZzqNgvGQHfkbjZSW8p
         UehggZZLkAO3GqdH50qTgNkg9rdji56JgApYD2IsZqNvwHojZx9qjygADXGJmNtf9c2B
         L6ZkmhbFkVQAMhpfoHNsMr91OSVnjQFveNEvTBTB5kar3Ku+omKiOkYEqePW2ykqquhi
         h8RLzdC25hem/rQLduHRuZH+ZtND1BGXLa+dNZ42NkqtejM8g0UwgRBkeHZbVBlI+cCT
         cEnGnyT7AuI4GTjJjR1SQhZGmX30Xxhb9tabu/p4cp1wv8wCp/V90enARpmkZrMA4LiU
         /xfQ==
X-Gm-Message-State: APjAAAVLDyE6iu3sQ3vNBKLQC2d7xUszo6iemITA0eCg6OgdhhW32viK
        WB7BbrXmHQZ0fFvOki3BXfnMYm8apb+heQgXbVbektqoxWGSGHYNS3q8EXXHEOg6shTrjKLt7MQ
        Kw3OYznQj1iQ7aV2dWqGsbA==
X-Received: by 2002:a17:906:e290:: with SMTP id gg16mr7984101ejb.176.1568969426870;
        Fri, 20 Sep 2019 01:50:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxm86r4nDmfGip9Js8Gt2Qa8FhAg8sYxIqzoTYIfqodB2gnkK5U+MAWev/tBSho/seaeE31pg==
X-Received: by 2002:a17:906:e290:: with SMTP id gg16mr7984089ejb.176.1568969426677;
        Fri, 20 Sep 2019 01:50:26 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id z39sm210440edd.46.2019.09.20.01.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 01:50:25 -0700 (PDT)
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <79c9533f-882d-f2b2-b6f3-b94fa49b4367@redhat.com>
Date:   Fri, 20 Sep 2019 10:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190919195624.1140941-1-luzmaximilian@gmail.com>
Content-Language: en-US
X-MC-Unique: YGGhnYVQPriGMu0czvbDvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Maximilian,

Interesting patch. Some comments about the i2c situation below.

Also I will give this a test-run on some of the existing devices
which rely on the instantiation of serdev devices for ACPI
devices which are childs of the uart device.

On 19-09-2019 21:56, Maximilian Luz wrote:
> When registering a serdev controller, ACPI needs to be checked for
> devices attached to it. Currently, all immediate children of the ACPI
> node of the controller are assumed to be UART client devices for this
> controller. Furthermore, these devices are not searched elsewhere.
>=20
> This is incorrect: Similar to SPI and I2C devices, the UART client
> device definition (via UARTSerialBusV2) can reside anywhere in the ACPI
> namespace as resource definition inside the _CRS method and points to
> the controller via its ResourceSource field. This field may either
> contain a fully qualified or relative path, indicating the controller
> device. To address this, we need to walk over the whole ACPI namespace,
> looking at each resource definition, and match the client device to the
> controller via this field.
>=20
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
> This patch is similar to the the implementations in drivers/spi/spi.c
> (see commit 4c3c59544f33e97cf8557f27e05a9904ead16363) and
> drivers/i2c/i2c-core-acpi.c. However, I think that there may be an
> issues with these two implementations: Both walk over the whole ACPI
> namespace, but only match the first SPI or I2C resource (respectively),
> so I think there may be problems when multiple SPI or I2C resources are
> defined under the same ACPI device node (as in second or third SPI/I2C
> resource definitions being ignored).

Right, so from the i2c side of things, the story with multiple
I2cSerialBusV2 resources is that normally we want to instantiate
only 1 kernel "struct device" for 1 ACPI "Device()" definition.

If a single I2C chip/device listens on multiple addresses then
usually the other addresses can be derived from the first one and
the device-driver can get a handle to access the other addresses by
using e.g. i2c_new_dummy or i2c_new_secondary_device.

With that said of course there are exceptions where vendors get
creative and put multiple I2cSerialBusV2 resources in a single
ACPI "Device()" even though they point to separate chips.

For this we have some special handling in:
drivers/platform/x86/i2c-multi-instantiate.c

Also note how drivers/platform/x86/i2c-multi-instantiate.c maps the
original ACPI HID as e.g. "BSG1160" to per device match strings,
because if there are multiple I2cSerialBusV2 resources and they
point to separate chips, then we need something to get the right
driver to bind to each I2cSerialBusV2 address, so the normal
modalias of e.g. acpi:BSG1160 is no good, we need a different modalias
for each I2cSerialBusV2 address.

Another way of looking at this is a typical _CRS for a device with
*SerialBusV2 resources will also have 1 or more Interrupt resources
and 1 or more GPIO resources. We are not instantiating separate
"struct device"-s in the kernel for each of those, since all the
resources together describe a single device, so we instantiate e.g.
an i2c_client and then the i2c_driver's probe method calls e.g.
platform_get_irq() to get the IRQ(s).

Given the above I think you may want to also limit your patch to
only instantiate a "struct device" for the first UARTSerialBusV2
in an ACPI "Device()"'s  .

I hope this sheds some clarity on the (muddy) situation wrt
I2cSerialBusV2 handling.

Regards,

Hans

