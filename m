Return-Path: <linux-acpi+bounces-11772-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88810A4DF85
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 568AE7A3371
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E72D204683;
	Tue,  4 Mar 2025 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XsnQUsgS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455362040A7
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095800; cv=none; b=UIA2H6ydpwJCrH3WpuA8CCWCz5WmywB0nrN9esjZxMv5M8vCStCZnsWn0+ZuxBVNHcLmvU3dw0sJ5IvKylr37ARCG34dtuWjR73qe50bgsrjmBXZB92K84Oy5tk+5N0X6Ztw4smC0pX8onhtvolkhH2anlAGZFKS4XQcHIUZz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095800; c=relaxed/simple;
	bh=0pGZ555KSvs9RkZQ2TF9sAp3mz0s0plHDaitzlJaP9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlaZnE19DqTLq89nfLeLCOTzs1RUIW3llOULwZDTjmuOLndEq2bC2/S/tC8dt8pyNainLWDhugrDqy7jq/aOzkH2QrA/m11Hcn6KI/EhrYbD/MRABHxwDl+Y+SHTyPD0ZYGS9RJ+XJMTwVQBu2ZBTtliKk/NlJq0ez1hd7iaLUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XsnQUsgS; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5452c29bacfso6184096e87.3
        for <linux-acpi@vger.kernel.org>; Tue, 04 Mar 2025 05:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741095797; x=1741700597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pGZ555KSvs9RkZQ2TF9sAp3mz0s0plHDaitzlJaP9w=;
        b=XsnQUsgSWo4iPO/7DEA6P6yo1Vd8HfWDljiu7o+GWXt/lAC1/RanTa9riq6LJye4uu
         6XAntWQ0EUvhPkp7FPaJy9I4i7qGNksgjVqXIo0Ivs97pHsZxkUiqRR8J9e2JIPWDkEs
         ty+TehVPr1yoX2Bs4EAsZTMstv9cIi/gtqnLGZ3CWQpRFFXJN4UHWyViK9GgsGPmZ2ME
         LemNwzL5DBbeRqVM16UZVpzMAJbPLnmdXlaXFXaVeSMHjNKJjog2YuV+dPOVr4J9uEiA
         jO+r3Sptp+AgpfMM2+iRc/AyHcfIl+6m30SaAEWPIGU0JcxkRIRDUS8GmwiIibjDur6X
         0n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741095797; x=1741700597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pGZ555KSvs9RkZQ2TF9sAp3mz0s0plHDaitzlJaP9w=;
        b=kvv72j8kkROVWQud1Civ1T2lxoR/axTGeKj7wIB8w3VJVRbbk6NS2NHOKWFbDW2NPz
         853/5ov1WSy/8yfxk/CMptLc5b8b71go4rBd0dIDJtAQR2+bLNcLRQaRUI1Cy65gXzS0
         RTj4PnSWI+oUEY8ubENxD15bwNQ2/ipya0fAnixjSEUj5pTtzS+Hnd7zWM1lyuAZFe9H
         zp14qbuQjspm+SeHTJKEBtPuDeLLn7Q3sDosP6AxTF9c+3CIh3Y0Bk36Ig0odAnHofK3
         gQE0wAfLYVJr5W6ViLK85j5e2GQcRhZBygF8TWj+s10HL2wC0omioBr9Slk/omwBptGX
         w29g==
X-Forwarded-Encrypted: i=1; AJvYcCXvjzCPjQLevKwbnWc59VDuAP1Qc5ETEC2ngYtiP1upPpuVOiETmiaJ3LYWrKmjDRLfP/9bO2XalyWn@vger.kernel.org
X-Gm-Message-State: AOJu0YxjgjVqMEnFBZyiabeX0GWpbyvUZRF8OhjNGIPj4O0UiohpKo+c
	PITZvzPL53eeV6wN2MHt2lHjy7WBXyEppxXTJQ7VQiKDuZaQallXnqYSby/HmBCrvEPSJKncRyS
	tTdF+FcIEyTGlMBEl6rx40DlTaxbJv5GEswM6gg==
X-Gm-Gg: ASbGncvw+6fC74DQSfTAv4b53mvXWY/pZ8ESplkPmmVc59hNX6/wXNjW3wXAoWuaFow
	rbAtPRqbpl9VUcutTzkSY97nzbljatPTvjvVkpZStpOmxe9JISif+xI5PEejmkLgkQT+NsRiIhv
	x+xI2BUG3QENSN7xp4n7bNCAAnZqjZIrMMX6dlrczR5rZXOOnjKigvUvG9xA==
X-Google-Smtp-Source: AGHT+IFWh03wXh64Ao3HRMlhJCKQLtqt910EoDBcwZtN1H8wHZ6DUI6QiDtsoKY7O3tRh80hbzaOHl+pKFDQV/B60Os=
X-Received: by 2002:a05:6512:2398:b0:545:a5e:b4ef with SMTP id
 2adb3069b0e04-5494c31ca37mr7947524e87.16.1741095797400; Tue, 04 Mar 2025
 05:43:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
 <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
 <20250304091804.GG3713119@black.fi.intel.com> <Z8bdDQGg_xcamZv2@smile.fi.intel.com>
 <20250304111157.GJ3713119@black.fi.intel.com> <Z8bhJq3kn_uw3iYE@smile.fi.intel.com>
 <20250304113135.GK3713119@black.fi.intel.com> <Z8brYjfL1yj_BvpN@smile.fi.intel.com>
 <CAMRc=MfsKc+r=uhDZVbd_BW=Gs1BpaidPC1tfF6TGqcq9bgP6Q@mail.gmail.com> <Z8cCQPWBmJXFgKAe@smile.fi.intel.com>
In-Reply-To: <Z8cCQPWBmJXFgKAe@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 4 Mar 2025 14:43:05 +0100
X-Gm-Features: AQ5f1JpqX_GHUguz2RwObiRuAUFX8DZ0DsNPbeLxo7WFuOXHLfYuwvzPP9w3pks
Message-ID: <CAMRc=McQY1r-Ni4buuvhD8DP6LGz22PAxk_QC9ENYBEzYTc+7g@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] gpiolib: Rename gpio_set_debounce_timeout() to gpiod_do_set_debounce()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <westeri@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 2:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> >
> > I'm definitely in favor of consolidation instead of renaming to
> > gpiod_go_set_debounce(). If anything a better name would be:
> > gpiod_set_debounce_nocheck() to indicate the actual functionality.
> >
> > How about first extending gpio_set_config_with_argument() to take a
> > boolean "optional" argument and removing
> > gpio_set_config_with_argument_optional() altogether? Both are internal
> > to drivers/gpio/ so it would have no effect on consumers.
>
> Consider this series as a report then, I am not going to spend time on it=
.
> Thank you for the review.
>

No worries. I applied patch 1/3. 3/3 doesn't apply on its own so feel
free to resend it if you still want it.

Bartosz

