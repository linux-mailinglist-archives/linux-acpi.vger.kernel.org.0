Return-Path: <linux-acpi+bounces-183-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF07B01F5
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 12:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 40A222829FC
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2903B156EA
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:34:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02741C691
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 08:48:15 +0000 (UTC)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72FEE5
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 01:48:13 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7a8b5ec9a6fso4090614241.2
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 01:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695804493; x=1696409293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UePqMDDAbqRhi0bsJrfurhqXQouyI8L8X5n7XzM0aw=;
        b=FfgwJS1Rvsv35goPZ8b9P23dOQOPPUlV7AExFRNOR7J8BjwtqnzOKRsbZCibiJwTJA
         mbD+wzPTx5xEmcy73G/DyVHiNsRVEROv33QSb9WUlEOF6J9BWwJdVmMrpKCeJb7KHAbN
         NV2KlQcdq4Wh4cK7HBRQRkmyVL2V138IJQZFysKfxIq4PfyLYQsSPAmB+6Mhta73cRdY
         KPnJ1u7Axrzm52VddpmuULaLD1ae1Jwt/tS19Osa+YjN+vi2yUhqEsawCtURYSYewIWh
         Eza8dzNEeIGMrRyYZrY8T8aPFFjOsMu6Q5mWKvnzZK3xHO8vnTn8Tn+v4u33Kg6LQ+LX
         q7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695804493; x=1696409293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UePqMDDAbqRhi0bsJrfurhqXQouyI8L8X5n7XzM0aw=;
        b=gdSTk2SSuyd70lsajA9LCHnTp1OYCDvjUw7m+6L+kYPIVufTWp8rGD2RyGqj1WERBi
         i5hOcRR1GQYBJ8ZNSfm5FH95qEDAZOafjjXI+Sdye5vrpNtG7cCnwSmyJlAD8D64nRN6
         uxaU5Uc/oG/+5/Vm3fv2gXA/cOjIhG+jVkozsEqyfLVohvgeHs6ddEVbFjiTmJMBXomS
         aMd7zg5CWGfNexLnhIMV2IjRziKbt2Xu5uS/vEt1V5ck2+6oU7U4LEQ1+Wg9nlsnkjUc
         cdocpqVIKp34ZCWi95PtSqCe5uQk4HguLAaZsHAkGhRPVFLLn0uHFtf5JdbmbK5uaGOI
         +yJg==
X-Gm-Message-State: AOJu0YzsD0jc5+PTl2LndRsXAKvDd+L/qWVj6E7iUvO3ca5t7uyaxUd3
	CY2fV7n7+P4D22dlaIZtB/cwFVl5TE4/BobiZ8WQwA==
X-Google-Smtp-Source: AGHT+IFQJtKsE+gtrZBKTdP3Ub4DSJkvgu5MeAUur4etdFKcriSX73VjALIHRe+/2tItrB4gRzHHuL+FlPlRAvpeIt0=
X-Received: by 2002:a67:fd17:0:b0:44e:8ef9:3371 with SMTP id
 f23-20020a67fd17000000b0044e8ef93371mr1313754vsr.8.1695804492779; Wed, 27 Sep
 2023 01:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926145943.42814-1-brgl@bgdev.pl> <ffb5b1a8-a4fa-f794-afc8-52eed4420a5c@redhat.com>
In-Reply-To: <ffb5b1a8-a4fa-f794-afc8-52eed4420a5c@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Sep 2023 10:48:01 +0200
Message-ID: <CAMRc=MeoRRzc+JHCSyOqYb2t5p6GMLdA5wX_-uq15O3tdzC1mQ@mail.gmail.com>
Subject: Re: [RFT PATCH 0/4] platform/x86: int3472: don't use gpiod_toggle_active_low()
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 10:38=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi Bartosz,
>
> On 9/26/23 16:59, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > gpiod_toggle_active_low() is a badly designed API that should have neve=
r
> > been used elsewhere then in the MMC code. And even there we should find
> > a better solution.
> >
> > Replace the uses of it in the int3472 driver with the good old temporar=
y
> > lookup table trick. This is not very pretty either but it's the lesser
> > evil.
>
> I saw your previous proposal which added a new api to directly set
> the active_low flag, rather then toggle it.
>
> I intended to reply to that thread to say that I liked that approach,
> but I don't remember if I actually did reply.
>
> I wonder what made you abandon the new function to directly set
> the active-low flag on a gpio_desc?
>
> For the int3472 code that would work pretty well and it would
> be much cleaner then the temp gpio-lookup approach.
>

You did reply, yes. Under one of the other patches Linus W stated that
first: adding the ability for consumers to toggle the polarity was
added to handle the MMC slot quirk, then it was used unknowingly to
GPIO maintainers in other places (including this driver). I then
acknowledged the fact that it should have never existed in the first
place as this is HW description and should be defined in ACPI, DT or
lookup flags.

I'm not sure why this information needs to be hard-coded in the driver
in int3472_get_func_and_polarity() but maybe it could be pulled into
gpiolib-acpi.c with other quirks?

Bart

