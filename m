Return-Path: <linux-acpi+bounces-4804-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C562B89D5C2
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Apr 2024 11:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C3C1F226F6
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Apr 2024 09:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC980024;
	Tue,  9 Apr 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="24aIgIE5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE837FBA9
	for <linux-acpi@vger.kernel.org>; Tue,  9 Apr 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655771; cv=none; b=W1AYnjW7lrbc+YtjguO0NELoQAAF5aG/wyqNv0Ycgp/+UcAO/EHAxCpGedb8h+CiKDBsG1NA7k/lSzxXY0tkwYzOKxeXkVKrLJEbVp+69kNEjb8mE9spdYLdYnq9dTxVxSS2F+le+x0VH/2+xMyr/1rQ/JNnV2G2iGgnZkrByIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655771; c=relaxed/simple;
	bh=ytL7QdYp2hCqyew7adjYY1rWgd8CDCZw9v1gyruAj60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6o3XQIAW2T/KffVJgCrW1M52Gint+xf+a14k9HBjNvX6/rfKXCUHkvEb/umK+58t0OwnZjPVS5Sv+kLnfiCy1vz4NFky4iKa/RUeOeFFl9CGAA9vuHwdvMV0W2LuD8BTKQHB03CzZWIGy8SAqTeCSi1+i0qf+qLY/NgFnQ/NP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=24aIgIE5; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d700beb6beso58979641fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 09 Apr 2024 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712655768; x=1713260568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRkNsSj/lYNCA3MRycU0zvpqCVRND9tlWV8O4KsTnlc=;
        b=24aIgIE5l28MQNHvET+s3C24ag0SoSC46oVvfz/e4VBtyuEWZ5PbH/Omv9IktBmAXW
         fPCm2/G4EdjNcxxrfkZHCIucBiZmWMnVAcGrezFIQCW1EeSrebkCULblOK2ow2AEBZA6
         ScKTVLz8SkDxV3ZuI/GnoQg7FTwAtHEaWGLfU+2tVv+Y/x4sRsWbd2dBM1008heX5Ekz
         xQpF3v9tAGD+bSzz9zfYR5p96a57/H6Qd4xMkK4LrIPSj5bFiYYbEgMztmrPgMkRAu8k
         smePAjVlnlP5QSduD0z1R3/IkWL/t6F7AUvnkDwAsT40D/0PbwpFw1swGMm/RYlr2pLM
         yMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712655768; x=1713260568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRkNsSj/lYNCA3MRycU0zvpqCVRND9tlWV8O4KsTnlc=;
        b=KiuTrI4gK3/vl2Uks6RWL93OnmxtM75Y9hLSJStf+6VfhRgznDtDH+mnRhAqNO6fMc
         oUvwFfnLNNqGbV+9efqv2YizqCqAs3jSapE7G5Wbhv4j/mrs6klTm00glJdyC5Dk9Nwu
         WCDBLkWOcV2ur/TJA64pmSBPE+BNWDT23kc9y0gUSWbuZQIEHfFBcBbGjrXs4BLAPzm4
         IuJMCyGgv/WFSrpSzShFtrclNa7tiXhU2Dux3R9+rLhKGZDv+QRGzuEl7mLo2w4a8qBy
         /h5bu2cClR9q+Z2BTpHqVmgS4eAVZM4rkEAqoMED7uTeThWG+hQcOlTKDXUFYDQezJIh
         m3Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVSRXkOUPitT8jv8qrsP3xj7VnlYID02Qc+Hy8+lmCM6ClHfvmCnyqDHg+L8eQUebjytLoPmriCvQRo3PM3H6KJnlMrEgA+w7W0dg==
X-Gm-Message-State: AOJu0YypEJpNvYzvE+Jvm4CMSGOJefatTUeltK9OwCvCtHwDNXzpWYYh
	sSJdGafQaaUXU3ZHGPBOMWoqOqiPLnWM7RF4QBzsCZFg1OD308hbWPNR3WUgO7nkmSDYjuxqYvC
	sGrun3cQjgAJtw4L0gCxuhRcq9j16LNQey5gQJ22cf9ekozz200s=
X-Google-Smtp-Source: AGHT+IGLok3BTsdCtcp+mQF0FlIfpGRtTXkNrJj6FjV/E2JhCIYngUvEmtKxHaZSUGiU6FzXlS6ipOOBorjeZLPGLJA=
X-Received: by 2002:a2e:854c:0:b0:2d8:5af9:9097 with SMTP id
 u12-20020a2e854c000000b002d85af99097mr6406610ljj.42.1712655768359; Tue, 09
 Apr 2024 02:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com> <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 9 Apr 2024 11:42:37 +0200
Message-ID: <CAMRc=Mf73fFHo83gNvDXGy9BosB1MNz_=8kt56hLA12bPBb8CA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 1:17=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
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
> ---
>  drivers/gpio/gpiolib-of.c                     |  5 ++---
>  drivers/gpio/gpiolib.c                        |  8 +++-----
>  .../broadcom/brcm80211/brcmsmac/led.c         |  2 +-
>  include/linux/gpio/driver.h                   |  3 +--
>  include/linux/gpio/machine.h                  | 20 +++++--------------
>  5 files changed, 12 insertions(+), 26 deletions(-)
>

I don't think ./dt-bindings/gpio/gpio.h is the right source of these
defines for everyone - including non-OF systems. I would prefer the
ones in include/linux/gpio/machine.h be the upstream source but then
headers in include/dt-bindings/ cannot include them so my second-best
suggestion is to rename the ones in include/linux/gpio/machine.h and
treewide too. In general values from ./dt-bindings/gpio/gpio.h should
only be used in DTS sources and gpiolib-of code.

Bart

