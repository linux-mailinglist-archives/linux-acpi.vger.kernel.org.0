Return-Path: <linux-acpi+bounces-4820-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ABA89DC09
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Apr 2024 16:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E6B1C21E46
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Apr 2024 14:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE5312FB34;
	Tue,  9 Apr 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Tylx6pbp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3812FB03
	for <linux-acpi@vger.kernel.org>; Tue,  9 Apr 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672340; cv=none; b=n9dce6ToQ5YY1BNAwyoqWBZLonaSzR1eUj/75+PNTGbd8q3m4L5Zf3fA0BhPr2Ce5KUQw+cXxQmcxBaHhZNwpqOxP/QBLh/s/qcsCzTTY3Y5Bne0Bpo7O187olOrEtqcX3gY7Cs51b73HTYYs2Fol2sGg2z8DD0wvtLQaR4AHlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672340; c=relaxed/simple;
	bh=eMkcUK06qPDLhvDjE1B8TO+83at8akeI50jFFu8wgFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SipE96VAsVHVV9MhAXcP2Dr21ekF5Npb7MqvQ1/ZVxVA+SAoJ/NLgTRbE/nUQpFLkwOTApU5KqtXh2UDo5xv+qCyjh1C/CdrE2t3AhB6CS2rP7H/S1Enezck52zLpNLv1/AJdA+O7AA9JtuRjGRzbytCEV4QILmNoSJDc8eepUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Tylx6pbp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516c403c2e4so4890891e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 09 Apr 2024 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712672337; x=1713277137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMkcUK06qPDLhvDjE1B8TO+83at8akeI50jFFu8wgFs=;
        b=Tylx6pbpY2xl9S4Uug2sBtxxWyg21j7S0VZ0vtLiy6WNFG0rrXi8QAb4oLTWwLhTmT
         6d+DuRiFDTb09d0WXKDthDoQqnkn8OP21m1w3pdz6jr+/O7jzc1gVOrygkiuc4Pbv0z3
         UU4kDaBCD3h6a55IMGx6L2DaG4pox1iyol4XaxZaXpR7xR7ENSXJ/HlsLn4g3C/s3amF
         IgCn/lw/xotid3jOY3z/OFXi4zy32MyXlERWqBkyNSqQHBRp0ywQvJi0tR7THhLf2km0
         5sUL3NC3Uma2TqA9YH/ELeDvf++INZlr/SUQADgv2qASmk8OXa9ZSKUBlMGeiz3HqOKh
         JxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712672337; x=1713277137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMkcUK06qPDLhvDjE1B8TO+83at8akeI50jFFu8wgFs=;
        b=B0AaSnCEg+cD4fBsnOnH1ihJ11Q10sR/eKoO2GfKZIvglJSkfgFUgTSk4KkUbC53Ix
         pEHEepT2o5X5tvke7Dxca4mnK+45tBmTcwCCifL2kw1fPsbvb8vNwIV3/o9bR80acwzh
         LH3i0D3/gZpHvdWT60Zu464mGM6sruagB93pSFhrws9eadI1bRD52FV18Q3/Uu0M2uBU
         LEBvPcDXXDlz/yXOctn/EflNomQsP7impIPkOxt5/VWsSmRNDxXND4Vvxt0azuo9knH+
         nc5C1r81w9lU11UIDQcO8m3gQa0H/zS7xtYCuJGdintNd/MbfxHSDvtLVF3VwNZRcYA8
         8Kew==
X-Forwarded-Encrypted: i=1; AJvYcCXhEJA+z568//83kvILE9uJj1lJx+bhZu2a3XR/OP+YFZ6JH52D+ol3ro8aeDf6+WwRLZTdvYuvyLEdkcv9q12TDMjMPbRGPzs3/w==
X-Gm-Message-State: AOJu0Ywlfsh37bHxLxFB/dGP+hTC5nRD5mLY3fji2TImHy+sNVQqwo1d
	PIOhGT+CUHnwdPy/b0WvOlyKsfRY/7BO9KDDHnYU5pBDwhHZxNQy/PNPIy2MswNdZsZ/QndTl3X
	lMeU2/pBymFFwFHbywFTuynpevbqXtzGEJF0QzQ==
X-Google-Smtp-Source: AGHT+IE3u+ZalmS8qBssVMXi5KRadHKoy9rZZQtArJs1lzIFCPJu561ovsAqj4VFT6R7k9J6PFrMucLi+4ucD6DJTkU=
X-Received: by 2002:a05:6512:36cb:b0:513:df5f:38cd with SMTP id
 e11-20020a05651236cb00b00513df5f38cdmr932555lfs.4.1712672337514; Tue, 09 Apr
 2024 07:18:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-3-andriy.shevchenko@linux.intel.com>
 <ZhU57jB_pVvDz0ZR@smile.fi.intel.com> <CAMRc=Mdzc2gSEX0h0Uwcxr2qMgwLLXfhJda=3AkNNYsDBQre7A@mail.gmail.com>
 <ZhVLcNI3rRhWs9_D@smile.fi.intel.com>
In-Reply-To: <ZhVLcNI3rRhWs9_D@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 9 Apr 2024 16:18:46 +0200
Message-ID: <CAMRc=Mf7aNuQfQtOEGO42jMNpCsLjetLYg5YwavLyDu2rz6X1A@mail.gmail.com>
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

On Tue, Apr 9, 2024 at 4:06=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 09, 2024 at 04:01:43PM +0200, Bartosz Golaszewski wrote:
> > On Tue, Apr 9, 2024 at 2:52=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Tue, Apr 09, 2024 at 02:12:51AM +0300, Andy Shevchenko wrote:
> > > > $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | gr=
ep -w warning | wc -l
> > > > 67
> > > >
> > > > Fix these by adding Return sections. While at it, make sure all of
> > > > Return sections use the same style.
> > >
> > > Since there shouldn't be hard dependency to the first one, can you co=
nsider
> > > applying this one, so it unblocks me?
> >
> > I'm not sure what the resolution is for % and HTML <font> tags in the e=
nd?
>
> Most of the constants are without %, so less churn now is to drop %.
> If you think otherwise, please, fix it and I will rebase my patches later=
.
>

I'm not sure I get the logic of it. If the kernel-wide standard is to
use %, then we should work towards using it across the GPIO code even
if we do it a few lines at a time instead of going backwards just for
consistency in drivers/gpio/, no? We don't need to fix everything now
but if you're touching this code, then I'd go with %.

Also: what about the s/error-code/error code/g issue? While we should
always say "active-low", I think error code looks better as two words.

Bart

