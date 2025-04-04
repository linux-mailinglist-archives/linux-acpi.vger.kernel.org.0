Return-Path: <linux-acpi+bounces-12734-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E871A7B90E
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 10:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C531C189ED20
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF90A199FB0;
	Fri,  4 Apr 2025 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="awDtH6Sm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4DC1993B7
	for <linux-acpi@vger.kernel.org>; Fri,  4 Apr 2025 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743755899; cv=none; b=l5VJ17Ieim3avBRXKXeEWWe2nHQUhoI3o89YhDMIKYCs0kvFFUh3rKDru4FYs9nlLBY009MpO45dxxtHnOyXbYsmmvoKA0nC5g9fQwdZZ/5sYWOQ3d9piGmefphaanlWpXztyXtqoji/p3zxxC5EVc1Pg1CHGS+d8+N9xuXf+2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743755899; c=relaxed/simple;
	bh=OktGT+TBkq3WfpZd1me7J15mRYBZ6g9T1DYDBuhe3d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fN8vuvOoEMa/msXlfrt+G/Q5JqeI6haluVtjm1rPTJEcRC9/xnLb+j9NlhugkbCC85XdCU6tsldclOdxSI/VjY+UvW816LH3nq0P0Kc9aYRBuc1QUkloKef2/BtjBd7ice2N8GRkmKmdfBm+O2uQ4Wr+VvfS41xKiuY0FeQVrsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=awDtH6Sm; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so15134411fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 04 Apr 2025 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743755896; x=1744360696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjK7W0Om4uq93pjMJtCwW0RKoP5OEp/tohd8eg66f0s=;
        b=awDtH6Sm4pWEr6KInTiEOOi8NnZyDAmshppMr4eQwj9VhLy2EshRGyZ/WmootQn0oj
         OoQJLc8jRb9Xmlz/YA2gJyLUJyP+HXn1PAeaToVeOFSD4ladaH7FKdNv/3gu5iKjoCav
         VOHBvwklezw7I9mkfDBZB2JIjwtglcKweoGjK+Co1oYmycg2ZwgoFgBaBrpRtSsMJTZF
         Yt8JBAI/qKPyvjVQGwAFaCvBeCQIifzPIbixUKxoTv2wJvBCi1Ks28q9K4iPhzKxzOP5
         yZT/gHo43HobB1gghIk3cWNKFxJEnOL+BiBLeWq61RABgDaFc1x1vXn6HdlT/+ouJZBp
         /H5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743755896; x=1744360696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjK7W0Om4uq93pjMJtCwW0RKoP5OEp/tohd8eg66f0s=;
        b=WcMzojAHp+xN41zDv8cdDvK0IxiNgaVMtxNMtMt33Tt/p3tSuXbGJkpbbfeoJFocbH
         gMWzZE0yV+0Y4RUch5WLqqe80NCYI4sLOKGQ3+l+EFBODTrE/2HeVXZdWqfZ4I5sKJDd
         mjLQW8FTAbgYxNu/jnmIj+KvUK7VR1ICLtd5ku9+xvaFfP1CofhQA2zYqJSZl60g2G3s
         iI6vE2vMkmewPXM0zvDSn2D/TWo977kXqz+7C4kS6J+yf9qG58RXlm8ItXN3pSHx6jov
         bK0nRX/g7Av9MK2xedviKbRoRPa//KmHiIM3+HQAaeL5whELyh1Bigg1rzSrYCzgSLsf
         jkPg==
X-Forwarded-Encrypted: i=1; AJvYcCWvk5qL9iSeUDtZcKYx7PNHxsu7+1ylbTPkGHI0W7FjFCP56h4n809ldEu68kefx3GkPUD6OdjXR77S@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7RZb9CfrSlv3QPWp2/hznG5N2N6A5omJVNBu0y9EK1Cmyx5u
	HSY6ZdlW08xpvXks8Dku4jsTO5rj6TPOWE5nTFUb3SF4e5m5zOn0i1bc7Q7ZQ4s+VaCU46oKUh9
	DNjBpuYqkEw+T032Rt1cQBEXBZFwBGIWzMnQK5g==
X-Gm-Gg: ASbGncui2t4+tMAEO6BXGnpNS7J/LEQ3OQYGADnt+Ji7OqxEiMIYNxKqSbRmaOdy22f
	Nk+2C1mEslCjCuIhrR4wuhDfN20OcEKSBIHcFk+RXsJAzp9D1XnERqCWsdKqH6V5qRd3axR4l6W
	RGs3lDN99zP8iWkLJPVS9mPBzVryXRGsAckyCb8A5Ch4rtajoKt+lIfxeMyg==
X-Google-Smtp-Source: AGHT+IFo1yqcfYeeSlc8DpjiZKDyI9rcLin3wb9oxxwP6e5Vf0xIJMSzOKpz/A/vVvQ7XboHvE1K21R5AhhVXknfqdg=
X-Received: by 2002:a2e:a588:0:b0:30d:dad4:e06f with SMTP id
 38308e7fff4ca-30f0a0f0da0mr7997421fa.2.1743755895678; Fri, 04 Apr 2025
 01:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 4 Apr 2025 10:38:04 +0200
X-Gm-Features: AQ5f1JoFgmR-MJjXIiICCtTNAV6gI4tCP6L06BPqgDcRNqu4WYtSJEQRY5AjDtI
Message-ID: <CAMRc=Mf8AyxAeNbBbiQn1HdkrEdODmTAhTmrtiAp6H3=HUPSWg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] gpiolib: acpi: Refactor to shrink the code by ~8%
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <westeri@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 6:00=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> A simple refactoring of the GPIO ACPI library parts to get an impressive
> ~8% code shrink on x86_64 and ~2% on x86_32. Also reduces a C code a bit.
>
> add/remove: 0/2 grow/shrink: 0/5 up/down: 0/-1221 (-1221)
> Function                                     old     new   delta
> acpi_gpio_property_lookup                    425     414     -11
> acpi_find_gpio.__UNIQUE_ID_ddebug478          56       -     -56
> acpi_dev_gpio_irq_wake_get_by.__UNIQUE_ID_ddebug480      56       -     -=
56
> acpi_find_gpio                               354     216    -138
> acpi_get_gpiod_by_index                      462     307    -155
> __acpi_find_gpio                             877     638    -239
> acpi_dev_gpio_irq_wake_get_by                695     129    -566
> Total: Before=3D15375, After=3D14154, chg -7.94%
>
> In v2:
> - renamed par to params (Mika, Bart)
>
> Andy Shevchenko (6):
>   gpiolib: acpi: Improve struct acpi_gpio_info memory footprint
>   gpiolib: acpi: Remove index parameter from acpi_gpio_property_lookup()
>   gpiolib: acpi: Reduce memory footprint for struct acpi_gpio_params
>   gpiolib: acpi: Rename par to params for better readability
>   gpiolib: acpi: Reuse struct acpi_gpio_params in struct
>     acpi_gpio_lookup
>   gpiolib: acpi: Deduplicate some code in __acpi_find_gpio()
>
>  drivers/gpio/gpiolib-acpi.c   | 146 +++++++++++++++++-----------------
>  include/linux/gpio/consumer.h |   2 +-
>  2 files changed, 72 insertions(+), 76 deletions(-)
>
> --
> 2.47.2
>

Will you take it through your tree or do you want me to pick it up next wee=
k?

Bart

