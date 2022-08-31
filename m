Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407275A855A
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Aug 2022 20:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiHaSST (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Aug 2022 14:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiHaSRz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2022 14:17:55 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B92DF23C9
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 11:14:22 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c9so11459819qkk.6
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=J57R+POjwarkhG0ohhPSH5aFm2b5W+GSzqYH/OtjluE=;
        b=coq0jRegFak07tL9CfIRw4qNyOsmTDdAeVhAFqpTTL9xu73mkSXYqMAd+h0jjTLInR
         YODQQ0l2SqeQrlpzTx49Z8yMSslvrqdOT3yyTgiPhTkvq/50a7Kr1TM3nT7Nz/KzlAUe
         JQ8RoQha7mg7lJPcdNXGfesGbfZZ6bYAZUF9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=J57R+POjwarkhG0ohhPSH5aFm2b5W+GSzqYH/OtjluE=;
        b=Co3n/mP/6LnpxzsI2LHxDyjXX0Np4/OYF9oIa3/CAwqzMIJwgHW58BEZpZgmxzMZrJ
         GYJqOXSv3BS4DEgOMBUlbJavkE7lZmTXB/Lx4gxnqp/ffD+ltTQ+GC1zaEofpLXx+rNN
         o91GUCPzOUZ2L+EnlwMeykQsIB0mtljFl1rfF9fUrgebX1Is7ywOrFDCgfdkyaz8mpnj
         zogHlT5BhfkZQcASVPLwgDKO5waPDhBpwpQfnFIhvVUeoF4/vRKHQQia0/p74Ns2ZurN
         m3p49timjnEf4JhF+peYeimj4WWiVE0W4dtJ+kLils2XMVAmueYjmrlELCgdWeA1AEet
         4RjQ==
X-Gm-Message-State: ACgBeo2Yjxwz/+qja4AVYJYIPAFwBAPkMT7P9jeVK7XssUi61JS47sGO
        uj4KbM/atPW48saGTTxtVmkIQ/2Rp0NyUg==
X-Google-Smtp-Source: AA6agR5MSfCP4fvcQKoWnfuejD4WvSMrNUdFI6/MRKaTumwlB7LhvtWjxa0ZfvHa7YaCUy+T1KfF9w==
X-Received: by 2002:a05:620a:4053:b0:6bb:b025:488 with SMTP id i19-20020a05620a405300b006bbb0250488mr16404740qko.553.1661969641886;
        Wed, 31 Aug 2022 11:14:01 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id q12-20020a05622a04cc00b00344f91f6fe0sm9167758qtx.67.2022.08.31.11.13.57
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 11:13:59 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id c20so11609623qtw.8
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 11:13:57 -0700 (PDT)
X-Received: by 2002:ac8:5fd6:0:b0:343:4b4:1022 with SMTP id
 k22-20020ac85fd6000000b0034304b41022mr20415702qta.616.1661969637250; Wed, 31
 Aug 2022 11:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220830231541.1135813-1-rrangel@chromium.org>
 <20220830171332.1.Id022caf53d01112188308520915798f08a33cd3e@changeid> <CAJZ5v0h10wrurjYG50dA+pCfRtNDqN=c8odQ0p6HJRnOyJh7KA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h10wrurjYG50dA+pCfRtNDqN=c8odQ0p6HJRnOyJh7KA@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 31 Aug 2022 12:13:46 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BTYEYEAGjwsbuiYuYGhpFtQy_AEP66v3trdTzY_DRUOQ@mail.gmail.com>
Message-ID: <CAHQZ30BTYEYEAGjwsbuiYuYGhpFtQy_AEP66v3trdTzY_DRUOQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] Input: elan_i2c - Use PM subsystem to manage wake irq
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 31, 2022 at 12:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Aug 31, 2022 at 1:16 AM Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > The Elan I2C touchpad driver is currently manually managing the wake
> > IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
> > and instead relies on the PM subsystem. This is done by calling
> > dev_pm_set_wake_irq.
> >
> > i2c_device_probe already calls dev_pm_set_wake_irq when using device
> > tree, so it's only required when using ACPI. The net result is that this
> > change should be a no-op. i2c_device_remove also already calls
> > dev_pm_clear_wake_irq, so we don't need to do that in this driver.
> >
> > I tested this on an ACPI system where the touchpad doesn't have _PRW
> > defined. I verified I can still wake the system and that the wake source
> > was the touchpad IRQ GPIO.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
>


> I like this a lot, but the assumption in the wakeirq code is that the
> IRQ in question will be dedicated for signaling wakeup.  Does it hold
> here?

The wakeirq code defines two methods: `dev_pm_set_wake_irq` and
`dev_pm_set_dedicated_wake_irq`.
The latter is used when you have a dedicated wakeup signal. In this
driver it's currently assumed
that the IRQ and the wake IRQ are the same, so I used `dev_pm_set_wake_irq`.

This change in theory also fixes a bug where you define a dedicated
wake irq in DT, but
then the driver enables the `client->irq` as a wake source. In
practice this doesn't happen
since the elan touchpads only have a single IRQ line.

>
> > ---
> >
> >  drivers/input/mouse/elan_i2c_core.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> > index e1758d5ffe4218..7d997d2b56436b 100644
> > --- a/drivers/input/mouse/elan_i2c_core.c
> > +++ b/drivers/input/mouse/elan_i2c_core.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/jiffies.h>
> >  #include <linux/completion.h>
> >  #include <linux/of.h>
> > +#include <linux/pm_wakeirq.h>
> >  #include <linux/property.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <asm/unaligned.h>
> > @@ -86,8 +87,6 @@ struct elan_tp_data {
> >         u16                     fw_page_size;
> >         u32                     fw_signature_address;
> >
> > -       bool                    irq_wake;
> > -
> >         u8                      min_baseline;
> >         u8                      max_baseline;
> >         bool                    baseline_ready;
> > @@ -1337,8 +1336,10 @@ static int elan_probe(struct i2c_client *client,
> >          * Systems using device tree should set up wakeup via DTS,
> >          * the rest will configure device as wakeup source by default.
> >          */
> > -       if (!dev->of_node)
> > +       if (!dev->of_node) {
> >                 device_init_wakeup(dev, true);
> > +               dev_pm_set_wake_irq(dev, client->irq);
> > +       }
> >
> >         return 0;
> >  }
> > @@ -1362,8 +1363,6 @@ static int __maybe_unused elan_suspend(struct device *dev)
> >
> >         if (device_may_wakeup(dev)) {
> >                 ret = elan_sleep(data);
> > -               /* Enable wake from IRQ */
> > -               data->irq_wake = (enable_irq_wake(client->irq) == 0);
> >         } else {
> >                 ret = elan_set_power(data, false);
> >                 if (ret)
> > @@ -1394,9 +1393,6 @@ static int __maybe_unused elan_resume(struct device *dev)
> >                         dev_err(dev, "error %d enabling regulator\n", error);
> >                         goto err;
> >                 }
> > -       } else if (data->irq_wake) {
> > -               disable_irq_wake(client->irq);
> > -               data->irq_wake = false;
> >         }
> >
> >         error = elan_set_power(data, true);
> > --
> > 2.37.2.672.g94769d06f0-goog
> >
