Return-Path: <linux-acpi+bounces-5074-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F468A7616
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Apr 2024 23:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF690281CC7
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Apr 2024 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605095A0FE;
	Tue, 16 Apr 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="arJ5KGVQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CE75A104
	for <linux-acpi@vger.kernel.org>; Tue, 16 Apr 2024 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713301693; cv=none; b=F+kUBQKzl56WEDja5pVxt76hAtM3T9b3HqgZyK4yPzGg7d/LCzcwPsgxYbHskKSxAxFApaw3o2wGFRPSOPMqryh/0iLt45aMpKAiNxCiZg4z497xTqfZ16lQglyjBa5XB7nKn3QkE/4FE6fUI94EO29uWdOax1mOm74cBWn2blw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713301693; c=relaxed/simple;
	bh=UtU4N8okJqSAEdf1gnSV4ZXUyH8a1M/0//8qvJWf6cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5QLcRyXMd/z5o+d2D1cPaKMDXGvI02B2BR1CW423Sr2HooXJr/Nj8DiqxhGDadj8n2ISFt89mZRQpDxBtFFwem7mmGeWUGhJNIGPyO75YGq46WswN7og693od/i9O7B1+lfAyYHFwkEfNzo0qc15RBsZj0YvipHhvsMeVgfhv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=arJ5KGVQ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518e5a74702so151945e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 16 Apr 2024 14:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713301690; x=1713906490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtU4N8okJqSAEdf1gnSV4ZXUyH8a1M/0//8qvJWf6cM=;
        b=arJ5KGVQS2l3pHCWt+SSVMZRDcS3ohbxb5NTEhA/lnOPBqE8TwNQxvHYBSBzYA/Da2
         jIGozS7S1xtC3FBFW6Rd4+REeDmX85Cpw8G8o+iJYAL9PS9IMWtr+XNVRHrvZvnmnpx7
         bGPIRwmH/WQ0RbNNoBmspIQXcGyRdzjEVL1oWNcmMNAtVYwMMMJWnyu8JFfXvHB5E9cz
         BopvktTDI5oo9NRjUY4LpFeWOGCmJX2CgOcx9DQQWWG+NH8hQKFTpxVvy9tSb9u2cwVU
         I1xIllDoOz6cwN9ObB/0pUMCJKWXeCF840twRtvm3Ot55cUioAzELVybLl3R+PIuycll
         I5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713301690; x=1713906490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtU4N8okJqSAEdf1gnSV4ZXUyH8a1M/0//8qvJWf6cM=;
        b=hd8Z6oBFKiIl/uZLhGpG8WxSz5z5/43Iva3QMSTjofuqJF/cZGfihgnJ99+eyB+8uq
         fBGsJSz++tktNJl+3NBUnYeEU6cz417eZAyL39eTVo+MgX2CfqnyvFRpXkwkLhKCihLK
         Mpsj97cDI8SzkwXwd9zSPmkdqcy6EVXzUVF1PUJJl/+FAWYefY87gRckoiiBbeczVOPS
         zwdb/JfFxjXxAW5apMpZCiTqE5Bu8ZSGDnEuiW3Wr1J7TYiei9ZAQcKaEgVgyZYrxr5T
         kCMpW7nHLwCo20nLL6rURLgdPR1SVejkD5uyQN0kZeoFzfzGZpRy+kfqIcJZijN8sPo7
         ybuA==
X-Forwarded-Encrypted: i=1; AJvYcCXWiLLrSIsOVwfa0Lx1colgfktMrvYHMhVWOKLFcmGTDYwmMegr+pXHVT358BbT/OI3lbt/GYczDOJLM9NM/yvl2EfE4B721xrGoQ==
X-Gm-Message-State: AOJu0YxE4+G+suCioct1ABDgLIN9v4cZ/4Hl8OqJ2lf/c3hZ13rUXoiI
	J4LB0m1HRt6FKqjYYayal6h17H4aF+PKLvvNpfK170WFug2IthFI385GijpecOWNiIgkmsbh/qX
	c9d7/XMTAiRPy/8WzVxN4/wdtDG1jkDAHTIVEyw==
X-Google-Smtp-Source: AGHT+IE8/UaVIMjV4kmwMH0LjKA/GWyrorfbQqNq2ie3gzWFSDuXaYK3c2mtzJXVYq5vskx9fsdHL6C1Ceqc7XdUXW4=
X-Received: by 2002:a05:6512:1106:b0:519:3643:c3ee with SMTP id
 l6-20020a056512110600b005193643c3eemr586278lfg.14.1713301689792; Tue, 16 Apr
 2024 14:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdYaXVvtt3b9rFxU4ZNShD17Bm4XU9X3h4dY501iJy3kPA@mail.gmail.com>
 <ZhlSaFWlbE6OS7om@smile.fi.intel.com> <CAMRc=Me489H-mTfT1hfUsY47iKwoaVsf6sgkiBwBVkxJOBo9UA@mail.gmail.com>
 <CACRpkdZRp-DFQgb3=Ut27DHd1w11_aEY0HbLjJHob=C5Ek-dyw@mail.gmail.com> <Zh6FkejXcwBTAqIR@smile.fi.intel.com>
In-Reply-To: <Zh6FkejXcwBTAqIR@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Apr 2024 23:07:58 +0200
Message-ID: <CAMRc=MeXV4_MT5_DKYtHqO+324dFJnr+Y1UtR9w9mj-y2OOqAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo <kvalo@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 4:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Apr 16, 2024 at 02:22:09PM +0200, Linus Walleij wrote:
> > On Fri, Apr 12, 2024 at 9:44=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> >
> > > IIUC include/dt-bindings/ headers should only be used by DT sources
> > > and code that parses the OF properties.
> >
> > That's what I have come to understand as well.
> >
> > I wonder if there is something that can be done to enforce it?
> >
> > Ideally the code that parses OF properties should have to
> > opt in to get access to the <dt-bindings/*> namespace.
>
> Whatever you, guys, come up with as a solution, can it be fixed sooner th=
an later?
> I mean, I would appreciate if somebody got it done for v6.9-rcX/v6.10-rc1=
 so we don't
> need to look into this again.
>

I'm not sure you got what I was saying. I don't think this can be
fixed quickly. This is just another bunch of technical debt that will
have to be addressed carefully on a case-by-case basis and run through
autobuilders in all possible configurations.

This type of include-related issues is always brittle and will lead to
build failures if we don't consider our moves.

Bart

