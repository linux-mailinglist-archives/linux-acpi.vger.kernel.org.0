Return-Path: <linux-acpi+bounces-19168-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BBDC75E5B
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 19:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58BDC4E022B
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 18:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762463242CA;
	Thu, 20 Nov 2025 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kyk29MP7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87B32FE57B
	for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662793; cv=none; b=u05G6ez16pmfaBWRMG5WSTcA2O37/Us9OyemvFIQ//pa9FuduY0eFgXwZLtsZFSDi+fYKYEd/AbnE96RuD8Kxo/FAOe8SYaOvsbJt3Kt6L9uTEXw6yAUeJNs8t+1qx0dfImRe0pYnHzViz7Aru2zjhrO5hpFX1f8JX0FzKvOGV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662793; c=relaxed/simple;
	bh=2frM4ZKJ9sHrFHvhxYMW/pljtv9IlgikwDwgYXbV9+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTWOXvKorW587oCER9O44EIPGUkP/SXTKhuSazdQ0wwAwjbwrTbnPVFW4PugiCpQV9U6vUv6fhc6iQ/C/JSJoauskZvhS7bMujAY9PgpYWrqImlYUWTWCQa94Aws4BsG4Sl0Tp2dsx/p26EwO03N2rF3Yy8Xt3gRN4rzBbtOpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kyk29MP7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5945510fd7aso970998e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 10:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763662789; x=1764267589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnYALWaCSwb3tCzOH7sb75PPH0v2Pj24u8FmC4zAj8Q=;
        b=kyk29MP7qKcrUq/lMPOHCAFiP6roy2oouvyrWvJhDLmYAwzVNM2DCq+YQ0glx4YU6H
         wfGraDVQzwEMJjMcGM1wwXpAEuGVByepve5+thh63Hr4ZS0HngBBDCvMTtAWISMl7xIA
         S+gaHIf3P36lFIl9p13wrxL7hTMNlrxYYDNUefUdQmMtf+6CRvN2Ww1lqyYhYS7QE4L4
         exmVTObHgB3Z31J5BcHtgTeQPwRqDfc0se2P9BHElwFYYAixboESwmwh6Pg9f085LpmG
         1fCCEzl5KAbE2C3TaUGu1iMlu9bn+hQWq4LZsgWOMJIgwZp6sefZhg1NLyIRhsstkNmO
         DboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763662789; x=1764267589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QnYALWaCSwb3tCzOH7sb75PPH0v2Pj24u8FmC4zAj8Q=;
        b=cZiISH4FY+qwCg/b1XeYBZUIo8qpu2iRW3KYf4kPzmbLmEzOXFp8KiLykxpwsNRy5+
         YZBgP+CdZNKfOOKqDCJrB0XXSeLk0+UQz5CY5hDu4xwiYyGLE6+8JcDNhINqqiYz5fB3
         pIga3g7Cl/5QoHK4nIWzixRACN1R6BKJ4Qc2xQqbZwU8O+hsqt9w4glJaGsZkPSV8anG
         yxjI0hotkIJaSLqp6ocoEDrhn/kHKHBBIvpy4PR/AIpFB/8lmxQV8p2IeTBgQPjITV8/
         7Abg6y5PdlizCHmd0JC6ow+CHvN3nb6j89192C/Djn4wSD84FnM41AVKr8udJrXrw0dN
         qBww==
X-Forwarded-Encrypted: i=1; AJvYcCWvPip71YOXdnJUI1hRm4u0Ky2pv6e6xnwK78SprE1gYfqi1o8XNPMfhZ40MuxShbrJ0/be4o1narrM@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJu5MYyKL90aIfOIjxWhTEMesNa9AlrEui3EvJQ5xj182/4Pz
	zb3qTiP5aAGs7rRr175V7ahdJ8ION3yQkeGZiXJnICVLd9pXUfDW2wSaYFsEsavg4KCpxE731Ax
	h8+g+2MLb0pbsTaCMWdrAoQ+qB7ZPXgAJEQ35g4ct6A==
X-Gm-Gg: ASbGncsx6IWy3Nvd7b5UbxnuZ/dBqkjTyZVwYVK16x0lK+5iEpW/mnEVGXrlNWSSsnz
	L3m3uuNhoSyuJML83DzPkI+K5KowgujxPRnJJQp70uHggp6uYlKJgdl10y4xSAdUMpAW7tfto2V
	a/Xv5mlURged+awWusN2tp979/kKdRzyLAVOFD3lPQILe5c9vviv/KVZoQZiYbwfU5GU9/hqvvo
	0ix1mzbk/gY28hHVc5iBbqfQWPn2WLlD22qGP2SnGohgUkPrnWQ0j5yo44648O5oWfWcEZo+nOV
	O/ZE8byg4mGQEGXE80WPLJt7sZ9UffKbQOh/
X-Google-Smtp-Source: AGHT+IFJUK59m9cV2hdaMboMdwCuLYZSd6vorsTLduT0KYUQfG8bYza6yPNSkEBgztU1V5kaircoAsMSf6iO5hTasWc=
X-Received: by 2002:a05:6512:b01:b0:594:34b9:a7f4 with SMTP id
 2adb3069b0e04-5969e2f421cmr1562911e87.29.1763662788999; Thu, 20 Nov 2025
 10:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120163252.34760-1-p.zabel@pengutronix.de>
In-Reply-To: <20251120163252.34760-1-p.zabel@pengutronix.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 19:19:36 +0100
X-Gm-Features: AWmQ_bkWVGFSZn3FalnS_qvDgjI51sEMsJrOYvZkmui2vXqgrMxEN-ruhSsnp2s
Message-ID: <CAMRc=Mfzzgx2JcBa1iG9L9ztF+S55cSNHgNurubPBsDteoLraQ@mail.gmail.com>
Subject: Re: [GIT PULL] Reset/GPIO/swnode changes for v6.19
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: soc@kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kernel@pengutronix.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
	Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 5:33=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.=
de> wrote:
>
> Dear arm-soc maintainers,
>
> The following changes since commit e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a=
7c:
>
>   Linux 6.18-rc5 (2025-11-09 15:10:19 -0800)
>
> are available in the Git repository at:
>
>   https://git.pengutronix.de/git/pza/linux.git tags/reset-gpio-for-v6.19
>
> for you to fetch changes up to 5fc4e4cf7a2268b5f73700fd1e8d02159f2417d8:
>
>   reset: gpio: use software nodes to setup the GPIO lookup (2025-11-20 16=
:51:49 +0100)
>
> This tag is separated from reset-for-v6.19 because it may also be merged
> into the driver core, GPIO or SPI trees, if needed.
> It contains a single series [1] with changes to swnode, gpio, and reset
> code.
> It is based on v6.18-rc5, which includes the prerequisite commit
> e5d527be7e69 ("gpio: swnode: don't use the swnode's name as the key for
> GPIO lookup").
>
> [1] https://lore.kernel.org/all/20251120-reset-gpios-swnodes-v7-0-a100493=
a0f4b@linaro.org/
>
> ----------------------------------------------------------------
> Reset/GPIO/swnode changes for v6.19
>
> * Extend software node implementation, allowing its properties to referen=
ce
>   existing firmware nodes.
> * Update the GPIO property interface to use reworked swnode macros.
> * Rework reset-gpio code to use GPIO lookup via swnode.
> * Fix spi-cs42l43 driver to work with swnode changes.
>
> ----------------------------------------------------------------
> Bartosz Golaszewski (8):
>       software node: read the reference args via the fwnode API
>       software node: increase the reference of the swnode by its fwnode
>       software node: allow referencing firmware nodes
>       gpio: swnode: allow referencing GPIO chips by firmware nodes
>       reset: order includes alphabetically in reset/core.c
>       reset: make the provider of reset-gpios the parent of the reset dev=
ice
>       reset: gpio: convert the driver to using the auxiliary bus
>       reset: gpio: use software nodes to setup the GPIO lookup
>
> Charles Keepax (1):
>       spi: cs42l43: Use actual ACPI firmware node for chip selects
>
>  drivers/base/swnode.c         |  30 +++++++--
>  drivers/gpio/gpiolib-swnode.c |   3 +-
>  drivers/reset/Kconfig         |   1 +
>  drivers/reset/core.c          | 146 ++++++++++++++++++++++++------------=
------
>  drivers/reset/reset-gpio.c    |  19 +++---
>  drivers/spi/spi-cs42l43.c     |  40 +++---------
>  include/linux/property.h      |  13 +++-
>  7 files changed, 141 insertions(+), 111 deletions(-)

Pulled into the GPIO tree. Thanks everyone for reviews and patience!

Bartosz

