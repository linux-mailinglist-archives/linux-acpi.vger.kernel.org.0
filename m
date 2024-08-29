Return-Path: <linux-acpi+bounces-7952-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B052964223
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 12:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF931C2214B
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E9718E04D;
	Thu, 29 Aug 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um8DtmAE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600E18DF9E;
	Thu, 29 Aug 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928345; cv=none; b=mAU/bDIPrzCenuEyrOSRmgJc1kZrhbHtqCtm/TdGdpbHbEGa0yOB8IIyNWEUPhtodCsuvM+LiKs7Nyj6LQ0hi8tMyY68p72Aw6pryKCMaUQIj3rCwDXcpd1ydEt6rTQRp7sUCStWZBMCzMl4E99tGvi4/KnMbDGkSJj85tH92Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928345; c=relaxed/simple;
	bh=A/QKc2MrbmwJbDL/DthXdVG+GBJuw1/3/+l7jGI5be0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlTMzH8wkh44075IBD50FgSuOi/GVMERopUieaVyUsqBZPLJ4qnbjXmPrKBGLNXTleYlIu5v8OTSFLnv7SReXjE1LUR05wUPZ89oe2oC2E+qBTNCC09KkI1u2FgUskQtFFKW9SINt3cIsC8/pzkont2SUewX13SEhuEXMKx/xGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um8DtmAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396B3C4CEC1;
	Thu, 29 Aug 2024 10:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724928345;
	bh=A/QKc2MrbmwJbDL/DthXdVG+GBJuw1/3/+l7jGI5be0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Um8DtmAESFlzw486oMqlHQ0EKsmbV0SiNoio2evtguegr/UM7Ckp0j4061ObjT9nl
	 RJZ8el9Gp3sDAcIT+5rCDpZQDBZbSDjh8U7Z7yh41ExKW8S4hBhk93hllsClx+e23H
	 LluvhL7wRlgNS1MmefbbPZTteZjPldP8waADy7bnVVhd79Pqkuvfkn/3KjnTmyzKjR
	 SKnryW4bclss3yQ6LbO2IfsYYZWbE5w/9BKlC71BGfgKIJ138KXsB3pgZaL3O7SAqX
	 jdCpg1SWIFMcoftrRjAF4J8gas6QXiNrt6HP6vXtcez3ga0qkUzuq9sacbo+Ysvezd
	 L6ptve883Vbrw==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db23a60850so275078b6e.0;
        Thu, 29 Aug 2024 03:45:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8vpZ6vfixKFHWbVMb1bZu+97kyJZs/Y6J1esZ8Xxq32xlTzJCdln2QcnmZkfEGO8bSIj437bNABdu@vger.kernel.org, AJvYcCW5512/5xXlkf+LDfzK4C7r5zlAHzlA+pTZ6bnPQisLa2WrngK4JUJyVMvADsJ2UIoU1GhM7RSHOZSpVQ==@vger.kernel.org, AJvYcCXE9TZKuvufFGRtBMWJcVsAN1U8RLGBUBlCBXrokr3arH+6oh4GhxP9pWzLlfdINdZoV7ybsi7zkB43eu36@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WvGHSaaMtT7u+uWdaAnRcIerBILah/1ZHMIhd+FyXBt6CaQr
	0TtgDEwwMuKiEXEdI4FgKb6EkXA6rEu4vHhHZyGPSMmTvfwaw2yK4OoxQNqe3u3sIiWxZ06434n
	9PPPT5jUhYK9KDoilyfW6LRt+ZRY=
X-Google-Smtp-Source: AGHT+IGMsrYYnwtpwOmbtg5dmwFYoofWlGAmRSaV8uF0Jhfe6l4Il0TpT/g6xHJdibzsNJ9IFXIGTJRMCR1hhnUQevA=
X-Received: by 2002:a05:6808:309e:b0:3db:16a3:748a with SMTP id
 5614622812f47-3df05ec405bmr2360705b6e.32.1724928344538; Thu, 29 Aug 2024
 03:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819142945.327808-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240819142945.327808-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Aug 2024 12:45:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jGxdR_0UsxgvLDfM3=GGTmB5NbtE-yK49CB8gwQ2o_ig@mail.gmail.com>
Message-ID: <CAJZ5v0jGxdR_0UsxgvLDfM3=GGTmB5NbtE-yK49CB8gwQ2o_ig@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] gpiolib: Add and utilise for_each_gpio_property_name()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 4:29=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There are a few of duplication of the same for-loop against GPIO
> suffixes. This series addresses that along with proposal to eliminate
> the exported gpio_suffix_count by converting the array to be
> NULL-terminated.
>
> v2:
> - fixed a rebase issue (LKP)

All patches in this set look good to me:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> Andy Shevchenko (5):
>   gpiolib: Introduce for_each_gpio_property_name() helper
>   gpiolib: swnode: Unify return code variable name
>   gpiolib: swnode: Introduce swnode_gpio_get_reference() helper
>   gpiolib: swnode: Make use of for_each_gpio_property_name()
>   gpiolib: Replace gpio_suffix_count with NULL-terminated array
>
>  drivers/gpio/gpiolib-acpi.c   | 21 ++----------
>  drivers/gpio/gpiolib-of.c     | 25 +++------------
>  drivers/gpio/gpiolib-swnode.c | 60 ++++++++++++++++-------------------
>  drivers/gpio/gpiolib.c        |  3 +-
>  drivers/gpio/gpiolib.h        | 16 ++++++++--
>  5 files changed, 49 insertions(+), 76 deletions(-)
>
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>
>

