Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1777968F2A2
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 16:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjBHP7i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 10:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjBHP7Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 10:59:16 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97925B8F
        for <linux-acpi@vger.kernel.org>; Wed,  8 Feb 2023 07:59:14 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id q9so12955377pgq.5
        for <linux-acpi@vger.kernel.org>; Wed, 08 Feb 2023 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k9BhvDBfk1/HCHLk4elktrqCZfSX23y0QKS642mqcw=;
        b=Q50bnAvx45vdXksl5QMGoBw+DmtuCNaMtHdynV1F2sp47H37W/LvsX5ne8lz7gyLC6
         /DPrLU3oyJzlfLFd5ANO41PGQagNhAdn6wRp9ArqIFYxMgZ5XaVprzGPhD1XJ/S7DwED
         Oy2aibvtMHgrayX8dRR2o7GDEIiU5SjxrZ92E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0k9BhvDBfk1/HCHLk4elktrqCZfSX23y0QKS642mqcw=;
        b=lLb4icbdRAtT+VXasYT7abMcrld1mL2Gnb/nnnCUz1EVLqA880lwyQIS8vcg+XHLSg
         Ow+QoqRF8a8nXqqE506Bx/X2Pqc9NqUzJ+G4JjrPZ+Myw3k5arroZMrVZ56dKUkfN16v
         83rAUkQS2nfhj4noWLWAgndQNlPH2GtwKMXn1mrdwhBXofQy4N0tMZPt384+vzVSE+WX
         00N3uYB/G+9uR4ljIROt287ilXS/1WSRb4ZmvnVeiCiGvVrUva8z24t69xv4shl7OQge
         Vj13lwA4V79hqgJHYwjYBaf6xDbAtWIjaWu9rPDikqolzNyOjtfbvQkB6Wqplfvg+Lk6
         CjjA==
X-Gm-Message-State: AO0yUKVGhWIuM7Vzh7yvXtpjwARt4bBgTHLdpaSx+XVMqvBXh31/RsPc
        7+Dz3OjABPFVV6UhQjHC3d7u4sS/1FbzQ9Zf
X-Google-Smtp-Source: AK7set8eE96qN8IkmjSKEC/4iYAXYF/wHN47nw9JGS2VeIiwmKapKIBuxjwzmwR6tOH2nkowz3SbtQ==
X-Received: by 2002:aa7:9f03:0:b0:5a7:c326:8f2c with SMTP id g3-20020aa79f03000000b005a7c3268f2cmr4645477pfr.14.1675871954083;
        Wed, 08 Feb 2023 07:59:14 -0800 (PST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com. [209.85.216.41])
        by smtp.gmail.com with ESMTPSA id j4-20020aa78004000000b0059242cd5469sm11788421pfi.13.2023.02.08.07.59.12
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 07:59:12 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id o13so18817700pjg.2
        for <linux-acpi@vger.kernel.org>; Wed, 08 Feb 2023 07:59:12 -0800 (PST)
X-Received: by 2002:a17:90a:8d17:b0:22c:19bd:c905 with SMTP id
 c23-20020a17090a8d1700b0022c19bdc905mr907492pjo.10.1675871951706; Wed, 08 Feb
 2023 07:59:11 -0800 (PST)
MIME-Version: 1.0
References: <20230207072540.27226-1-mika.westerberg@linux.intel.com>
 <CAHQZ30Bzn1Lxy+Y2gCcFTmzWzwnxqUZAHAjSh67Pz=WweaKHkg@mail.gmail.com>
 <Y+NH9pjbFfmijHF+@black.fi.intel.com> <b429918f-fe63-2897-8ade-d17fe2e3646f@linux.intel.com>
In-Reply-To: <b429918f-fe63-2897-8ade-d17fe2e3646f@linux.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 8 Feb 2023 08:58:59 -0700
X-Gmail-Original-Message-ID: <CAHQZ30C=_aS+FefChYZFAG4vNbFZofh=wpP2mBGbfW1JTD3D_A@mail.gmail.com>
Message-ID: <CAHQZ30C=_aS+FefChYZFAG4vNbFZofh=wpP2mBGbfW1JTD3D_A@mail.gmail.com>
Subject: Re: [RFC] i2c: core: Do not enable wakeup by default
To:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Wed, Feb 8, 2023 at 1:28 AM Amadeusz S=C5=82awi=C5=84ski
<amadeuszx.slawinski@linux.intel.com> wrote:
>
> On 2/8/2023 7:57 AM, Mika Westerberg wrote:
> > Hi,
> >
> > On Tue, Feb 07, 2023 at 09:33:55AM -0700, Raul Rangel wrote:
> >> Sorry, resending in plain text mode.
> >>
> >> On Tue, Feb 7, 2023 at 12:25 AM Mika Westerberg
> >> <mika.westerberg@linux.intel.com> wrote:
> >>>
> >>> After commit b38f2d5d9615 ("i2c: acpi: Use ACPI wake capability bit t=
o
> >>> set wake_irq") the I2C core has been setting I2C_CLIENT_WAKE for ACPI
> >>> devices if they announce to be wake capable in their device descripti=
on.
> >>> However, on certain systems where audio codec has been connected thro=
ugh
> >>> I2C this causes system suspend to wake up immediately because power t=
o
> >>> the codec is turned off which pulls the interrupt line "low" triggeri=
ng
> >>> wake up.
> >>>
> >>> Possible reason why the interrupt is marked as wake capable is that s=
ome
> >>> codecs apparently support "Wake on Voice" or similar functionality.
> >>
> >> That's generally a bug in the ACPI tables. The wake bit shouldn't be
> >> set if the power domain for the device is powered off on suspend. The
> >> best thing is to fix the ACPI tables, but if you can't, then you can
> >> set the ignore_wake flag for the device:
> >> https://github.com/torvalds/linux/blob/master/drivers/gpio/gpiolib-acp=
i.c#L31.
> >> If that works we can add a quirk for the device:
> >> https://github.com/torvalds/linux/blob/master/drivers/gpio/gpiolib-acp=
i.c#L1633.
>

> I've seen this one already and also tried to use it, but it didn't work.
> Also when I was reading code I wasn't really convinced that it is linked
> to i2c in any straightforward way. I mean i2c decides in different
> places that it has wake support (I even added some prints to make sure
> ;). The code you pointed out decides in
> https://github.com/torvalds/linux/blob/master/drivers/gpio/gpiolib-acpi.c=
#L387
> but i2c code seems to decide in
> https://github.com/torvalds/linux/blob/master/drivers/i2c/i2c-core-acpi.c=
#L176
> where it just checks if irq flags has wake_capable flag set. When I
> looked at it previously I was pretty sure it comes straight from BIOS
> and passes the quirk code you mentioned, still I may have missed somethin=
g.

You also need the following patch
https://github.com/torvalds/linux/commit/0e3b175f079247f0d40d2ab695999c309d=
3a7498,
otherwise the ignore flag only applies to _AEI GPIOs.

>
> >
> > I think (hope) these systems are not yet available for public so there
> > is a chance that the tables can still be fixed, without need to add any
> > quirks.
> >
> > @Amadeusz, @Cezary, if that's the case I suggest filing a bug against
> > the BIOS.
> >
>
> Well, I tried custom DSDT and had problems, but I just remembered that I
> probably need to pass "revision+1" in file, so kernel sees it as a newer
> version, let me try again. Is it enough to replace "ExclusiveAndWake"
> with "Exclusive"?
>
> >>> In any case, I don't think we should be enabling wakeup by default on
> >>> all I2C devices that are wake capable. According to device_init_wakeu=
p()
> >>> documentation most devices should leave it disabled, with exceptions =
on
> >>> devices such as keyboards, power buttons etc. Userspace can enable
> >>> wakeup as needed by writing to device "power/wakeup" attribute.
> >>
> >> Enabling wake by default was an unintended side-effect. I didn't catch
> >> this when I wrote the patch :/ It's been exposing all the incorrect
> >> ACPI configurations for better or worse. Mario pushed a patch up
> >> earlier to disable thes Wake GPIOs when using S3:
> >> https://github.com/torvalds/linux/commit/d63f11c02b8d3e54bdb65d8c309f7=
3b7f474aec4.
> >> Are you having problems with S3 or S0iX?
> >
> > I think this case is S0ix.
>
> We test both cases in our setups.

IMO if a device needs to support wake from S3 the ACPI table needs to
define a _PRW and define the proper power resources to keep the device
functional during S3.

>
> >
> >>> Reported-by: Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@linux.=
intel.com>
> >>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>> ---
> >>> Hi,
> >>>
> >>> Sending this as RFC because I'm not too familiar with the usage of
> >>> I2C_CLIENT_WAKE and whether this is something that is expected behavi=
our
> >>> in users of I2C devices. On ACPI side I think this is the correct thi=
ng
> >>> to do at least.
> >>>
> >>>   drivers/i2c/i2c-core-base.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.=
c
> >>> index 087e480b624c..7046549bdae7 100644
> >>> --- a/drivers/i2c/i2c-core-base.c
> >>> +++ b/drivers/i2c/i2c-core-base.c
> >>> @@ -527,7 +527,7 @@ static int i2c_device_probe(struct device *dev)
> >>>                          goto put_sync_adapter;
> >>>                  }
> >>>
> >>> -               device_init_wakeup(&client->dev, true);
> >>> +               device_init_wakeup(&client->dev, false);
> >>
> >> This would be a change in behavior for Device Tree. Maybe you can
> >> declare a `bool enable_wake =3D true`, then in the ACPI branch
> >> (https://github.com/torvalds/linux/blob/master/drivers/i2c/i2c-core-ba=
se.c#L495)
> >> set `enable_wake =3D false`. This would keep wakes enabled by default =
on
> >> device tree and disabled for ACPI. This matches the original behavior
> >> before my patch.
> >
> > I don't think it's a good idea to make the behaviour different. Drivers
> > in general do not need to know whether the device was enumerated on ACP=
I
> > or DT or whatnot. Same goes for users who should expect similar
> > behaviour on the same device.
> >
> > I wonder what is the reason why I2C bus does this for all wake capable
> > devices in the first place? Typically it should be up to the user to
> > enable them not the opposite.
>
