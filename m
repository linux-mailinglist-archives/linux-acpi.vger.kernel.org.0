Return-Path: <linux-acpi+bounces-18448-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A99C2B291
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 11:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 955CE345078
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5636A3002CB;
	Mon,  3 Nov 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UCIvXGY4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43F2FD673
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167203; cv=none; b=nVF387pLjoVuLcfUjqCwgP0xhepYJ0Gfs+hAuQnIq0v09PXU3LZWuNtJf0PPRdUOhtRKWTUR/sK7i6QHwRE+RcWyUwBsoxt6nKnSsd3YzSj7YaMKxbU3D/HXhxO6jOXpH2eSmDP4h5iz4xH1EjTkuinRgQe0grq/km0B8sJHKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167203; c=relaxed/simple;
	bh=EY4jDPbNPmr5PzA9GSYwh54Yw35fl5rlzQYnUs6Iusk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHWW8ZBmbj0QDjS+2v7nUcf224WrKRgnN4HbewN2A7pgvJp1UUnkiduPrxshh0jqtqzIiEkML06OfuaZwos/b9lurgKLM8g4J1c9J0wvgyp/SzM/NMlYaLh1Vfwiex1hQjxTqDTjlRJUK2oedsR8NFs6WEIeVkMBaBKm5oG6KYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UCIvXGY4; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37a33b06028so10326471fa.2
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 02:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762167200; x=1762772000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY4jDPbNPmr5PzA9GSYwh54Yw35fl5rlzQYnUs6Iusk=;
        b=UCIvXGY42sups7C267nt135b6IGwZCedTHICPhayhHMPbplbJQj+iOC6BAtOb9Lj8E
         fhyks2qEOtJoDm+KKTNHfuL4jPTr6I5WF1m6tIkzroGPEVlg4JJSNfFGe1iMdFfLEuKo
         MybiOA76NyK7Y+ynd0E+ZbZJqO03HqinL/RyIhCzNYUd0CCL48SaVATHZDRPRfnWkBar
         0oCOvGC28fCNYArTetHEUb6A61qG0ym2cKVcMvlIn9ouVfqBOhnv6E4wVE1zef0IqAJW
         UERR+FbO8XOafCTeIRIQ906SuvwNCwL45ZBDbi14zEQyGp0MLFPjUcNqMUQLIEyUtlg+
         kCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167200; x=1762772000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY4jDPbNPmr5PzA9GSYwh54Yw35fl5rlzQYnUs6Iusk=;
        b=Y4BLb2ye3g7PvYzT2L97kBHbwkb8SSf5A4LBHiER1Cqll4XaxTY2QhDdnSdFUncpvj
         JsZAG738QXrV9+o5XGBQr+XZiridnbNmfLNnHJk3BA9aHxCjI9Xc8P3X2kBsW6eN0SYX
         7I8cmmxVeAEABPOdrLyccvOkYULd9FCCKOMfcBley2ez15bDoaCEKkHYnySUBV49IJ9A
         /JZoSOCJ0ZjeJY3hkpprbQuqmryg6uKZzSuO6InmSyqUrMxDbSTuDiO9+GJeI8kOz90S
         obPzqr+YQWKWCWw+WdY2O7uYChw7MF2O/h1fmyrhdvsyGw41vlZilB08Z59sR+tL5g26
         o5og==
X-Forwarded-Encrypted: i=1; AJvYcCWuc8G4bO8CWzZbMVeanycKogl1R9NLGA8Na4hPs5Abl9aLavsCcNgCuo4S1qZ6w+5N08ppdGHn5/89@vger.kernel.org
X-Gm-Message-State: AOJu0YwUejVT+oRJgz9qecWHbALNzGUiuZhxlEUqUvTBBqBClbqWTSBM
	8LMB1k2W7mDgeBJ0o0HMLH4a/efNkMnSRfNxLQ1gUNiM+F7HAZi4CCfgaLvKJY5wYnZX+pgMWNG
	4JGVuLkPC3BOMsIXATfaMLQwhaNAYcpfN6cdYA6SWNw==
X-Gm-Gg: ASbGncuRp6grHkh/ixbLvyiHdacQ6uKfp8cnalj5Z8YBsbt2FQ5g7U0NH72E9RWaWRj
	lX0NixL0Vfz4noTHYrtB+P9lOCMf0Nq6L9ITh0+WbT6HJPrGx+qHXubuERe2KHXSMcggHwHCOPC
	dOFd0tdhUNEVbXyCqO+gWosSwY6f97AkaeGbS5xLra28KDW4gwfw8tDiY/eHy9xL96W88NHATUU
	VI8j7kOptqOWI2q9xRMPShCAqI/A9JcqM5ggI/qxZg5KqTzcI8erdef46oeEzhRFGXC8fEBqX8p
	joIDhO3SXg+HAST2
X-Google-Smtp-Source: AGHT+IEShcGLq+8nFRRZ1S7fCAIIXDtScTJ8z36zHz5pLUhN35vmGlC0mMXVLA08DstbNEHUwTHKGlgAvk7gFq8+FWI=
X-Received: by 2002:a2e:9103:0:b0:36d:114b:52e2 with SMTP id
 38308e7fff4ca-37a18dd5390mr27978041fa.34.1762167199608; Mon, 03 Nov 2025
 02:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org> <aQh7JUeQ84WwUzW9@smile.fi.intel.com>
In-Reply-To: <aQh7JUeQ84WwUzW9@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Nov 2025 11:53:08 +0100
X-Gm-Features: AWmQ_bkPWbySIvFJ536kZ_G3NlC3s3A6TPy9KXNNHgvuSGjsmX4rbxmg-1iSaYU
Message-ID: <CAMRc=MdpX+jHQWqFAgOuHB0E3Sdge92=vcjm=xcS4Asqm8_3Xg@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] gpio: swnode: don't use the swnode's name as the
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

On Mon, Nov 3, 2025 at 10:51=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 03, 2025 at 10:35:24AM +0100, Bartosz Golaszewski wrote:
> >
> > Looking up a GPIO controller by label that is the name of the software
> > node is wonky at best - the GPIO controller driver is free to set
> > a different label than the name of its firmware node. We're already bei=
ng
> > passed a firmware node handle attached to the GPIO device to
> > swnode_get_gpio_device() so use it instead for a more precise lookup.
>
> Sounds to me like a ready-to-go patch and even maybe with a Fixes tags, b=
ut
> it's up to you. So, why not apply it so we have less churn in the next ve=
rsion
> of the series?
>

Yeah, makes sense.

Fixes: e7f9ff5dc90c ("gpiolib: add support for software nodes")

