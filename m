Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419DC68DE04
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Feb 2023 17:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjBGQeM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 Feb 2023 11:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjBGQeK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2023 11:34:10 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B152636448
        for <linux-acpi@vger.kernel.org>; Tue,  7 Feb 2023 08:34:09 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id iy2so6055852plb.11
        for <linux-acpi@vger.kernel.org>; Tue, 07 Feb 2023 08:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feOVtnjSZjGmTAyYmWKNjD+1i+clfm4gUti33NkjnFE=;
        b=QWndu82h99RLtpJE9U+c0/bTDJlFJzKzM9JyXRGUS5IxQpxbGwsN1vxTOHqvZJgLEs
         ZFgO/NcQhPCf4iyRAzJcyseyWcbFbXElxJP/Lo7c4kKzQ0RAhkmvY/TXB74x0sqsWGnu
         AEiEbXoigy7Mzf9i749C+j1vAy6do/vGGRcJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feOVtnjSZjGmTAyYmWKNjD+1i+clfm4gUti33NkjnFE=;
        b=ulQiqdpcCnZMoSpL1ZmC4fE6QfiGXk7MRlChPHmy+Oxvb6eVwo2F5nKfu55iFQacQ2
         9H3nvAL3Ims/zdxRgBYbtFpycOPBfnooQO+keybtrEMSzANvQ41fOB3WH00sPKuIPEg3
         ngVWBMsB5yFjiNoqMdOKdEMn+BfJqJOO8268YV7c4NtyyGwzjaI1Ec6Wy0rzJq27/Pyy
         XFM49jfE2dpplZFpMqzebeYX4xkIsnTY5i+nP0JvozXYDVKvdQBT1bf9x3f1xyNIxJ5Z
         Xz5bb3IRchx1hw9gVFJgYCZW+Twzzdy8il8TqoMTRw3gHVyDDD64gpwNDnqqLL1gbbb3
         4o7A==
X-Gm-Message-State: AO0yUKUtOMd3vKZNBlIL6TWOMFu3MKGM6VSEXQPzeovz+7OrSCPT42+f
        wypStFbig+DVm0UJ0j+Nh2Xbn8RipV+g7MZZ
X-Google-Smtp-Source: AK7set9FzmSrXjwVirA+c/CDvnz9QNzqaMe2/ylnBIwoK8SHV9tbtcodNYb2T6lW2CAwvvqvoI34gA==
X-Received: by 2002:a17:902:dac8:b0:198:f1d0:f9fd with SMTP id q8-20020a170902dac800b00198f1d0f9fdmr4335674plx.27.1675787649022;
        Tue, 07 Feb 2023 08:34:09 -0800 (PST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com. [209.85.210.178])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902c14400b001993c1a42dbsm197689plj.206.2023.02.07.08.34.07
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 08:34:07 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id h197so1587595pfe.12
        for <linux-acpi@vger.kernel.org>; Tue, 07 Feb 2023 08:34:07 -0800 (PST)
X-Received: by 2002:a63:7250:0:b0:499:7f08:40c3 with SMTP id
 c16-20020a637250000000b004997f0840c3mr772244pgn.80.1675787646796; Tue, 07 Feb
 2023 08:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20230207072540.27226-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20230207072540.27226-1-mika.westerberg@linux.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 7 Feb 2023 09:33:55 -0700
X-Gmail-Original-Message-ID: <CAHQZ30Bzn1Lxy+Y2gCcFTmzWzwnxqUZAHAjSh67Pz=WweaKHkg@mail.gmail.com>
Message-ID: <CAHQZ30Bzn1Lxy+Y2gCcFTmzWzwnxqUZAHAjSh67Pz=WweaKHkg@mail.gmail.com>
Subject: Re: [RFC] i2c: core: Do not enable wakeup by default
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Wolfram Sang <wsa@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sorry, resending in plain text mode.

On Tue, Feb 7, 2023 at 12:25 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> After commit b38f2d5d9615 ("i2c: acpi: Use ACPI wake capability bit to
> set wake_irq") the I2C core has been setting I2C_CLIENT_WAKE for ACPI
> devices if they announce to be wake capable in their device description.
> However, on certain systems where audio codec has been connected through
> I2C this causes system suspend to wake up immediately because power to
> the codec is turned off which pulls the interrupt line "low" triggering
> wake up.
>
> Possible reason why the interrupt is marked as wake capable is that some
> codecs apparently support "Wake on Voice" or similar functionality.

That's generally a bug in the ACPI tables. The wake bit shouldn't be
set if the power domain for the device is powered off on suspend. The
best thing is to fix the ACPI tables, but if you can't, then you can
set the ignore_wake flag for the device:
https://github.com/torvalds/linux/blob/master/drivers/gpio/gpiolib-acpi.c#L=
31.
If that works we can add a quirk for the device:
https://github.com/torvalds/linux/blob/master/drivers/gpio/gpiolib-acpi.c#L=
1633.

>
> In any case, I don't think we should be enabling wakeup by default on
> all I2C devices that are wake capable. According to device_init_wakeup()
> documentation most devices should leave it disabled, with exceptions on
> devices such as keyboards, power buttons etc. Userspace can enable
> wakeup as needed by writing to device "power/wakeup" attribute.

Enabling wake by default was an unintended side-effect. I didn't catch
this when I wrote the patch :/ It's been exposing all the incorrect
ACPI configurations for better or worse. Mario pushed a patch up
earlier to disable thes Wake GPIOs when using S3:
https://github.com/torvalds/linux/commit/d63f11c02b8d3e54bdb65d8c309f73b7f4=
74aec4.
Are you having problems with S3 or S0iX?

>
> Reported-by: Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@linux.inte=
l.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Hi,
>
> Sending this as RFC because I'm not too familiar with the usage of
> I2C_CLIENT_WAKE and whether this is something that is expected behaviour
> in users of I2C devices. On ACPI side I think this is the correct thing
> to do at least.
>
>  drivers/i2c/i2c-core-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 087e480b624c..7046549bdae7 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -527,7 +527,7 @@ static int i2c_device_probe(struct device *dev)
>                         goto put_sync_adapter;
>                 }
>
> -               device_init_wakeup(&client->dev, true);
> +               device_init_wakeup(&client->dev, false);

This would be a change in behavior for Device Tree. Maybe you can
declare a `bool enable_wake =3D true`, then in the ACPI branch
(https://github.com/torvalds/linux/blob/master/drivers/i2c/i2c-core-base.c#=
L495)
set `enable_wake =3D false`. This would keep wakes enabled by default on
device tree and disabled for ACPI. This matches the original behavior
before my patch.

>
>                 if (wakeirq > 0 && wakeirq !=3D client->irq)
>                         status =3D dev_pm_set_dedicated_wake_irq(dev, wak=
eirq);
> --
> 2.39.1
>
