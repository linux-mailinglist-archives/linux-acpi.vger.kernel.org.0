Return-Path: <linux-acpi+bounces-18025-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B53D0BF58DE
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 11:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDAA18C79C7
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 09:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9585B2E1F0A;
	Tue, 21 Oct 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Hy+aycos"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C72EA47C
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039597; cv=none; b=nGqbIsI5pQ5Y94EkOeP3L/3YzxMSYjhW7W4g61wuaRsnJadcbNefXcQ0rIfKv6PDqsWgpohpcLBXBlFAFjqaIZ94ATq58QWaagJuAtH2nw0i+1K5NorwDkpBC0I0T470l6aO2jzkbVdrgDylgJyvDGdWIFE32BH6HhOTsXR+WqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039597; c=relaxed/simple;
	bh=SbwSE0eaGZLqdl1Y98QCAxRyFY0MQhw0U73vrBGwDCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOn7Cy0X+4yziPQA2cRgkabc2L+NZeDCj7AVHnU0MU+5ivTu/FmMWdW3Fo/hfgnU9sZyDGMJTThRCUFdnc88H2Xx2ZxC2IVixqezBf7U0pgQ4Xoo4hq1Rh8Z5lGjLvH3IOoRh6jDoZeV5uO+0+NpfERZVfNXRsozjhwu+zc0UQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Hy+aycos; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso6275160e87.3
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 02:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761039593; x=1761644393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbwSE0eaGZLqdl1Y98QCAxRyFY0MQhw0U73vrBGwDCE=;
        b=Hy+aycos+dzzLA+6O1T8vyh1quN8ragPBL0epIdibqoZZznzbb8eq88XWcGH0/jWvJ
         jMXjtuB983rhtMNE5OfI/eCY++yUyFIIiKpMgSirT6aBR/PnxMvPUglgDIwjpUsWuL8f
         U0vpS3X+bpy0GEJmaYk0NoPdkKiKf2ybCDqIALKt3C9Ufi+LBrikdOoc9jlAQzXw6+90
         CBwFvP8vP1UBgSavH5xhlaoMvuJ3NzbSUOLUdID98qJ8+2zgqxFKal7N+Hd6RKcKcZGj
         qnmygZxmHIYAFMmXpSoCJeA53P5ykhheOxwPIpPFeaCUZLJCMIhIdQdoruWLhnIwZaOU
         wskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039593; x=1761644393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbwSE0eaGZLqdl1Y98QCAxRyFY0MQhw0U73vrBGwDCE=;
        b=i4wsWxJKcv4niAgkpV4/deYSyMQnrzS01BOjNKN+4w6SkPVn1554/OhYRiTmFiEzUn
         tZoh29gTazlW57rt0nJyB/NiJqMymvKBZ+60qDCxSFivHeE0YsAwetK2YXsJ6mk3swn1
         c7Ky4gi932tCLO0dYuKDRoZ1yTwIlToruK5hIHFGiw7t1AuYIfYoWUqns0sUbz0MHl+0
         BlxlsqKxHJymfpSdDwMqdbAQsGUazwW3YTqBsaHxkcJ9sviUZhHIXk1qDX0bJFAvq4qS
         GKYcmz1nuD6JSdCjNqLyRo8sh3VVid0nCv8IoOUWvcD3+VT4jc7NVHPyoTNrsg4bERDH
         ke0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCXpAbE74vpOekA+Q2SOtJbinIqjTtb9B81pNc+vseK123VF2r/rpdncQKZytjODRY0CkEOT21enqn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9cfcLjMZwi8Pfqh+obHYw2nPAw33LNk6JYvupXtYLQXObahSo
	pptQoxbZnpkr4jI2GrkysLwM0x+KC9mwih0GrC9zJYuLVbCCqRoaUXyDAsbxDdd/Z8U12Dob/96
	RYJvmfO8pmdW6BLh0nQwrweIE0I2r2XZBdYH7/UBRxA==
X-Gm-Gg: ASbGnctdd242QFMYVd/SzFfltBtzObGEHxb7DTXRPH/qLRC+puFveBjlcrCZp6Mjdeq
	MZ6cX8Fmug27AXGpqHXMl57N/6uaabuuMlw8MQqiljRhfDMz8RTZRhPX7UJcRs+zsV/GCsODKIY
	W0hUyJinb+duBcaG2bIhy/5HLvYZb/nQ7tTEZkTfeBbeE8//9ZUV++HDGsS+6emK/gvlRO0Paa7
	sExfUvXpCJtkGVziPk/kxXhl12Bo4xJ40VwbFJqcx+65cdkgmpoViovAwusizUtfiyIGmtwqAD/
	97rM9idk3sq/h1Vsu4GLLZuHX0Y=
X-Google-Smtp-Source: AGHT+IFcaFEo/qZQspCXEfaZ9asrhR7AsXRlzRs90EgrMOz4+xmyfUEQn+pkgPSIrP9iTrJOQF2z9EmxBKSKd4EW2d0=
X-Received: by 2002:a05:6512:e8d:b0:57a:311:3234 with SMTP id
 2adb3069b0e04-591d856f103mr5546707e87.55.1761039593310; Tue, 21 Oct 2025
 02:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-7-6d3325b9af42@linaro.org>
 <95bbec130437846d4b902ce4161ccf0f33c26c59.camel@pengutronix.de>
 <CAMRc=Md_-mO=HqfncD-vJS6XzPJ+aTcBjSjtkxLH_h1=pNjCcg@mail.gmail.com>
 <075a4511a6ae4b047599757d41b559c6b7cf9d0f.camel@pengutronix.de>
 <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com> <050d74d7619bdfdf5ca81d8914a2a8836a0d4e2e.camel@pengutronix.de>
In-Reply-To: <050d74d7619bdfdf5ca81d8914a2a8836a0d4e2e.camel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 Oct 2025 11:39:41 +0200
X-Gm-Features: AS18NWDLZhvxp2462wbLcsyKarFFiAj7m0dCchf3HriAjmdsiNckscvHC1N6jtM
Message-ID: <CAMRc=MfPqRLFHPW988oMry7vVoTgtQHrxxND4=nr_40dOa5owg@mail.gmail.com>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent of
 the reset device
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:31=E2=80=AFAM Philipp Zabel <p.zabel@pengutronix=
.de> wrote:
>
> On Di, 2025-10-21 at 11:27 +0200, Bartosz Golaszewski wrote:
> > On Tue, Oct 21, 2025 at 11:17=E2=80=AFAM Philipp Zabel <p.zabel@pengutr=
onix.de> wrote:
> > >
> > > On Mo, 2025-10-20 at 17:25 +0200, Bartosz Golaszewski wrote:
> > > > On Mon, Oct 6, 2025 at 5:19=E2=80=AFPM Philipp Zabel <p.zabel@pengu=
tronix.de> wrote:
> > > > > [...] could you take this
> > > > > opportunity to prepend a patch that splits the part under guard()=
 into
> > > > > a separate function?
> > > >
> > > > If I'm being honest, I'd just make everything else use __free() as
> > > > well. Except for IDA, it's possible.
> > > >
> > > > That being said: I have another thing in the works, namely converti=
ng
> > > > the OF code to fwnode in reset core. I may address this there as I'=
ll
> > > > be moving stuff around. Does this make sense?
> > >
> > > Yes. There was already a previous attempt at fwnode support [1], but =
we
> > > abandoned that when there was no use case anymore.
> > >
> > > [1] https://lore.kernel.org/r/20220323095022.453708-3-clement.leger@b=
ootlin.com
> > >
> >
> > Ah, what was the exact reason for abandoning this? It's not clear from
> > the email thread.
> >
> > To be clear: I think that we can convert the core reset code to fwnode
> > without necessarily converting all the drivers right away.
>
> The use case vanished in patch review.
>
> No need to convert all existing drivers right away, but I'd like to see
> a user that benefits from the conversion.
>

The first obvious user will be the reset-gpio driver which will see
its core code simplified as we won't need to cast between OF and
fwnodes.

Bartosz

