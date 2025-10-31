Return-Path: <linux-acpi+bounces-18395-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA48C23F8C
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 10:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8F8189AB8B
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 08:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6C6327200;
	Fri, 31 Oct 2025 08:58:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C222192F5
	for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2025 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901120; cv=none; b=LatViPboELVuAqBfjjBEKqwVM32OtkgZNSuFSA0ZXGH03joAY+96h7fg3Psm/4I3HPASdt99o7fU9scOuDpwR7Nm487hmMFZvxCVOxWstH2KoJf2aRxGw6AXp2JU4/+PjUynYVu/Iv81IVObL3fiXrkfSTo+ML4x3oqziyAm024=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901120; c=relaxed/simple;
	bh=NYbl8HJcgb3R5SVJ9GXGI/Jq2+mOIag8w0HzHBPHPoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RG7Dtk2GG1WmwU6LyRgwQnrl8U9NfIgR9zROKpXI0AAzyY9MYUlBHOM1jvUA7PKVqlpeNFu1dc8adXgZVkaenM78sD8AWBzBylE94/MbiARo1qLfkK0q4AJSHgpN57LUVa3Lv2FbQtanJJ8qYIz/pvNO3xNjvt1TejGsUVJLX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8a84ba42abbso225217285a.3
        for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2025 01:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901118; x=1762505918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQVVX5c2GB+a2QgL3UYe6DKU+bmVaydohzEFkpxq/1c=;
        b=QAP8942jh2nVGnYAlWoD/OqdsWrLZOM9hcjs05MI65l0xtvoLiTODyqunkuJwJ3nLQ
         xXh0y7Jg8TmQ73WW7GPxg/vgxkHJcDJT5HMoFYWxqUhqsHcRjilOhdXn3nlHqoKdq5pI
         4wNSeSr1bm54D98AMKnf0bKsqlyiNxliJO9v6NF4gCKx8qzBqtqNaUuwrtBBGRDqT5TA
         7PtwDPI7/Yr2rBCkwdkgi/1oidfB9UJKhQZxk2hqAD28aQHs+Wa0Co5cbbFGXO0QRi21
         HfutuK08Gan9mJCZ6uFg24xvY9N0kkP1YM2aD/Lo5UkV+ripYkeDN94hMyM5zHhWBH9z
         14+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZm6hc9cyrfPeJKOSndjjoVao1fxW1I3eteE4Twv6EyG+7bUbLdSf1kcWq+0c15oA2mGHeL1jXQSyc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3OlEjkiK9p/vAVMnLLXt0y/85mkoWbM41lnZldgukOI1IOcr1
	dW6L9dFXOPcrzxSGhpGWoi1CQ/tX8767/ukhiZsjGMQ2YYtlWpGzPmUt7UsszYot
X-Gm-Gg: ASbGncts1Wu6tzPY5rbgxr6ooIQ9aXNg6D+9gWEhOj2DUWeSdi/UAJwvcgzs+hZie9I
	9+wAZLAAZZiDvyL/zt/KBs77cIABT3xEDfrxHgaY9iB8whIAfxt95pMaHaA8AfQ/jIv8ZrGw5qo
	0hhCm84VItKHXFmYdU1eKviV2LTc2qzRYnedq9onr7BjIcFzTCy9Mrmk5Km4aXXFIz57IF3grBv
	IZ++0yN3Entm6xhQutDftVqSDQ5IL1q+O7A8Ekl8LN4BrJlZrJXPW5IvNn8jm8L9Bz3KqgzV57v
	kffaH7CvZk0zO3VL3xVaGBBoNKFULXdp9VqpEDkMbp29oaz3WkX19ptVujPFzlChcZnkQCNoWbU
	XXjWpLBivqw0TKBclLVLBS6XR/kcWLjiP89BKvM5dhxXdqO/Q7q5n9uYE8ZTge6tT2pz1D4nkG1
	P3pYzsG3PFUK3mRYTtO1oLbKKovS89pcQsH0KE+UU2K/YDpRg095C4/t2LhlfBaMQ=
X-Google-Smtp-Source: AGHT+IGOLt9lAmS1xnbDR2FjS2KnAo8+22jDnKhaItn1xt4V5sKyzHaip+4AdADXIBukZ7Ilx5cvmg==
X-Received: by 2002:a05:620a:178e:b0:892:5eda:1a8 with SMTP id af79cd13be357-8ab9b6910d7mr256912785a.73.1761901117575;
        Fri, 31 Oct 2025 01:58:37 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8abfdebb115sm77692585a.0.2025.10.31.01.58.37
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:58:37 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-89ec7919c71so220718685a.1
        for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2025 01:58:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQkWiXaEXKPkLon3zu8ahYdSscHZpSxrK9tFg4/9/ukvYlh+BIgUuhA5/DgJSDwKWbKFj17Q4BEffN@vger.kernel.org
X-Received: by 2002:a05:6102:c13:b0:5d5:f6ae:38c6 with SMTP id
 ada2fe7eead31-5dbb136ecc7mr717064137.37.1761900747573; Fri, 31 Oct 2025
 01:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com> <20251015071420.1173068-6-herve.codina@bootlin.com>
In-Reply-To: <20251015071420.1173068-6-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 Oct 2025 09:52:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVnsWMB24BTFKwggEXKOtqJ96GWZh2Xz+ogocQHM+=+6Q@mail.gmail.com>
X-Gm-Features: AWmQ_bm5vGlc5XXZic8RvnXrZNNcCRnf0-7M9Km7uh4sqx0Aign1FjKoX2MZmow
Message-ID: <CAMuHMdVnsWMB24BTFKwggEXKOtqJ96GWZh2Xz+ogocQHM+=+6Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/29] dt-bindings: bus: Add simple-platform-bus
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
	Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
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
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Wed, 15 Oct 2025 at 09:17, Herve Codina <herve.codina@bootlin.com> wrote=
:
> A Simple Platform Bus is a transparent bus that doesn't need a specific
> driver to perform operations at bus level.
>
> Similar to simple-bus, a Simple Platform Bus allows to automatically
> instantiate devices connected to this bus.
>
> Those devices are instantiated only by the Simple Platform Bus probe
> function itself.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/simple-platform-bus.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/simple-platform-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple Platform Bus
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |
> +  A Simple Platform Bus is a transparent bus that doesn't need a specifi=
c
> +  driver to perform operations at bus level.
> +
> +  Similar to simple-bus, a Simple Platform Bus allows to automatically
> +  instantiate devices connected to this bus. Those devices are instantia=
ted
> +  only by the Simple Platform Bus probe function itself.

So what are the differences with simple-bus? That its children are
instantiated "only by the Simple Platform Bus probe function itself"?
If that is the case, in which other places are simple-bus children
instantiated?

Do we need properties related to power-management (clocks, power-domains),
or will we need a "simple-pm-platform-bus" later? ;-)

FTR, I still think we wouldn't have needed the distinction between
"simple-bus" and "simple-pm-bus"...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

