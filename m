Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33D15A805E
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Aug 2022 16:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiHaOhd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Aug 2022 10:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiHaOhc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2022 10:37:32 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DFE51A18
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 07:37:31 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h21so11094295qta.3
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=rnLojn8m5RIM9q/IHnLgW3r82z0fH67X9Nn6XLx+iP8=;
        b=eP2EBWEyS5OceuUNbFWUUEhT+EaDji20F6lwBwaZaBxv8WpYTOUsYf0S6rmaThA347
         0Ueh4D1zirBcr2kZkhBlN4xIzW5pRVT+G8+yhXfqg806chDbfySODQazELVomunSOhEm
         zQH0SOBIDUDXqHRoSK4bYuBXgvQMaAqp35YUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rnLojn8m5RIM9q/IHnLgW3r82z0fH67X9Nn6XLx+iP8=;
        b=z58oBUekTnjJP3D9aya4KL2P2wvr+n00QmYDyiR51ooBqe/eY+OKRlOsP1hIcN0fbM
         3/UO4NBcwe6TmumOgpewH+4OK6bNcGEx5dZIkMz0URtmRVHHWpxkHH/YMNUxgdlwOI1+
         s0l8TLyLkkuDugGwHnWB5kelNkm+2IjNmY5hno8bDitXkdbM1gnvUA8Kp5vJ5x/vYR0i
         dqEaRoXzaFwgb0mKFVS8FoeE8qd7tGRa9qZzrTkGa86XxA187BbL+QmHb2Oi9uJMSeSv
         ACiteDTo6AMS//U8VJafvy1eoLouGDMBDkVwdSvVTfh425fXYy2xb3jw7w2bQsZUVZvi
         dr3A==
X-Gm-Message-State: ACgBeo3UP2iS6m2gNm02yyUm2DhN/NClk/EKFvPoZn118kaTrihGlpZc
        ehl/wbnFaVFf0e40HTvcc+rCcHO/wxte7I0V
X-Google-Smtp-Source: AA6agR4K88K5doOwviBNhFdMpRRBzbKmBcfODhlLPxljlxt5+9rVInJRmDqgvVFZCUw/Wf7V4mBPVA==
X-Received: by 2002:ac8:5cca:0:b0:344:9548:7bb8 with SMTP id s10-20020ac85cca000000b0034495487bb8mr19806738qta.347.1661956650218;
        Wed, 31 Aug 2022 07:37:30 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id a14-20020ac8720e000000b003431446588fsm8519686qtp.5.2022.08.31.07.37.22
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 07:37:24 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id g16so10920279qkl.11
        for <linux-acpi@vger.kernel.org>; Wed, 31 Aug 2022 07:37:22 -0700 (PDT)
X-Received: by 2002:a05:620a:1650:b0:6bb:29b7:198c with SMTP id
 c16-20020a05620a165000b006bb29b7198cmr15523438qko.552.1661956642390; Wed, 31
 Aug 2022 07:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220830231541.1135813-1-rrangel@chromium.org> <Yw9LdxWQMpnzgFe/@smile.fi.intel.com>
In-Reply-To: <Yw9LdxWQMpnzgFe/@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 31 Aug 2022 08:37:11 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BemtpHiZHOh+Wvh3N9wz5SSD9VdoQHNbArKhZUmudkwQ@mail.gmail.com>
Message-ID: <CAHQZ30BemtpHiZHOh+Wvh3N9wz5SSD9VdoQHNbArKhZUmudkwQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] acpi: i2c: Use SharedAndWake and ExclusiveAndWake to
 enable wake irq
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alistair Francis <alistair@alistair23.me>,
        Angela Czubak <acz@semihalf.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Len Brown <lenb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Interesting... The patch series is here:
https://patchwork.kernel.org/project/linux-input/cover/20220830231541.11358=
13-1-rrangel@chromium.org/

I'll look into why you only got added to 2 of the emails.

On Wed, Aug 31, 2022 at 5:52 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 30, 2022 at 05:15:33PM -0600, Raul E Rangel wrote:
> > Today, i2c drivers are making the assumption that their IRQs can also
> > be used as wake IRQs. This isn't always the case and it can lead to
> > spurious wakes. This has recently started to affect AMD Chromebooks.
> > With the introduction of
> > d62bd5ce12d7 ("pinctrl: amd: Implement irq_set_wake"), the AMD GPIO
> > controller gained the capability to set the wake bit on each GPIO. The
> > ACPI specification defines two ways to inform the system if a device is
> > wake capable:
> > 1) The _PRW object defines the GPE that can be used to wake the system.
> > 2) Setting ExclusiveAndWake or SharedAndWake in the _CRS GpioInt.
> >
> > Currently only the first method is supported. The i2c drivers don't hav=
e
> > any indication that the IRQ is wake capable, so they guess. This causes
> > spurious interrupts, for example:
> > * We have an ACPI HID device that has `_PR0` and `_PR3`. It doesn't hav=
e
> >   `_PRW` or `ExclusiveAndWake` so that means the device can't wake the
> >   system.
> > * The IRQ line is active level low for this device and is pulled up by
> >   the power resource defined in `_PR0`/`_PR3`.
> > * The i2c driver will (incorrectly) arm the GPIO for wake by calling
> >   `enable_irq_wake` as part of its suspend hook.
> > * ACPI will power down the device since it doesn't have a wake GPE
> >   associated with it.
> > * When the device is powered down, the IRQ line will drop, and it will
> >   trigger a wake event.
> >
> > See the following debug log:
> > [   42.335804] PM: Suspending system (s2idle)
> > [   42.340186] amd_gpio AMD0030:00: RX: Setting wake for pin 89 to enab=
le
> > [   42.467736]     power-0416 __acpi_power_off      : Power resource [P=
R00] turned off
> > [   42.467739] device_pm-0280 device_set_power      : Device [H05D] tra=
nsitioned to D3cold
> > [   42.475210] PM: pm_system_irq_wakeup: 11 triggered pinctrl_amd
> > [   42.535293] PM: Wakeup unrelated to ACPI SCI
> > [   42.535294] PM: resume from suspend-to-idle
> >
> > In order to fix this, we need to take into account the wake capable bit
> > defined on the GpioInt. This is accomplished by:
> > * Migrating some of the i2c drivers over to using the PM subsystem to
> >   manage the wake IRQ. max8925-i2c, elants_i2c, and raydium_i2c_ts stil=
l
> >   need to be migrated, I can do that depending on the feedback to this
> >   patch series.
> > * Expose the wake_capable bit from the ACPI GpioInt resource to the
> >   i2c core.
> > * Use the wake_capable bit in the i2c core to call
> >   `dev_pm_set_wake_irq`. This reuses the existing device tree flow.
> > * Make the i2c drivers stop calling `dev_pm_set_wake_irq` since it's no=
w
> >   handled by the i2c core.
> > * Make the ACPI device PM system aware of the wake_irq. This is
> >   necessary so the device doesn't incorrectly get powered down when a
> >   wake_irq is enabled.
> >
> > I've tested this code with various combinations of having _PRW,
> > ExclusiveAndWake and power resources all defined or not defined, but it
> > would be great if others could test this out on their hardware.
>
> I have got only cover letter and a single patch (#3). What's going on?
>
> Note: I'm also reviewer of I=E6=B6=8E DesignWare driver, you really have =
to
> fix your tools / submission process and try again. No review for this
> series.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
