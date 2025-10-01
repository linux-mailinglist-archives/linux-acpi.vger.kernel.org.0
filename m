Return-Path: <linux-acpi+bounces-17487-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342DEBB19B0
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 21:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59E02A7A1A
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 19:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2A724EF76;
	Wed,  1 Oct 2025 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8anHiVL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626B1DF97C
	for <linux-acpi@vger.kernel.org>; Wed,  1 Oct 2025 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347203; cv=none; b=aMfAdvKO5ZSbe9HwZ3BfJfxOWeP75o2Jt1bZ2/suZRYGuYtq/8/oM+8PUeJLmwdc9rHh4yaTPTGqlYfQtt6IX+G0Sm8pgaPKn7GgVczCiqO619VHxNJmBUFeY5eRw4a6+9ObMVpIztgirlY3zcNiQ7n4AX5oMHXzLn78+w7X2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347203; c=relaxed/simple;
	bh=pcmTjHEZBX8fcLEcUvi2ZcYt2991FZW3Fd5xDq5NUoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJtNf+Gnod6Fza9m3xNWAEOgKiKF1e2Ih+sIqYKKqiAfX8VEx34fc28w8whDM1iGAwVhX4rXJnOkRqlRQNDGBNG8OP0KtCuJ7UMCrFoqbyQtGqof5+KYAIomdUpSOXNMYurov7D2d2UUi7pRW6lImSwVuBOnxEpzK+TSCwchgaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8anHiVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C67C4CEF1
	for <linux-acpi@vger.kernel.org>; Wed,  1 Oct 2025 19:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759347203;
	bh=pcmTjHEZBX8fcLEcUvi2ZcYt2991FZW3Fd5xDq5NUoY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C8anHiVLG+bRcxEBlsWnJMQ6on2YkXCWleaKNxnRg2t9zssUgk5gIVI+x7KkPiUX6
	 A9l4Q4UNfa0+ecPvUhYliAzZnJCF+eTUHkLTeugKdLd9VDidDHpJNQGI7ZwX9qQAD5
	 es02EqJy+6nz7Ik7VScOZ8/BuUD9i/2iWMYwAQq342iAujI5lm0oA8hH8p1HcRFSHc
	 8FJxeQ4iCI89TmVt4jLxgzSytF/hhRnH2uydTeeqd4gEqr9GdCuz2y4WOet9zaXPIH
	 KDwctwPBV3ApKfE4tpmVK3yzXkN/J144Rv2MQVNINf5Qrj5xtykjstP4oSn5h1HECU
	 2lQ8mpPYxgRrQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-621b965a114so102059eaf.1
        for <linux-acpi@vger.kernel.org>; Wed, 01 Oct 2025 12:33:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVM18qen2PuF3SVJXRuoa4RcWzfSCim2sWF2IgzfT5zGdbPQjd/fVB68Nz6Qrr7bQyDRlvF8uinnCBI@vger.kernel.org
X-Gm-Message-State: AOJu0YyBf053aMwWTdlKdGZx7uBKU69dYJ6DjAy1H/pii1UVU5yJ2gEV
	Np9sRnErv9XbjwU5xj5JLEdvAITpl3nTVrvIifpW7Qa8m32CW9vxVE7Vs5nyvdwoxYQur7Dq1AQ
	TtQbDs3QnYSvEZmPUb+NADKUGHYfnsXo=
X-Google-Smtp-Source: AGHT+IGTZl9glwlZZ3zZMBlAPNdxo6duyuaFSx2GsTebbU3ia5HEgvSrVWBKJYE/hyGDJFSUuJ46DxT9ykDzZXiMBu4=
X-Received: by 2002:a05:6820:2385:b0:63f:61c3:7e7f with SMTP id
 006d021491bc7-64bc0a2da77mr2168217eaf.8.1759347202443; Wed, 01 Oct 2025
 12:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917120719.2390847-1-srosek@google.com> <20250917120719.2390847-2-srosek@google.com>
 <CAF3aWvHStokULYuGj9rZ4v9dESTxWYtzrx5H6FDP1kdjzfbjYw@mail.gmail.com>
In-Reply-To: <CAF3aWvHStokULYuGj9rZ4v9dESTxWYtzrx5H6FDP1kdjzfbjYw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Oct 2025 21:33:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hCZ0FqS7ehm_Y21=q73CcOxYmYz0z-JRk2t_96HQ+TZQ@mail.gmail.com>
X-Gm-Features: AS18NWB19ZO7VwJor5b_v9eillelUaEMgA6qNT5UWj3HIaGiJdQctMKxgUN3BnE
Message-ID: <CAJZ5v0hCZ0FqS7ehm_Y21=q73CcOxYmYz0z-JRk2t_96HQ+TZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] ACPI: DPTF: Ignore SoC DTS thermal while scanning
To: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	AceLan Kao <acelan.kao@canonical.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the delay.

On Tue, Sep 23, 2025 at 2:16=E2=80=AFPM S=C5=82awomir Rosek <srosek@google.=
com> wrote:
>
> Hi Rafael
>
> On Wed, Sep 17, 2025 at 2:07=E2=80=AFPM Slawomir Rosek <srosek@google.com=
> wrote:
> >
> > The Intel SoC DTS thermal driver on Baytrail platform uses IRQ 86 for
> > critical overheating notification. The IRQ 86 is described in the _CRS
> > control method of INT3401 device, thus Intel SoC DTS thermal driver
> > requires INT3401 device to be enumerated.
> >
> > Since dependency on INT3401 device is unrelated to DPTF the IS_ENABLE()
> > macro is removed from ACPI DPTF INT340X scan handler, instead Kconfig
> > is updated to ensure proper enumeration of INT3401 device.
> >
> > Fixes: 014d9d5d0cc1 ("ACPI/int340x_thermal: enumerate INT3401 for Intel=
 SoC DTS thermal driver")
> > Signed-off-by: Slawomir Rosek <srosek@google.com>
> > ---
> >  drivers/acpi/dptf/int340x_thermal.c | 7 +------
> >  drivers/thermal/intel/Kconfig       | 1 +
> >  2 files changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/in=
t340x_thermal.c
> > index a222df059a16..947fe50c2ef6 100644
> > --- a/drivers/acpi/dptf/int340x_thermal.c
> > +++ b/drivers/acpi/dptf/int340x_thermal.c
> > @@ -11,10 +11,9 @@
> >
> >  #include "../internal.h"
> >
> > -#define INT3401_DEVICE 0X01
> >  static const struct acpi_device_id int340x_thermal_device_ids[] =3D {
> >         {"INT3400"},
> > -       {"INT3401", INT3401_DEVICE},
> > +       {"INT3401"},
> >         {"INT3402"},
> >         {"INT3403"},
> >         {"INT3404"},
> > @@ -76,10 +75,6 @@ static int int340x_thermal_handler_attach(struct acp=
i_device *adev,
> >  {
> >         if (IS_ENABLED(CONFIG_INT340X_THERMAL))
> >                 acpi_create_platform_device(adev, NULL);
> > -       /* Intel SoC DTS thermal driver needs INT3401 to set IRQ descri=
ptor */
> > -       else if (IS_ENABLED(CONFIG_INTEL_SOC_DTS_THERMAL) &&
> > -                id->driver_data =3D=3D INT3401_DEVICE)
> > -               acpi_create_platform_device(adev, NULL);
> >         return 1;
> >  }
> >
> > diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kcon=
fig
> > index e0268fac7093..47950859b790 100644
> > --- a/drivers/thermal/intel/Kconfig
> > +++ b/drivers/thermal/intel/Kconfig
> > @@ -45,6 +45,7 @@ config INTEL_SOC_DTS_IOSF_CORE
> >  config INTEL_SOC_DTS_THERMAL
> >         tristate "Intel SoCs DTS thermal driver"
> >         depends on X86 && PCI && ACPI
> > +       select INT340X_THERMAL
>
> This selection does not meet INT340X_THERMAL requirements so
> kernel tests are failing for randomly generated i386 config
> https://lore.kernel.org/all/202509181359.fLTuROj6-lkp@intel.com/
> I am considering two options:
>
> 1) Align SoC DTS thermal driver dependencies to match INT340X.
> Currently X86_64 and NET are missing. This is quite simple fix
> but after that enabling a SoC DTS thermal won't be possible
> for i386. From the other hand the driver requires ATOM Silvermont
> https://elixir.bootlin.com/linux/v6.17-rc7/source/drivers/thermal/intel/i=
ntel_soc_dts_thermal.c#L39
> which is a 64bit architecture, so I am not sure if support
> for i386 is really required.

I wouldn't worry about this.  I'd just make SoC DTS thermal explicitly
depend on X86_64.

> 2) Don't select INT340X driver (the original patch does not)
> and use acpi_walk_namespace to enumerate INT3401 on the platform
> bus just before intel_soc_dts_iosf_init is called
> https://elixir.bootlin.com/linux/v6.17-rc7/source/drivers/thermal/intel/i=
ntel_soc_dts_thermal.c#L54

I'm not a big fan of using acpi_walk_namespace() for such things.

Those namespace walks usually end up being quite expensive.

> The code would be cleaned up later with next version of patch 5/6
> and direct call to acpi_walk_namespace would be replaced with
> dedicated function exported by acpi platform core. Eventually,
> after the the last patch, there would be two drivers enumerating
> INT3401 which shouldn't be an issue since the acpi_walk_namespace
> uses global mutex while traversing the acpi device tree

Well, this doesn't sound really straightforward.

> Please let me know your comment so I can prepare the next version.

I'd go for option 1).

Thanks!

