Return-Path: <linux-acpi+bounces-4818-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802A589DBA9
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Apr 2024 16:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216071F21C52
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Apr 2024 14:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811DD1304A3;
	Tue,  9 Apr 2024 14:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CaxnLlfk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D42112FF95
	for <linux-acpi@vger.kernel.org>; Tue,  9 Apr 2024 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671318; cv=none; b=DvPHvseajpqZ8de0iO86kj0LLGuqoVt6XXHfbCvxuiDhgrEaiQKue8aWR2PppqWJUS2RBE6pJkUa83FiCrEL/waJr9bkSRFFDEWQxdoBeWCs5lekMo4KtH9vSkuqXcmrFhVJn1j/T7W01v5nVzYWDyqaH/0J8zfcOCWsFyeRhMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671318; c=relaxed/simple;
	bh=WVcmmCzMCx0qOzeVSGr+rFq9VNZEW9SgsVKpHYBH4Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+L6kd8ZDl79lcJNMBNAjUVjJfDTEeSrEfYeVWshIN+hJMmguhq/lcMrQM1Ywn5u+/K++xvRuUYupQmriCuiACuSHycCfxjfmIDARSgdGCMWi8CkxEVX1tJHLoP44GI9fHRllfqYDE2hCl96E0uml+O/LL5XnRnePil5FP8Fjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CaxnLlfk; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d87450361fso44255831fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 09 Apr 2024 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712671315; x=1713276115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVcmmCzMCx0qOzeVSGr+rFq9VNZEW9SgsVKpHYBH4Jo=;
        b=CaxnLlfkl58JCtUZ30X0CvE8NXIjWzFO+raSJK0f+8v5cA++w8o7nSIKRV/WiXk1Ku
         Gpx+3WOpNNvwNs34VFEROSlvvHzsAdXrNBWyrn+fI82dYbD/chkBIc3nsGXhtegAykgV
         OSNUzjdM+N2GULEUYuSuzd6v7fC0Ase8IZ31FfcsGehbn1NXSodIHVNRIQgJkNBLhj6L
         gybIKYW7pIuWwSd/V+xAXrkYI6i4cE2F5nsNwis8z22FiAh3/+p8KCyDqzU8vfTMk5xx
         x1xOyeicumDJaw4SeyNQGIPb4YE2skLS6ObYEDdgjK5eEIJursIvu7cs392T572mZHPU
         PoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712671315; x=1713276115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVcmmCzMCx0qOzeVSGr+rFq9VNZEW9SgsVKpHYBH4Jo=;
        b=QKqIOqtHQ9zY0PC16Xf/AtCJOmOkyvKluFl9Wou3M64JEpAW3o5ektMT4ZyFYzorO/
         RY2USun/lUiIa6CPz64Sve56G2CELZjMUpjPoxiQBFhaEUeKaC6BSMGtk1N4GEv07HKu
         q7YQ9x0tB1C6nj59PSGszpD63i5hm+U4gmspmOuG1zxxv4SL3ZY+w6wI6v1UyH7sUlLl
         6gzPtbCLrlR2L9GtgYXsodoKKmmC5sWLdb7mPHiLfklm5frKYkOiXhEjc9hY8bhxm453
         5/lEOvkJXtVXFNKciw0T/g8QIm6hxYDdKslOkQ7oy/3mnZGD0l/EpezkjPdcgS5eQnwv
         rTSg==
X-Forwarded-Encrypted: i=1; AJvYcCU33NUaMSMw0WCKtJVK2NzCs1faPMF7I7YOgS3i5k6F62TF6OdV4x2nm+HW11AwHWaqgh/2D7iI7eRSY6W1HLc466kiZYVZeRz1vQ==
X-Gm-Message-State: AOJu0Ywk/ZVmys+drUtiGfEDalGzW1YdlLOks4RpNGJrHcWBgDZUPB4D
	TdGAPrH1l1oAzP5Ts6dWZDMw9HlHYLy4PImg7ZA8G1IpTAkpTQhwkjGVQvWrDVmSzyD/+E1qA0p
	dKq1sQJX+rri8sm79UE8Ucsg6n63ldJSfP6tIwg==
X-Google-Smtp-Source: AGHT+IE0BTLqNhCg/BINBcFyauRaMvF/trglatuDvkvJ1Zps7+gNBKvwiRvgYkhWF8C4ymW2ozFLRyADZMwLTSRX/9s=
X-Received: by 2002:a2e:87ce:0:b0:2d6:dac4:7d4f with SMTP id
 v14-20020a2e87ce000000b002d6dac47d4fmr10185577ljj.4.1712671314663; Tue, 09
 Apr 2024 07:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-3-andriy.shevchenko@linux.intel.com> <ZhU57jB_pVvDz0ZR@smile.fi.intel.com>
In-Reply-To: <ZhU57jB_pVvDz0ZR@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 9 Apr 2024 16:01:43 +0200
Message-ID: <CAMRc=Mdzc2gSEX0h0Uwcxr2qMgwLLXfhJda=3AkNNYsDBQre7A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: Update the kernel documentation - add
 Return sections
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 2:52=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 09, 2024 at 02:12:51AM +0300, Andy Shevchenko wrote:
> > $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -=
w warning | wc -l
> > 67
> >
> > Fix these by adding Return sections. While at it, make sure all of
> > Return sections use the same style.
>
> Since there shouldn't be hard dependency to the first one, can you consid=
er
> applying this one, so it unblocks me?
>

I'm not sure what the resolution is for % and HTML <font> tags in the end?

Bart

