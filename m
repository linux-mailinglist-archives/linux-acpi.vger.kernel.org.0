Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEE35C00F3
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Sep 2022 17:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiIUPSv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 11:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiIUPSs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 11:18:48 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FDE8B2D6
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 08:18:47 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r134so5296057iod.8
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KLCmAE9UlNDGgLGs2ArJ00VmIdhhVt7eh934lDS0138=;
        b=JURosBZkyeDvy/vyZPMqlVgB6IuAkyD75OrRJfNUt8s3w3vxLN7VamcPkqlyzdXLxr
         6swKXk3vZvHZYdWG8NrSs5fqQ4zSAGVnpshII0vyAtAUYXty40xxoz50U7xZkAXpCBnl
         B3sxf5HQVWZvvDPtd3cWBMqGFvqnM1X5cb4es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KLCmAE9UlNDGgLGs2ArJ00VmIdhhVt7eh934lDS0138=;
        b=z+dHiJepz+HlYcYzZvBNlw1SjsIf4BsGjVfET5V3BXDKlQppMzElvra5EL61lRq4QY
         cpQPJJO4zjpcLv2VQkXkJtYFCcDq++VohU50Yl/UWDGIUHy0N+lbv1Kyp2g94rf9HpRM
         6IxxzPm0HNLbRrchTl9FcPsMd+9aqNb3i7JLDdlfWkTR6IafolAgoHAvGsnYFH/V/I3e
         PAzNq4E9YP4LQ5AVS94/JubOG8ENzpW5fQvkpvdyqoCNsLtquGas4i5PbD/EfyCg0yml
         Waf1BaTOhxgM82hagyvuxlpzaVJqR3QPrjOo6fdCInUn19pGZvb+QS9fW4fhpvtuJLZ0
         XlTQ==
X-Gm-Message-State: ACrzQf0wVduQzDI6njEARPZzELuUCj7eRfznIq/AhYQ/UxSLg/PKEDSI
        q8PNvf6KSQIP6tlILPlt62Arm5qoBz+kAQ==
X-Google-Smtp-Source: AMsMyM7tVSl6GnSddhB7xqaWZ1pKP85TU+euBb/t9o5Iph1CZ2y4PWDe6xC9uSPj84KFXbORRsZo9Q==
X-Received: by 2002:a05:6602:29d1:b0:669:428e:8c59 with SMTP id z17-20020a05660229d100b00669428e8c59mr11308486ioq.85.1663773527042;
        Wed, 21 Sep 2022 08:18:47 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id c17-20020a92c8d1000000b002e939413e83sm1084889ilq.48.2022.09.21.08.18.45
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 08:18:45 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id y15so3300174ilq.4
        for <linux-acpi@vger.kernel.org>; Wed, 21 Sep 2022 08:18:45 -0700 (PDT)
X-Received: by 2002:a92:c569:0:b0:2f5:927d:b61a with SMTP id
 b9-20020a92c569000000b002f5927db61amr7672947ilj.151.1663773525104; Wed, 21
 Sep 2022 08:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220919155916.1044219-1-rrangel@chromium.org>
 <20220919095504.v4.7.I8af4282adc72eb9f247adcd03676a43893a020a6@changeid> <Yymyzcfp7gqdTYam@smile.fi.intel.com>
In-Reply-To: <Yymyzcfp7gqdTYam@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 21 Sep 2022 09:18:34 -0600
X-Gmail-Original-Message-ID: <CAHQZ30C3Wsqbwnpn+9tP2DCDdtMGOqOZ8di77agDcLM7idWxuQ@mail.gmail.com>
Message-ID: <CAHQZ30C3Wsqbwnpn+9tP2DCDdtMGOqOZ8di77agDcLM7idWxuQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] i2c: acpi: Use ACPI wake capability bit to set wake_irq
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Tim Van Patten <timvp@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 20, 2022 at 6:32 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 19, 2022 at 09:59:09AM -0600, Raul E Rangel wrote:
> > Device tree already has a mechanism to pass the wake_irq. It does this
> > by looking for the wakeup-source property and setting the
> > I2C_CLIENT_WAKE flag. This CL adds the ACPI equivalent. It uses the
> > ACPI interrupt wake flag to determine if the interrupt can be used to
> > wake the system. Previously the i2c drivers had to make assumptions and
> > blindly enable the wake IRQ. This can cause spurious wake events. e.g.,
> > If there is a device with an Active Low interrupt and the device gets
> > powered off while suspending, the interrupt line will go low since it's
> > no longer powered and wakes the system. For this reason we should
> > respect the board designers wishes and honor the wake bit defined on the
> > interrupt.
>
> ...
>
> > +     if (irq_ctx.irq == -ENOENT)
> > +             irq_ctx.irq = acpi_dev_gpio_irq_wake_get(adev, 0, &irq_ctx.wake_capable);
>
> I just realized, that there is an inconsistency on how we fill the wake_capable
> parameter. In some cases we check for IRQ for an error condition (IRQ not found)
> and in some the wake_capable still be filled.
>
> Here the best approach I believe is to add
>
>         if (irq_ctx.irq < 0)
>                 return irq_ctx.irq;
>
> I.o.w. we apply the rule "do not fill the output parameters when it's known
> to be an error condition".
>
> > +     if (wake_capable)
> > +             *wake_capable = irq_ctx.wake_capable;
>
> > +     return irq_ctx.irq;
>

I applied the following:
diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index ba64e505183595..1618f5619d5ed9 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -220,7 +220,7 @@ int i2c_acpi_get_irq(struct i2c_client *client,
bool *wake_capable)
        if (irq_ctx.irq == -ENOENT)
                irq_ctx.irq = acpi_dev_gpio_irq_wake_get(adev, 0,
&irq_ctx.wake_capable);

-       if (wake_capable)
+       if (irq_ctx.irq > 0 && wake_capable)
                *wake_capable = irq_ctx.wake_capable;

        return irq_ctx.irq;

Thanks!
