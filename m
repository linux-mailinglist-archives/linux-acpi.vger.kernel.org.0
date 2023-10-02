Return-Path: <linux-acpi+bounces-322-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18AD7B5067
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 12:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 746082827B5
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEFE10A02
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:34:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106A0C2EB
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 09:54:52 +0000 (UTC)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CA29E
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 02:54:51 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-45281e0b1cbso7729630137.0
        for <linux-acpi@vger.kernel.org>; Mon, 02 Oct 2023 02:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696240491; x=1696845291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQk9WKQf6wTX5p8wxFHLOknA4t/nyk+AgRRg1oWYdhQ=;
        b=Mv815g/nbn4u+I/KrsKa9iyJhqx3JwE+L+KWjECqLOu9e9chdWhji57KYEL7eVKnER
         sLXu/clJB+AdbsL7V4YzyvWBYx95/v1vpcQ4iYXZSobH5i0+Qopd80B3m9ddKLQq/Fgu
         S0dyesIgw5EoRu381pOGjbdEYKbThC/L2woPBarT1yVF+XkZ0TNFTwKWHqtT7NLTUjHN
         vXFXS54dXC/KtEzMCRLu7gJkpuiS7KrJbCwa6HX2GXVZOKKYUgKzuvTfGxWOzWf2vrSm
         ij5GvODhmC8XE7K1Lgly4K7t9p+Rx0Q/rus0cIM0HwbAMOl4oICCv96VxDXz9sH2BDd0
         M64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696240491; x=1696845291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQk9WKQf6wTX5p8wxFHLOknA4t/nyk+AgRRg1oWYdhQ=;
        b=w1R9BqHjsM2r1evPkBrFQruTqforjyVsmWeFjEy0fqwzJY8t7t3jWxpiASGADH0AGc
         pI7okOe1Ohj9hZdyBDaTB1Yyzon/PmY+NC7qCZAfIPQn9IcQlgph8+XIMADSOcFu/Dj5
         MFTkftfH1xoyjHB0yftN3HLwuYmKIHxmRUjs3OamNQ1r+ACwuwfoAy9SZLRUr+hymXMb
         GtCs2IcXeWP9vgK8dI2T2614WtEvYnpOoIQHDYfs+d0X4LRNxRdrwO5Ao79LiDhezveo
         DjeYJCbYe/5Z/D0w3jKMkLqiaXl/rVpGXx/a4NlcKkfbdqOMkOKOJ8aijl5Wo83s9swV
         ndpw==
X-Gm-Message-State: AOJu0Yx+hNKVKTIsdLOoUgqaQSo5L0rWk+itoB3kab/YixcMyfUcVQwc
	OHKP+gj8Wf/QoLw1IVqmGM+crIBhw3UkwpvNMaNpjA==
X-Google-Smtp-Source: AGHT+IH3Wly4Y8a48dseTR5Kou8rKUP3Ria54hdWexULcUH+2B+J4+J2ck9zX9NWtGibqgI6Ke50Lkhgrls8gcDKcc8=
X-Received: by 2002:a05:6102:302b:b0:452:6bb2:3620 with SMTP id
 v11-20020a056102302b00b004526bb23620mr9152195vsa.22.1696240490732; Mon, 02
 Oct 2023 02:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927142931.19798-1-brgl@bgdev.pl> <20230927142931.19798-6-brgl@bgdev.pl>
 <ZRqRfss5oI+xcS3o@smile.fi.intel.com>
In-Reply-To: <ZRqRfss5oI+xcS3o@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Oct 2023 11:54:40 +0200
Message-ID: <CAMRc=MesApEwEQxesBkodtB_4Zu4ubf3XScJ4iNLwn7sWBEcEQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] gpiolib: provide gpio_device_get_desc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 11:46=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Sep 27, 2023 at 04:29:25PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Getting the GPIO descriptor directly from the gpio_chip struct is
> > dangerous as we don't take the reference to the underlying GPIO device.
> > In order to start working towards removing gpiochip_get_desc(), let's
> > provide a safer variant that works with an existing reference to struct
> > gpio_device.
>
> ...
>
> > +EXPORT_SYMBOL_GPL(gpiochip_get_desc);
>
> > +struct gpio_desc *
> > +gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum)
>
> I'm wondering if you move this to be upper than gpiochip_get_desc() and
> diff will look better...
>

There's a limit to bikeshedding in my book and "making the diff look
better" is definitely it. :)

Bart

