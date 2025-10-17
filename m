Return-Path: <linux-acpi+bounces-17857-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56438BE6E61
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 09:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B63E835AE3F
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 07:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269F13112CB;
	Fri, 17 Oct 2025 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FyWsD4Uw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241D3112A0
	for <linux-acpi@vger.kernel.org>; Fri, 17 Oct 2025 07:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685152; cv=none; b=XjJtYuCGl8/qGtP/aK8gc7pQHm3NuHHBaoOtbgh77UQKPg172Ca7Nw9+oZFbjyFJiGuZNvDnpQDrSAwjZzKUaAyUNgwLQkU2+QcUkQpxVKuoE5yVzUBRn2BQ1R3NE43haH9/QbsgL6IP8ruCW/EzHHUm0BTWoI0MLLw7y7N+bf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685152; c=relaxed/simple;
	bh=25YUziEhf9uU4zAhrMwI7Nzd6K8Li1d73QSpIFvWNy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBlBZ6VduivYbsgPQZ5rujMOZFfAEiWI2OT5GahS9j/XtLsI324ebdo+RWFms5aBYcS6PG0OwU7ZDHrYkRMTM1UG2Q+7xeGDfgpMYD3RghqfcuXscfjTsDb5u7zNQkZdxhKXtIedFWZxG89CMV8C3hDxt8Z+o8KNYyo1+45liSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FyWsD4Uw; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-586883eb9fbso1957838e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 17 Oct 2025 00:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760685148; x=1761289948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25YUziEhf9uU4zAhrMwI7Nzd6K8Li1d73QSpIFvWNy0=;
        b=FyWsD4UwUsYXqKuj+6OHL8sM15xUnl/aRGH9KGC3WPoUXNxbmsrZ7Iqhq4UJhqkevj
         GE2OUwBSaGqqmRen3P/7lAzvmQk1ujQS2MgKFSmW0LOTtrDNNy/mvfuz+l2BBe1tqjB8
         Mk6weoPuxdW1lCUq1wDyzTAZtdaUWOS8cQscukLNPhnF5WVA0BUcgNGnJS8Mk6hSLvfb
         QdPWmaOw9xa5INbayYaoIZtZBjhOlUiC9bEkGyL5s/fRAia5z3iVth4YjQ3o4lnlt69p
         T2hIPhsvo6Q0jRU11R5LtSH8YpZoo80Lr9Wds5SFkmOITF0SLmjxWh+gczBxHHmEnhk2
         wyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760685148; x=1761289948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25YUziEhf9uU4zAhrMwI7Nzd6K8Li1d73QSpIFvWNy0=;
        b=NQcCfQvAykzDYU+RztCJd4pNQJdZo/5R/C21BI9XjUKrla0JCDSqfw1zGWCRSWNU0C
         /n2eiXn33GlgKjEY+7Bo53vLrTm8SAC+ipYA4VzMYxFNpqn7SVi9vzZDB6cAHlYwy2Z0
         dMQ2dcyS41BKrNI1sjXc/VUPziTyrOKNrJlhRC3dVd/GW/AcoZ8GbQTJlVxbbXeFPNQw
         cc8ruy86XhRl8+qS8rwqZ5uRs1aLjJRgEBKPoVHkzFI4lx3cSH0r5cKKwYKuvGlPHDqu
         kAZHTPku6oXlpV7stanItuCIHNJSjYvnL53rvT3DvniaiTXUOCP3NQmW+3uYTi42QXgZ
         5JfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoJfQYnewlfez1k/cxrMFIpuZzFYi5F5bheBudhoYNHG2GTyVpy01Pvmjyzw3rncgx7G8MNOK99aYe@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJ5LztXaCBLPFF8El7I6qwvxSrpDPgNhfBQZ221Hu/Eu0IDxO
	bbXi7jpoQuBoiuIrzjUbfKCMFXpIPZZdPNv3m09pgjUz9Jh/LRay4iTChJ9mg3eBWMFNXMWgyQR
	bI9J3QrpGvKIopxoFZxjxPRlZL42zNUO9NvbXJvcyFK1QaCxSzHcHG4Y=
X-Gm-Gg: ASbGncsEEvOnTEKXnanXb8TgQ88n4jThT4OjyWxMo4o9mPY+Ss4A3zfabkrj3cWJSsH
	WS9lVRrIyTJq/MyaH6PqjUVk7h0wNc4esFc5+MY8SmfqiyAeJ1vysph/ISKw60C0PYHR9daGJh7
	IM7SniBDkx++G0jk4/IwkldzxrMtRfKEvF9fSwzMXQfREiQ32CbxwSO1oF2wireVr2yLeZfaMRE
	thFvFwLtnaoMHbzgR4AtOV2j1KxShAWjt8ubRjjQrHcoluumyNuvJkEDE8VM+222bARjRFqQEJI
	1F3YH/OkguICxMyRTjqRejaHW1kidtlCaEnapA==
X-Google-Smtp-Source: AGHT+IFxsGx5ftXqLpFiYlA84nFq8R9lxAW0hXzt0jnPlbVMKUOA3s65BQF+cV2LW4ytM3YBAr0RQpHCOIZdAc+N9t4=
X-Received: by 2002:a05:6512:ea8:b0:591:c346:1106 with SMTP id
 2adb3069b0e04-591d84cee43mr889809e87.9.1760685148094; Fri, 17 Oct 2025
 00:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
In-Reply-To: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 17 Oct 2025 09:12:16 +0200
X-Gm-Features: AS18NWDblNzpuLCnzeXon3yTi_RZXCYBcRhb_slg09UcNYGLrahNCin0h6f8tMA
Message-ID: <CAMRc=Me=atAoPSGdTOn32rEHh3djTSVveYg0QYxYdb9yivy5YQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] reset: rework reset-gpios handling
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 3:00=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> Machine GPIO lookup is a nice, if a bit clunky, mechanism when we have
> absolutely no idea what the GPIO provider is or when it will be created.
> However in the case of reset-gpios, we not only know if the chip is
> there - we also already hold a reference to its firmware node.
>
> In this case using fwnode lookup makes more sense. However, since the
> reset provider is created dynamically, it doesn't have a corresponding
> firmware node (in this case: an OF-node). That leaves us with software
> nodes which currently cannot reference other implementations of the
> fwnode API, only other struct software_node objects. This is a needless
> limitation as it's imaginable that a dynamic auxiliary device (with a
> software node attached) would want to reference a real device with an OF
> node.
>
> This series does three things: extends the software node implementation,
> allowing its properties to reference not only static software nodes but
> also existing firmware nodes, updates the GPIO property interface to use
> the reworked swnode macros and finally makes the reset-gpio code the
> first user by converting the GPIO lookup from machine to swnode.
>
> Another user of the software node changes in the future could become the
> shared GPIO modules that's in the works in parallel[1].
>
> Merging strategy: the series is logically split into three parts: driver
> core, GPIO and reset respectively. However there are build-time
> dependencies between all three parts so I suggest the reset tree as the
> right one to take it upstream with an immutable branch provided to
> driver core and GPIO.
>
> [1] https://lore.kernel.org/all/20250924-gpio-shared-v1-0-775e7efeb1a3@li=
naro.org/
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Are there any comments on the software node part before I respin it
with Philipp's comments addressed?

Bartosz

