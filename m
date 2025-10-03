Return-Path: <linux-acpi+bounces-17540-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBB3BB6448
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 10:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFDCF4E120C
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E3275AF2;
	Fri,  3 Oct 2025 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="m8AHGWe8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125CB254B19
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759481506; cv=none; b=YlYVZ3C1YHFRFJfCA6IDVU7Ordc8I3KWy40uoqvZ6IjkD1WUxRsLvzSFBKbZo1KfXn8duHoKedzgi+76WQNW5MUSbOHHMe5EK2CDuu9W3X18yZGK09NhEe2oY707L0f71P2j3RZKvr/ZTqPa4fGMzBwWBhvlyml5dHIKpm8zQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759481506; c=relaxed/simple;
	bh=x2XT9zcVh7kzpD0X4tRTqt0/foxsWPu3XNzZKS/xTCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGUCsXeHORWH0qq1ldxY4ArW5jGdAMrpwFvkYw8vEBCjqq/4UX5UlGlIaXRrLPr/hu9Bn/QBP86Tm2HdqnHOzfE9fMjSYeceyHH7NgUkim99gguJjYRKg3ChVo4P5qxXbAjjyy/rQiD6V6eA+MvQS/0zv5QbpD7tqnr1uC2szVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=m8AHGWe8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-36c0b946cb5so16304181fa.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 Oct 2025 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759481503; x=1760086303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmsmH87Q3nsWkYHojOW1pGLDSq47SZ4os0x3/+bAd08=;
        b=m8AHGWe8HvKSi7+9lYUVf2aMm16iHSkGGiFtwoQNHZgfx+2da1ua5h4lsvrCEf3kgT
         8aO9ZQO+vP/KFj1w5aOcM10ArD2WvZX57bmNXwMYsd4keYfskgHkwNlGPRVW69h6jZ4e
         ddWQFbDOkoTUggQpqzHA436NhCQtWOtsbb6uYYqIP7gOij2WqKzM+NiCav1naoZQyYsk
         QK1J4iKhXr/o9ClW4mdqRfuzhpIWaaLqpaMhXTDoAd+ZZ//dpSj70i5qxPzn2oDwZG9N
         CIXyAMx8DeOJBEU1Mfs+FTo744x58MqMlX620xpIEyKPJwJY7YqCGxFkA8/IOyt7bOSi
         oHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759481503; x=1760086303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmsmH87Q3nsWkYHojOW1pGLDSq47SZ4os0x3/+bAd08=;
        b=D/OKiurSxF+K/I+qrdn1FRCtjiekoaQnJbSMK/yc/H/4DYd5jq6vZ8c1/zB+6j4hxy
         Jf+AYmmYfgzLWAc0dWD7FtE0YGEyCFy7eXxG1cdHhzXzzG3ZM/YS6NpQSGEVClXFGtIO
         F8yUKeATJ+cm7TgFn9R89oW7Ok1fcB440GKN0QcAO27QoUR5vo8qkpf3CfpmF6S6EsSB
         lB8by/x2jJzNUHtOblaDcdaCDReBMIsob63agkLeEbdtbK/YZFw3Zg1ewIAliU2EQIa0
         oNTjzQXjpgCgxThnff12HOFbBCqRvGu+hgvKwy53986nKlRVk/xs8sEwquoOgOlF91Jf
         8iuA==
X-Forwarded-Encrypted: i=1; AJvYcCU/rz7A5g2cLl0D8uReu9cAVYIxnH6UUz0dnEb0/E6IBDeYM3k+5RiCcJN17KmO83R+AbsflswrGvdA@vger.kernel.org
X-Gm-Message-State: AOJu0YzTsthDli642htnvr1W7Pfrjtqc9OuGXONMmyMyt/5FqjMxRXB1
	RYThqXE9BeU2iiD/CLjSExOMvHXEqlc8Ob+an+unm7kQhhc/bY0Gip3UUel2yqntTrYtIqhQHYf
	Dxhxs9njJhnS5AF/AZOPjeoGzwfIfj15/r/1FzjD4dQ==
X-Gm-Gg: ASbGnct5TxKe+c1fud+ZeFT9UnX4YiF1+5aaho6kYgY8BRDfGGUp5qz47rS4guiceRT
	LEakUPE68srme4zQUGPs2Ing9EzHh2i+OkgLa+b6IVQ+V9oynT02CbVM4mOuYyhNSoq+TiCXMd1
	PABgjiPkp58O1wXB8pvHPiLTzrhwN7t3sEoO9rsbuX8Zo2dkkHKeK+sE8zPKFz6eM21rBlO9V1j
	bZpNpJAwB8WJtNGROlRCsuhsMTMp5UP1LWWFBZpk/QI5tsuB/lLy5abiIsbVA==
X-Google-Smtp-Source: AGHT+IGpVFhYHvvmq0k22AePxJXM3wxZnhvCRYnHq9Pngg2NH46casC/4XWUD4nLAbqyQDtuHaatgzMh2vzh8d67flE=
X-Received: by 2002:a05:651c:12c1:b0:332:3562:9734 with SMTP id
 38308e7fff4ca-374c36c07f2mr6231941fa.8.1759481503006; Fri, 03 Oct 2025
 01:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002215759.1836706-1-markus.probst@posteo.de>
 <CAMRc=Me3VLbmRksbrHmOdw8NxN7sxXjeuNFb9=6DzE=uLn0oAA@mail.gmail.com> <7f4057f25594ac3b50993a739af76b7b1430ee6a.camel@posteo.de>
In-Reply-To: <7f4057f25594ac3b50993a739af76b7b1430ee6a.camel@posteo.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 3 Oct 2025 10:51:31 +0200
X-Gm-Features: AS18NWCIhQoF-dv9QcLF1nIcoukTH-eCETtxxDfQif9_jQZhzC3c7G8RkGTaXOE
Message-ID: <CAMRc=McioBjF3WCBu0ezzuL+JJTiEpF2fz1YpbToRpijpHfAEg@mail.gmail.com>
Subject: Re: [PATCH] gpio: of: make it possible to reference gpios probed in
 acpi in device tree
To: Markus Probst <markus.probst@posteo.de>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 10:40=E2=80=AFAM Markus Probst <markus.probst@posteo=
.de> wrote:
>
> On Fri, 2025-10-03 at 10:03 +0200, Bartosz Golaszewski wrote:
> > On Thu, Oct 2, 2025 at 11:58=E2=80=AFPM Markus Probst
> > <markus.probst@posteo.de> wrote:
> > >
> > > sometimes it is necessary to use both acpi and device tree to
> > > declare
> >
> > This is a rather controversial change so "sometimes" is not
> > convincing
> > me. I would like to see a user of this added in upstream to consider
> > it.
> >
> > > devices. Not every gpio device driver which has an acpi_match_table
> > > has
> > > an of_match table (e.g. amd-pinctrl). Furthermore gpio is an device
> > > which
> >
> > What is the use-case here because I'm unable to wrap my head around
> > it? Referencing devices described in ACPI from DT? How would the
> > associated DT source look like?
> In my specific usecase for the Synology DS923+, there are gpios for
> powering the usb vbus on (powered down by default), also for powering
> on sata disks. An example for a regulator defined in DT using a gpio in
> ACPI (in this case controlling the power of on of the usb ports):
>
>         gpio: gpio-controller@fed81500 {
>                 acpi-path =3D "\\_SB_.GPIO";
>                 #gpio-cells =3D <2>;
>         };
>
>         vbus1_regulator: fixedregulator@0 {
>                 compatible =3D "regulator-fixed";
>                 regulator-name =3D "vbus1_regulator";
>                 regulator-min-microvolt =3D <5000000>;
>                 regulator-max-microvolt =3D <5000000>;
>                 gpio =3D <&gpio 0x2a 0x01>;
>         };
>
> - Markus Probst
> >

Krzysztof: Could you please look at this and chime in? Does this make any s=
ense?

> > Bart
> >
> > > can't be easily disabled in acpi and then redeclared in device
> > > tree, as
> > > it often gets used by other devices declared in acpi (e.g. via
> > > GpioInt or
> > > GpioIo). Thus a disable of acpi and migration to device tree is not
> > > always
> > > possible or very time consuming, while acpi by itself is very
> > > limited and
> > > not always sufficient. This won't affect most configurations, as
> > > most of
> > > the time either CONFIG_ACPI or CONFIG_OF gets enabled, not both.
> > >
> > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > ---
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > =
> > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > > >=
 > > > > > > > > > >

[snip]

What happened here with your mailer?

Bart

