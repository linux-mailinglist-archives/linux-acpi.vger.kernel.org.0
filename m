Return-Path: <linux-acpi+bounces-13722-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 902E4AB7EB7
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 09:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567311BA4684
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 07:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3987C200BB2;
	Thu, 15 May 2025 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoZim4mZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1F1B960
	for <linux-acpi@vger.kernel.org>; Thu, 15 May 2025 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747293686; cv=none; b=e5Hag8HUWInf5RCBtsyNAPtMh/LG0lL3ODIJsWhPWVgheYRKxSSlwt9Er2xpyAeQuFhmkn1spNdy4AWmwRHHWqS3rVH89molR+iFhtkCrs/t/yU4eeT14BsFBsY/PgYifaFlIRLyK5zTgRVxmxU1n8SVByjVZnq6PArXlw1UpMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747293686; c=relaxed/simple;
	bh=rFA23rO8B1u3kvxa4WIKw/RxaGLl6GEtW0gjkkQkqnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+urGsPLPw+FezOFN+w+tZm31o5mG/GR94Dr0uvmMIH89xCzh429g8PFR9Jpbu/1uIRE482pMWYZ8c/yyha8eOQTxD5cjs44DSTE/jPev64V92vHBzGOXudVFcBGtDYNnC69xtI9qyc8lDHKZocVlgCoByBo+IwCwi4FvVORbRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DoZim4mZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54fcb8b889cso547401e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 15 May 2025 00:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747293681; x=1747898481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6YK9RRVMXkVGqlU6GqJxPV6A7A/9haPaSrRoUXo37E=;
        b=DoZim4mZARrtzj7AnQpB3ITf5KOj5QfSWZyAVA8sLcfWoPRdLWHMynnKR3U6XRKzC0
         ks94JYHXBT1VgCvckLijuffJaAjaD5wy4HCHf6TreUkywkmhsbDZ6/EIZ0tthgngmaHz
         TV19Vh4VWhdVGKPQnIt4Od2/CqVbfSieM6m+PfDop3KVXhDWhBw+rzf/ySNS/UZvj7bY
         OnhWUTXL/+FzbWiiWDXUvS6h9vYNnefybU8gHgtZwisfRtvN1cFGsZQyshdfkUR8ilS1
         q9ncl/JIfPPvCeLClbw4GqyV1olE6hnECW6Lv6qXr2HdNWUI6JF7+haWW7hv/tEb34Wz
         N0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747293681; x=1747898481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6YK9RRVMXkVGqlU6GqJxPV6A7A/9haPaSrRoUXo37E=;
        b=bySLEZbkbfZByA02JnWx+y3HXYbJWhZLVaTEzNYQrw4msLrvevU72wTUAtn8sVw11v
         n1nUd6mSLPCVjyK8VFwgNZ6hpo1MWkoWWxOnBjbuE1cwrNISvmZ297VYRA90EOlhZOBZ
         qGxhlkwSl6jb6sVkl0FEvCpX4xvCoTum46dEzgzTKJsT+VWJPzx5jpBgEd7WXh5VPODE
         5U0P/rybdeYsJ6W+gflI0VqRZ11hXkOWU+NWedlA/ZViBk2XY6qGbiXGRCwptedImPsp
         GvjdCH/vEIRZ164Nke5zpugL8UZ3d6JDhvb3BPuKecRiqta9tnlY8UDiGjIlk6W9ORrn
         487A==
X-Forwarded-Encrypted: i=1; AJvYcCWYIAjifw5YkrLOiUb3n4TtrVwTM3NIbUiBHJUYS7d+9++PAiDM5A83GWRjzXZ6i5jiYHg2lZnHTEQC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4P8WiZDbdUZry2GjDFH/4M4Ulzb4UzaMI3to7pKJnCHldYXY
	+Q6ycF4Z0IQfJ8Ad6xVqUdiFvshg1J2oHMbjLN/VpxvaXvSRkNFToFmHeSUqHzZkhrqGVwG5jI4
	ccZC1mln3lJlcuDgBzQMHlbBwKYePBNcrA1HySK7/gb0x/DZb
X-Gm-Gg: ASbGncsUkTJ0bTa1cUa7aQVesLRPSuoHNksACWIRW/xofPpI0cFAcPWgvUCRTRJSMJ5
	Gd943tioTpixuOIAjOVR2clxvbSs8PWacBudYS+s7xjMKA2UQ3cX3k6Pjyl6lSaTtBw3jWlhMY3
	0hdxwybMHf/i3al/930zAznTaHVHaKQe2sSJwE1ockjeg=
X-Google-Smtp-Source: AGHT+IEQDghWbCxuBbPh7MoxRvTvC4TcoQ8cazusXwqfZHPvPiHoVHrYr5jD67moVFO5st3g3yaGcaBX8eP9wX1a9UA=
X-Received: by 2002:a05:6512:640d:b0:54e:a262:c93b with SMTP id
 2adb3069b0e04-550d5f9ff82mr2562008e87.18.1747293681475; Thu, 15 May 2025
 00:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com> <20250514155955.GS88033@black.fi.intel.com>
In-Reply-To: <20250514155955.GS88033@black.fi.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 15 May 2025 09:21:10 +0200
X-Gm-Features: AX0GCFunPKAkQp3YlQHAKcUwsKeCICBeSwG40YsLNZHuw00mxaGy5pSg_nbMeyM
Message-ID: <CACRpkdbhnoffwtwVTMRaUAGVEpLfAESQNOb1PvYOer=V+og97Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] gpiolib: acpi: Split quirks to its own file
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Mika Westerberg <westeri@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 6:00=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> >  drivers/gpio/Makefile                         |   1 +
> >  .../{gpiolib-acpi.c =3D> gpiolib-acpi-core.c}   | 344 +---------------=
-
> >  drivers/gpio/gpiolib-acpi-quirks.c            | 363 ++++++++++++++++++
> >  drivers/gpio/gpiolib-acpi.h                   |  15 +
>
> All this -foo-core things look redundant to me. Why not just split it out
> and call it gpiolib-quirks.c and put there all the quirks not just ACPI? =
I
> Don't think we want to have gpiolib-of-quirks.c and gpiolog-swnode-quirks=
.c
> and so on.

For OF/device tree the quirks are in gpiolib-of.c and we probably do
not want to put these into a shared file with ACPI (and swnode?)
quirks as systems with OF compile objects (Makefile entries)
and ACPI compile objects are not always included in the same build,
so having them per-hw-config-principle cuts down compiletime
overhead. Also it's pretty clear separation of concerns I think.

Yours,
Linus Walleij

