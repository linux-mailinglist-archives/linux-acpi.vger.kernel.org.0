Return-Path: <linux-acpi+bounces-178-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A607AFE9D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 10:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BB5452842BA
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 08:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B89522C
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 08:33:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295901FCC
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:02:18 +0000 (UTC)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9A3F5
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 00:02:16 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-4526c6579afso6843029137.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 00:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695798135; x=1696402935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIhw6V2vNvwuHPJdanJymYad1CWCeReXt9hAkVYiSu8=;
        b=UUgp2qkBRuw7atZO+bq6YhZnv2XP7IXd16nAdUZoFPR6yYKrrje3qoKCG8PWe+lXZA
         wvB6L/b2+jWifMiFq2LqfScOb5McaPyr2PYzZvk/ALoL6VW2SHkFRXRTaOUvDD1IGoHf
         ITmQj2ihroFVxBp29v3yyrtt+7r4ErTriCU25/tuGZFctbEV2L4PwyKDhg1o6oBDNOGT
         HP1HGeGNkUro89LmwjFXv9IxiUI4w2v3dQP6TpVZoFaNzNKjsYz9lDXyuSXIwU0eiwqt
         Dud/Vjhj74jiZ3HK5VGJR00Uvdcm+B5JEEbgSrmp3KrKxH+4A1JhuTZCA4KDgkZniqJM
         tmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695798135; x=1696402935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIhw6V2vNvwuHPJdanJymYad1CWCeReXt9hAkVYiSu8=;
        b=GeWmoiEehTYu/jWUwY6XveALQMDpqIxZQKd4RhhFrOJS6+esrKE2b4buaoiMJEGVR6
         jTOLZKUHLex5kngbjsw+aU84sIP8QMKpBltS+o87+yHIxNIxKvCWI3JViWXsINrMAuuY
         4iaGv64e7SCMdsDuZK89z1ECuAQl4zumweLbvwBm7WzHYuBXWh0xfNFA0hvdaKvBM6Zm
         OKE4KEqpIHFz8lH1/D7qtx77P+Fa+qW54MtqZ7p2iLsg+O9HBxCggSHzi23wq/sPSDr1
         vmwpaenH/Fppf6JfnO/cdsVZ2DXvspu+29zAZb4+dexdO4tOElW5YnJYXw13oiMw4NUI
         4xig==
X-Gm-Message-State: AOJu0YyOXpETNnEoQehIiMaOdy4XvLlTLOiGuVPlortQHat7HXzMQ121
	MlvSOFzzu52UDIA8Q5k5y4Z0HVgwwsOaEFD4xrv+hU3yA1dkOYos
X-Google-Smtp-Source: AGHT+IFeBg+cETieioky1nVVQRLBCT9NkB2t+sJgbjsopgLmTzgcBajxJFtqUg5cY06CWtryBPEjDMHEXp1rIT8Co8E=
X-Received: by 2002:a05:6102:3e0f:b0:450:985f:ef28 with SMTP id
 j15-20020a0561023e0f00b00450985fef28mr2450526vsv.5.1695798135672; Wed, 27 Sep
 2023 00:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926145943.42814-1-brgl@bgdev.pl> <20230926145943.42814-3-brgl@bgdev.pl>
 <ZRL4PYeX21bwCPR0@smile.fi.intel.com>
In-Reply-To: <ZRL4PYeX21bwCPR0@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Sep 2023 09:02:04 +0200
Message-ID: <CAMRc=Mf7P4sWdhgTV+jVD8HEVpxbSuGK8JjJb5Q9djCkKUeUcg@mail.gmail.com>
Subject: Re: [RFT PATCH 2/4] platform/x86: int3472: led: don't use gpiod_toggle_active_low()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 5:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 26, 2023 at 04:59:41PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Instead of acpi_get_and_request_gpiod() + gpiod_toggle_active_low(), us=
e
> > temporary lookup tables with appropriate lookup flags.
>
> ...
>
> > +     int3472->pled.gpio =3D skl_int3472_gpiod_get_from_temp_lookup(
> > +                             int3472->dev, path, agpio->pin_table[0],
> > +                             "int3472,privacy-led", polarity,
> > +                             GPIOD_OUT_LOW);
>
> Personally I found this style weird. I prefer to have longer line over
> the split on the parentheses.
>

I in turn prefer this one. Checkpatch doesn't complain either way so
I'll leave it to the maintainers of this driver to decide.

Bart

