Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01A879BA47
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 02:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244290AbjIKVSo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbjIKM7w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 08:59:52 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E18E40
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 05:59:48 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-44d4a307d30so1368681137.0
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694437187; x=1695041987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeSQxtav1kBfFjeqACTcKoKw74gowqJrLRYGxNHMnw0=;
        b=YZGQrRMSi3y354ze1F7tvDEBw351AYB/VJdMMaMHIrxRh+LlcTa/m7madmyi5uVm2Q
         juC8+KPPspKorp1tMAPeLQQNrB82EvHJhFeL6lOC922VTlNZReBClDxrdOg6t0o2s5ET
         ypNIVaqx1GzGGqzsZyOoEKSOrk+pVbiVDULh0uB1a2XLbqA9syEzYfwK785o7XFvBFB8
         w5CppFgxFxoxwIEp43wYzwXzHTX7Meg1aB3eghmyHVV49F7jikhdO3R6ez1Gcgc8seV1
         BznYsHb/mEk96s7460gI7fYp2+Us4stFnPYJwbhexZl2ratBybyivy5xYXJoo3jbqI0m
         UW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694437187; x=1695041987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeSQxtav1kBfFjeqACTcKoKw74gowqJrLRYGxNHMnw0=;
        b=BC7MlfB7EIJH/BPhq8DJH0akUjoustAwqu4YSWhSK/ZMEEOeHMxc3WITQp0p0idl2Y
         qKW2GLuMTeVxgZJZfGchPylE43Ojpcu6XBGfhuYvvqBCkXL/O+ebPv2268w1QI7Jxqxz
         dZJOawzcznOrQ5tRgxuq8X6TqGmfwB48IyqtInsi4vEE5/QNuVDVSaqX+lQ9yjZDBF93
         9zQuo5COv2gBFJ4WeX/iExZQLkUQj7BX9nXLOgH6K4ux19hDC/qJ1sSPj3a5X24ojc7u
         Uj3KiGUtLtTlNYFgOZtvPErs7NmpALEvJAN6uXVstDPtiXuTfnbCW8Kr0Io2//LFKYE4
         kgvA==
X-Gm-Message-State: AOJu0YzSzUuHhSNisLQmIi5Wjk4I3UWewaQ8rtxTF1fdbSs/Ci2040pW
        zHf/bTmGzIDYlfd6VFEYqOWYClzCpKNsaqOLy/RrJw==
X-Google-Smtp-Source: AGHT+IE0n8JXf3+DAvbPF9PFOTNkGS9vcxY40uQLrQXaLhJ4zhNZGFloDo3Q1B5xvzQi89I59FTrSQaZkShTMaJ0bF8=
X-Received: by 2002:a67:fe57:0:b0:447:7a6b:2c8b with SMTP id
 m23-20020a67fe57000000b004477a6b2c8bmr5774075vsr.30.1694437187276; Mon, 11
 Sep 2023 05:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-7-hdegoede@redhat.com>
 <CAHp75Ve888X7xJ0VrQfswaStL8C3SHXjnJV35O2ajZVq6=KfMQ@mail.gmail.com>
 <afda7862-3c36-98d8-43a3-dd67538de923@redhat.com> <CAMRc=MdmzPWeZ7CtFe2b6xZFAges2cD-ckq4vn-+52CG=tVRSA@mail.gmail.com>
 <ZP8OiuhvgLxAzmVE@smile.fi.intel.com>
In-Reply-To: <ZP8OiuhvgLxAzmVE@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 14:59:36 +0200
Message-ID: <CAMRc=McDsAz8VMgLdJQW0RVYZ9PjF3YDS0duO+8QJS5fMbpwqw@mail.gmail.com>
Subject: Re: [PATCH 6/8] platform/x86: x86-android-tablets: Stop using gpiolib
 private APIs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 11, 2023 at 2:56=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Sep 11, 2023 at 02:49:44PM +0200, Bartosz Golaszewski wrote:
> > On Sun, Sep 10, 2023 at 1:26=E2=80=AFPM Hans de Goede <hdegoede@redhat.=
com> wrote:
> > > On 9/10/23 10:24, Andy Shevchenko wrote:
> > > > On Sat, Sep 9, 2023 at 5:18=E2=80=AFPM Hans de Goede <hdegoede@redh=
at.com> wrote:
>
> ...
>
> > > >> +       gpiod =3D devm_gpiod_get(&x86_android_tablet_device->dev, =
con_id, dflags);
>
> ^^^
>
> > > >> -       *desc =3D gpiod;
> > > >> +       if (desc)
> > > >> +               *desc =3D gpiod;
> > > >
> > > > Are we expecting that callers may not want the GPIO descriptor out =
of
> > > > this function?
> > > > Sounds a bit weird if so.
> > >
> > > Yes specifically the Charge-enable and OTG (Vboost enable) pins on th=
e
> > > bq25892 charger on the Lenovo Yoga Tab 3 just need to be set to a fix=
ed
> > > value, so we request the pins with GPIOD_OUT_LOW / _HIGH and then
> > > leave them at that value.
> >
> > You mean you leak the descriptor? It would warrant either a comment or
> > storing the descriptor somewhere and cleaning it up if the device can
> > be unbound (I guess it can since the driver can be built as module).
>
> Note devm_*() above.
>

Ah, nevermind my comment then.

Bart
