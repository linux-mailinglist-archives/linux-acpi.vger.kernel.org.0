Return-Path: <linux-acpi+bounces-18033-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97271BF5D50
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 12:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7F044F321B
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E491F328B67;
	Tue, 21 Oct 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OV4FJNFQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3AF32E745
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043050; cv=none; b=Bqe3WgZyv/ZHFD9duaph9638YxmEtMgj/rdtC6obCajP96PGYPb0WgmDmGw2P38yK2UrxrM4bifagSXsMClZXk8UIl1/woSDKr3v8p3QTiKHQAGTrcVURxDBCbtpBk+wx2H1F7C9IKWUiGKn7+emT9Mi6S3AOtc7dnXYCbAxTVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043050; c=relaxed/simple;
	bh=G8bIrdKOREeaQWFYl+BVblIyK/tNvhnzk9i8+sGZ5Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6RQ5gElWn/5yYSrNrH5zqG6IAs+8rlawu9vkRFHw7j2bfzmvAFmgoKXJtvvfs+yqippf8AmJM3jjUHabEAV0ju1LXyupt/jzyEhckzzt405T6q1SD0UNnUR02ilVy0V//2ppUhmvW1n/tFM6CEIzgWsdFK5WtN5fE2X5hZiV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OV4FJNFQ; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63e1591183bso4310047d50.0
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 03:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761043046; x=1761647846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=du/uiA2g0ruAK2UrT7r+xEuTy7bML0SpAVcY8ooVq04=;
        b=OV4FJNFQ1uapnGqxwNArp1c3sMnou9Gn5Mulg7FgaRBpu3ejO833yxc66+0QPR5qku
         aA6EtTV2yORIXSU8/KOKiCgkLr08ed7m+oB3VG68OcVm4IkfQWuf0NSFnvDvBvHYEmGO
         s7eoCUGrMzgib3JPXWKNfiFjGSXvsakVOwKCpyf53cvuthskb+tI6l295G2g2M067qv0
         G6+Xk1iy4eqtknYhBYxWVNcWvuKiCEb1jHN6XCahAmWGOYfMn+CWYLTXienvZkfJa3Lm
         e+zGW8er2mG1JDxIljGhsR0OOWqP1w+F6NtkkmNhuPT00c+L0r+NcJ0Wx1GHFOjnhc7B
         L2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043046; x=1761647846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=du/uiA2g0ruAK2UrT7r+xEuTy7bML0SpAVcY8ooVq04=;
        b=Ks87qpulPskUMiuLUxalfac+vBPvR5IyTgFJFHreiTfYTATItNUP1421x+NckNQtLH
         GttEY0kJM9eV+5MQ/9zVd+qQ0kZdWPWemNC6h+kvslhYP6JedF0xZlSYLQDuaZ5Z0SjB
         adr3D97xUDeIWOGoeClfjuM5IpcOhlGMiLUslzVaQv6x0fm6lvGHJyC9zIdwhUlLnO4I
         IzTvR0vf0gAdWMObhrhJNRBGxau2m1X9PjaP6THYX7vgJ0FJ6n6xq+hYCCAYUMjaYIu2
         9H+tbmjwnRjyJHSQFy70l8D+jr/mKUTZjYPAsJrwe7vT1X/ib7ZLKuIdoJv/2tKigzwg
         wijg==
X-Forwarded-Encrypted: i=1; AJvYcCVoO+9VXwHjdsfGLxpLele2Q2VOtrMfL7BB+xKfg4g6xlbg2vkfhhEJuBvgkAFo2B8l6rdB2Qel32ck@vger.kernel.org
X-Gm-Message-State: AOJu0YyzYUlgWABDcfcPzNI6uK8mF5EZFsDt5yNVD7VU7G3GXkOwryJc
	IYO7d9WwFOnC3lmeRPGBaJ5YH+8Od8LoKYLzuYBqHVL0Kwrt1BiPBaunRs/8TVLO+XabejLpl5o
	mPueqF5SVY855l/gkuADbcocx0tKkIMP+dL3h7qJhJw==
X-Gm-Gg: ASbGncuaRsqKRhCHggT1d7bmxNua6C7AScGk4lxgk6z6eIaLZhnv0N1HC+pH4pGnG7J
	xPwk79lW2P4Az6r9xWSKutrxm15tUPEmPJPmFVsMvsEkYHpqXreFPfFjBVYDiynsR+eR5vmCQka
	aY5IM/ir46NIGtcAN4D9nOZvU3wKUfaxI9RjNU4F2IjU9nEkhVjublsXcrX0NBGJ/NiE9IJAj48
	CBB2HV8VsWDmqLNRbE38b3RYb6M+2F5EyWOYNS1M4XuVjPJQ/doWB7WoYHZYA==
X-Google-Smtp-Source: AGHT+IFFOhRKu4kQW/XKD1Pm8VUPug9hRZQumhyHTlK9vebZPyquvLC0TgCPXJX5yR8+F8jVszRXlOsVXxUxv7obTms=
X-Received: by 2002:a05:690e:4090:b0:63e:3e77:a7c4 with SMTP id
 956f58d0204a3-63e3e77a7fdmr3660188d50.1.1761043045615; Tue, 21 Oct 2025
 03:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com> <20251015071420.1173068-10-herve.codina@bootlin.com>
In-Reply-To: <20251015071420.1173068-10-herve.codina@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 12:36:49 +0200
X-Gm-Features: AS18NWAi-o77CPd71JT42D3mLl8vqFN7eYPAV53oOUDllJc5eKGrXIzOLUEhLMM
Message-ID: <CAPDyKFrkJp4Ny1kUoWy6LHmv6zCOGK-jVEYk95s2ayhqEbDOpw@mail.gmail.com>
Subject: Re: [PATCH v4 09/29] drivers: core: Use fw_devlink_set_device()
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Oct 2025 at 09:18, Herve Codina <herve.codina@bootlin.com> wrote:
>
> The code set directly fwnode->dev field.
>
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 3e81b1914ce5..9da630d75d17 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3739,7 +3739,7 @@ int device_add(struct device *dev)
>          * device and the driver sync_state callback is called for this device.
>          */
>         if (dev->fwnode && !dev->fwnode->dev) {
> -               dev->fwnode->dev = dev;
> +               fw_devlink_set_device(dev->fwnode, dev);
>                 fw_devlink_link_device(dev);
>         }
>
> @@ -3899,7 +3899,7 @@ void device_del(struct device *dev)
>         device_unlock(dev);
>
>         if (dev->fwnode && dev->fwnode->dev == dev)
> -               dev->fwnode->dev = NULL;
> +               fw_devlink_set_device(dev->fwnode, NULL);
>
>         /* Notify clients of device removal.  This call must come
>          * before dpm_sysfs_remove().
> --
> 2.51.0
>

