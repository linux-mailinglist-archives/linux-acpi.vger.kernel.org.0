Return-Path: <linux-acpi+bounces-190-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AAA7B042F
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id C4FE11C20840
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 12:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA7728DC0
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 12:31:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F376D19
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 11:22:48 +0000 (UTC)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5719180
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 04:22:47 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4524dc540c7so4608941137.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695813767; x=1696418567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9W5Ngnr14nBoSC3H+GsUsSguJamNvyP0jPE38TzV6Q=;
        b=dpFKMwO2uHfiNz9y2gx0Nnmmy5ODNomLeaiTrhwCZYmUFpdRnyO1BLzHYplu5oyFnR
         HRrVQvhd9QE63j59Kr7yo+xZwqTsLyZFMYsTI7yHzaOlimyDKiuHdRJck96Wv6DelP68
         ci1gmyg4D6OUdADmjrYrVdvCtDR7wYvOo6hYZfR4KXnVQif6IlwCvLdfzBQqH9YaS/ZX
         wKlNkdVFwnejAQ4zIJWp9NwAzbW5zxHvkQCTNaXDlXpanBScvc8kNME3vJ9cZpwiNvH4
         DVZZlsz4oMxTPazgDGKG/y2qeR85RtEUCiqTA73DPE2y8EOAGMYmsdwpFh32s0Gfa3XK
         6jAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813767; x=1696418567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9W5Ngnr14nBoSC3H+GsUsSguJamNvyP0jPE38TzV6Q=;
        b=hdlRW5pxB+zZffobAZaO64mU69pQMRAuHT0HuyyjmzXYeF/g3U2rt38WQdgk6HyRUH
         kKsfo2VrqfM9oSeCKaomjkzO54mZy0PNbpi5Zo7QUNQRcogX/ipi12Qzo9PTAPhvWd1Y
         5D1CSZwzJf+2AlGtIh8ne3aN8rtYgMxM8xa+E2BRRgpTFsqSX3WyjQfCp3ldoJmqFt2d
         Y6wcLoEGAs6OONhRruSgRwvPzw8iligbsxtFCsfJebPRSkp3TybXN9zNCsFYYBv8YRku
         2aa1K9wM3XCJW1+tkQzgJtwouHgom20OuVgG/B4p6256MRx7lNauVk0gNmc3wmvJ4RsF
         Fv8g==
X-Gm-Message-State: AOJu0YzkFn/7C1nnWnJrqM1MGXk1nRm5oHBuZbZnwwpsQONbzYTizs5e
	aP3MWNrkUOTlg4CnYHjq3Nc0jSe2RwhWmS+yTY/K7w==
X-Google-Smtp-Source: AGHT+IGr1xBVjlwUfBbRaYOQjuqK8MH9oxjPnhUw6XCTjJAgAJXthvL/V4CfCz4xo2U7wFPkIciv9LoUnl3NtvK5zJg=
X-Received: by 2002:a67:ec59:0:b0:452:8e0e:9aff with SMTP id
 z25-20020a67ec59000000b004528e0e9affmr1694068vso.2.1695813766870; Wed, 27 Sep
 2023 04:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915150327.81918-1-brgl@bgdev.pl> <20230915150327.81918-5-brgl@bgdev.pl>
 <ZQf6E+itll3dmCnU@smile.fi.intel.com>
In-Reply-To: <ZQf6E+itll3dmCnU@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Sep 2023 13:22:36 +0200
Message-ID: <CAMRc=Mcq-0yWcYp6ksDF5RP-B+7b+r2KYh5onEMKx1tpS9O4hQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] gpiolib: provide gpio_device_find_by_label()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 9:19=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 15, 2023 at 05:03:19PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > By far the most common way of looking up GPIO devices is using their
> > label. Provide a helpers for that to avoid every user implementing thei=
r
> > own matching function.
>
> ...
>
> > +static int gpio_chip_match_by_label(struct gpio_chip *gc, void *label)
> > +{
> > +     return gc->label && !strcmp(gc->label, label);
> > +}
>
> I am still wondering if we can oblige providers to have label to be non-e=
mpty.
>

Of course we can. Just bail out of gpiochip_add_data_with_key() if it
is. But that's material for a different patch.

Bart

