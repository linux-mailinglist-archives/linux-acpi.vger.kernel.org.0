Return-Path: <linux-acpi+bounces-19035-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 045EFC6B153
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 19:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79EDD4E28F0
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 18:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC8D2877E9;
	Tue, 18 Nov 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="E3+/bxp0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127CE2D23B9
	for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2025 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763488899; cv=none; b=WWbLemRuASNdoakG6g7gNFaYr8uAHXwZr35Ge2sIhHgtPU4T7LVJfXtBJ0xV79PoMTSGU1ZOMHnmAPCbVA0CeTisU7Te+6wj32kjWxtOBW0QI2sxqbAiKfkEhiVBKDHo+jPL5+mb6j+Mzc5inBTS7ak9NsysiRp4al2rISPXU1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763488899; c=relaxed/simple;
	bh=SnW7UzuqKJ5rM/ZgtBMlRbig81FOve9wzINRcn1dYzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TF/jhtw56CapsISgccjek2wKrb88MK81syprs2Czv2Npc63lec+pPDnaok1aDCBV3Dr+jv4iOIziVGu4HEC/14PwTSExpQtr7c5PT6Vp0xNm9W5ZRb/n6xwVIH09YpHawkb1sJChb4aO1vEuZ3f9365y5nUFuHdxpfInF/xxKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=E3+/bxp0; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5943b62c47dso5802474e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2025 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763488896; x=1764093696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3P3rRUVq+sFXnSS3zCUbO/spJbXMMnxEdI7C9ymapPQ=;
        b=E3+/bxp0dR+U3ZgTfutVW/ikhcWxlOOzr9LdmcSKEYvCNk6aaCwEQsjFlBocsfV18S
         XZBaSa8tFiRjPWY4sgkuqf3COwuP3OSAv4Eej4ky2IIa1YDJOrX3a4BWZm2aAhoLNrxm
         lQPUsjIEBI+a53nX9vYWqQHq6RU7wdQoGQK7Tq8vcFSYxea7lhMjeRkBKrlLgZ4Vio4C
         UxVIzZ+wk8V4GjkbEiX/X+14Hy4JKwthI1pZU2yNUj+84n4St0iw6Vdi2leaa2UxR6gW
         mVKnHd6AlIcC4Dr6uEvYrEhRWfZXQ1r2BSbwbV5M2Jqi1TX/tYoxizCMA/y+Yb6WXYST
         jq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763488896; x=1764093696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3P3rRUVq+sFXnSS3zCUbO/spJbXMMnxEdI7C9ymapPQ=;
        b=dFJgJbkKpcy+wNQRccAVoHUgSfDH3VvCbRFrFwH4KcSvxnlPqr2cMDAxMnoPeb1RWF
         0SnYihB2kj6kIZ17Av6YezLuFFt7pZ091dpFzJWJqePQCMDCQ8AaxWzFvYBdSE3WOrM/
         xnKU6GxnGntOOBon8YoDtIO6oj0qhIppOceploixhexel/lWyFnMo+kZAQRnWQc6KZ6J
         +HX5zwZwKP5JCwfFtOLbWNweonK1Hh6oqBDcgU0W8WvrJqQtgPrBjL+RK9TXr5wLF55M
         uO1tGg1Si53PK6lzDoyyvYmZ/1mbHmtUfawvmW0RlTUdDJrJAmSksLS+bNj6uUJwN6+m
         Jw4g==
X-Forwarded-Encrypted: i=1; AJvYcCXEOauByCC3r7CP9OsriePTPbdO4t7XyIDQfSIS+fXjDDnZW1LQTyKibdFEDPxgP2U7zQaDWqDqVyhK@vger.kernel.org
X-Gm-Message-State: AOJu0YyccETpvzdj4xlXnXFtkpCxXKNIHZVPionSGcsmpIvtgXFGkpJU
	gxuzuFERHtduz+p/ExeRLXyIc4H+jQOzwMH0VHuFoQh3Y5RjmPRESQydnZvTlg82kMCKScUoUC0
	JMkBvtnSQOaeUC48lOrZA3VAk917946Z3l5jNXaRkPw==
X-Gm-Gg: ASbGncv6qz1aUwFQtO8HBEhfizE+YYjBAsd7a72EW+0LRQbGzjUEi48wzvSY6asEgOI
	LBkh2cQ4PTbyWwoOXmUG1M0+88AmSXhciyQZxLarRQ+ye7yq1w2sH/Xg7owfkxzpLXVOD8d41Mk
	+aPFGpTjngW98wGhB8N+CiS5gL4eW/wkVQ3ZWionMiGKei8VYLCV5MUsqIsP0xGfwGa12lqVqPo
	NRFxSBgElAzAQPpO4KNIrTT1e8HNmEiJtNZhhYjuHSmhvKvM0v6On7IGODttH1l9fGokxM9bULJ
	m9BHypFVebz0Q0Rinprm219qQRM=
X-Google-Smtp-Source: AGHT+IEWC7zJ3AFn5UbdpabBbmuXW3FNWuLD3q3ufY8SHzYHgz3vTgCcqOFiEET7iKyCQIGYrA3eeq0SfERai1S6P+g=
X-Received: by 2002:ac2:4e08:0:b0:595:9d86:2cc7 with SMTP id
 2adb3069b0e04-5959d863118mr191555e87.39.1763488896009; Tue, 18 Nov 2025
 10:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org> <aRyf7qDdHKABppP8@opensource.cirrus.com>
In-Reply-To: <aRyf7qDdHKABppP8@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 18 Nov 2025 19:01:24 +0100
X-Gm-Features: AWmQ_bn5fs5An1Ys_Go6Dt64d65nQeBWJZvAP84oOejrkVzt78TppX6f_h1mou4
Message-ID: <CAMRc=MfD7ZbwU4akkCJNgmRPwgSOqSVi2-L2dJDOBHrfdD-yZw@mail.gmail.com>
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

On Tue, Nov 18, 2025 at 5:34=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Mon, Nov 03, 2025 at 10:35:24AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Looking up a GPIO controller by label that is the name of the software
> > node is wonky at best - the GPIO controller driver is free to set
> > a different label than the name of its firmware node. We're already bei=
ng
> > passed a firmware node handle attached to the GPIO device to
> > swnode_get_gpio_device() so use it instead for a more precise lookup.
> >
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/gpio/gpiolib-swnode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnod=
e.c
> > index f21dbc28cf2c8c2d06d034b7c89d302cc52bb9b5..e3806db1c0e077d76fcc71a=
50ca40bbf6872ca40 100644
> > --- a/drivers/gpio/gpiolib-swnode.c
> > +++ b/drivers/gpio/gpiolib-swnode.c
> > @@ -41,7 +41,7 @@ static struct gpio_device *swnode_get_gpio_device(str=
uct fwnode_handle *fwnode)
> >           !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
> >               return ERR_PTR(-ENOENT);
> >
> > -     gdev =3D gpio_device_find_by_label(gdev_node->name);
> > +     gdev =3D gpio_device_find_by_fwnode(fwnode);
> >       return gdev ?: ERR_PTR(-EPROBE_DEFER);
> >  }
>
> One small problem is this does break drivers/spi/spi-cs42l43.c.

I'd say it's a big problem. :)

> That driver has to register some swnodes to specify some GPIO
> chip selects due to some squiffy ACPI from Windows land. Currently
> it relies on the sw node being called cs42l43-pinctrl to match
> the driver.
>

What is the problem exactly? The "cs42l43-pinctrl" swnode is
associated with a GPIO device I suppose? Does it not find it? I'd need
some more information in order to figure out a way to fix it.

> I guess that is not quite the right way to handle that but its
> not clear to me how to link the software node properties to the
> pinctrl otherwise, anyone have any pointers there?
>

Depends what you mean. Creating software nodes is fine, depending on
some arbitrary string not so much. As I said: I need more information
but I'm willing to help you fix it ASAP.

Bart

