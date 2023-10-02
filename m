Return-Path: <linux-acpi+bounces-325-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBD07B506A
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 12:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2F4DC2828C6
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1689510A02
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:34:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29AC2EB
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 09:59:46 +0000 (UTC)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E6583
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 02:59:32 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49abb53648aso1594949e0c.0
        for <linux-acpi@vger.kernel.org>; Mon, 02 Oct 2023 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696240772; x=1696845572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpADBQVeHbIRHJaTMsTz7x+KU4g4QU476C8qCet021k=;
        b=IVKia2CZmJuzXJK1HCE9Z7utPkqt1y9ftUJH6qq36a35Tny2uNiaFKlqG5x16TN/XT
         +MNK8ZcdDUiL9K6w3/mAIZ7658R94/thvIAAGGVQ1QQ7mYG16JDrLUWezb2GlnK1seXJ
         P02H+vJD8ZE9Dnt+TvMEOaS/SWhcZTecww3sTUIRHqLUyRCdA6+l/OvupMB3GiL+SbkN
         yNW++78uCrX7K+wippD91/EM/sZuHEmzHykSg3l8x+m/wW7hQZWCzqrjYsNbMHyhs1D3
         +ALVohdqvUeBQ7ZalEde+IlM92KX1U96ReR4lNIH+Nlp2dmOjQ3F3/IbVjFdcJAoyN/I
         9rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696240772; x=1696845572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpADBQVeHbIRHJaTMsTz7x+KU4g4QU476C8qCet021k=;
        b=UyMLEWdQqFTYrah6DW2gUr0K0tNAZ2yINZrJAFIEemh5CKDI7dnZFwBPvFHhwHMAwI
         hNcCxyuAsoIB825G15igM87uzdUSbcXEDkvIp0uoky2or8YnoFAIz+T9V8VbA1Y8wr/1
         aNhPQ1JYiez5EtCjCSqqO/ZcXNARYOrhKSCI9oNaUD0V0PLHOWdEDj0Q2iUCezDhi1v8
         iFdp2Rju5xemVo3wp10FnNQvsJ334pIlPnXUdi25v7bbWBobJO4WmQyq6x1QU0qgUKKP
         1h6Ta9XQh3kg8jgEIhXOciJvptlCG8hlunznsLSz78ZZJVX1VxHbp1v1/PS0dxtMrgt9
         4a/Q==
X-Gm-Message-State: AOJu0YxEk8uHt0ttoZIJfXyZGOqnKEPfTPi4DJwBwbvOFVjadMpixz0w
	HizfQSzLx4XgMxKedXHUF5mU7j1uFYUU+rNktljTOw==
X-Google-Smtp-Source: AGHT+IE8ubq22pILCS8LRc9ka3dzKYLPr2jswA3LPcMeu3jullkr8Z+iIybQQJ2jsplDFL1ZhQ8ANGzAUHGnRKOfLKk=
X-Received: by 2002:a1f:ec43:0:b0:495:cac2:253b with SMTP id
 k64-20020a1fec43000000b00495cac2253bmr6632247vkh.0.1696240772053; Mon, 02 Oct
 2023 02:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927142931.19798-1-brgl@bgdev.pl> <20230927142931.19798-4-brgl@bgdev.pl>
 <ZRqQbzbcNHOtJm7z@smile.fi.intel.com> <CAMRc=MffRnq2ABRGAL9zuQxytfE6E-cJWwUrourgY2k=RNv-Aw@mail.gmail.com>
 <ZRqT+qZ+Xrz4x1IQ@smile.fi.intel.com>
In-Reply-To: <ZRqT+qZ+Xrz4x1IQ@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Oct 2023 11:59:21 +0200
Message-ID: <CAMRc=MctV5xEXBARLun7T9jOtptFzfv=thFG29Li=g2V0DBYRA@mail.gmail.com>
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

On Mon, Oct 2, 2023 at 11:57=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Oct 02, 2023 at 11:52:52AM +0200, Bartosz Golaszewski wrote:
> > On Mon, Oct 2, 2023 at 11:42=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Sep 27, 2023 at 04:29:23PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> ...
>
> > > >  struct gpio_chip *gpiochip_find(void *data,
> > > >                               int (*match)(struct gpio_chip *gc,
> > >
> > > > +struct gpio_device *gpio_device_find(void *data,
> > > > +                                  int (*match)(struct gpio_chip *g=
c,
> > > > +                                               void *data))
> > >
> > > Why not
> > >
> > > typedef int (*gpio_chip_match_fn)(struct gpio_chip *gc, void *data);
> >
> > Because gpiochip_find() will go away as soon as we convert all users.
>
> And gpio_device_find() does not. So, I didn't get this argument.
>

This symbol would only be used in a single place. But whatever, I can
do it as there will be another respin anyway.

Bart

