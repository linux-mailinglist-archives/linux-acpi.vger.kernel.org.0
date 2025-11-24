Return-Path: <linux-acpi+bounces-19220-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9545C81F89
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 18:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EFA2349386
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 17:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B982C374B;
	Mon, 24 Nov 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fEYlIdOQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6B72C0F84
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006503; cv=none; b=hteP01CTbvNnEa/W9FTcAbRSE7/4X5mmBhtUrZGNvLGrNvQl1cDTwSNxzxdX9U1KzSWkd5fMAywAEq+ekKhXR9K4GSbrb11gneEKbRkEdXPyLUlL2FkqKC8UKgvJlseX07aEVXUPFBQc+opjlZ7eHtnL1o2BK3uSTHNi583Bsl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006503; c=relaxed/simple;
	bh=4r6uq+XJ6hrSbkNoNXPhbiKHyGHCKt75UkrHPmh0NFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRil83meUSZrO8CGy1AfX0sC+csn11BCyHmwCOnoBUGQjtkeVmB+drrL1yTx8lpCYesSmdeggQZi0laUf8zHrpbj5nI4hFU2GMVq8AhiwUAxG5k0Wz2oA1qZTQP/4wHiXft5H44rP+sW/fQQXatCUkGmu/g8yeb7wc1iQoNshBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fEYlIdOQ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37a4e329a90so33085501fa.0
        for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 09:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764006500; x=1764611300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r6uq+XJ6hrSbkNoNXPhbiKHyGHCKt75UkrHPmh0NFQ=;
        b=fEYlIdOQ3Nx0FvthAY/5aEUw5UUb3MtRrsBm/5nbXJ6RShy2OIOJrnBvaYqux8QtsN
         6E+DodmUX2Io+IMCmxdf25iypV0EtHUMbOG+3howrJVjk9XVF3HnNl2cUDZyzMGektvw
         xj4VjUPWw3dfOIX36p+OcSsbbbdnHI9slG0YOIcDYiscmrsSPdxk1hPJrDNE4ogmL5XY
         pMLDmFqIMQfiRMK3mIEzExfbo7UhLuvjEeNTwOCU4gjpw6x6FPW9hYyOwSQ/chzZiG2T
         g2PxPWTCJJJLxTUDzQk/GCU/WZhi9XvvvJYnQJvt/fQj2k6vVVQH7lwQWx8mNuTS7i/g
         ilqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764006500; x=1764611300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4r6uq+XJ6hrSbkNoNXPhbiKHyGHCKt75UkrHPmh0NFQ=;
        b=gSRKrAjAjfJV7CUWalJH24tnM9iEISa5r1Q1jSsVisZwkYWYw2IzpZS383saNuIOhV
         djTLKl8Yy0qBl+m3dzxN0KsdPEavBvCWyBIz775fJhqWMiCWCt2aTsACsZh/uDagoyw7
         3aXiMFmJ4sake1/65Cdv1qOjhS0yCfT1Q+zy8hBXLuF5Gr+fomDTtQTu76CeRnVq4Mrc
         dyrr3mIFfVaPdki/Qs9h+M2op+u92O7n9/LsJcqjowhbTU6RhQKJA66C+pk3RV6Vo/z0
         o2R6SRBM2IAH9y3+GsifCJ2OHZWj7cyCPaX08sAgxZGBW3uiX8UWSIlVwE7wFop1djT1
         Ki5g==
X-Forwarded-Encrypted: i=1; AJvYcCWQoHs5ISNBnRfvFhxXRbPLYi1VTj8QM5bIhvOocM2m83yR83LBKB+ztezj7fT6sQKh955JweO8GBYZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyii4eTZ6rhRncSrt/DmDGBktlW8TkWLwODDDyhWXCkFysUubpX
	kmlXAhYL9/s7s1maz56+kItMuU0ArNWHnV7Dhk40QvZ16ayTbRJ+0ZtczxKmjBznW0UP1R+P35Z
	m/kRXtVIup62xUKb4rIFjppcDqi8GAmVewQjhMqI5sQ==
X-Gm-Gg: ASbGncs7FHctP4weXQENwlMATncwXdhwQdv99Fy3T0c18kUwzZv4kVq7b+r/9kWt/S/
	g8xDzehZ4B8zfI0VC+fWQSt02AMbpbtfcQuT5Tnf1QD5BSCLTu/YLnXpuVlB0FVI9Y1+OjgKHoo
	O3qt984MQAo65HMoiAuNgHGm+SOnkvvt0PwehAIVvogvX03bBmgQE29NueIM7RsDRTigX8HtDQr
	2PsLKWfEPXeqjbXhQbC7ZCEI7IE5gk7Y9AL5AIscQqPUA1vmmbLsyvp0Em8HT0gFpi1ps4V45zW
	ywmmnkcYUkK8jNk25jzb7gU+PqtFU3IR07x34Q==
X-Google-Smtp-Source: AGHT+IF993DoHSMlB60mWDtCOrB1XMOt2yUP8xFOoEjON0prsCxIqX3jeiL/LWt48eiHKiIUUX/0Hv99+yLDo3p5YEc=
X-Received: by 2002:a05:6512:3b27:b0:592:fa8a:810d with SMTP id
 2adb3069b0e04-596a3ea7847mr4433290e87.16.1764006499554; Mon, 24 Nov 2025
 09:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
 <20251120-reset-gpios-swnodes-v7-4-a100493a0f4b@linaro.org> <aSSOo4q0sLDHqe1h@opensource.cirrus.com>
In-Reply-To: <aSSOo4q0sLDHqe1h@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 24 Nov 2025 18:48:05 +0100
X-Gm-Features: AWmQ_bnvq_Ux1-kkcgnqJRAH0qfvPMdf4XOXl8mrvC21GsBAI5YmjWFZH8pho_M
Message-ID: <CAMRc=MfiR4AMYXc5YA0GOt=+-kx0yO0qFdYd2mZqwguW5v+U5g@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] spi: cs42l43: Use actual ACPI firmware node for
 chip selects
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, 
	Maciej Strozek <mstrozek@opensource.cirrus.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable+noautosel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 5:58=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Thu, Nov 20, 2025 at 02:23:59PM +0100, Bartosz Golaszewski wrote:
> > From: Charles Keepax <ckeepax@opensource.cirrus.com>
> >
> > On some systems the cs42l43 has amplifiers attached to its SPI
> > controller that are not properly defined in ACPI. Currently
> > software nodes are added to support this case, however, the chip
> > selects for these devices are specified using a hack. A software
> > node is added with the same name as the pinctrl driver, as the
> > look up was name based, this allowed the GPIO look up to return
> > the pinctrl driver even though the swnode was not owned by it.
> > This was necessary as the swnodes did not support directly
> > linking to real firmware nodes.
> >
> > Since commit e5d527be7e69 ("gpio: swnode: don't use the swnode's
> > name as the key for GPIO lookup") changed the lookup to be
> > fwnode based this hack will no longer find the pinctrl driver,
> > resulting in the driver not probing. There is no pinctrl driver
> > attached to the swnode itself. But other patches did add support
> > for linking a swnode to a real fwnode node [1]. As such the hack
> > is no longer needed, so switch over to just passing the real
> > fwnode for the pinctrl property to avoid any issues.
> >
> > Link: https://lore.kernel.org/linux-gpio/20251106-reset-gpios-swnodes-v=
6-0-69aa852de9e4@linaro.org/ [1]
> > Fixes: 439fbc97502a ("spi: cs42l43: Add bridged cs35l56 amplifiers")
> > Cc: stable+noautosel@kernel.org # Don't backport, previous approach wor=
ks, fix relies on swnode changes
>
> Just wanted to check what the thinking is on backports here. I
> see we have marked this as do not backport. Which I think is
> sensible the changes in the preceeding patches are a bit much for
> a backport. However, the patch has caused the regression has gone
> to a few stable branches (v6.17, v6.12):
>

I totally forgot about this having gone into stable.

> commit e5d527be7e69 ("gpio: swnode: don't use the swnode's name as the ke=
y for GPIO lookup")
>
> Are you guys ok if I send a revert for that patch to the stable
> branches it has gone to? It doesn't actually fix any bugs on
> those kernels, and we are starting to see issues coming in that I
> think are related to this:
>

Yes, definitely, please do. You can add:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Bart

