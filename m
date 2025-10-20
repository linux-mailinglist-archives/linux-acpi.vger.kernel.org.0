Return-Path: <linux-acpi+bounces-18007-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7069EBF21AA
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 17:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3720F4FAD8C
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 15:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FC5257458;
	Mon, 20 Oct 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XSngMUTo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B1217704
	for <linux-acpi@vger.kernel.org>; Mon, 20 Oct 2025 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973972; cv=none; b=p/NNIXMRHNPgseGiOixSGuCmdHxpdCuYLabJBVa/2hbXKIuiUVDQKXImTgmTYJjSOmUL4AdYrnWCgW58KWi5QvLRM7d2mvU9FB1RkbI+mU3mO9YoqSPaSIb+qby+Lc/ZhBDkTnWsFpRxTEaGGhs0zKdUxaVyemx1mUHnL9VKwdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973972; c=relaxed/simple;
	bh=a9ZMjyfDA31yDaba7Y56UnAcVJ4HbdeHmZr/qEpxu9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAPjniHQkek0VYtZgQm9tJ833vm+zdvYhK2gt8DEvJooTW2yyzkCYATEOpwWvHb32NbnLI84rxEtbt4f7RyVLT8Jaovn5EP5nT3cw7QjshJsLKYCwAFYeSNp7ijASPt58iZyZx0l6nLGT4Le0hHFCSVTG2XYMqTd1VVa6otAt1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XSngMUTo; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57edfeaa05aso5150153e87.0
        for <linux-acpi@vger.kernel.org>; Mon, 20 Oct 2025 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760973969; x=1761578769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq0Ngsa6W3+xLONQxcuO1N5EPGipkieRFHNCPkJXdK4=;
        b=XSngMUTofG2mnCVOQxRJBpGFtJ1tlrC3GImdXbm6lvRj79vsP2dpgJDjaGzPc1Ce0z
         NBgevDgJZRciHPviT5qkrpgYizL6RYBUNe98n00P5U9wd5LCZUqiA1gCh8VTF0O+gkjM
         FciREUDLHn2arlh6ILcCC+CfBLeENadCE8grkAf9I8leaD1R3ZAVpIrJGPTLncUqMSiY
         2ItqRkYN+/4VkrXaQA2kWDpUQHwklevRsj/YnM8zlhVJtpO4D/dJLSMHYsdTh/AweUnL
         j91i+N0/ec4XF0Ea9Z9u3iIwt66Tv28Ys6WS+XrTpimfnLeBF62ZlMU0MnkYleFWwDmU
         rmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973969; x=1761578769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vq0Ngsa6W3+xLONQxcuO1N5EPGipkieRFHNCPkJXdK4=;
        b=IpoQX/kyq+S25JucVskktYojalbAVYHfrm0Fa+kTh8IxhUoO7qyST08GZa60+mqC4G
         VZZSpaZXeMzNpCPz0XC3/XyqvBexwvAKaJP1bFAkZuyCZGR7ZCRK2Y22lq1KlSoyuGJP
         ywXJffCZKS3wJ5+PmIU1uZlUa9F46W1ISv3HAnpQLbaSrHhhDCZ+aTNAS6v8J6Mq/SsZ
         BXB0W6SyNUH89vb2mNtofhgC716H7ey1TwryFNfHiaLFqV3H1uP8elp55iNn0Iq2Lnwm
         0Bg4QQ7mq1b6Wzk/B+vIFWbNYwWnY6RxZih1S7peB7Aa9tWJ051jaxH6X1MI9LPKBmZm
         /rMw==
X-Forwarded-Encrypted: i=1; AJvYcCWD6P9DCBxsGN1hN0ba09ng+apxPCP6Jcl+8fXKdkKfAof7QZjzIZ3V3sFKhVHQSMqCiD7tKagtV7Jp@vger.kernel.org
X-Gm-Message-State: AOJu0YyOZQVR5aSADbqrRlN1Tqol91CRuv04oh5u3TTDouOUp0LAmrLw
	hLyHBRaoGgUwHT94R90JN9i4r+Og4vji6EpTYV1Qak8XFGbk9i6rNKww5wnA3ojYoQ86xzjm+Mq
	XesU2EUYsP2fXW9eVGlgjlkJoRvvJtyeIWYWwD8I00A==
X-Gm-Gg: ASbGncvpxFOCBxqRH5zIXsWDQrEiMSYtb0cMpyRQbpCkEjGCtbeR0+o8LMDo2VOKQMy
	hgXb74zqber5SFMEEw6/HpNlGAYfzx0qCqr6i1j/Yftf4wr0QczAg0a76KP2M5lZ7gIZQGBRt3M
	5rO1MwKYDlbSv3GLnEMADLK+8i5NT/zDlB1jXCSGFmMqReI864PDMC28RHV1UpWd4vU40HL9Hw2
	bosFRhYgepTW+E1Fz0Xc9wo91hjryReIAzwcuB+PcrlaMPIE9aX8gIL8mb1Bm/8RkSIaXqBOPBT
	ZULx7lEU60+4fSd0yMu+VhvxZ/U=
X-Google-Smtp-Source: AGHT+IGll3AO5pddldZvdf8aT3o18197wF1OauftFBj0SwG5yVH2Ck3XNplXu499kdviIVNDW5wL3ULwaxU1vYqiW0E=
X-Received: by 2002:a05:6512:6c9:b0:591:d7e1:7859 with SMTP id
 2adb3069b0e04-591d8577432mr4474281e87.56.1760973968664; Mon, 20 Oct 2025
 08:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org> <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
In-Reply-To: <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 20 Oct 2025 17:25:55 +0200
X-Gm-Features: AS18NWAjCt18PuLE0qD-eSmCj5bEgp_luJDnH9x9exFUGhDFJ5w2jrnK3EKU3zo
Message-ID: <CAMRc=Md_-mO=HqfncD-vJS6XzPJ+aTcBjSjtkxLH_h1=pNjCcg@mail.gmail.com>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent of
 the reset device
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

On Mon, Oct 6, 2025 at 5:19=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.d=
e> wrote:
>
> >       if (!label_tmp)
> >               return -EINVAL;
> > @@ -919,6 +915,11 @@ static int __reset_add_reset_gpio_device(const str=
uct of_phandle_args *args)
> >       if (args->args_count !=3D 2)
> >               return -ENOENT;
> >
> > +     struct gpio_device *gdev __free(gpio_device_put) =3D
> > +             gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
>
> We are mixing cleanup helpers with gotos in this function, which the
> documentation in cleanup.h explicitly advises against.
>
> I know the current code is already guilty, but could you take this
> opportunity to prepend a patch that splits the part under guard() into
> a separate function?
>

If I'm being honest, I'd just make everything else use __free() as
well. Except for IDA, it's possible.

That being said: I have another thing in the works, namely converting
the OF code to fwnode in reset core. I may address this there as I'll
be moving stuff around. Does this make sense?

> I'd also move this block after the lockdep_assert_not_held() below.
>

Yeah lockdep asserts should be at the top of the function.

Bart

