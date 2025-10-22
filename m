Return-Path: <linux-acpi+bounces-18084-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA6EBFBD04
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 14:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FDE3B5088
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 12:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C062F3431F0;
	Wed, 22 Oct 2025 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xAv5oXoK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2AE33DEF8
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135491; cv=none; b=LLQrTrKGv69tfdQcJ4DFRCzrJYEH8x089bg877rZ1iSgqP/d6ZmgvXA2aU+LfHJfwgbGreODjDaMLJ/t/1yRFYSsLP9SNX4UarofYpr0UxGWtPKhlewg547GEfYVABmSpJK6mLZzqpoIN++vjv0aU6U77m3ENTHMUMQ+8FxDcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135491; c=relaxed/simple;
	bh=WBrGicdJ7vJmFD7ULLVAtRjwv/BXxswDEpGZGdImK50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTuFovJehsqPTvpLvMMKucqzueTMxsen70hJhs5PswOulmmbUpABW92QqfBflbj8gC62EEiBfkjOu+fnU+AtN+4LD01GZe/CYKaWzSGlmsey3qnfB/4jo9oU/FKPaL/dm47uKKUzHmHW0abl2cUD2PbwAbE42DZhakwusGpio50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xAv5oXoK; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5818de29d15so7962537e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 05:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761135486; x=1761740286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBrGicdJ7vJmFD7ULLVAtRjwv/BXxswDEpGZGdImK50=;
        b=xAv5oXoKfbVVGAdLjEvtVPWEgV3x5Pvth28fyWj8XT99aP3h1JGqI53/ETWjYdhM22
         AEUlAVuEK6kO90RcDw8uvYpsiTJ+1haXJu059RYWMFhCpGOO63zgJg0A59NfgjicHi79
         8aQfMB6RqnoVOMB5gkSc/rg/amESUiBVaFuM1pp29pi0VHBbFGCnftpmUtsJlEKeKBju
         iP33FyuJbRP1SJZ68JzrDBgW9YomyAkR2RkmvMv1dzSuYfTUTjZoUfB2uvambnnaJrsr
         1jPDBQJ/mSWTMUhITVVBuV457GRLUQQ3OqJa+KMZBiwjaziPAHyNXutnsc1O6IgXGSoE
         4yDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761135486; x=1761740286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBrGicdJ7vJmFD7ULLVAtRjwv/BXxswDEpGZGdImK50=;
        b=JgLafB0gzo7v9zaWJhQeXn+6ImxTz2L9CfXRGjUo8pkkgA2Q8NKgFznu4VSZnr/5yC
         yYaT2fVp41ytPRl7gPqzyQltJA83WmZ51pxVf4PKWALVybtcftau4Nj4q0zvjtaVokpv
         i0rXZpjGzGSqyGflFPoRDBVsd3CqIJaN+fJYajyY2AkMMkMVR72tjjwRMQ3bOVoXyu8D
         75VR+imYzn7yF0WFG3vl/R0C7XZA9q+iQh3UnFah7X9k4X9+pLGOXTyi6fVJ3Z7bdotX
         JRZ3vahsw6wTJP/6LAFR+9HEW4w0DiEQAW8bsTD86/FkqZx7bQwNrt1jzxMwj5kNE7hz
         t0tA==
X-Forwarded-Encrypted: i=1; AJvYcCXQOWfwLySxorGE/NaAJSWd6zXCFUvAVTpifAFp7rjZNRpBVqT4vxeyqGpn6Bkxn92wowVeZYeY85u2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm4yP92ilLKfFRQEgwmiVXvOfUU57xIaZimB3yauni4TrZwPaf
	rqYn0JOqRvu11XY3IxLAgLuep06wKSotIAJ0m+PMCwAFPBeyIFdT8x7cZeT+feOTaO6XydNR/tk
	evawoOXE36v3y+zdYyu49qM/unlqQDdSc+UP8Kkqm+g==
X-Gm-Gg: ASbGnct3UF/MV7MUMvho91qby4UXJhqpJTUF3d1tgF9yUas4kZhEMqfLAFHSvUHr5tM
	J94Qy3rzfrZD6Lu09vzXVGm8U8+pbUbts3SdCaro/DuWtwLPM9oZ5KTpfJzBKH0i/7SmdfQufxg
	MZIYZpzVCfSnJqx+uQ+/0ljochjp2IkhOs1tfiMD7myyjKn1IsxdVDJdS3TME8mA/8A5sqJTtZo
	/yiLLjJdWHRmM19JZ9mOon0qMjwc4Et3sa7prlk53w7skpJOsTxXMvPJbWPao+lAXvYqSeqmU4P
	cMviSlJZPJTzeT/6
X-Google-Smtp-Source: AGHT+IHdFjD1upF60QNrKQiPHb0EuLyjig0EXitYcomcOh2LTKy2vCTOo5wwpoP3zGRv3ACq4Fw6m6AiGSWjUoYZbaI=
X-Received: by 2002:a05:6512:1115:b0:591:c2f8:9a5a with SMTP id
 2adb3069b0e04-591d8595e35mr6051681e87.35.1761135485542; Wed, 22 Oct 2025
 05:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
 <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
 <CAMRc=Md_-mO=HqfncD-vJS6XzPJ+aTcBjSjtkxLH_h1=pNjCcg@mail.gmail.com>
 <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
 <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com>
 <050d74d7619bdfdf5ca81d8914a2a8836a0d4e2e.camel@pengutronix.de>
 <CAMRc=MfPqRLFHPW988oMry7vVoTgtQHrxxND4=nr_40dOa5owg@mail.gmail.com>
 <aPeexuA1nu-7Asws@smile.fi.intel.com> <aPegyVyONkPWRgi9@smile.fi.intel.com>
 <CAMRc=McPpFEmg7dpfiYWJaPR4yMynOaU5Hp37E7rTzWSCNxBuA@mail.gmail.com>
 <aPerDcMFdbWecGEv@smile.fi.intel.com> <804b4b8cf23444fe5dc9400ac1de3a738a77e09e.camel@pengutronix.de>
In-Reply-To: <804b4b8cf23444fe5dc9400ac1de3a738a77e09e.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 14:17:53 +0200
X-Gm-Features: AS18NWCQ7ANfnKQl00uAA5vEojJxMGPQi1isAnxjQuec18eN_PhBUMwxJKrcpO8
Message-ID: <CAMRc=Md-KuNp1o6GLA0WTbknbN-qtt8YJqy5fJs0P0EyE7KY3Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent of
 the reset device
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 10:39=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix=
.de> wrote:
>
> On Di, 2025-10-21 at 18:47 +0300, Andy Shevchenko wrote:
> > On Tue, Oct 21, 2025 at 05:23:33PM +0200, Bartosz Golaszewski wrote:
> > > On Tue, Oct 21, 2025 at 5:03=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, Oct 21, 2025 at 05:55:02PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Oct 21, 2025 at 11:39:41AM +0200, Bartosz Golaszewski wro=
te:
> > > > > > On Tue, Oct 21, 2025 at 11:31=E2=80=AFAM Philipp Zabel <p.zabel=
@pengutronix.de> wrote:
> > > > > > > On Di, 2025-10-21 at 11:27 +0200, Bartosz Golaszewski wrote:
> >
> > [...]
> >
> > > > > > > No need to convert all existing drivers right away, but I'd l=
ike to see
> > > > > > > a user that benefits from the conversion.
> > > > > > >
> > > > > >
> > > > > > The first obvious user will be the reset-gpio driver which will=
 see
> > > > > > its core code simplified as we won't need to cast between OF an=
d
> > > > > > fwnodes.
> > > > >
> > > > > +1 to Bart's work. reset-gpio in current form is useless in all m=
y cases
> > > > > (it's OF-centric in 2025! We should not do that in a new code).
> > > > >
> > > > > More over, conversion to reset-gpio from open coded GPIO APIs is =
a clear
> > > > > regression and I want to NAK all those changes (if any already do=
ne) for
> > > > > the discrete components that may be used outside of certainly OF-=
only niche of
> > > > > the platforms.
> > > >
> > > > To be clear, the conversion that's done while reset-gpio is kept OF=
-centric.
> > > > I'm in favour of using it, but we need to make it agnostic.
> > >
> > > As of now, the whole reset framework is completely OF-centric, I don'=
t
> > > know what good blocking any such conversions would bring? I intend to
> > > convert the reset core but not individual drivers.
> >
> > Blocking making new regressions?
> >
> > Otherwise as long as reset framework and reset-gpio are agnostic, I'm p=
retty
> > much fine with the idea and conversion.
>
> I think we might be talking about different "conversions" and different
> "blocking" here?
>
> 1) Conversion of the reset core from of_node to fwnode.
> 2) Conversion of reset controller drivers from of_node to fwnode.
> 3) Conversion of consumer drivers from gpiod to reset_control API.
>
> My understanding is:
>
> Bartosz would like to convert the reset core to fwnode (1) but not
> convert all the individual reset controller drivers (2). He doesn't
> like blocking (1) - this statement was partially in reaction to me
> bringing up a previous attempt that didn't go through.
>
> Andy would like to block consumer driver conversions from gpiod to
> reset_control API (3) while the reset-gpio driver only works on OF
> platforms.
>
> Please correct me if and where I misunderstood.
>

I think Andy is afraid that people will convert drivers that are used
in the fwnode world to reset-gpio which only works with OF. I don't
think that anyone's trying to do it though.

> I think fwnode conversion of the reset controller framework core is a
> good idea, I'd just like to see a use case accompanying the conversion.
> It seems like enabling the reset-gpio driver to be used on non-OF
> platforms could be that. Andy, do you have an actual case in mind?
>

I'd say converting the reset core to fwnode has merits on its own. We
should typically use the highest available abstraction layer (which is
fwnode in this case) unless we absolutely have no choice (for
instance: using some very OF-specific APIs).

That being said: the reset-gpio driver will be able to work with any
firmware node once we do the conversion which is a good first
use-case.

Bartosz

