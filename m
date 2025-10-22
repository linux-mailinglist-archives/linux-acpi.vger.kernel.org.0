Return-Path: <linux-acpi+bounces-18104-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FCEBFCB21
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9498119C7CFE
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 14:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C56340DA7;
	Wed, 22 Oct 2025 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tR5vlHqf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8CA30DD32
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144769; cv=none; b=POTsUKfHLBjCx4Q1h27KY4BU56nqyHox35uwHYGFgK2g/FCVAog40im4bxVz+WfdQhgr/kN7IDQXDcNqY9Vc3OZTfZrv0eStLeq3ZB37YJw0vVpV36EExHwj3x1i2XZlLImGSankpkmhsGDIdWAImGZumXKvyEertVo2NgfZqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144769; c=relaxed/simple;
	bh=xh9CmQkxVsV9RC2x2p7KC5RESg+QfKoATUgNDTMz5fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHWavSSQ42BqG6J3lg9oSZRIq6INCGgVPCrbY4ScutmzpO6K1D6nxmzCwzCFoCWO5eoO/O1x9A1YrAU2Ss9daE2Cx9z5myL78BmTtg1ZzQyx4IHjRRnLg+OAJec+qRWijjysKJDCrdAy14cY1cxtPHTDmNFxlLnShCUFRe+z0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tR5vlHqf; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-591c9934e0cso7800761e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761144765; x=1761749565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmCNP4JPT6ISqq81Ea+ZKZcu4abvsAE5zrLeAHfQet8=;
        b=tR5vlHqfuSXVYE28ge9VUzTf6lUnWkHHsnEcekvY+oO6K2bkwN2jpan70+6RIa4VtA
         C8EWzwSoSd/klHob9/l3r19FVIFmZvl/ak9og3cPl5IVT8zAlq47S8hCUUnJ/ZDYBk1F
         v3ZFkwlkD/gQXW0wmVV4fJaRS7MEvMMjojDtb5B516yYnT8cy8Y5rTSB7PZrX1G3vkoU
         GqDPFnvTre0s+M7qEgj+oNEC8TH4O4XX1vClYSgtR1F/3PXBVxFzEmlW1/dX0Mi7IPz+
         4UDKwryVry32gu1LGn+u+x1CmnsZDlPKO+aZBbeAAAXHNMZ5kxgfRZOKwHBU7prvFBrO
         OIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144765; x=1761749565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmCNP4JPT6ISqq81Ea+ZKZcu4abvsAE5zrLeAHfQet8=;
        b=sfKj6F9WdsTqVhh9Pwdj38HG+ihOZ+RPN/jOjKU/QkLC13KIXx/0AX11i6b80TTafR
         rr3PIkWu2sp6oz5CVkjyOwEQ66Ta0Aa3OId3W/zEZIOsVfTXQ6ZhkELoEUNebPSvYVb8
         WfggwFO5yAmtfdQ7Bwj/sRPVn9y+ayWp7/UcusERzISqqT2/ez2b3vLWgjbgYpGeBVNP
         hBSU2eQS2zyM8e+NrfeXbWC3ctYm2OvmDy174hlnSb3A0LBpUCa6/kw16ziim0xtgb5q
         BEqKEqbH3k3qdo4H+dFRZVePLoieCzRvKIlvMOlZA0qIWP6xH7fG/evos9nKzet8UneL
         tmgw==
X-Forwarded-Encrypted: i=1; AJvYcCWeraVgBqdlzozx9t2pg37uQwrZN8xr1FQhl7sOapAt/i+QYPkmkNaPFstmVvx8eCNScbN+q2jJ9PUL@vger.kernel.org
X-Gm-Message-State: AOJu0YzwSpS4MWlJp3pHvNM7B6GY/BFOWIbEIdUNhX5oPM8SSs3Jx+HQ
	cnew2ZKZMETuMCxw4g7eHx0JAi4QLgkUSPXTvlP50den17NIP1EFmAnyNW4qWtyIP1ue5MM5WWC
	zAYLqX/ZWjZqk2ipFdY5PavjiHxp8FMm4IpXTA2zegw==
X-Gm-Gg: ASbGncuRmod+dx2xinTir2uoHX0S1OIa6E6VdkOhrWtk2yfMab9ET3aOBH99NTXFYyg
	/tLzb6WCeAEj8OCXI2/tzZBncBfas2fZ68yzR4TGx6QK7t59UBvg9Qo4wwmV8/3KWDBbL1PW51b
	KOXC/+lP98XLX2nnpsRgd9pyYvuNvSfqx4P0QxAQga50uYk16Nif6E/4slOQ6JSOwwKziA+brqP
	f4O2a0T6DmbTsXAWpH4zRKWe+G/sbjcdfnv5S8ECO4LUkepaA187UkjZmpwOjzYCJgw3yd9uLR4
	OMx8Acr+ztj0bsAf
X-Google-Smtp-Source: AGHT+IGBBhRx0YzsXET+VtFW+sPDELcXEcSsY3fwYo5kG/qbQhoaN0mdJJLMdkf1kGOIwKn1vR6GjMsjzx+KrrXkyto=
X-Received: by 2002:a05:6512:23a8:b0:590:656c:d10c with SMTP id
 2adb3069b0e04-591d84ec157mr7085239e87.16.1761144764601; Wed, 22 Oct 2025
 07:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
 <20251022-reset-gpios-swnodes-v2-7-69088530291b@linaro.org> <afdcde3c2ce49f42740e3e436d78d2796bead3ad.camel@pengutronix.de>
In-Reply-To: <afdcde3c2ce49f42740e3e436d78d2796bead3ad.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 16:52:32 +0200
X-Gm-Features: AS18NWDHMGlvggGhK5l0kHNgLJMMTVZV0jKA27W2ZbuBaqkCFbwhJFa52Dfg5tw
Message-ID: <CAMRc=MfxLNPgmNUHOuC8eRf1dyx88i4chzpJZGj7=7_4hrTg=g@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] reset: make the provider of reset-gpios the parent
 of the reset device
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:45=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.=
de> wrote:
>
> On Mi, 2025-10-22 at 15:41 +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Auxiliary devices really do need a parent so ahead of converting the
> > reset-gpios driver to registering on the auxiliary bus, make the GPIO
> > device that provides the reset GPIO the parent of the reset-gpio device=
.
> > To that end move the lookup of the GPIO device by fwnode to the
> > beginning of __reset_add_reset_gpio_device() which has the added benefo=
r

Wait... I remember fixing it and even mentioned it in the cover letter. :/

>
> Still typo: benefit.
>
> > of bailing out earlier, before allocating resources for the virtual
> > device, if the chip is not up yet.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/reset/core.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > index 5a696e2dbcc224a633e2b321da53b7bc699cb5f3..ad85ddc8dd9fcf8b512cb09=
168586e0afca257f1 100644
> > --- a/drivers/reset/core.c
> > +++ b/drivers/reset/core.c
> [...]
> > @@ -919,6 +915,11 @@ static int __reset_add_reset_gpio_device(const str=
uct of_phandle_args *args)
> >       if (args->args_count !=3D 2)
> >               return -ENOENT;
> >
> > +     struct gpio_device *gdev __free(gpio_device_put) =3D
> > +             gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
> > +     if (!gdev)
> > +             return -EPROBE_DEFER;
> > +
> >       /*
> >        * Registering reset-gpio device might cause immediate
> >        * bind, resulting in its probe() registering new reset controlle=
r thus
>
> Please move this after the lockdep_assert_not_held(), as discussed.
>

Sorry, I missed that.

Bart

> With that change,
>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> regards
> Philipp

