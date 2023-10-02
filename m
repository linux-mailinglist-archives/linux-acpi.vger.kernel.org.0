Return-Path: <linux-acpi+bounces-320-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9A67B5065
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 12:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0061D282080
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCFD10A03
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:33:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE9C2EB
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 09:53:06 +0000 (UTC)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9F08E
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 02:53:04 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4545d8a95d9so2483333137.2
        for <linux-acpi@vger.kernel.org>; Mon, 02 Oct 2023 02:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696240383; x=1696845183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJ2RNKbqBCF01iGKaf/5GP2YZbK8smzVqJ1fHWoxgs0=;
        b=ksoqhBGd5UrNumg9kfPMBIlm5nyY9OJcmQKJRbuInFPe8NEzfu+DZ6r2RRbsAirN2M
         0t2hRPPkozWDH/6oXqNXqHh5QSzIEoYMe+cBoQfvkaPCHpQsU5d7cEy6knYhnuo0VyvI
         U8oSaWafhWgkkMmljiGSYofnVYPZ8xde0fEyxAw39CPgJNqSiqAjzlp2tsY9JSlunPaB
         dq7UCnHKSw0kb8z39NrdSnNdwCiBP3V6R9u4HSGTUMRhqZ/6idv7tuYoAuS4sCFuRo3t
         OFhPHaMe9JTSqpoPlovtu0KoKyvGTrX9fkmFZ/s/rwYyl2hHmQvCCgAgywgTIxuskUko
         YBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696240383; x=1696845183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJ2RNKbqBCF01iGKaf/5GP2YZbK8smzVqJ1fHWoxgs0=;
        b=SuUN6iUtfBBr3fO6cjtyyy2iSC3AhTl0PCiMjjF6eTtelgk8sqX3mF0UNrhLO1WekK
         xlkeM6BC3e27QxTzo8JGqrDBLdPucdyMKUneIcWIyk2oGaWoa1a9z4k0wr8lgPDijojZ
         Vhkp/sd3WBlATsjJvCfZaYUUmBRMuVZpxZ0RMKmq5DQey+mTMKDhwua4iUv8lzPpNmSV
         S9R2zX7q8K/YEclBDorMWlL7QCq6F6Nx+sXHZCtjpT7qJ0xvUPJJ1wkKklGlcrldJv5/
         H2ekdsY+aaYDmUKGLt+F6T+fDcKn0Hwq3sE+awoowRyxutV/aA/8uKlQI06mKxxfhgDN
         MnoA==
X-Gm-Message-State: AOJu0YytKyTdPHrZ0P+qeD5thdqZbDvGmOXq4CWN4kt3pOcEArShazkU
	KdIxeUFD2hb/A5hv8G/zcfXY5x8d6OAUza0sVvvdyA==
X-Google-Smtp-Source: AGHT+IGyVCZL3sfc5Zr+CwIhiT2KyxiyaXEFWHJ24S3fjHDruyaP8wN7bEp8KDDe5yZxt9Ewj3XgBkS9VxbV+ZraVK8=
X-Received: by 2002:a05:6102:3175:b0:44e:9351:e4f0 with SMTP id
 l21-20020a056102317500b0044e9351e4f0mr6288399vsm.22.1696240383483; Mon, 02
 Oct 2023 02:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927142931.19798-1-brgl@bgdev.pl> <20230927142931.19798-4-brgl@bgdev.pl>
 <ZRqQbzbcNHOtJm7z@smile.fi.intel.com>
In-Reply-To: <ZRqQbzbcNHOtJm7z@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Oct 2023 11:52:52 +0200
Message-ID: <CAMRc=MffRnq2ABRGAL9zuQxytfE6E-cJWwUrourgY2k=RNv-Aw@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] gpiolib: provide gpio_device_find()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 11:42=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Sep 27, 2023 at 04:29:23PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > gpiochip_find() is wrong and its kernel doc is misleading as the
> > function doesn't return a reference to the gpio_chip but just a raw
> > pointer. The chip itself is not guaranteed to stay alive, in fact it ca=
n
> > be deleted at any point. Also: other than GPIO drivers themselves,
> > nobody else has any business accessing gpio_chip structs.
> >
> > Provide a new gpio_device_find() function that returns a real reference
> > to the opaque gpio_device structure that is guaranteed to stay alive fo=
r
> > as long as there are active users of it.
>
> ...
>
> >  struct gpio_chip *gpiochip_find(void *data,
> >                               int (*match)(struct gpio_chip *gc,
>
> > +struct gpio_device *gpio_device_find(void *data,
> > +                                  int (*match)(struct gpio_chip *gc,
> > +                                               void *data))
>
> Why not
>
> typedef int (*gpio_chip_match_fn)(struct gpio_chip *gc, void *data);
>

Because gpiochip_find() will go away as soon as we convert all users.

Bart

> ?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

