Return-Path: <linux-acpi+bounces-18341-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E09C1AAF9
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 14:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D261AA2730
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F85A279334;
	Wed, 29 Oct 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QRdQSWtx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7141427877B
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743971; cv=none; b=eAIln/9WqY6ne6RP2rjqacTHMtBfGfyc3JJ1CzqAMdkNCN9chC+BLXuE4qejvmi3faEyV9F1hk6zEBqTAdR28x9RVPsYMSzsD3dcJP9ysOgnTcJKp57OiighixAzNaZ3Rmo8ggbHcxz34/l0RqnOrU1DUuDJZea+fOOuhFI2/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743971; c=relaxed/simple;
	bh=5qpTR2oYTbgD5TBux+eB/2ftXVOVUsAhm9/BBxaVk10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJ6Ve8FitMl0p8wDS82sfbhx+yeOKgKVvyCHlPhtVm2KTIRcftSrcbuSGESEYLM9VDgJ3fEOdfvkIw4eNou1EvDpoGBD/SBqJnR1PZVz7hCR/eVLp7ObL5nxi52BcW5ZEharSLDdzIrlvXQg4BiPn3DMXdJtgOuV6o9P6mdE94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QRdQSWtx; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57992ba129eso3866024e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761743967; x=1762348767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qpTR2oYTbgD5TBux+eB/2ftXVOVUsAhm9/BBxaVk10=;
        b=QRdQSWtxQDFOefbPwxyGfp5NXzRgztAWp3Q4UlqZC0YSVBWoIS3MCsbN7gk6CTsWYX
         nzLPeTtKcIyiXLmNWypl1/ivBzp033JhDLiSvYfnvWAu1RqIBRAU0B++VfxGzZI/u4pG
         /KN+QbKRNBbKSSmh//o8qR/zC7Wtl7rN9ui/8pXOKuTXyFNo6+wiO7Qt+JS1LYpf8p8s
         ytyVxYL24oiD9BCW0LTkQRG8qI9O+9TfNESZhZp+X1YGPCkYoLkABqt2GTHRl+hQT0ke
         doQQio4sxxH4uWE1eBuQK76P6f8fKV26/3SHXY4m2QjSA7s8/fKuUlAi61YFvOOIXfqO
         Ip4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743967; x=1762348767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qpTR2oYTbgD5TBux+eB/2ftXVOVUsAhm9/BBxaVk10=;
        b=aUlEw7zs4zu6PcxxYGI1+CQgiBwftvExKTjBuzBPYTHKYVTAAOZkHyIm46Dv4r7p3C
         nORi/oHBK+IlhJFhRBltCpqNiqsKOqK6FyGK5in3yxJu4xaP6E6q2aSTvp4xJ03sLneN
         LjMvq0iAEHwu7XySwgaEPSzK0AfZdDV65zmZFDxM9ctrB1yPo4Rq/3UBbnLVLesM24rw
         FgFbelY80Lust5ba0tnt5oVzNjgd9nIpSwjWcTiOyWe+4BfldCRcG0+JyYbAMgtWZpZ3
         GfYwtl8N9Wg7lajFfhlF54Nh1seBd26mT2RkQFRMyNjIksOlhzQQH0XNn3E25pCba6tV
         AHYg==
X-Forwarded-Encrypted: i=1; AJvYcCWAKHqSujM5eoJdoswZwlSbOzQyrYqWgLBwmPK1z+7djIOu1NK8/mvMMyQZsqhiazUynm0jGuRfvQWV@vger.kernel.org
X-Gm-Message-State: AOJu0YwPusrTURVLnYoK3bTM42N+AeGeedRwy65PbbSdAfdnSu4+5k2q
	ohgE+zWCCJgy3SwrJw0yf/OQvgI2Kohv6Wni7NRSUIeVDQ1ttRydfitpVW/WQp7OR8dFkjFws1Y
	p8kyh03KLa/MaQZnLTjIP0xSMddUrqP6ct+gpDtwrFA==
X-Gm-Gg: ASbGncteiq6xUsM99m+5m0WQzCKKdIvOoL4GJbMq/o8CMvWil2AykOWCkrskbXxeEyB
	avZY0oWXOkpwtmJYhMVGVvIB09I3l7IuR3pYu/MFgRIf6oXRoF18CxfGPTnumYHcRrLfTD8lHaG
	B7YWY+fL3D6kAWDpHo2ECHN+PTAO2XTJibXQk1USlc4sA3UbCreA234KY0aCl9oPUSKxtSPXS7y
	01gMZF5bSdy7zVa3bjZbuLD+DvQzUSbES1E1eavB4652u/lsTXLzOjesB5pKL0v02pxwem1ZwFC
	qlEFoSZodyF+9kjF
X-Google-Smtp-Source: AGHT+IE3KmYDFGeVP8vm6lY3xdcGUVy3w95tHVkpZ6gECTYHrhRU9cn+mn6vdK2o/wGFbA/KoklGqT3oyauzcDjh3so=
X-Received: by 2002:a05:6512:3d15:b0:592:f54d:8647 with SMTP id
 2adb3069b0e04-59412c42487mr1007961e87.30.1761743967499; Wed, 29 Oct 2025
 06:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org> <0b8ec641c76b39f6a96863c16e5f758451641849.camel@pengutronix.de>
In-Reply-To: <0b8ec641c76b39f6a96863c16e5f758451641849.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 14:19:15 +0100
X-Gm-Features: AWmQ_bkjxtg2FXNoc-CZ-J0YudbBfWqhJfw98u15uzEr2iaJoxlwIVFcuMlgKKI
Message-ID: <CAMRc=Mc7GTwXUw2PWMtSMRPf45feizfZkAWhO3NBm7OCh0Pj2g@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] reset: rework reset-gpios handling
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

On Wed, Oct 29, 2025 at 2:16=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.=
de> wrote:
>
> On Mi, 2025-10-29 at 13:28 +0100, Bartosz Golaszewski wrote:
> > Machine GPIO lookup is a nice, if a bit clunky, mechanism when we have
> > absolutely no idea what the GPIO provider is or when it will be created=
.
> > However in the case of reset-gpios, we not only know if the chip is
> > there - we also already hold a reference to its firmware node.
> >
> > In this case using fwnode lookup makes more sense. However, since the
> > reset provider is created dynamically, it doesn't have a corresponding
> > firmware node (in this case: an OF-node). That leaves us with software
> > nodes which currently cannot reference other implementations of the
> > fwnode API, only other struct software_node objects. This is a needless
> > limitation as it's imaginable that a dynamic auxiliary device (with a
> > software node attached) would want to reference a real device with an O=
F
> > node.
> >
> > This series does three things: extends the software node implementation=
,
> > allowing its properties to reference not only static software nodes but
> > also existing firmware nodes, updates the GPIO property interface to us=
e
> > the reworked swnode macros and finally makes the reset-gpio code the
> > first user by converting the GPIO lookup from machine to swnode.
> >
> > Another user of the software node changes in the future could become th=
e
> > shared GPIO modules that's in the works in parallel[1].
> >
> > Merging strategy: the series is logically split into three parts: drive=
r
> > core, GPIO and reset respectively. However there are build-time
> > dependencies between all three parts so I suggest the reset tree as the
> > right one to take it upstream with an immutable branch provided to
> > driver core and GPIO.
>
> Should that branch include the reset changes, or only up to patch 6?
>

I was thinking about it containing the entire series, somewhat similar
to what Lee Jones does with MFD changes.

Bartosz

