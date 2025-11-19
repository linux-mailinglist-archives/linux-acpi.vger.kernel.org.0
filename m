Return-Path: <linux-acpi+bounces-19070-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D48BC6DB2F
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 10:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86F894F5FB0
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9D3336EDF;
	Wed, 19 Nov 2025 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vINaM7nM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD933509C
	for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543626; cv=none; b=WsgxVuUscI8XGakB1xQwvPIb5lMimeDJ7WhhXszDXw0mewQHmf4950pj6w2965EgnynZe1CqELtgokTPs4xpLzDevpQXPhMxW88J2ubjZo2cnRcuuBJ0hu2xopsI4zXM/zQeAenNZ86fj0vOg/58cN+WfVX6SghBoj3IjSfnTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543626; c=relaxed/simple;
	bh=SbhtefDEL1JVdo9c7AxfhRGCxX4s0TnTb32liO2X7YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irc+joBodfPJMS3/BDzV0LRKKxHW+Zir1X5Y7BWTq6vqV681X7+81DAHirRHCW83N6pPv1lavXpmqvZWce4R0hCh9wKO14n0Ae4L8ShBDkWW1TEd2drPJC2HkH5oAmJ9fAEjfiAX2HoE8DiRPPpYEB0tvGYM/M/8FaxXu2C4fDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vINaM7nM; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37a56a475e8so58660431fa.3
        for <linux-acpi@vger.kernel.org>; Wed, 19 Nov 2025 01:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763543623; x=1764148423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbhtefDEL1JVdo9c7AxfhRGCxX4s0TnTb32liO2X7YE=;
        b=vINaM7nMx0gUYKm933DxgFJ1vdxfMb8jPCNTBTVfYO+M9p0utcluwnFF1n3Q0M/On7
         0tBM0EKbITKR2qvsSIA97b69TcwBj7q+TwTzxB9KKyp3cJpUF7C5eXzgKF/IFoj/wmaF
         kdKavfo0nUR7fMNNUbGiyW3S/fyPjZWdEPb1g3b6/Bs67sYCI84jrfbsTAbw0WesixJS
         fEFitDtWzF9UABMhZIZ9ooJu9k9Y5msLew0646YcT/veqv04nPqRz3vIno6aGi0QWXXv
         2oxEbHDNfrszMUvE1sD8YzmM6uuqp+AT0GuSGP7ibuG2FQ8sDgEQu1XQbfHvIcz2+JZ6
         LS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763543623; x=1764148423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbhtefDEL1JVdo9c7AxfhRGCxX4s0TnTb32liO2X7YE=;
        b=LmUAlEpr6FVm3bskresOcY0Z/WCuLvds2m8gqEnGVuaXlrFnaaVaGeEYhMVZzTqPAi
         K4CI0QUyVwnoRtKJ2T2KhSJ8ThqQ0xrU0D48909VFr9KMU6ixHXXrhaAybbv2eO3GSrx
         1PYnGzmClVmxBkGunWsYqF3N4s8Swcbe4lLfMOREEtvFFU2iEAPpWrb90rnoRLoLZ1Og
         PO1adAbvxSrJZGtA1JmDgYbZXv++gkNUsJ8IQFG84PjyBU6aHzRGTysJeL6zHoiA44tS
         y7R90hhgA7jp2RUQQnVtQyTyZGvnbSCwRxJ819NGl2mMnLg5eNErD5Jz0f+vRbKUrYH9
         /PMA==
X-Forwarded-Encrypted: i=1; AJvYcCVLo8lp+c1il0w7RXhxeHjwh9XWgYqF3h/i08Fy5OV9lx/enuBCqXpVCnskb7p+y4HnFqb1Ql1GF5rw@vger.kernel.org
X-Gm-Message-State: AOJu0YySArwtOH3SJ2CdsXG/R0oBIVnjOM/q5PdOqrvPz6oVy0TocWZm
	COKWB4uLVXKd24nIg2dzPd68qFQjfv/tSvDFpXrWS8DyE4ZU3pIYFKYPBywZ4qdYnZ340J21CUr
	k7Q4F6U9Ctt+4lzD1+k/IV2m+Cqi9eBKOJ0WoC2O76g==
X-Gm-Gg: ASbGncuuwjI9UfdDMYQo3xQohHCgyVF6b+e40MHecmo9g92f/TUI4mJiOyh4JBnJt3b
	NplDdMqAl0kq5gLn+plT5s/BJQrl1Xy7yZdbjz0m8nNUKPbLHnAQq8f7Dy9MjzcXlADRF23wXRo
	lW+bhYkDiibreSfSW3addlQIarD9uBvQN2dk8UCqxdm8cVmpiB9/0rEvROxUnaEdr3T629gIni6
	yJNnsO5wJQ3XLgPUehJRNbKsg3qhOOu8ZnmQxAAxVQCajg5C1L2EEbfzGnE32OqHelWOWLUYIQc
	na2RzpOCPvk79PykxRkrID9bMdvKLjnfPApgBw==
X-Google-Smtp-Source: AGHT+IHwrmWVe0fTzGNmVIVPgXHKs8nRB7AdVRKxxPYxEkvRQiwB2I68CSlaxxDkR+T2G+m2AFalkbENOhtcE9IAPPo=
X-Received: by 2002:a05:6512:e88:b0:592:f773:3cb4 with SMTP id
 2adb3069b0e04-595841f0d7emr7194876e87.31.1763543622810; Wed, 19 Nov 2025
 01:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org>
 <aRyf7qDdHKABppP8@opensource.cirrus.com> <CAMRc=MfD7ZbwU4akkCJNgmRPwgSOqSVi2-L2dJDOBHrfdD-yZw@mail.gmail.com>
 <aRy31U8EQA1DO/R6@opensource.cirrus.com> <CAMRc=MfNf+WMtSW=Wag0QHAaYzcRe9igrbOeRZiY92KmOH70oQ@mail.gmail.com>
 <CAMRc=MdKN4Uj4RZk=3L82c0-0Z0CihbAfzVK0zMBb9Tsjh3BqQ@mail.gmail.com>
In-Reply-To: <CAMRc=MdKN4Uj4RZk=3L82c0-0Z0CihbAfzVK0zMBb9Tsjh3BqQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 19 Nov 2025 10:13:30 +0100
X-Gm-Features: AWmQ_bmlF3VxlIlJXnVsQfGfeaQK6PW5ypfTwhEDVOWnrVb0vJ3HHNi3iPCJoYI
Message-ID: <CAMRc=MeYEoiXWCdYNSmmbquMwmt99vPgzW+0gmX22Of9o127+A@mail.gmail.com>
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

On Wed, Nov 19, 2025 at 9:41=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Wed, Nov 19, 2025 at 9:35=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > I have an idea for fixing it, let me cook up a patch. It'll still be a
> > bit hacky but will at least create a true link.
> >
>
> Scratch that, I didn't notice before but we register both devices from
> MFD core. We can just set up software nodes there.
>

Here you go: https://lore.kernel.org/all/20251119-cs42l43-gpio-swnodes-v1-1=
-25996afebd97@linaro.org/

Please give it a try. This is independent from this series and should
probably be backported to stable.

Bartosz

