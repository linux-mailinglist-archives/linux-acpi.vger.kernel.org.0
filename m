Return-Path: <linux-acpi+bounces-321-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161AD7B5066
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 12:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B1E802827C6
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B14010A06
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:34:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1879C2EB
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 09:54:01 +0000 (UTC)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6A9A7
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 02:53:59 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7ae19da7b79so3813316241.2
        for <linux-acpi@vger.kernel.org>; Mon, 02 Oct 2023 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696240438; x=1696845238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjJTpH15uS3ddzPHZfcNZKAKlTvCRlB+B1ZihX3N+kM=;
        b=Ld5xlCLKkRIvpkn/muY7G87yujndOfifgN6GD3uHW8s6GdVLFeDTMiuAEoTaAAU86R
         qGKsxePaYLT5IvWMFRwwf7mIqe7m+2omCjnSQOViHISRWcAx76k9bUUhuivqSKAZgXKS
         chduV1srQQs+TEdLOOAIGE7BBKlnkHbta/6xxN3ggpS14A3d56ECIGxv+rjRp6/HUXpR
         n2gESnBgwxPVImPfILJtpjWCi3opft1VabMnCD2ou065FAw7ksWW5ZPZdetFeUXM2j0T
         lhWdxUx6jJHsuhFtFHfipg1Aqbc108yEB2mNRM2glldKRYcs+gOXN8twVnzMKOe6m9xo
         FsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696240438; x=1696845238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjJTpH15uS3ddzPHZfcNZKAKlTvCRlB+B1ZihX3N+kM=;
        b=PDTAwPCU8OdAw4wdUopecfbcJtHG/ZgGK7SMZUn/oumauMHelZ5PUyACOq+ZoA63k8
         4HfPpfd9JSr+KYFd+0xjJTuqzDWWIkizHxe1wFyxZteuJyZM5d9eiM4z4g6MLc6VFyuF
         DNLVZLqOtHRnOJkCzVhWAVxb69ZOtXtUoCRR70bH0EZEManZ3fNq2msSkBJNSiDPLi5n
         9PbP9NZm5ISTSYDHr/StKps8fUNyoPjP94prEZE12x/9y6Ym5/nHssAof7kODPtgE7id
         MvGKBNGm+w8eK72vb+N7zfzNKwgWyL/aWIPt5b2e/m5jA9JMWajfPg/Sw6sC4VBB+HRq
         UKZw==
X-Gm-Message-State: AOJu0YxyJLIWRJKJYesI3qPQqq5/8gHb1pcmDZ/Gb5T0YzDUZKoCbtOq
	GgsWjyObU79etybfDOX6WHosP25nVmAbowauQpWaaQ==
X-Google-Smtp-Source: AGHT+IHXp75RaHIqUPrY5dpDyz8XwBgG4eTttIV7MPUmgom1c1vTD6yp4hlL+7Y6EcIAlX2I9KnnUTt02JAY3/VsJ3M=
X-Received: by 2002:a67:be0d:0:b0:452:60c5:20b with SMTP id
 x13-20020a67be0d000000b0045260c5020bmr9251197vsq.15.1696240438549; Mon, 02
 Oct 2023 02:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927142931.19798-1-brgl@bgdev.pl> <20230927142931.19798-5-brgl@bgdev.pl>
 <ZRqQ9KZe619vx7pz@smile.fi.intel.com>
In-Reply-To: <ZRqQ9KZe619vx7pz@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Oct 2023 11:53:47 +0200
Message-ID: <CAMRc=MfGPHk9vyS1iDJnB8PQEowB+mWBGM-9CKxDvMrNKnNuhw@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] gpiolib: provide gpio_device_find_by_label()
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

On Mon, Oct 2, 2023 at 11:44=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Sep 27, 2023 at 04:29:24PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > By far the most common way of looking up GPIO devices is using their
> > label. Provide a helpers for that to avoid every user implementing thei=
r
> > own matching function.
>
> ...
>
> > +struct gpio_device *gpio_device_find_by_label(const char *label)
> > +{
> > +     return gpio_device_find((void *)label, gpio_chip_match_by_label);
> > +}
>
> Are we expecting that data referenced by the first parameter to the
> gpio_device_find() can be altered? If not, why not using const void *
> there and here as well?
>

I guess it's a good idea.

Bart

