Return-Path: <linux-acpi+bounces-187-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A35C7B01FB
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 12:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EDAE7282B08
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D711CA86
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:34:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4271CA85
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 09:19:08 +0000 (UTC)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27E4B3
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 02:19:05 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-49a885c5961so598526e0c.3
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 02:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695806344; x=1696411144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oxXoE551jD1Vp4hrRaFI77nAKLuOgm5/lU4CohMTWs=;
        b=OgA6B6jGQjN5kjxjiC7WDGyOX6Y0Kg+5Z2tWVTaPi3p8Uz5EDtJu0UHgXmHTNjYUNp
         ZqUoGXzjRpPoYivb4drZSClBRbXQbsGYC8EQbPlGTedDmWVNZ0URs14/cRxKtxYbvSOT
         mQF4Ia3W8GZgBZsLlSes/HkSzaI/C29emcsggOIIZuvpTaLmr248QS2memGppfK3ha6m
         gJlcvdIytkTQfNoJj6uBUvxPp5Oa4rNJ24tJvY1VxNhf6aVMfEuOVLGkamW16cKfWopa
         0U3aZU6xkCkAyh+Sx8p/+1QF8mVb5i6oNavN6nl+hjqDQUyHlEvKcGdWR+xKW8kPBRQj
         3+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695806344; x=1696411144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oxXoE551jD1Vp4hrRaFI77nAKLuOgm5/lU4CohMTWs=;
        b=b0ngQ2fZWHEaCbyTELfrs/LdhYQBZ5IBfAOyqpbPSr82DuWzKkQxhpJPHcxa0XSwra
         37HIQmXR1ObQJEugB+6CHaL6tqhJmFQSpbLgyqEekDFej04eXQIrZOpzWsYUEaGj4Ya5
         hUHHVDSS5VIjaHW47ibzESPBJw9MhNLyVlRj17bxQ1GKzvA5a/nKEFCuOSm2wNYrNCr9
         9YlWoYxvSxlhc0lgIj2ay1He51GT444x1nvBs1YJuFhodOFR//dERaWSvyrBjosrErkE
         l8QnNeJbwJ6oZ0yHSFku8xdnWr+2bNUzPmS3DpBbqH88wzNReLtKGxhbDTnkzzHXng5t
         khUQ==
X-Gm-Message-State: AOJu0YwKnDbArVotXASp2G6+tfhtd1B9MgVpXkB+WZobWkX613tsABsp
	TUrzhayi/RoyWBgwOQQrf3mQSR+FM+/4UlF5q1NFiw==
X-Google-Smtp-Source: AGHT+IF6M3tOfTHL3XxyE+L48RNem3W4+F+j0auKA4FqmctObb8Tp1rG43ef/qTf18NK+lStH5ynfhstqZcuddkecoI=
X-Received: by 2002:a1f:e182:0:b0:495:d846:ebc0 with SMTP id
 y124-20020a1fe182000000b00495d846ebc0mr1126427vkg.16.1695806344676; Wed, 27
 Sep 2023 02:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926145943.42814-1-brgl@bgdev.pl> <ffb5b1a8-a4fa-f794-afc8-52eed4420a5c@redhat.com>
 <CAMRc=MeoRRzc+JHCSyOqYb2t5p6GMLdA5wX_-uq15O3tdzC1mQ@mail.gmail.com> <181dd873-90eb-0db2-03a6-0809c9e3d835@redhat.com>
In-Reply-To: <181dd873-90eb-0db2-03a6-0809c9e3d835@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Sep 2023 11:18:53 +0200
Message-ID: <CAMRc=McGTizah7fPjWEer4mioQnOPZeFm-eBsrLxP0=7bM1-UQ@mail.gmail.com>
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
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 11:02=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi Bartosz,
>
> On 9/27/23 10:48, Bartosz Golaszewski wrote:
> > On Wed, Sep 27, 2023 at 10:38=E2=80=AFAM Hans de Goede <hdegoede@redhat=
.com> wrote:
> >>
> >> Hi Bartosz,
> >>
> >> On 9/26/23 16:59, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>> gpiod_toggle_active_low() is a badly designed API that should have ne=
ver
> >>> been used elsewhere then in the MMC code. And even there we should fi=
nd
> >>> a better solution.
> >>>
> >>> Replace the uses of it in the int3472 driver with the good old tempor=
ary
> >>> lookup table trick. This is not very pretty either but it's the lesse=
r
> >>> evil.
> >>
> >> I saw your previous proposal which added a new api to directly set
> >> the active_low flag, rather then toggle it.
> >>
> >> I intended to reply to that thread to say that I liked that approach,
> >> but I don't remember if I actually did reply.
> >>
> >> I wonder what made you abandon the new function to directly set
> >> the active-low flag on a gpio_desc?
> >>
> >> For the int3472 code that would work pretty well and it would
> >> be much cleaner then the temp gpio-lookup approach.
> >>
> >
> > You did reply, yes. Under one of the other patches Linus W stated that
> > first: adding the ability for consumers to toggle the polarity was
> > added to handle the MMC slot quirk, then it was used unknowingly to
> > GPIO maintainers in other places (including this driver). I then
> > acknowledged the fact that it should have never existed in the first
> > place as this is HW description and should be defined in ACPI, DT or
> > lookup flags.
>
> I see and I understand.
>
> > I'm not sure why this information needs to be hard-coded in the driver
> > in int3472_get_func_and_polarity() but maybe it could be pulled into
> > gpiolib-acpi.c with other quirks?
>
> The problem is that for camera sensors Intel uses this special
> INT3472 ACPI device with a custom _DSM to list GPIOs, with the _DSM
> returning an u32 and one of the bits in the u32 is the polarity.
>
> We really do not want to deal with this Intel camera team hack
> inside gpiolib-acpi and I can understand why you and Linus W
> want to get rid of functions which allow drivers to meddle
> with a gpio_desc's active-low flag.
>
> So using a temporary gpio-lookup in the int3472 code as
> you are proposing is the best (least bad) thing to do
> here then.
>
> I'll try to make some time to test this sometime
> the coming days.
>
> Other then the discussion we just had is there any specific
> reason why this should be considered a RFC / why this would
> not be ready for merging?  (I still need to review these,
> but lets assume that goes well)
>

This is not an RFC but rather RFT - Request For Testing. I don't have
any HW to test those with so I only built it.

Bart

