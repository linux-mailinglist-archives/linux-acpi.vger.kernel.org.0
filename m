Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6016F6783E1
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 19:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjAWSAL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 13:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjAWSAK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 13:00:10 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B8E2FCC6
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 10:00:08 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id g16so413504ilr.1
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 10:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfn2VKc5tb13Bmz2zLJ8hWQgh2Rqf4hF3vv12c+wU7M=;
        b=jOub7jZTow1wn8ew5Y8TSGPzf32gf0xc/HOcWVvtPFrlL1PNxXlIpqj4gyrwGvFnlu
         lTcOtGkZvEcd/PogWFZn9IftEqohazgbExLcjV+a0Ielu+ZxGUbNyFVQOBRmtFK6hvaV
         fsqZ6CaIu8KRAk0yuNdOanfSdGgAobHkVoh4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfn2VKc5tb13Bmz2zLJ8hWQgh2Rqf4hF3vv12c+wU7M=;
        b=Qxucmh+zVcp/RXX+PTlVQlB7bUt2iSXpsFQGMD0fw+poONMBZZDWeDH7NmwzS+yW/0
         kxhKPZoRWWEk9f/ydjmGFksQGmvpPf5TDYUm/7YidKf0kgjdhQgcgkKxG2HD13/gK681
         mky1HE7CauAaaXahvIWKmSB0EEQZUcNwa4beLPdy/96E6qit4FZjJdsX8sUP0mPtboOQ
         uRR+PhwjNJIMpRMfQrtGFF7Xf2/W3DRRbx1nfBJDOepbbgVSVmpU4xYOr2r1dvDbWFrV
         ZAwxGlvJ9xn/F5Z7XBI4cpYBFS2MUn+64FTc5Hy+GOxufuUVh6ZTc/VnNMScLvIsG2WN
         wDSw==
X-Gm-Message-State: AFqh2koL3drSjNDvrgQVx/ORF+BlsRUlTcTCGVnI4/79svdWn7zg8Fkh
        D8Nq832XA5RvZ0py6x7cLWYFqTBcj37nvhVk
X-Google-Smtp-Source: AMrXdXv3KC43lCpCgtRaLHjnFfhOAw3J4J7+BuCShJWYuL/0pLwRXCbQnlRUGsIfnp20xim4TbsNyQ==
X-Received: by 2002:a92:cc01:0:b0:30d:7ae0:1ccc with SMTP id s1-20020a92cc01000000b0030d7ae01cccmr17974140ilp.30.1674496807587;
        Mon, 23 Jan 2023 10:00:07 -0800 (PST)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id w3-20020a92d2c3000000b0030da09e3bd0sm697108ilg.50.2023.01.23.10.00.07
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 10:00:07 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id i17so6279648ila.9
        for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2023 10:00:07 -0800 (PST)
X-Received: by 2002:a63:4c54:0:b0:4cf:ad0f:7387 with SMTP id
 m20-20020a634c54000000b004cfad0f7387mr2371573pgl.208.1674496481336; Mon, 23
 Jan 2023 09:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20230121134812.16637-1-mario.limonciello@amd.com>
 <20230121134812.16637-3-mario.limonciello@amd.com> <CAMRc=Meeiix1BuPi81Ad08yePvd7U5S-AVNwU+vYUHv2VcDiEQ@mail.gmail.com>
 <CAHQZ30Dgs=ScuQ2MkNkuHyZNC1wwaBDkMhcvh9dt3oAppTKBbw@mail.gmail.com> <Y87ERbaTEhKIK1nq@smile.fi.intel.com>
In-Reply-To: <Y87ERbaTEhKIK1nq@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 23 Jan 2023 10:54:29 -0700
X-Gmail-Original-Message-ID: <CAHQZ30Aj-S1kRiYhh4sFzZYH8MLKY=sdqYRDqZtqOGGMn1Bang@mail.gmail.com>
Message-ID: <CAHQZ30Aj-S1kRiYhh4sFzZYH8MLKY=sdqYRDqZtqOGGMn1Bang@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpiolib-acpi: Don't set GPIOs for wakeup in S3 mode
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Smythe <ncsmythe@scruboak.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Hasemeyer <markhas@chromium.org>
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

On Mon, Jan 23, 2023 at 10:30 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Jan 23, 2023 at 08:55:02AM -0700, Raul Rangel wrote:
> > On Mon, Jan 23, 2023 at 8:03 AM Bartosz Golaszewski <brgl@bgdev.pl> wro=
te:
> > >
> > > On Sat, Jan 21, 2023 at 2:48 PM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> > > >
> > > > commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capab=
le")
> > > > adjusted the policy to enable wakeup by default if the ACPI tables
> > > > indicated that a device was wake capable.
> > > >
> > > > It was reported however that this broke suspend on at least two Sys=
tem76
> > > > systems in S3 mode and two Lenovo Gen2a systems, but only with S3.
> > > > When the machines are set to s2idle, wakeup behaves properly.
> > > >
> > > > Configuring the GPIOs for wakeup with S3 doesn't work properly, so =
only
> > > > set it when the system supports low power idle.
> > > >
> > > > Fixes: 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capab=
le")
> > > > Fixes: b38f2d5d9615c ("i2c: acpi: Use ACPI wake capability bit to s=
et wake_irq")
> > > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2357
> > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2162013
> > > > Reported-by: Nathan Smythe <ncsmythe@scruboak.org>
> > > > Tested-by: Nathan Smythe <ncsmythe@scruboak.org>
> > > > Suggested-by: Raul Rangel <rrangel@chromium.org>
> > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > ---
> > > >  drivers/gpio/gpiolib-acpi.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acp=
i.c
> > > > index 9ef0f5641b521..17c53f484280f 100644
> > > > --- a/drivers/gpio/gpiolib-acpi.c
> > > > +++ b/drivers/gpio/gpiolib-acpi.c
> > > > @@ -1104,7 +1104,8 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi=
_device *adev, const char *name, in
> > > >                                 dev_dbg(&adev->dev, "IRQ %d already=
 in use\n", irq);
> > > >                         }
> > > >
> > > > -                       if (wake_capable)
> > > > +                       /* avoid suspend issues with GPIOs when sys=
tems are using S3 */
> > > > +                       if (wake_capable && acpi_gbl_FADT.flags & A=
CPI_FADT_LOW_POWER_S0)
> > > >                                 *wake_capable =3D info.wake_capable=
;
> > > >
> > > >                         return irq;
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > Applied, thanks!
> > >
> > > Bart
> >
> >
> > We still need to figure out a proper fix for this. If you read my post
> > here: https://gitlab.freedesktop.org/drm/amd/-/issues/2357#note_1732372
> > I think we misinterpreted what the SharedAndWake bit is used for. To
> > me it sounds like it's only valid for HW Reduced ACPI platforms, and
> > S0ix. My changes made it so we call `dev_pm_set_wake_irq` when the
> > Wake bit is set. Does anyone have any additional context on the Wake
> > bit? I think we either need to make `dev_pm_set_wake_irq` (or a
> > variant) only enable the wake on S0i3, or we can teach the ACPI
> > subsystem to manage arming the IRQ's wake bit. Kind of like we already
> > manage the GPE events for the device.
>
> From the spec:
>
> Shared is an optional argument and can be one of Shared, Exclusive,
> SharedAndWake or ExclusiveAndWake. If not specified, Exclusive is assumed=
.
> The =E2=80=9CWake=E2=80=9D designation indicates that the interrupt is ca=
pable of waking
> the system from a low-power idle state or a system sleep state. The bit
> field name _SHR is automatically created to refer to this portion of
> the resource descriptor.
>
>
> Note: "...a low-power idle state or a system sleep state.". I believe it
> applies to both.

Without the _PRW, how do we determine the valid system sleep states
the device can wake the system from?

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
