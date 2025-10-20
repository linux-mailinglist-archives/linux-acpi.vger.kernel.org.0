Return-Path: <linux-acpi+bounces-18009-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84327BF23E7
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 17:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6F864F81C2
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B9127B336;
	Mon, 20 Oct 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="it80txUR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624427990B
	for <linux-acpi@vger.kernel.org>; Mon, 20 Oct 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975827; cv=none; b=bCpO4qkAa9R8DXth7+tqMmENmUhEPAemAZLnqLDGuHpxWWmK6gBCB9qjRFyyEORJZxckqg4D5Kwy/YcmfDrHwzA2pN8LKao4tIOaMI67ANqc8lD0evI49sYI2Hvcx8S8crZg4JYvlqZax3WjT6aRYtl9i8Hs69RdfjEiUABucEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975827; c=relaxed/simple;
	bh=2GHllKR78eXABXgCgXnbeq26/zdb3DR14G1wBwF7LXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WR/bb3ddfZCxNzMr+65PVnayrB1NinBB+lm1lgNSzSYqFObM4Xx62fZAr1WdTwVJnJZr0BjP9rP4lvOelKq/LyqjqpxmmkPFjD5BD5Lxfyzdf0Roi99QS9CzueHATLVAsP09rYgwqqZps7QOejdjkYfrs5bu4Qd0kLql809xn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=it80txUR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57a960fe78fso5911568e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 20 Oct 2025 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760975824; x=1761580624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=see7eeK/o3JXFmIi0swdhzRJ0AZ3Yr9L2D3lHDaHtOo=;
        b=it80txURHOiLdwoe77XG1aiPXjIUoMIGiD4iPGh+EGHOq9MujGiMoEl9i5LWfvQ5Mp
         UV0P80q42sXX/XtRZnwia0OrTHa8YIt8+3SKuTAHYMkjIHrpo2o6HHTNu5At2p7qXM6U
         011PjC78n2jNzzUJ9L50PX8NK6maVLMZfuTkg1sTIp9x3kTGqW4dVRR8ZJESg/onzOHF
         LGcxupbq6EUS1XZDzipQ1XcU6VGUVbA68indkZ1trAA37+lpnSNe/x45qlYkF7MRZe1E
         XrT/SKQGWfrka5c5iFI3sC0uBWaKwrrcH0cefYzTaC8XPiyzc9E9ZGiTtg4mhlmM+shM
         kkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760975824; x=1761580624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=see7eeK/o3JXFmIi0swdhzRJ0AZ3Yr9L2D3lHDaHtOo=;
        b=HKaffWzxRT1qzkN9RIFQJg3oLUen64AsflEdHOJC5j6q6ZyDdv+MwoIeyCZ3N8Bri2
         rniMn2OWEBRwflu89QNzfT5+PdzXwy4cFF2EAk+3On6CI9bg+U/rHE+cuOrVh32EtaNC
         UQwGiRVBBEappIkEuHIPTIwqwciYpNBGFt8MJn8jtGvs+YSkTDihMLminwa36tTYKOu3
         qQnyw1vssVU9Vnx7Kxyk5auosIMjWcBGXqQwi2LLy3pMR2UDRWWvPMHzkkZMG4ENl8cB
         Rt+zXFEtfP1kr4EJuzBnrrUfYDfgraUwdq/8wqKYuT40BFwFS9U8Qt8clH/LbarXS1UM
         D8HA==
X-Forwarded-Encrypted: i=1; AJvYcCXCJYauVnPerot5yydmg3s+Opqd+apJgs9TRSBAQxggi7TLzWdhWzK+BZyu6uIa9BOPiPFUTeYipnni@vger.kernel.org
X-Gm-Message-State: AOJu0YyZpLvlQHDO3bQRLl5YeoSI0CTgJUXMxuGJ/oN4UUxIYVoKsBhu
	jgV5Q1zt2cKXtUEa3PRhR0q1QrHEOi+JTkorSdnGGVKGxFbrdK6VqDrT21DII2Vf1LU00UyUgFW
	I/A4hjt5kPl7vLIFA/2iKAOzYxl2iOd2JynDfpi+bWQ==
X-Gm-Gg: ASbGncvYAWrk71LOdXF6rTMqS/U8Mo494o48YxWEAz9q885mWeD5C1Xj+aZWkZsG4bv
	ZeJpOxUq89tt4G8s3hLq6aseVK07M++MvoN2jdKymFlvJ5jBT08JEqWGb0TNDnoj07mkWH0JvM2
	ildhsBNuoKu3LC5TYhwpHSa6QpS8azZsH+xmScctNHb2F0ECR9ggJ6MVzIjSr78sovcj+hunXPW
	se1dqpu6l3mx1qAo/Y2NkjnXRaodz2Kyd/c1EdYg4qKArzfpOhFqiXk7AIZM5ne93HB9VDC7OlT
	Vd6unCmea1jreKIBRH+WyGryQRE=
X-Google-Smtp-Source: AGHT+IEuuuAXyQbhIZ1efTXDOiUURdFYJXMq2J+B/+HoQEbi+jmTEhyTs5lF9J4ykjqXS8qP6TFPNABuDMtHbVYgwAc=
X-Received: by 2002:a05:6512:6c1:b0:57e:ad46:b0a9 with SMTP id
 2adb3069b0e04-591d851f0d3mr4618106e87.16.1760975823902; Mon, 20 Oct 2025
 08:57:03 -0700 (PDT)
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
Date: Mon, 20 Oct 2025 17:56:52 +0200
X-Gm-Features: AS18NWCip_vrKjuKwXv30qIgtOF4llYZifypjnStXrv1XDQCWqc4qBKkCG1yVdc
Message-ID: <CAMRc=Md6FRUjUBGYZnrNd+FpYq3eb4kptkzxU0wJiAzALx1dWw@mail.gmail.com>
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
> >
> > @@ -868,10 +868,6 @@ static int __reset_add_reset_gpio_lookup(int id, s=
truct device_node *np,
> >               return -EINVAL;
> >       }
> >
> > -     struct gpio_device *gdev __free(gpio_device_put) =3D gpio_device_=
find_by_fwnode(fwnode);
> > -     if (!gdev)
> > -             return -EPROBE_DEFER;
> > -
> >       label_tmp =3D gpio_device_get_label(gdev);
>
> This is the only remaining use of gdev in
> __reset_add_reset_gpio_lookup().
> It would make sense to move this as well and only pass the label.
>
> Given that all this is removed in patch 9, this is not super important.
>

I'll allow myself to skip it then because it causes a surprising
number of conflicts later into the series.

Bartosz

