Return-Path: <linux-acpi+bounces-4919-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FCE8A2927
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Apr 2024 10:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A03B27892
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Apr 2024 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB5450294;
	Fri, 12 Apr 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnL+1Sr3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2B50243
	for <linux-acpi@vger.kernel.org>; Fri, 12 Apr 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910037; cv=none; b=ARX2SU40Cbe65sdYScEe+0M9vMS2tmoCH3eWGnDDDKNwbLjIxTXe3aPRZ3VrrkL8bwo5e1pzn/cJ2vREFiolbUK2/cVpqv4y86Jm6KGU0Vmz0f66UifwgKpc/5gj8G8b42y/ZJlRS3+6cICxbuXRBO4Qgdhvjdp5zsDWquVaBW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910037; c=relaxed/simple;
	bh=Aedlqc/+sWlrdhS4ESFI02d9zvfrw3+3l7iIyP8GAJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3u6ijHntTwZ9thEbf+LhLqLWcXeBtbEuVfZ6G9GawFwXxNhY4CG1rD4LkKJMXy2P6WBzK2xCf6Jheh3aeZerrgWrvLfGXbQ7j7gKnEHq2617HaZweofLeeT/KInEyZ5HBaBoQaR2qJkNPoqUuEAQLot/96QeWEhLXaD1xiMLfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pnL+1Sr3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6150670d372so5245057b3.1
        for <linux-acpi@vger.kernel.org>; Fri, 12 Apr 2024 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712910035; x=1713514835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aedlqc/+sWlrdhS4ESFI02d9zvfrw3+3l7iIyP8GAJU=;
        b=pnL+1Sr3OS3NKG3k5J+w65//o3EjhVJplqV+2KPYVP63ibnUzivdsegG5bMc1NmFl+
         winlpfLRlFAJotdxT8oxc9y6xP7pWKNw2hUw+fTdsNjzjtHC8ZYwouyuKAoBhPostRBW
         Sj3U9COIS5VSZKXRLfVDPnCHSWilWEmLMlnTGJmeeNs+NuUhMR/0kF7aFVhVCJbQZueB
         vt6QpCqkvPdz7rwHiYoJ/lnCLELf6oVgufcOiBmPmlrRTfT/sIR4GEZyii2z5xjdJJCo
         pm0F0n/bxuAuXKjkNmaktu5Xx601a2Jh3uVwW9Tcaz2hQHCyFUBUEfsEqhaA7depus6a
         EEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712910035; x=1713514835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aedlqc/+sWlrdhS4ESFI02d9zvfrw3+3l7iIyP8GAJU=;
        b=sqQXnacxItmVSv8p4q5jDlPzvfKXsMCNl+fHWnxhd+rHtZb0RcMUDMFibIroe/xY8w
         NBaFVc07QKooSOyllfdiQoc0PsKJ6G/l9HaDRITzDHljt+j7CmW0cDwJGrHSwybVhkNm
         SsrBQUdyugwx5lkmMTJXi+o0BTrKvnO7AZ4HosXmpJWAlTJ6NA1SJWYaqqW8XtMee6If
         4O+7ZW22XK0bp1xSNUSnCwxzmjT5vG1qCrGJ1EI8xNVogDrPEmmQQnQuRiPcgOujYqyf
         DVHgGXIHfPqR+Mc32WGJ1hVIJk+SkFFcnbxDfgIxKexgfH9MbYrxQDLpGHc5W2PzWr+n
         hAmA==
X-Forwarded-Encrypted: i=1; AJvYcCWI8JuoOtlDAb23Tv2fxXewsMJYP1TVcq27O1gQnH3PQqHqeb4DTVgzXDP8HqW6QmS7jkt5kSAo0+00Q75cIR2p9/OdnrIiB9bP+A==
X-Gm-Message-State: AOJu0YwnO8t9G5W72iRW4/DMQcvvYqHCmnhxecEbb52DrxaB9IO58w9a
	nbYi+NwiwB3gkY/qRGXscZuYON6hKAd4gVXe4OGjlm5Dn23lILfpCNIlufkfl0uC9TXx7isCuZz
	4ZS7WUuxRXu95yZhZQiKb/HttF8geWgmQiJJc/A==
X-Google-Smtp-Source: AGHT+IG+4rQ6Eh9nveJlqBaXSsAk+9P2sQbLBF5MFuUjpO/kkQmwqe5TMpDLQMsN88iMDs5uoLIqTTKAs7BUYZSSmZw=
X-Received: by 2002:a25:900f:0:b0:dcd:40fa:7bd0 with SMTP id
 s15-20020a25900f000000b00dcd40fa7bd0mr1617358ybl.3.1712910035197; Fri, 12 Apr
 2024 01:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com> <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Apr 2024 10:20:24 +0200
Message-ID: <CACRpkdYaXVvtt3b9rFxU4ZNShD17Bm4XU9X3h4dY501iJy3kPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:17=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The GPIO_* flag definitions are *almost* duplicated in two files
> (with unmatches OPEN_SOURCE / OPEN_DRAIN). Moreover, some code relies
> on one set of definitions while the rest is on the other. Clean up
> this mess by providing only one source of the definitions to all.
>
> Fixes: b424808115cb ("brcm80211: brcmsmac: Move LEDs to GPIO descriptors"=
)
> Fixes: 5923ea6c2ce6 ("gpio: pass lookup and descriptor flags to request_o=
wn")
> Fixes: fed7026adc7c ("gpiolib: Make use of enum gpio_lookup_flags consist=
ent")
> Fixes: 4c0facddb7d8 ("gpio: core: Decouple open drain/source flag with ac=
tive low/high")
> Fixes: 69d301fdd196 ("gpio: add DT bindings for existing consumer flags")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The way the line lookup flags ("lflags") were conceived was through
support for non-DT systems using descriptor tables, and that is how
enum gpio_lookup_flags came to be.

When OF support was added it was bolted on on the side, in essence
assuming that the DT/OF ABI was completely separate (and they/we
sure like to think about it that way...) and thus needed translation from
OF flags to kernel-internal enum gpio_lookup_flags.

The way *I* thought about this when writing it was certainly that the
DT bindings was a separate thing (<dt-bindings/*.h> didn't even exist
at the time I think) and that translation from OF to kernel-internal
lflags would happen in *one* place.

The main reasoning still holds: the OF define is an ABI, so it can
*never* be changed, but the enum gpio_lookup_flags is subject to
Documentation/process/stable-api-nonsense.rst and that means
that if we want to swap around the order of the definitions we can.

But admittedly this is a bit over-belief in process and separation of
concerns and practical matters may be something else...

Yours,
Linus Walleij

