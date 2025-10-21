Return-Path: <linux-acpi+bounces-18044-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5F6BF74DA
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 17:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C9E46773E
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FB6342C81;
	Tue, 21 Oct 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EWkGTyCn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389933F8C7
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060228; cv=none; b=bMDmCXufy6UR9CoEjovyf85kl7FE2t6XJBOujQ5SihdPIhYrR2XnOZAWdeptldQvvQvtb1iGlas/XHYaZyaQxLBvZdepuTh4SXQ1kRQCFupn1KjZhi0Vdu7gKzqS5mvYJZleo86fAdwxS3f5/UwAx2svd+5VtqDq8NvOCpOFeHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060228; c=relaxed/simple;
	bh=LranUERPcQFVX4C3LPo4yvi6i4EnvwENiJ5DOAMZJo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSHdQW3PPQRqx0m30vu/zpuuRPoPUbqE1nsK4anug70RKW5rDj17DdI1YGP5nczkBCusQSszTDWQQMVJxwqnCCEVaMDTD25L7CeuciW2Qp5z083osdr2T1J3DUAycIeG99FxqBmnGDQ/aTDuH4ZkFL1CJCEP7vf7pRv0K8jOYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EWkGTyCn; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-36453927ffaso50851591fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761060225; x=1761665025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LranUERPcQFVX4C3LPo4yvi6i4EnvwENiJ5DOAMZJo4=;
        b=EWkGTyCn6lVnAVAl5gMahiqmt0QU9adOiznVYX4MZed7J6op4KygdkGeZ9kbt55rKu
         QaLNRJ1b7+RBmZblY93o+ZIB2E1gVS5K6mA8RXI66wQeeJAqWpsM74OR79qC80p1It+i
         9Eolzy65Bn4vQ0zf+EYtFOkq0sSep6IoNgKgUcXeq9P/RfbcEDCEg/i4ae9GXZLvzc74
         wctnGjw4GT8hXGUPOsPApN4c9QMODYvbvzpqDE9jgo9lfmH4dTEcgDYygXlCTyA0Ervm
         Ut910gGBRTu0r1HXcLyDUJEtnmOuvj0I9LqlsqmwOSg+9sc47iLAAmx445MMsxKpwdx9
         Z6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761060225; x=1761665025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LranUERPcQFVX4C3LPo4yvi6i4EnvwENiJ5DOAMZJo4=;
        b=T2ESIiw4ZOgu3bRj89zIWC/uCRfaFCXe+PHlikCdaAfpO3yrXQmQ5XuEfvMdM/Fthj
         kBWsHGOphWUQ4nI/ZgXa6GRLrx5VNmeUg4gJ2X6ZFWLS+R+v/wppY/DPgkuIfvfogzq6
         I411JBKFkpIIKMG1+kjUvoOd/PHU30yej8pouE840wZaiz8l3X1wetX4j34Q79AmtOsh
         /ax2AiiyFRLxVGriT94s2EjqjnvP3lqTToa4rP3MhTqrYKbypO5q/lIcmVeVS8zsxULB
         BYY21LhHDONI8W9gT2PjarMEOilzKEih6CGfnSoLnDRauJLUolPUgcGE5Jma7V0d82DO
         2VRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3YlYo49xc77Z/54jh8yWE8eRIaTW4ECmEFnlV8gpsR8/b5LprtcS5v3KrQK8ue4ax/K0LhEU5Y7Ct@vger.kernel.org
X-Gm-Message-State: AOJu0YxUeNwE1zA/cgVF5rfqpZZjG7Yk2QK/5H4QnLzUDj3WZHlCfXE8
	PGv84Gtvq+crtgDGPXbo9Zqjn3cvTOuwLBv5VNh/Eif1RqdKL/s02JBo0KkGPK9t0qnsbx3NPhg
	GckhudOArv7VHj8EG2I2EUSVaJUO1ub6fmV/v5zKkZQ==
X-Gm-Gg: ASbGncthCW1MhjXvnj2Cyw0ezc5lXXvAZMDq8PsuG/pVxnEoMBEsT0hSeHa9TwgCSna
	eSLlWOOs8gAVhqIPWlDRs/mO8/vZVmqv9I79oXS63iwWEg0GSpdUGkBZ280IB1M4lwVW/Yg581u
	JRqk8LRu7bILV/W17pGXE/Wz7dQ5lS0bbkI2u/9Ez6xdBngvSEGJ/3FFBBzcoIK9l94l32tjRl9
	bnlTSThHEi3Zsyp6LvoI3kdD/pTF6tn8LhnUZLS3h3SyVai7Cz7tBtCx6j0xpSs8WuxAeBbS2gk
	8fEMTZWduSGmVlD/lL60wyKnkn0=
X-Google-Smtp-Source: AGHT+IGgc9KeMCqsp0M9361FU4xtXnSdpuEq/15+MfSP4MmOYfHv0qjJU2f6NUqRnqHECXUrME8KkqIWvVWDw8pMiGQ=
X-Received: by 2002:a2e:b914:0:b0:356:839:56f with SMTP id 38308e7fff4ca-377979419dfmr34052621fa.20.1761060225159;
 Tue, 21 Oct 2025 08:23:45 -0700 (PDT)
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
 <CAMRc=Md4DUSuwv07EuBVDJbY1Uzezq+TONxyCvLtOHD=iFXrcQ@mail.gmail.com>
 <050d74d7619bdfdf5ca81d8914a2a8836a0d4e2e.camel@pengutronix.de>
 <CAMRc=MfPqRLFHPW988oMry7vVoTgtQHrxxND4=nr_40dOa5owg@mail.gmail.com>
 <aPeexuA1nu-7Asws@smile.fi.intel.com> <aPegyVyONkPWRgi9@smile.fi.intel.com>
In-Reply-To: <aPegyVyONkPWRgi9@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 Oct 2025 17:23:33 +0200
X-Gm-Features: AS18NWBXrVCB06tyTpBmVdEBjowWLVzdXt71bqZY_QqEoblKCiav8MRbM9cW_iY
Message-ID: <CAMRc=McPpFEmg7dpfiYWJaPR4yMynOaU5Hp37E7rTzWSCNxBuA@mail.gmail.com>
Subject: Re: [PATCH 7/9] reset: make the provider of reset-gpios the parent of
 the reset device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 21, 2025 at 05:55:02PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 21, 2025 at 11:39:41AM +0200, Bartosz Golaszewski wrote:
> > > On Tue, Oct 21, 2025 at 11:31=E2=80=AFAM Philipp Zabel <p.zabel@pengu=
tronix.de> wrote:
> > > > On Di, 2025-10-21 at 11:27 +0200, Bartosz Golaszewski wrote:
>
> [...]
>
> > > > No need to convert all existing drivers right away, but I'd like to=
 see
> > > > a user that benefits from the conversion.
> > > >
> > >
> > > The first obvious user will be the reset-gpio driver which will see
> > > its core code simplified as we won't need to cast between OF and
> > > fwnodes.
> >
> > +1 to Bart's work. reset-gpio in current form is useless in all my case=
s
> > (it's OF-centric in 2025! We should not do that in a new code).
> >
> > More over, conversion to reset-gpio from open coded GPIO APIs is a clea=
r
> > regression and I want to NAK all those changes (if any already done) fo=
r
> > the discrete components that may be used outside of certainly OF-only n=
iche of
> > the platforms.
>
> To be clear, the conversion that's done while reset-gpio is kept OF-centr=
ic.
> I'm in favour of using it, but we need to make it agnostic.
>

As of now, the whole reset framework is completely OF-centric, I don't
know what good blocking any such conversions would bring? I intend to
convert the reset core but not individual drivers.

Bart

