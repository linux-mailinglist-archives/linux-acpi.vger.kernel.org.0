Return-Path: <linux-acpi+bounces-17557-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C00BABB6812
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 12:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33A314EB83F
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB222EB5B9;
	Fri,  3 Oct 2025 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJi/pg50"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891D280CFA
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759489092; cv=none; b=Rtm8IjGTJ1ouBkMNJ2r4p27F4T/OjbFkBaVHNW1kh89l3TzANyLWVU0GuqPV6Y/uUYCcNVZ9VSPPQXoHlVY3oT91g81ToQXUbcpeZ7PubzAB4ip70HQ2bShDrbontajyx5Ygy45o8DM5ordunQryaYXU6GLmbZummicGjD/rFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759489092; c=relaxed/simple;
	bh=2ZqSL/hQ5eW3fKXgUIyGRehc4fvd7MUY+Vv/AhmJaO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDRO+sFZr/0d4u1c2e/O0cejeR5XNVM4YGxMWIm5MMSd98XxkwvQnOz7+OEOEpfX6zVzXPLUcZKrLSW7mx54Y76+13o20JAINtNNEBGfFIXWyZ/r9yrfD7r+nkBQz3sVXG19/Hb4mcAp9sEyTnJmacoXjaYEDn9rlFkFxiPu3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJi/pg50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9471C4CEFA
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 10:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759489091;
	bh=2ZqSL/hQ5eW3fKXgUIyGRehc4fvd7MUY+Vv/AhmJaO8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KJi/pg50e48oh1csKYm/caMjXMRLy/fjdDhP3yo1N4+BVHj6aCw3ENTxp4GcEUhSQ
	 0fmLoI3cOZevawjGmCX0SNtfBuEixGocNGg83bE/eRW8t0SFvh/D58/hVNF6ZFyOBj
	 m07ufrLemeIPxS8dlBleQwK8z32IsRvUGKd9DSEt5nwkJZyLmfqocz2HObGo0MJHDw
	 x81q66yxycyhCibsnssj+dzV8yrxpCJ5GgAG9qG4bWqvM3pTAMZ+ZJf/xTBCKVIOOi
	 kCJSjO3OKAPB3JHjHnT07e0Xx2nUxcKdD3m92lkFkY7qnBSCNiZaKaUq9pXJSZYrV2
	 AJZc7N7BMe9yQ==
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so824599a12.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 Oct 2025 03:58:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjQyPkR08OXraE5ATliYBUiIX18pgvwst7XRj3VuieC7KFBch2RYzGLTrDN5MDG/ZVndFNeR1K+/As@vger.kernel.org
X-Gm-Message-State: AOJu0YzMeA5dIDRM21YMq60P+wzoADO8hRMEdoKGSh9asz747bB1uz9+
	mXcFoKn/2NrYd7WvmrdourzgTQHFe7e++EJyPL1ELMGbP5GQIb3AgckFj1u8K9RsPUIUhrUJyiF
	ORClVqtofKh534sNCVMsSnrJUlw0RD/M=
X-Google-Smtp-Source: AGHT+IFmG/T5ydYBpXYGsbRhmiBriNStHppU1Rq6jY26Qw5eYEj6G6asV9iuaLQXuosKy981XLb98+jPtPYn9o/019g=
X-Received: by 2002:a17:903:2f4c:b0:270:4964:ad82 with SMTP id
 d9443c01a7336-28e9a6292bfmr33684635ad.38.1759489091372; Fri, 03 Oct 2025
 03:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002215759.1836706-1-markus.probst@posteo.de>
 <CAMRc=Me3VLbmRksbrHmOdw8NxN7sxXjeuNFb9=6DzE=uLn0oAA@mail.gmail.com>
 <7f4057f25594ac3b50993a739af76b7b1430ee6a.camel@posteo.de> <CAMRc=McioBjF3WCBu0ezzuL+JJTiEpF2fz1YpbToRpijpHfAEg@mail.gmail.com>
In-Reply-To: <CAMRc=McioBjF3WCBu0ezzuL+JJTiEpF2fz1YpbToRpijpHfAEg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 3 Oct 2025 19:57:59 +0900
X-Gmail-Original-Message-ID: <CAJKOXPcRTcSY7qdPXn15CmzHFJ1mCPxRhBeMzrDyD8u0nyinBg@mail.gmail.com>
X-Gm-Features: AS18NWBENGrqk9nuqV8exR9BvVwySmyz1AmxSfdqnVkR6eI3H8eOi6dQsRufivc
Message-ID: <CAJKOXPcRTcSY7qdPXn15CmzHFJ1mCPxRhBeMzrDyD8u0nyinBg@mail.gmail.com>
Subject: Re: [PATCH] gpio: of: make it possible to reference gpios probed in
 acpi in device tree
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Markus Probst <markus.probst@posteo.de>, Linus Walleij <linus.walleij@linaro.org>, 
	Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Oct 2025 at 17:51, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Fri, Oct 3, 2025 at 10:40=E2=80=AFAM Markus Probst <markus.probst@post=
eo.de> wrote:
> >
> > On Fri, 2025-10-03 at 10:03 +0200, Bartosz Golaszewski wrote:
> > > On Thu, Oct 2, 2025 at 11:58=E2=80=AFPM Markus Probst
> > > <markus.probst@posteo.de> wrote:
> > > >
> > > > sometimes it is necessary to use both acpi and device tree to
> > > > declare
> > >
> > > This is a rather controversial change so "sometimes" is not
> > > convincing
> > > me. I would like to see a user of this added in upstream to consider
> > > it.
> > >
> > > > devices. Not every gpio device driver which has an acpi_match_table
> > > > has
> > > > an of_match table (e.g. amd-pinctrl). Furthermore gpio is an device
> > > > which
> > >
> > > What is the use-case here because I'm unable to wrap my head around
> > > it? Referencing devices described in ACPI from DT? How would the
> > > associated DT source look like?
> > In my specific usecase for the Synology DS923+, there are gpios for
> > powering the usb vbus on (powered down by default), also for powering
> > on sata disks. An example for a regulator defined in DT using a gpio in
> > ACPI (in this case controlling the power of on of the usb ports):
> >
> >         gpio: gpio-controller@fed81500 {
> >                 acpi-path =3D "\\_SB_.GPIO";
> >                 #gpio-cells =3D <2>;
> >         };
> >
> >         vbus1_regulator: fixedregulator@0 {
> >                 compatible =3D "regulator-fixed";
> >                 regulator-name =3D "vbus1_regulator";
> >                 regulator-min-microvolt =3D <5000000>;
> >                 regulator-max-microvolt =3D <5000000>;
> >                 gpio =3D <&gpio 0x2a 0x01>;
> >         };
> >
> > - Markus Probst
> > >
>
> Krzysztof: Could you please look at this and chime in? Does this make any=
 sense?
>


In a week (Gmail on mobile absolutely ducks), after I'll dig out from
the emails. Feel free to ping again, in case I forget.

