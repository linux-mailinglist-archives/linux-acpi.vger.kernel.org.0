Return-Path: <linux-acpi+bounces-18074-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E2BBFAEBF
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 10:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C401A0162D
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455E330AAC2;
	Wed, 22 Oct 2025 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rT4OSEDU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD631309F1F
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122166; cv=none; b=kL7hXV1pjQHfp8OVBqLf3e86DJucxkr6vYXZ0gjyC7n9bchRF/J8QApq76+PHG7YJ1VyeMsfuAoRiDgnhx2iIBdmSSiY+Z4eGScawbwS85WLZqYb5G8mN4QLOhVRwaBfrMdiAy8S/oYjxVb9zMT56fHzYls8r22kjOJbPzTj0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122166; c=relaxed/simple;
	bh=ft9zQVqN+nzITI87mLbcN5D/HEbMWHnwzUpstiwu0DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joM2+H6YGvXOOiISWL0Iox633vIw9AfIqsUME+WzTgmPTkFfn3F8ISilltbxLvFOoR7+/+u7ASuTBqxvZXlWcIJ6K+qglWOgBcZXYNv0UMJAjQ/sAIn+fMVSlad7k6mOegcHS7COj7gAOG7zd99faHr+z3/BQ47KsaydmCI0NDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rT4OSEDU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso7776473e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 01:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761122162; x=1761726962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drZoQKRza9HaUOy3briff86rS8ukgG+FU9BhTLti/14=;
        b=rT4OSEDUcy9F8gSwV3F6ThBO/ZrnFsYBEG3TwLiQSbC2YbIH00+dHjmrwmlCpPFexs
         B7KRRhVvuaKYryiKQGX81KCwr9Y9jkMK7/NLzgdhM0K0D+RoZoD5FbErG6UN7MSuTx/I
         s/gVzMEVk4fJuQSdAxSAyNKLidW+xd+P6AQ/kr08yaz/uCjl1wx4Y0iFADhID2ecPDIl
         8gK2iCi0h2jSoiIN+kXRE434C84SC+YYrLyKUT/tPIYSlskcA1Fcv/wsK/8BidJK7LSX
         Sh60npT4QsW/wVu/DvRo/GpCKUOvmTgNewOGDE8khb7V5fu6eUjR1q4J6vw95kbPDVgL
         H2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122162; x=1761726962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drZoQKRza9HaUOy3briff86rS8ukgG+FU9BhTLti/14=;
        b=dst8r0T71C1gDpljn7gua5bSreWXRG1BBOFH7uDoabQkO+CsiJGQZl9hsj+wJZwvPS
         H8O6rSCHv3MghO2a9/+bTQ7H0LxNLzuvVkTOuuPA7Mts17kdZWUSo9Y8hAG/hO0Wg9rt
         vKUu3WRv00HUvTGVaMLS/JKULtIW8JiSh/Py/+VBuWutD9oV2cPuwpGTT7UmT9vn0Eeg
         WB4NHKgG4OS8OneRMJP8FMcipBEdrg9c20iMaxzSmFyKsAAy6ai+yG3DWzRdGFDv/Pyj
         Gv+5wJJ47k24tBTUsx+1rsZzu442PKAPY0Ep5uxH0sFxJcciPYvzE4sPp3fCMzsSY1/D
         /Ikw==
X-Forwarded-Encrypted: i=1; AJvYcCX+FbUHxODqJObZj3Apn9BUSTalEvyFaQ/3Y/WGIDZ96lixMWl31l7WmGtVMOy3lQ2e/VFQAcBq5H8C@vger.kernel.org
X-Gm-Message-State: AOJu0YzqY2RXr2STUGJoGs95bl5jK/YytYQvA6ifvmmX8S45EZ4LMbzr
	T0dNaUt92QZiUUcIpvjYsV/X3Y9pyV2eP25ZIHnT2/y4erKMqFS3VZEIncFPLGfoFI5uQmBA/tL
	Hdu2C+ZMeQvRvyjbFtSF9sEDC8L/bqSkVToOYadjoOCbMy6+Rv9wDPNU=
X-Gm-Gg: ASbGncsMpqkc7gsl15ipgl4IjBcyvD2zlxvXbyTn2OWKcenZG/UzpZEJ+MaXlvRpFnz
	xMhEcfAst/O+G2jFMNVtMuQfP0pnfIl1ngqUgVhA7QduLen92jZTCU95JVXExGFhqzxYCULh9fy
	2bmBfXgstj1RwrzkAwG11NDG17E8Xz1VxSTWxbfY5QAqkvO2K+h2XuhLG951c+EvP6cJUQL2zh/
	jISNawS7ku4nhCBPTDj7fWKZqkHkmR6GY1B/Iz+IWINo0HpXC+mF9vFQUZMSjmZLkAC0D2/0Nb8
	3mzkfSV2ADdMvVCO
X-Google-Smtp-Source: AGHT+IGX7sCe3yBSSpD0fKQ5qj+HTU9dcCwL0BcXmC3wYc5Oet+hdU0LoqiU9KOpTi1hOGBZHNlYeKYBvgiefJkS4KQ=
X-Received: by 2002:a05:6512:1509:10b0:591:d903:4384 with SMTP id
 2adb3069b0e04-591d90346famr6280364e87.51.1761122161816; Wed, 22 Oct 2025
 01:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-1-6d3325b9af42@linaro.org>
 <aO1bkraNrvHeTQxE@smile.fi.intel.com> <CAMRc=Mc0E33JTettxsCEPf+K5FZ4-JOUX6tF1xq2QGr2gD0vLw@mail.gmail.com>
 <aPiUwzpunM2FGXhX@kekkonen.localdomain>
In-Reply-To: <aPiUwzpunM2FGXhX@kekkonen.localdomain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 10:35:49 +0200
X-Gm-Features: AS18NWDiPqjfjCHvtf3wzrnnGkJ-9enbGa5nBre5wuJ8Ydlv8uKX6YeUmeqhjwA
Message-ID: <CAMRc=MdjvbVV-m8f9+GCR3dEqf2yjYnm3q2RJJm2aZTNWYjdMw@mail.gmail.com>
Subject: Re: [PATCH 1/9] software node: read the reference args via the fwnode API
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 10:24=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Bartosz,
>
> On Wed, Oct 22, 2025 at 09:51:44AM +0200, Bartosz Golaszewski wrote:
> > On Sat, Oct 18, 2025 at 7:35=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Oct 06, 2025 at 03:00:16PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Once we allow software nodes to reference all kinds of firmware nod=
es,
> > > > the refnode here will no longer necessarily be a software node so r=
ead
> > > > its proprties going through its fwnode implementation.
> > >
> > > This needs a comment in the code.
> > >
> >
> > Honestly after a second glance, I disagree. Literally a few lines befor=
e we do:
> >
> > refnode =3D software_node_fwnode(ref->node);
> >
> > We know very well what refnode is here and why we should use fwnode
> > API. If anything, the previous use of direct property routines was
> > unusual. A comment would be redundant as the code is self-describing,
> > what do you even want me to write there?
>
> Given that the only way the three implementations of fwnode have interact=
ed
> in the past has been via the secondary pointer (for software nodes) and
> that this will continue to be an exception, I'd also add a comment. E.g.
>
>         /* ref->node may be non-software node fwnode */
>

But this becomes very clear after patch 3/9 just from looking at the
code. Even after I removed the union, we still check for ref->swnode
and ref->fwnode and proceeded accordingly.

Let me send a v2 and please look at the resulting code after patch
3/9. Tell me if you still think it needs a comment.

Bart

