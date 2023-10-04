Return-Path: <linux-acpi+bounces-415-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23EC7B7F29
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 14:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 620BB281845
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 12:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B20A10A20
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 12:32:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420DD514
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 11:59:12 +0000 (UTC)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E9EA9
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 04:59:08 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7b0e19acda7so945676241.0
        for <linux-acpi@vger.kernel.org>; Wed, 04 Oct 2023 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696420747; x=1697025547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVw1l2trXRnxFi0TaySuozbKIYN2oOG8xoWmOb0upws=;
        b=083/VA33stgN3NYTmEJgs1azmBRVmmzp8IVIM5KJvf+mpumuixbF/jsgN15tWa516+
         eHiqEvthREHQZFgAPPV/vH4y17f3IiEdbyggt4VFFraL9aEkXETnjbe9PNtUKPGPHV6L
         IzxQH+KqaQ22kSy3S1nWZJJX1ZH6MUZG01K6Hm2TvXiiDI4Wm1hixAWok4BflSYC8KL1
         48DHB5h7kusH+Et9Lnl5bQqhOSJsOWEBJCkUBQpRr5jASJWxIGLx+A9N+Wlv80Gj/z7Y
         Znv5pIJyuD+nMYTgRelqWDreQbQgSHXWPk3ZxN1Jv7LPCMIV8fxJSpefKWqaF1bE812j
         53/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696420747; x=1697025547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVw1l2trXRnxFi0TaySuozbKIYN2oOG8xoWmOb0upws=;
        b=KIRqYuOFb6ZgcSLFz882HKP0nrjs48FEnpQWnmaA9T6Zx9d97NCzk41HPT6PzJ2Sqb
         4mjDsy1L7njT+MrtkdLyQPfYzBJQ3AJgcAd9R+7fps2JeoAaT+LTs4ld82+RUU63Djzp
         u0zJuaX5jfsx0Kjev1vz0seWgJtuA5aFe7Z29Cux7a9oNzgoxSwlH60rIvwix4kk2oih
         Siz/eO0ESfY0M01sxbAxPWlZ70AaAdlwFgecDENVxcSfVv2GYEkOmDGru709X2VMKuHP
         l0gPtVCK3L9dia500mJgXP4Jk5H1Ovcz2zd3TpCut7yC5egcbq3xoO/83kQ0tC1bOqh+
         OOjQ==
X-Gm-Message-State: AOJu0YwCucoEAEB57bdsuh1wP3ri9rOOX6+8XwCweTwK8x6iIx7h+SLn
	78vKBO0N+gjLqBr5X9lamBv+Ti6hDUyihKB6gTJXeQ==
X-Google-Smtp-Source: AGHT+IHWauAEDI913UXUJqGyQcRq4KhqbDo7k+iMspoO5nTxXRhkVHFfJdYKQhz5WtnJJadvtfxRm9v6KqoFFC2qz7M=
X-Received: by 2002:a1f:cb42:0:b0:48d:b7c:56c8 with SMTP id
 b63-20020a1fcb42000000b0048d0b7c56c8mr1945183vkg.0.1696420746981; Wed, 04 Oct
 2023 04:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927142931.19798-1-brgl@bgdev.pl>
In-Reply-To: <20230927142931.19798-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 4 Oct 2023 13:58:56 +0200
Message-ID: <CAMRc=McZ2qDyF_pfSdFY8Nn-uwAVrcEbzjYT-FaFFVAcbVVyfg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] gpiolib: work towards removing gpiochip_find()
To: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 4:29=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This is a reduced subset of patches from the initial sumbission[1]
> limited only to changes inside GPIOLIB. Once this is upstream, we can
> then slowly merge patches for other subsystems (like HTE) and then
> eventually remove gpiochip_find() entirely.
>
> The GPIO subsystem does not handle hot-unplug events very well. We have
> recently patched the user-space part of it so that at least a rouge user
> cannot crash the kernel but in-kernel users are still affected by a lot o=
f
> issues: from incorrect locking or lack thereof to using structures that a=
re
> private to GPIO drivers. Since almost all GPIO controllers can be unbound=
,
> not to mention that we have USB devices registering GPIO expanders as wel=
l as
> I2C-on-USB HID devices on which I2C GPIO expanders can live, various medi=
a
> gadgets etc., we really need to make GPIO hotplug/unplug friendly.
>
> Before we can even get to fixing the locking, we need to address a seriou=
s
> abuse of the GPIO driver API - accessing struct gpio_chip by anyone who i=
sn't
> the driver owning this object. This structure is owned by the GPIO provid=
er
> and its lifetime is tied to that of that provider. It is destroyed when t=
he
> device is unregistered and this may happen at any moment. struct gpio_dev=
ice
> is the opaque, reference counted interface to struct gpio_chip (which is =
the
> low-level implementation) and all access should pass through it.
>
> The end-goal is to make all gpio_device manipulators check the existence =
of
> gdev->chip and then lock it for the duration of any of the calls using SR=
CU.
> Before we can get there, we need to first provide a set of functions that=
 will
> replace any gpio_chip functions and convert all in-kernel users.
>
> This series adds several new helpers to the public GPIO API and uses
> them across the core GPIO code.
>
> Note that this does not make everything correct just yet. Especially the
> GPIOLIB internal users release the reference returned by the lookup funct=
ion
> after getting the descriptor of interest but before requesting it. This w=
ill
> eventually be addressed. This is not a regression either.
>
> [1] https://lore.kernel.org/lkml/20230905185309.131295-1-brgl@bgdev.pl/T/
>
> v3 -> v4:
> - initialize managed pointers when declaring them
> - drop unneeded casting
> - collect more tags
>
> v2 -> v3:
> - use gpio_device_get_chip() consistently
> - clarify comments
> - fix buggy chip assignment
> - check for PTR_ERR() in automatic cleanup
> - rearrange code as requested by Andy
>
> v1 -> v2:
> - drop all non-GPIOLIB patches
> - collect tags
> - fix kernel docs
>
> Bartosz Golaszewski (11):
>   gpiolib: make gpio_device_get() and gpio_device_put() public
>   gpiolib: add support for scope-based management to gpio_device
>   gpiolib: provide gpio_device_find()
>   gpiolib: provide gpio_device_find_by_label()
>   gpiolib: provide gpio_device_get_desc()
>   gpiolib: reluctantly provide gpio_device_get_chip()
>   gpiolib: replace find_chip_by_name() with gpio_device_find_by_label()
>   gpio: of: replace gpiochip_find_* with gpio_device_find_*
>   gpio: acpi: replace gpiochip_find() with gpio_device_find()
>   gpio: swnode: replace gpiochip_find() with gpio_device_find_by_label()
>   gpio: sysfs: drop the mention of gpiochip_find() from sysfs code
>
>  drivers/gpio/gpiolib-acpi.c   |  12 +-
>  drivers/gpio/gpiolib-of.c     |  33 +++---
>  drivers/gpio/gpiolib-swnode.c |  33 +++---
>  drivers/gpio/gpiolib-sysfs.c  |   2 +-
>  drivers/gpio/gpiolib.c        | 202 ++++++++++++++++++++++++++--------
>  drivers/gpio/gpiolib.h        |  10 --
>  include/linux/gpio/driver.h   |  16 +++
>  7 files changed, 215 insertions(+), 93 deletions(-)
>
> --
> 2.39.2
>

I queued this series in this form. Other than the constness of the
data pointer passed to gpio_device_find() (which - as explained under
the relevant patch - should remain non constant) Andy only had two
cosmetic issues with some patches which I'm choosing to leave out.

Let's give it some time in next before the merge window and hopefully
get the rest of the gpiochip_find() removal done before it.

Bart

