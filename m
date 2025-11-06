Return-Path: <linux-acpi+bounces-18582-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E40C3BB6A
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 15:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2E01AA839A
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 14:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66E0303A12;
	Thu,  6 Nov 2025 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ylPbjCkI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832527FB3E
	for <linux-acpi@vger.kernel.org>; Thu,  6 Nov 2025 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438721; cv=none; b=ummXFH7lk9OLenL6fdDYDuCb7LOXbZAZ2S2Z2wICTVrQ+2oAQqW97hXLmyzgGUBHDr5aBsvn4/DHPYBW4b5WMBmY9GW59g/SqHVO5rcnFSPoQRS0l/ouFwrnb1KMJ6FClMo4Oh0jrzhhJfqxVMtm9f2Xhpk+skoqIe/AU5Un2os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438721; c=relaxed/simple;
	bh=nbU9VTJQs8QIjbledFSiiMZSbQur1NbRbjuGKQHQDy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nObNi9lL3vO4LmqRG6tmmUiA9x6TG2HCTNYEiexiOITgZTuqtjro6rIxqgNkyxKQQBbAn8Uw+5VWCNs0EFvF4eED80tTBoS2gC4ef5DMajXqUTM9t762bamX15327y3fRt6+0Wk/47AtrdG5id4h9qCPPAWw0WnXeEnrK/qWTHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ylPbjCkI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so867521e87.2
        for <linux-acpi@vger.kernel.org>; Thu, 06 Nov 2025 06:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762438718; x=1763043518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UYCyFD4Bb6aFEIHyNbsrjvvwW06LJgyiNw5ci5l6Zw=;
        b=ylPbjCkI66k6A0ncr7t2GiAUCQ1ie8tF/WRaSRAUevrkVrQ24Ri7Xcl4uOUtoiuNxi
         IVgRLe592zxyH3sRldeCZa3Yi7HUGqXdQpM17/VDz+WUB5m7qLwt10DRKW0coCYubewU
         j6n++SkNpwUZDfaUUy47xt43vdZQnQ2g45PTl/nRxo58Bpv7CDoi7XkYf4xjBs1McUlL
         Y31DJ9kimin2sEHEl2u1QHsaCRfFhyasBnExqo3wW74oKnHrj2gSfaNU3gE6yZ48A/7f
         kCMCMfBvjWUl2KSdLsFbaShNFRzOAsaOb4nesmJlR2xaLRJVMuME6Z+ziiieUn17EWUN
         /RjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438718; x=1763043518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UYCyFD4Bb6aFEIHyNbsrjvvwW06LJgyiNw5ci5l6Zw=;
        b=FE8zOzXbkgMkA8v+M4BXjO7CZolAvqWN0SORmYMP8+NGvwIjKpeWeI70t/whmtLR2d
         zD4l53kgG7pnXoOAuF2agFAh+i6/bV2QdhwGE8R3CN7/Fmrw4UjI78+T73Hb4n+MZw7u
         cTZvW3OCPze9/PIV1zjlHj3PpBp5ZCZg/O7066ipH/winNl4qzr1eKOKepfL0xP1Yq/3
         YpmBg4C3jZtXy0GycZ71/RpcvlvHsFtlgBPZW7qCubWpyT/pMbcqFEfN+88ufrANJ/af
         Tp64JK5eEpuQt7eo78TTed4VYL4HNXp4dzctTE0G4xhJEFSx3RP6DNix6QuUPmZxJyra
         wi0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyGpQ0eGwXdP2aVINNMCl5H2soVolxIWEleNZze/ryQGqwZsJPouTu+wS7uROf+b/QKH+4ttBL0lxX@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFtaxzo77Y1bzXBfsIMZGkovld20cTz4pdxehG4zaMosbc46Y
	iscOIILEzHImVz07I/BIpMSH2Qw5v8R+3nupCghzLkPZNFE/6N7h2VuAzKwgrqYrWmW6PRS2LdV
	jkxD1yLd+4RWiu++YGF5yvRehwsNy0ljxuGcUhblugQ==
X-Gm-Gg: ASbGncuAKxiOGSI0KbQAsC5t1UhD3tHAOOCM6gq99A+3/nBIBTDnym9BSC5LYQhtOuQ
	WB+0Cn3iHNQUnlSecn6BM2XuVYLkq928flcmyYqKKBf3wodiXedO/Bs0AobA2S0mdtaUNqZrJEs
	bIk33uPRRECPS6fO9XPxk97EUgDuX8IH9jeQr5NpMVETA4OuY8Ri+0zEXZhRbU6xGmGoOULvZb/
	lOVZfOIRPpx208iteWyAOGXD/gRneCEiyFOacPK0TAsQrj66ZZwz73Vcar/evmxQOtCnFfsDGtY
	wYapeVSk/Fh2KLU=
X-Google-Smtp-Source: AGHT+IHdQJZPunwUY3ZHIE+wSItRDRGbaVjfDZ3bclHs8LsxocMfrUMoNk7HzUzk835mq0tyKBc5gXkBG+W/siXqRXk=
X-Received: by 2002:a05:6512:61b1:b0:594:34b9:a817 with SMTP id
 2adb3069b0e04-5943d7c01acmr2183793e87.33.1762438718011; Thu, 06 Nov 2025
 06:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org>
 <20251105-reset-gpios-swnodes-v5-8-1f67499a8287@linaro.org> <aQta01b_PyeHirxu@smile.fi.intel.com>
In-Reply-To: <aQta01b_PyeHirxu@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 6 Nov 2025 15:18:26 +0100
X-Gm-Features: AWmQ_bm4y26DefF3te9d8PCRfESO6EycvWadxioNhhdZRQkv54SvcFlwZN3U2B4
Message-ID: <CAMRc=MfgPsf78pPTD2zNYkjp6QYO2xFnzN-niEaVn7nkjnUB5A@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] reset: gpio: use software nodes to setup the GPIO lookup
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:10=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 05, 2025 at 09:47:39AM +0100, Bartosz Golaszewski wrote:
> >
> > GPIO machine lookup is a nice mechanism for associating GPIOs with
> > consumers if we don't know what kind of device the GPIO provider is or
> > when it will become available. However in the case of the reset-gpio, w=
e
> > are already holding a reference to the device and so can reference its
> > firmware node. Let's setup a software node that references the relevant
> > GPIO and attach it to the auxiliary device we're creating.
>
> ...
>
> >  static int __reset_add_reset_gpio_device(const struct of_phandle_args =
*args)
> >  {
> > +     struct property_entry properties[] =3D { {}, {} };
>
> It's an interesting way of saying this?
>

I hope this is the final round of nit-picking...

>         struct property_entry properties[2] =3D { };
>
> >       struct reset_gpio_lookup *rgpio_dev;
> > +     unsigned int offset, of_flags;
> > +     struct device *parent;
> > +     int id, ret, lflags;
>
> I assumed that lflags shouldn't be signed. And IIRC they are unsigned lon=
g
> elsewhere (yes, just confirmed).
>

It doesn't really matter that much here but whatever. I do plan on
tackling the duplication of machine and OF flags at some point though.

> ...
>
> > +     rgpio_dev->swnode =3D fwnode_create_software_node(properties, NUL=
L);
> > +     if (IS_ERR(rgpio_dev->swnode)) {
> > +             ret =3D PTR_ERR(rgpio_dev->swnode);
> > +             goto err_put_of_node;
> > +     }
>
> Can save 1 LoC?
>

Oh come on...

Bart

>         rgpio_dev->swnode =3D fwnode_create_software_node(properties, NUL=
L);
>         ret =3D PTR_ERR_OR_ZERO(rgpio_dev->swnode);
>         if (ret)
>                 goto err_put_of_node;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

