Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EBF30A3E0
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 09:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhBAI7B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 03:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhBAI6y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 03:58:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAAAC0613D6
        for <linux-acpi@vger.kernel.org>; Mon,  1 Feb 2021 00:57:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c6so17947021ede.0
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2021 00:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GyxsNnWu7EqjyU0NKMwi2dzcVL+ptjeCIPcsXEH/9OY=;
        b=i6PdTJrbTgfPEq1qvNzYS4t4VsejQHvBMA2i45CHObKGwPzTKS4X3R5W02R02DNRfr
         9F48UgomgbOq6gppxgT4+6tuQmsSHf5a7Vr2bMdmt57Uk39z4OU49+Do6uCOXRqHkV4f
         XE510R+cNphZYBjIKhw5YlVF955NPuWlSvhpasOICJu+nCFpU8GkzQKIg6AxYZ2wOFOx
         7fxMDR9GSb9IaenWC1mMrNc2pzs6J+uQqfoAp42APYhs+a4ElJZZ0CIgjXBbfND2wQFw
         2uJbWV+HCa/Z5qJx2c+Oo0Etw5ORVx5jgX00rHyrO1+Ug3riu1gD7nHgATlqC2gexrji
         lbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GyxsNnWu7EqjyU0NKMwi2dzcVL+ptjeCIPcsXEH/9OY=;
        b=JtQxDo1WuBuGL7PhJdUFXTWYupUKcK4RpuGZivL4B2Ihm79lpWO7AD2e66/yGaqwt1
         gpDntjC5xwky8df2stJZVJOgXhZHsh5bw4c8veeSJDdy9k6jKvC7qrUQ4a2MdwbpAdGn
         oOG9aMCD2LFHJelUo6OhNenFLHghDxiBtDotPMIna/zT3fbEnioF76Fa9JFuPt8qQAVc
         OIDXZ8HMggeU58vovTZMlhC7SEP5Cp6nwiKhbnw6pIwJcIDhKA/pw/29kj+KINGZZA8L
         ndxlRDA56DLc5SD+Z6xx06LE/n2XEif5Mym9itqZOPPm4xSavUIiYRInaEa68pmPCScx
         bEQA==
X-Gm-Message-State: AOAM532hql+n7qaDYeXoiI/wTw8E105f1XSZM9RGwrXHwBec8ahj2Fke
        NBtR2GzizOu1nOg3G6lcVQI/NZf9aWT/zt+Yf9FMHA==
X-Google-Smtp-Source: ABdhPJx7YJeaIThw9MHlmgqwuHrnNn2An/DeuJv641UUQWTVd5Zapsko0YlOuYX2v/CmLEKKjveQedF2USmYjR4gynw=
X-Received: by 2002:a05:6402:35ca:: with SMTP id z10mr17750262edc.186.1612169867171;
 Mon, 01 Feb 2021 00:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20200903081550.6012-1-sakari.ailus@linux.intel.com>
 <20210128232729.16064-7-sakari.ailus@linux.intel.com> <CAMpxmJVTPgvxOVdTkmt4VjUnGabNBKauKF_DKtnnkV6O0QYTWA@mail.gmail.com>
 <20210129121955.GH32460@paasikivi.fi.intel.com>
In-Reply-To: <20210129121955.GH32460@paasikivi.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 1 Feb 2021 09:57:36 +0100
Message-ID: <CAMpxmJUfP86jQg11imFUtjt8KtJ25tDRQUGvrZqDbT5xyKoH9A@mail.gmail.com>
Subject: Re: [PATCH v9 7/7] at24: Support probing while off
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 29, 2021 at 1:20 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Bartosz,
>
> Thanks for the review.
>
> On Fri, Jan 29, 2021 at 11:56:00AM +0100, Bartosz Golaszewski wrote:
> > On Fri, Jan 29, 2021 at 12:27 AM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > In certain use cases (where the chip is part of a camera module, and =
the
> > > camera module is wired together with a camera privacy LED), powering =
on
> > > the device during probe is undesirable. Add support for the at24 to
> > > execute probe while being powered off. For this to happen, a hint in =
form
> > > of a device property is required from the firmware.
> > >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  drivers/misc/eeprom/at24.c | 43 +++++++++++++++++++++++-------------=
--
> > >  1 file changed, 26 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> > > index 926408b41270c..dd0b3f24e3808 100644
> > > --- a/drivers/misc/eeprom/at24.c
> > > +++ b/drivers/misc/eeprom/at24.c
> > > @@ -595,6 +595,7 @@ static int at24_probe(struct i2c_client *client)
> > >         bool i2c_fn_i2c, i2c_fn_block;
> > >         unsigned int i, num_addresses;
> > >         struct at24_data *at24;
> > > +       bool low_power;
> > >         struct regmap *regmap;
> > >         bool writable;
> > >         u8 test_byte;
> > > @@ -750,14 +751,16 @@ static int at24_probe(struct i2c_client *client=
)
> > >
> > >         i2c_set_clientdata(client, at24);
> > >
> > > -       err =3D regulator_enable(at24->vcc_reg);
> > > -       if (err) {
> > > -               dev_err(dev, "Failed to enable vcc regulator\n");
> > > -               return err;
> > > -       }
> > > +       low_power =3D acpi_dev_state_low_power(&client->dev);
> >
> > I've raised my concern about the naming of this before but no
> > discussion followed. Do we really want to name it: "low power"? This
> > is misleading as the device can actually be powered off at probe().
> > "Low power" suggests some low-power state or even low battery IMO.
>
> This was suggested by Rafael in place of "powered off" as it's not know t=
he
> device is powered off. The same terms should be used in all contexts (ACP=
I
> and I=C2=B2C frameworks and drivers). Others haven't expressed concerns.
>

So we're describing a situation where "device may be powered off" by
calling it "low_power". This doesn't make sense. Why not something
like: acpi_dev_may_be_off(), acpi_dev_powerdown_possible(),
acpi_dev_possibly_off(). If I'm reading a driver's code an see
"acpi_dev_state_low_power()", I would have never guessed it refers to
a situation where the device may be potentially powered-down.

> ACPI spec appears to be using terms "on" and "off".
>
> The use of the function is not limited to driver probe time.
>
> >
> > If anything: I'd prefer the 'low_power' local variable be changed to
> > "no_test_read".
>
> That misses the power management related suggestion now present in the na=
me
> --- the device needs to be suspended using runtime PM if probe fails and
> it's not in "low power state".
>
> How about "off_during_probe"?
>

Yes, this is much better than low_power.

Bartosz

> --
> Kind regards,
>
> Sakari Ailus
