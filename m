Return-Path: <linux-acpi+bounces-2670-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F2D822261
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jan 2024 21:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165001F2340F
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jan 2024 20:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DA815EBC;
	Tue,  2 Jan 2024 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OcZ299Ej"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F93216400
	for <linux-acpi@vger.kernel.org>; Tue,  2 Jan 2024 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ef7c6f4cfcso28006057b3.1
        for <linux-acpi@vger.kernel.org>; Tue, 02 Jan 2024 12:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704225833; x=1704830633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfHt0I2z8mA2aMyeN1/mHDUnhoQ0xxk+YhecaMv3gUA=;
        b=OcZ299EjiRzOnCd3LOK8gfy5lUs1Ol9+Qmx9c6Jwl9KYEBYOr4E9CnPjK5F0I4TJl4
         XTGjoKpCsS1DEBPs2DuAHjXBf5vg4SlBhuQfw6ZNy9wzbLdNY/wAr8hy8BJZQtGcPhR6
         gXUG5g6vbiv5bV/J4R46ASb7M9ZsDJby1EJcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704225833; x=1704830633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfHt0I2z8mA2aMyeN1/mHDUnhoQ0xxk+YhecaMv3gUA=;
        b=dWYaj3/K+wE6bBoHpzl7z+18lsBs/zKPpIJOVqEUced9disztp9bG17+OWXwVMAa++
         6KOKzmlsZyt4L/AsMI+xSvvdg2Bb/EyF288glp6apO/dlaYQuG2OUvoGzme/85Q3weH1
         ijBc4iGiTELYPAhwAfP8JUg8hi7BlEdW2g0bewOSfEl07vMPeabH+1xk+/8lEoS0pS6d
         euRAxtMk5I7sbuIwi75tzmr//5HlXMXp+MMn2U9c4w2m9QwP++0tGFHmAHGJMijd9/f+
         5BacdS49TpE6apUpn05t5FElaoAKYgwkXv9oovON/Uc14IMXTy3qJ3MPKb1utZwUJ3Mg
         IGaA==
X-Gm-Message-State: AOJu0YxzW8neIcKcI76ADnIXT3VV/JzFmElAHjsroD4PJquSZuCIiXAm
	a69B6SWvK8iwKw4JwK1X2ddXuSTUPvk41g3FFb5OA+BxDNWa
X-Google-Smtp-Source: AGHT+IGRKv3xWw0UMhylF354QBxUKSpNWpyj75qXkn8ercPRzde9MaV8IjQVOSzWAtd6/sf5oyjojkBjKJ7RnzM0ITg=
X-Received: by 2002:a05:6902:10e:b0:dbc:efce:f34b with SMTP id
 o14-20020a056902010e00b00dbcefcef34bmr11240647ybh.29.1704225833418; Tue, 02
 Jan 2024 12:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.2.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid> <ZYxbBkimS1VIuU0a@smile.fi.intel.com>
In-Reply-To: <ZYxbBkimS1VIuU0a@smile.fi.intel.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Tue, 2 Jan 2024 13:03:42 -0700
Message-ID: <CANg-bXA12ZAd9vZFV9L2ffMmcG33ByJ-=+03aB+Rz3OMZQGCgw@mail.gmail.com>
Subject: Re: [PATCH v3 02/24] gpiolib: acpi: Modify acpi_dev_irq_wake_get_by()
 to use resource
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Raul Rangel <rrangel@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Len Brown <lenb@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Wolfram Sang <wsa@kernel.org>, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> > +                     *r = DEFINE_RES_NAMED(irq, 1, NULL, res_flags);
>
> So? The whole exercise with the first patch is to have here:
>
>                         *r = DEFINE_RES_IRQ_NAMED_FLAGS(irq, NULL, res_flags);

Thanks. I was staring at the macro changes in ioport.h for too long...

>
> > +     ret = acpi_dev_get_gpio_irq_resource(adev, name, index, &r);
> > +     return ret ?: r.start;
>
> Btw, this function requires header to include ioport.h. I'm not sure
> if it's good for ACPI. I would prefer safest approach, i.e. exporting
> this from a C code, i.e. gpiolib-acpi.c.

It actually just needs 'struct resource' declared. I removed the
dependency on ioport.h, but it may make sense to leave the definition
of 'acpi_dev_gpio_irq_get_by()' here because non ACPI based systems
need a default implementation anyway.

