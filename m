Return-Path: <linux-acpi+bounces-16882-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76704B5694C
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Sep 2025 15:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9AF3A2AA2
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Sep 2025 13:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6284122AE5D;
	Sun, 14 Sep 2025 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlWfjIxh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87BA221FAE
	for <linux-acpi@vger.kernel.org>; Sun, 14 Sep 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757856306; cv=none; b=VOmQYl+CzOD7gkgZcbnKQCUmrq/T9OoRDU/kQx5Ujrq7wOlJ5ZAzkJAIFQn9LWEvFkwtuDj7fbQgQswJflUiNuMwYyWNs/KC+q+AzIGR6NVr4WE/bowhV9VJp+/0CqmAXyoG/rO4AjYtO+pXXz6RP6GSMHuSx7qucXq66bIN2ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757856306; c=relaxed/simple;
	bh=c1ENNsggccsIqoTu/x1ARD82i45oCDooMzrY1x/lqsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxA432hCmtc4maiClZEc76A8g9Q8YGuDqPTHsxkecvSxDI74S0SPnn+hY053dF/4EYfd4MYXjtEf7W8qk6nTISFz/Wj5rhoJ9vA8CsN+0652Pa8K+HstwiN9gg4ywvYRtypAJR4zCGrj4MhVpWttVx/74w1GHHFUEeV6xxJjiFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlWfjIxh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0411b83aafso494842966b.1
        for <linux-acpi@vger.kernel.org>; Sun, 14 Sep 2025 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757856303; x=1758461103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1ENNsggccsIqoTu/x1ARD82i45oCDooMzrY1x/lqsY=;
        b=GlWfjIxhRiIAvBLR/R8uPPV+fufB4SVhcrxZ+suAcN7TfjysgX5JF8dIQLrgOksJDl
         43KhdKSR4cmEAXNDAJe18YB8UeKW5Vi++ehcMHI9aFVKQG6qdF8rWx75WyHVGAsso+Zt
         U5imMGQuyOtSfTO8aZIltgzQ/4T6ClPF/fxj3Ngzz0wzi0cOGZTBxbfihK9mdOKTNR0+
         k9NXOHiRBe7dP8zK0+Tjgmf4gWySAucV3NjHpV4OPmPNQLuugI2Oazix4eQNTkaPWIOv
         imgqSvlm/9iTdkM2WSaNzcWYpf2VtNfqwZmmhqskmVURZv1OwIrbAaECUD/9J9+fsACz
         bWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757856303; x=1758461103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1ENNsggccsIqoTu/x1ARD82i45oCDooMzrY1x/lqsY=;
        b=rlMy2KuqBAMs4yrTUmg0vUzIYxggc3EZ8adIA0wLFKQwXbqZVoLjglNjpaIp6yzWa9
         OANDF7AMHLv0SrGeWiO6+aVeQUQVlJbwgY2nsxCfcL+FdJ8QZ4O44B6Ofa+PTercKVoR
         Sa9e2sBXj6eXxvhlke+CEw54lY8ALxM8NNLS4VLBv1S+mFh7auegWUOGpGkTCilLxd4o
         6JW+b9gOqvSInzLbijNAFnVnjddakfuKQygbzBPjVzxRRAvJWqc3Bct+ta61N+lp/5vo
         1clEOofl7m/GsGdcEWPtVVk4iHkfJIs8ZSfpl0N7JCXkzjd/SSTt73SthjKN02jQG3t1
         KqbA==
X-Forwarded-Encrypted: i=1; AJvYcCUd8MvLYkBHQ0lQeEX/Y5yTN8q+bHBX4e5x7t2hGjuTOwmQDdms8W5zcXtnpdsYvOmvN6nDFjmTW74S@vger.kernel.org
X-Gm-Message-State: AOJu0YwScjZjSBon+MJfTs2L/l9+xIVcv8TDdzKTCFiFvHi7tRJYyDeG
	PIXRGrDn07vVbVT5fAR7eNKKfq/TlaUolHU5KXqK13ERuz+2gtSToil7oLy8U8OMgHRgdNuw4vp
	GAcx6nLAaBsirJ9a8N1q7w+/+bCxd3mY=
X-Gm-Gg: ASbGncts+kIvW4DcipB4Xz9hsLInYi6+PcWMPjRCgW9XPOIZbRPKc40qodR5NGKDE+O
	zQ2MYNSZ7eM8SfEYMClfA/BzGxssJ63MR8WE06WmKZzgb3IEXYvOOg8tBHicbNy4lAQ142+F2z5
	f+vwW3AFIUpCz2katDYiKOnwnXdCmZecvWSrsixjPUiK25r0/eKPPJcKMYNMS+96udEjgmUrv1k
	3/bigw=
X-Google-Smtp-Source: AGHT+IFWT10RqkjFYzbnJe0RmtlfLcxsUFP0lSqT6wIOhIEfFMe8hhsUjxJ7Lj1/NZxxB1LnsHHPWGst9v9QYT40wJU=
X-Received: by 2002:a17:907:bd98:b0:b07:e3a8:5194 with SMTP id
 a640c23a62f3a-b07e3a85443mr446254666b.22.1757856302956; Sun, 14 Sep 2025
 06:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912221859.368173-1-hansg@kernel.org>
In-Reply-To: <20250912221859.368173-1-hansg@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 16:24:26 +0300
X-Gm-Features: Ac12FXzFq5r7td9YdYFjXae8rJdLRnJ6tPPEUqTs-9VSdqmeEr-y5otDdTk8VmI
Message-ID: <CAHp75VeOAuhQC2xZxSJ_9hedNzGXdmmeAeoahnKBSR-K9UP3mQ@mail.gmail.com>
Subject: Re: [6.17 REGRESSION FIX] gpiolib: acpi: Fix using random stack
 memory during GPIO lookups
To: Hans de Goede <hansg@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 1:19=E2=80=AFAM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Before commit 8b4f52ef7a41 ("gpiolib: acpi: Deduplicate some code in
> __acpi_find_gpio()") and the follow-up fix commit 7c010d463372 ("gpiolib:
> acpi: Make sure we fill struct acpi_gpio_info"). The struct acpi_gpio_inf=
o
> used during lookups was part of struct acpi_gpio_lookup which gets
> memset() to 0 before use.
>
> And then after a successful lookup, acpi_gpio_resource_lookup() would
> copy the content of the zeroed acpi_gpio_lookup.info to the on
> stack struct acpi_gpio_info in __acpi_find_gpio(), overwriting any
> uninitialized memory contents there.
>
> But now instead a pointer to the on stack struct acpi_gpio_info in
> __acpi_find_gpio() is passed around, but that struct is never
> initialized.
>
> This passing around of the uninitialized struct breaks index based
> lookups of GpioInt GPIOs because info->quirks now contains some random
> on stack data which may contain ACPI_GPIO_QUIRK_ONLY_GPIOIO.
>
> Initialize the on stack struct acpi_gpio_info to 0 to fix this.

Ah, very good catch! I missed that field that can have garbage as we
don't file it. I'll take it on Monday and prepare a PR next week.

--=20
With Best Regards,
Andy Shevchenko

