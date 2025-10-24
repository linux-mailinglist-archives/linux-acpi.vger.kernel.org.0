Return-Path: <linux-acpi+bounces-18170-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA69EC04AF7
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 09:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C491B8076F
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 07:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157062D248A;
	Fri, 24 Oct 2025 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Hh/LIHH9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE792BEC34
	for <linux-acpi@vger.kernel.org>; Fri, 24 Oct 2025 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290260; cv=none; b=iMRjeSSca052sCkhajSNhJYFFGcPHAAwluoCz7rksy/pByDsoHCZDGTqj6HwQlMpFipeR1yQcLLcZvolhCho3X53bz/4aRr8efnrPaVS2dlvrwrQjHc2pZ8YW0ehFEba9IhxoJvmBralxsnPWC6H8Rh92xWpLAHoua4g9NkOPfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290260; c=relaxed/simple;
	bh=h6tvnK0ig57jTEdAxnPvo8iEQOCIPVB7NO7ABROSJlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVv8t8pQkcwF/hkEQc4tDbRbIcz6ZE5HL3focAItO574MILf+h7XAbqt+52Po4Ur16zvR+s5bEdAdR6eIPR39J+w6oMErIBRM8XGyxQHzDJV3BifcTmLH8o5jWrJFnivhp3CQL3NgYN/hBipW0S7VPk4jfpLlyB2AggwtCLpTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Hh/LIHH9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-592f3630b69so2135689e87.2
        for <linux-acpi@vger.kernel.org>; Fri, 24 Oct 2025 00:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761290256; x=1761895056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50RoFCtoYdtNhCcZXh1N26BbF9N2TRDC7n9nR8KK4ck=;
        b=Hh/LIHH9EWP9SMo1Wz5KepCOsj7UOc1jBMW/MX6ohDd4KTQmQ17vieVR1zojgB00jV
         leZ+sb2JWjQFdJJmM37l2QezEFlulxaqMmBR2GSYsSsp0p693NgdZDJXXm2ehejLOKye
         b2bInW90ScSf4wTuC3I2s5/uUwW++tX3mHiiFo3oPdIfSMU0WxzkLxm43ynRWlPDxl+e
         Fiz2NuoghtjzM9Z+X9p7mkDU6Z1ig0auZFNWMIjHHDmA2YlorVgaghfazAQfnkSd36dQ
         F2tHDJsAeofrFad3Km5PEDWF1X+kDkTmxnSUySyupWSrMUOxBGRxwqGJUSdfiygmWBwr
         de6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761290256; x=1761895056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50RoFCtoYdtNhCcZXh1N26BbF9N2TRDC7n9nR8KK4ck=;
        b=rS1rw6VNwgPRtjjD7snT7br55lAvlH85tJvJ0yGm74EGPfBSeJmMGFisALFIB4oM3X
         EvTjw3NIPcHshORsodmK5wL35DJQ81IpffYCq/2eEVToQUdl0gZloe4fF9ju9U56jPEt
         +VWWb4wWgd2WMsnDHBtdswEdTmfkD7uI8ViZGd21DpyU36qYFWgpKYGGSBhm+aKYbvb6
         x9iB9sXMCZiSmQlQ6tsMVA5H+mnaSvKZKSWn1tpzDT06kJ7yy/3uKc57mkaN/MVdZf4B
         jeqAeeQTL0QxaAsxU2+3eYMSS992R48+CDrLSp2fZo25zQRDIKjnfvfMeTItmAesIKWt
         SNTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZr0ShGSrC0JWyZaizwyxbDkm5oN77hPd+dNoBHgWUr0yzwsBFBxaDTTUqfdO6XbKYhqYte/Dx3Z3X@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0ts2gL075dJupAfryyUTFKMxodN9lrEfuSzW7s81r04Me9mP
	thYAKBgErcW/wnO2ZCiHBC48HT0PoHm+u9mq1nQSsAIafzYlRsJiqbMccOhR+cX0NwVlE2pS6BA
	mzhtTE3uT5PHpBpWo9hFKaZTm1YXh87xDhRWMq+pu6A==
X-Gm-Gg: ASbGncuHP3MdbJwP3WCqC9F6k6ZbJ9MHiwZt/SkSrSOHd7JyBrq7JJWFBA/N2C9hsJ0
	Ohb5pP3+mjE1MWWc2Ndvvs4E16fpQ+osXvALga/BbtpKN6oZq2QACxx8/6fc3Bqd/Qt9PQa3VUp
	mAujJzExx669cLIUzSdh1fd+axdEFbjZPdUW3OB45AUKegvqwh+pFEYjnaWf2h2LVun4olOEZFo
	r83fxuoZxp+jdXX2mrcYpK0JnK/pcTVO5NG3Xs4m/J/Py2CqYtrJ4B3JX5j7HhYzk4c0IEeNTGT
	fLtLjjS+ren6id4=
X-Google-Smtp-Source: AGHT+IE8neVFu8ZIN5sSXL6tieYxgR9sJA/fT6BQfIeVNgFTWlxgxkEp21AyvSf43DhGoh14lH1c87nKZ36hn82BpM4=
X-Received: by 2002:a05:6512:3c89:b0:592:f727:3209 with SMTP id
 2adb3069b0e04-592f72732cbmr1678539e87.37.1761290256485; Fri, 24 Oct 2025
 00:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
 <20251022-reset-gpios-swnodes-v2-4-69088530291b@linaro.org> <aPkmDWJEKrjlMPnD@smile.fi.intel.com>
In-Reply-To: <aPkmDWJEKrjlMPnD@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 24 Oct 2025 09:17:25 +0200
X-Gm-Features: AS18NWChfhu5HfalO-BdlmyskcwYb0ZO_M2N7vcsZ7y2nHqTFlEjipwk5PGstwk
Message-ID: <CAMRc=MeNNGXy6aAanLnbWFYJiK65dvm_HyjCDS1=LZ4RiA4GAA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 22, 2025 at 03:41:03PM +0200, Bartosz Golaszewski wrote:
> >
> > Looking up a GPIO controller by label that is the name of the software
> > node is wonky at best - the GPIO controller driver is free to set
> > a different label than the name of its firmware node. We're already bei=
ng
> > passed a firmware node handle attached to the GPIO device to
> > swnode_get_gpio_device() so use it instead for a more precise lookup.
>
> ...
>
> >  static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle=
 *fwnode)
> >  {
> > +     struct gpio_device *gdev __free(gpio_device_put) =3D
> > +                                     gpio_device_find_by_fwnode(fwnode=
);
> > +     if (!gdev)
> > +             return ERR_PTR(-EPROBE_DEFER);
> >
> >       /*
> >        * Check for a special node that identifies undefined GPIOs, this=
 is
> >        * primarily used as a key for internal chip selects in SPI bindi=
ngs.
> >        */
> >       if (IS_ENABLED(CONFIG_GPIO_SWNODE_UNDEFINED) &&
> > +         !strcmp(fwnode_get_name(fwnode), GPIOLIB_SWNODE_UNDEFINED_NAM=
E))
> >               return ERR_PTR(-ENOENT);
>
> Now we might get EPROBE_DEREF for the cases when previously it was ENOENT=
.
> Why is this not a problem? (I haven't found the answer neither in the com=
ment
> above, nor in the commit message)
>

Yeah, maybe it should only change the last part from looking up by
label to looking up by fwnode and leave the previous checks in place.

Bart

