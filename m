Return-Path: <linux-acpi+bounces-19066-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C97FC6D75E
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 09:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC584387AB3
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445EF303A19;
	Wed, 19 Nov 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SF0CWKcO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAA63161AB
	for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541335; cv=none; b=k71Ld9rO6HLLZXnPYHpnh9h5slKusuICEbjD3mT/2LJ+0truBzigJVcnQQvQkq8JFRi6kBB0jX7eQ/qL519cp8j0If05/LWbQLJeDbjxvZ9EhGTNrxgKdCf8avP96kzHUGuNy9qFAZbXTPU56Phj225s1ZPl7nv2/dk+eaJQXwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541335; c=relaxed/simple;
	bh=uGN3R7fBdySWsuqfc39dy2R7BgddWUy+SrgIPe0ZWAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdBRCJ+5ZGthO3QWp2urL71ybIkD17K1K/KLCNqzDmL/yMkCPKnSKQ3SteTOl+l+PfRjYx9KwB/d3WHpEdQEx5dmZEdbBlrC37IQUecUVYU3wQ3iGEirWiStm9hKkVYsuhwA6fq6KSFmr+1yodtgH/LOTIMoGlO+5W9DiL3Zb3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SF0CWKcO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a4e329a90so49852041fa.0
        for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 00:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763541331; x=1764146131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2RFWmDfVhBxr6ySHiSGUFsXD66mksFtBiRw5xe0uVM=;
        b=SF0CWKcO6GjCvyykrqc9zlnoigSiiSUOwmw+YV0DIaOwFL71wDNMzVdWEdse7DtAwe
         h59hbx+FPoR2wfrcYOFUhUfyk+myYKpc0guRlsMVmJwXRpGMUVvUYViQwbGh4Fi5tcPw
         JnsbCaJZSonLy1JnWS8hMNNelvmJp1Y0vStsfPkPlz4KHF/Wi2yqNv6tbibvdol9fP//
         VePEJk3QCy11aTsFjynRP07q3XdaXsfzfSmSxhr5XSF418n99KkR4uuFdzPPn1HflXif
         kyoRYsAigXGLj2Z36w88nTMsKYNdqeiv0mIflcCavDt8y84SDbCIHz00i1Bl4Q/eofXh
         pGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763541331; x=1764146131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B2RFWmDfVhBxr6ySHiSGUFsXD66mksFtBiRw5xe0uVM=;
        b=CsHnyGP2HB6fgw1CkFfqPJ6F66TWSZbT27PbYd6UgmigtWtfzGI9se+9LaIwi+3Lsp
         olG1FUO2ZycgdUvTmUsWBzCTKq08GPOdO/jYvFnTHysDtANJmaSfY1c7dV1Hnltfb+xK
         vyCHSpj4uyQD4WuLONCBqTDm8fxiYN/UtjHIAVwVMeYtugkc23chBPmsVQMckNKAoJXb
         i9UwA1xl1BF6oqMQVnTTILk+8rUHcLbLRH/bVSydcVnBq6pPHQccVQ4CZRAWeiYc9APx
         E4zZv0ll0PzvZ0NEuYaRd1AlppR3V7y+IMEq6Ws6KXV51D7y5do/YpO5lKuKx9AM97mM
         e8cA==
X-Forwarded-Encrypted: i=1; AJvYcCVzOohEnK47CjZ0Bv9Pp2tlLPsZAbPPT+hrkldekdpWhV+ROJ73ky92LlEZ53LNYEf5Eu51gu1FNG9B@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr8Il2jJ9BVqQ2shXmz/2Sg3rfTgjOjhZ6rZlJXhtCHxjkh9lU
	F78gnYBEqSgHIlcW8dSIG3yrUUk77tUOxQZdU5AK10mi3/IdaLRB3nO3zhsY6FlV9cWhzwmn2A0
	7Ujto4LzXTyOsWa+tJo1Q3eoFcL3fpT4L/vQaY+/IXg==
X-Gm-Gg: ASbGncvYNT0Qeg5JKhhvIniVo2IcbGuv52tn7qeoiFlsHBGRJXHzR2yD+9azr5+l1+P
	xGintMq/2jYtfV5hm92Y/yeWNAGDSntoFHe/sNgiGS7dvJxNNRsq25ceEon2WbxIhZbCYkSi4r9
	7BynL1knOQRjADj0W4dL9x7yGLUUU4i5W+BJp3jsBYiW5Uxrh98t/QqJwu8s1e/6q4MfzaOaStp
	0KAYJOZ/3CovLHy7lu7gpdpi4qea42peCP6dtJXptNOaq8CWBjWPeffZwLquzsSPFcpzDSx45j2
	T8XtrbwEFB991xxIhkjxnfRqVjo0N+1oeJhtyQzSvQ64/hov
X-Google-Smtp-Source: AGHT+IEhkwqsKf1fwQnBnqd6x2v30Z/ALakurVARFnXAL/A4rbDF39u4mcvEddy2xtJWhYfLs9keKFvI+YCxl/zn3R0=
X-Received: by 2002:a05:651c:f17:b0:37b:af2d:13a3 with SMTP id
 38308e7fff4ca-37baf2d1885mr50653411fa.7.1763541330536; Wed, 19 Nov 2025
 00:35:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org>
 <aRyf7qDdHKABppP8@opensource.cirrus.com> <CAMRc=MfD7ZbwU4akkCJNgmRPwgSOqSVi2-L2dJDOBHrfdD-yZw@mail.gmail.com>
 <aRy31U8EQA1DO/R6@opensource.cirrus.com>
In-Reply-To: <aRy31U8EQA1DO/R6@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 09:35:17 +0100
X-Gm-Features: AWmQ_bmtH_181RFi84pmThis5ExthWACzq-oQozeVhLThxvpKWPFLPjRzEW-udQ
Message-ID: <CAMRc=MfNf+WMtSW=Wag0QHAaYzcRe9igrbOeRZiY92KmOH70oQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 7:16=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Tue, Nov 18, 2025 at 07:01:24PM +0100, Bartosz Golaszewski wrote:
> > On Tue, Nov 18, 2025 at 5:34=E2=80=AFPM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > >
> > > On Mon, Nov 03, 2025 at 10:35:24AM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Looking up a GPIO controller by label that is the name of the softw=
are
> > > > node is wonky at best - the GPIO controller driver is free to set
> > > > a different label than the name of its firmware node. We're already=
 being
> > > > passed a firmware node handle attached to the GPIO device to
> > > > swnode_get_gpio_device() so use it instead for a more precise looku=
p.
> > > >
> > > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > ---
> > > >  drivers/gpio/gpiolib-swnode.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-s=
wnode.c
> > > > index f21dbc28cf2c8c2d06d034b7c89d302cc52bb9b5..e3806db1c0e077d76fc=
c71a50ca40bbf6872ca40 100644
> > > > --- a/drivers/gpio/gpiolib-swnode.c
> > > > +++ b/drivers/gpio/gpiolib-swnode.c
> > > > @@ -41,7 +41,7 @@ static struct gpio_device *swnode_get_gpio_device=
(struct fwnode_handle *fwnode)
> > > >           !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
> > > >               return ERR_PTR(-ENOENT);
> > > >
> > > > -     gdev =3D gpio_device_find_by_label(gdev_node->name);
> > > > +     gdev =3D gpio_device_find_by_fwnode(fwnode);
> > > >       return gdev ?: ERR_PTR(-EPROBE_DEFER);
> > > >  }
> > >
> > > One small problem is this does break drivers/spi/spi-cs42l43.c.
> >
> > I'd say it's a big problem. :)
> >
> > > That driver has to register some swnodes to specify some GPIO
> > > chip selects due to some squiffy ACPI from Windows land. Currently
> > > it relies on the sw node being called cs42l43-pinctrl to match
> > > the driver.
> > >
> >
> > What is the problem exactly? The "cs42l43-pinctrl" swnode is
> > associated with a GPIO device I suppose? Does it not find it? I'd need
> > some more information in order to figure out a way to fix it.
>
> Yeah doesn't find the GPIO device. Apologies the background is
> fairly lenghty here but to give a high level summary. The cs42l43
> is an audio CODEC but it has a SPI controller on it, in some
> configurations there are a couple of speaker amps connected to
> this SPI controller. For Window reasons this SPI controller isn't
> properly represented in ACPI, so we have to depend on a couple
> magic properties and then use software nodes to register the
> speaker amps. However, as part of this we need to register a
> cs-gpios property for the chip selects used by the amps.
>
> This chip select gpios property is where the problem happens, we
> need to refer to the gpio/pinctrl driver of the cs42l43, but
> software nodes only seem to allow referring to other software
> nodes. Previously this worked as we gave the node the same name
> as the real driver, which meant it found the real driver.
> However, after switching to look up by fwnode, it is looking for
> a gpio controller attached to the software node.
>

As mentioned by Andy: this sounds precisely like what this series
addresses with the reset-gpio driver. We now CAN reference fwnodes
from software nodes.


> static const struct software_node cs42l43_gpiochip_swnode =3D {
>         /* Previously matched the driver name for the pinctrl driver */
>         .name   =3D  "cs42l43-pinctrl",
> };
>
> static const struct software_node_ref_args cs42l43_cs_refs[] =3D {
>         /* This needs to point to the genuine pinctrl driver? */
>         SOFTWARE_NODE_REFERENCE(&cs42l43_gpiochip_swnode, 0, GPIO_ACTIVE_=
LOW),
>         /* This is a mark that indicates the native chip select is used*/
>         SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
> };
>
> The bit that is unclear to me is how we get that software node
> property to point to the real pinctrl driver rather than the
> dummy software node. I think maybe we need to add a SW node as a
> secondary node on the pinctrl driver itself and link to that?
>
> Also happy from my side to spend some time working on this as I
> am not convinced what the driver is doing now is totally legit.

Well, it is sketchy. We register the cs42l43_gpiochip_swnode and
reference it but never assign it to the GPIO device. If you assigned
it as a secondary fwnode to the relevant GPIO device, it would have
been found during the lookup.

Right now, with how the lookup-by-label works in gpiolib-swnode.c, you
get the referenced software node and read its name but there's no real
link between the swnode and the GPIO device. It's just a big hack.

I have an idea for fixing it, let me cook up a patch. It'll still be a
bit hacky but will at least create a true link.

Bart

