Return-Path: <linux-acpi+bounces-4622-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23F0896DD7
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Apr 2024 13:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47851C24C37
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Apr 2024 11:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1914C1419B3;
	Wed,  3 Apr 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X56YSJfu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E9C1411F7
	for <linux-acpi@vger.kernel.org>; Wed,  3 Apr 2024 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142887; cv=none; b=cf+Afu3Vxkwn32xsEiuQNmsU5opYjOMvq9C1Hm8QIczxBooo/mqA8QCYK5DiAqkKoVtfTf1IVavjqiZJDHoe8hU8z4rHQrcq2MU6sKXd8pbLr7eqaVj+Ctx7/mwxYvJdbsNZJTJLZnY+V7SEwHnYrs/MUlH+IDAhHywL0uIiRdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142887; c=relaxed/simple;
	bh=4dHen/LG9VvUA4vaNwOXfwrjtdQI8Ef8IuzweWNrq8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZblp2u4qVYTuJdlqSloyYhVKXUjkSGtHk5s+gHlOPW8bG4YB9+ZOuTxWNPykuKxGIC+7U3RoVorHcUDcKoWY8U7tpiDoN512jazQiCHDelJOO+SxNBvf+3YrsLbhiyeZz8eMRXrhdPnp/44v9Cdj6Hkirnt+2C7hFRmHLukLns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X56YSJfu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513e6777af4so10290820e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 03 Apr 2024 04:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712142883; x=1712747683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0nFW594aT7o5X9JZAIpTWGMmhMtKBdSxH8O2b6eDQs=;
        b=X56YSJfuNQOKfWw3DIDCM7V0NtwzalBu++KLxpmSthF5Acf8qgZ1hYPKOvSi8wh1gX
         Yp6xLEE2sO5Cs4tNJmaJp8FMzSKmubUoP3KjSEgOjCwjED9LJpft2CdMcoblsJkrJ9dC
         +/SHvkuzFtkwyZx1QXUzKht0IWA6ZJrtQ8wwyZNd7fh1/9EHHW1SJ4NGgbxwhKr/ruC+
         1lIzUVKobSBcZLk+T5+Jz7U53ksYZXlOPrWJc3MpXYxucuXltmqjQM6+CBtJJ1yefQjD
         q9ISYQvmDyTZR5CMryjcKjlnwgnT4fJ7++VXvDvJc9brrlhdpruyO+iOeGYSi75UTNAx
         8q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712142883; x=1712747683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0nFW594aT7o5X9JZAIpTWGMmhMtKBdSxH8O2b6eDQs=;
        b=cYjlUYsM20D+NlPr0JIGg+Ip0yo2o5KMeh5RojB+OAW3qcHPNqw9tq1S3+PCFcPhx1
         UTFErXpkvzF4MHG1UiI96TVZYJbQCmz8DpycOP/ULq17K0R6joTt0t7Q70GIb/88fzBR
         oN6l+He+lQ8tbh72kUtQMgFyGtdVg+jxoBlglGjDpv70QfUf8yTJ59V10i66uedzw/cY
         gwf1tQI36pyEpIlmUHVhBrnrUdET5Pj7nQfPfumI8WG3GpoxCWSLRNo8vr8VPMGbkcHE
         rCUUsrQhjLk5r5yFrxir5BSXSq7SYIMSgrMpQhYnVnUJ4+duT5/7sWxheq6mDOFoiQ8Z
         WAng==
X-Forwarded-Encrypted: i=1; AJvYcCUlcpkkmvi8cnr+avdmZpAN0m6NAksWWPbpFHVVb+tjL6ACOzs3JyCC7cJEj9JzZNRPDoQEXdIpKEVsg+zp+ABO3qkf1rVoDPaU1g==
X-Gm-Message-State: AOJu0YyC0DIOs3Ks2kq9OkYQXGFHpl7k+b72MqsiJEVCbxExtZUHvtbN
	g2xETe7MwwjkjySi5K7yVu3+gnj++yckdTjzPipMWvXvnuJSaGkud7oTIVmbNN2e6kdblerP+dP
	Qt5iGCMlDfAjpTOUXsCWF7ZTCBYRH8+M2B17KYQ==
X-Google-Smtp-Source: AGHT+IG4z+4Ndr++qcPD3IhaBePnk545Jp4QWd/wFfePEK48Nb2+1h6x3A0lxSuntNtHpaS9ouWx4IHGkN/0YtNh8WA=
X-Received: by 2002:a05:6512:1044:b0:515:c9cf:7245 with SMTP id
 c4-20020a056512104400b00515c9cf7245mr4927235lfb.38.1712142883469; Wed, 03 Apr
 2024 04:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326181247.1419138-1-andriy.shevchenko@linux.intel.com> <20240326181247.1419138-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240326181247.1419138-2-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Apr 2024 13:14:32 +0200
Message-ID: <CAMRc=Mea+avqmdRgUhAuZPuEh9F3ET_6gYOGGwb1LunkLv4uVw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpiolib: Do not mention legacy GPIOF_* in the code
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:12=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We are going to remove legacy API from kernel, don't mention
> it in the code that does not use it already for a while.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 5589e085ba25..f749ece2d3cd 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -364,7 +364,10 @@ int gpiod_get_direction(struct gpio_desc *desc)
>         if (ret < 0)
>                 return ret;
>
> -       /* GPIOF_DIR_IN or other positive, otherwise GPIOF_DIR_OUT */
> +       /*
> +        * GPIO_LINE_DIRECTION_IN or other positive,
> +        * otherwise GPIO_LINE_DIRECTION_OUT.
> +        */
>         if (ret > 0)
>                 ret =3D 1;
>
> --
> 2.43.0.rc1.1.gbec44491f096
>

Applied, thanks!

Bart

