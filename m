Return-Path: <linux-acpi+bounces-18113-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42318BFDDD9
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 20:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19A93A2C7A
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 18:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B1F3491DA;
	Wed, 22 Oct 2025 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epRDjPKR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2723321DB
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158035; cv=none; b=SsYaIKrTjkV9M/54ZqNXmJ3ABpepiyQDHaFmW1r6pKuQxGd2neIotZFjDu5N3aN2oMlNGK9gGnATmn/sgUAjJ8XZhDqWPCDW6L8/E3oS9rKrQrxorO1Z0nQHYAIhkQzJc4nNUbFhY3S4deV5dKpOLBTNX3Z1Z4lV1zANkNPUoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158035; c=relaxed/simple;
	bh=HnMd6ESDOQPNkHtYkXXBggLVB+O/NgfKnQ0epXgTK1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnMJgOrFs+ZshPhS+F4aObxEMDAjuQ1KXo/o8JKqFZ/xxz5diejX/1tJ3jD+514DDVJMrdrPLLSu8KpCfB6LqLuacz2Bb92Y2UlJlt6UwJUtCZcuX0SbwB8ucxxKod/QBgs9cwgpjicCJ0PJmeApdfy7LDh/3/8AX2/FK0xwpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epRDjPKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B44C4CEFD
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 18:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761158035;
	bh=HnMd6ESDOQPNkHtYkXXBggLVB+O/NgfKnQ0epXgTK1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=epRDjPKRCa9BxTAl/maqOnCFs1ZYsOn5Ff45yfJ8lt1ez+NhK+IabdLZgpqlmCD/D
	 zKSPA79zjPYg5yekdsOjQ0emuKANc7+dkt8QMV1HiV2dCnWf5wt/F9TYgDgE/BzzIN
	 qMw5WfzLodb+7FVfka4Zbn2HgXDA/5cC3d275udo+xYHRvAVZLxAGQEo5zmRS354sw
	 Gf3SWH+ogk8qvUI4z3DknXeoTAamqgaPaGPSG3lBsJEpDoIs6CWOc1umdqPYaKJtRn
	 6DbXVb2OmddqGQ92VRQiEA7mnzX1I+R5lWYMmb45opBxbR2CA+FxZ5fzJfA6xd3X8R
	 ZazyqYsMwdaRw==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-443a7490a54so3554775b6e.1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 11:33:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXoBOPmHXl8pkoSxKk9FHjl8lPyesbegd2yT4DE6qiQiL7IiXsXGTKmTRqimwkZrInGMSKb//IQZZAw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7riix/tbK4JoOMRGiGrDn2yCeY28WyebZbB0sxrZiJ1McsadU
	G4N0tXqH4XtpP54KW+BQtRfHEUW4Ck+XaDre9jySeYqaVaQXexh5LFTJC0SDbtK5w4dYZRGo6zT
	ZD1C3XQsERhNkfB+I19w1hxXzCDgVKWM=
X-Google-Smtp-Source: AGHT+IH1IqVM6euAMndvLHW5UlV1j14MYMhRCeJ6OM2UaHr7gpeL9K3LN5TVDVQPxH3fDyMM2m8mNxGtYP3Yupx2W1o=
X-Received: by 2002:a05:6808:3442:b0:441:8f74:fbb with SMTP id
 5614622812f47-443a3186027mr9639045b6e.56.1761158034616; Wed, 22 Oct 2025
 11:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-2-srosek@google.com>
In-Reply-To: <20251002113404.3117429-2-srosek@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Oct 2025 20:33:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ho8MhU8jj=YMyDKdTQWZt24LjoCaoEgJRsdi3YykkBBQ@mail.gmail.com>
X-Gm-Features: AS18NWAQt62Xl-VqxhnNXIPFUkqK65I3ztD52Ptw3B2aZq-oo8JKqxO0ZlzYWTc
Message-ID: <CAJZ5v0ho8MhU8jj=YMyDKdTQWZt24LjoCaoEgJRsdi3YykkBBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] ACPI: DPTF: Ignore SoC DTS thermal while scanning
To: Slawomir Rosek <srosek@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@google.com> w=
rote:
>
> The Intel SoC DTS thermal driver on Baytrail platform uses IRQ 86 for
> critical overheating notification. The IRQ 86 is described in the _CRS
> control method of INT3401 device, thus Intel SoC DTS thermal driver
> requires INT3401 device to be enumerated.

I don't think that the specific interrupt number is relevant here.  It
would be sufficient to say something like "The IRQ used by the Intel
SoC DTS thermal device for critical overheating notification is listed
in _CRS of device INT3401 which therefore needs to be enumerated for
Intel SoC DTS thermal to work."

> Since dependency on INT3401 device is unrelated to DPTF the IS_ENABLE()
> macro is removed from ACPI DPTF INT340X scan handler, instead Kconfig
> is updated to ensure proper enumeration of INT3401 device.

It is not entirely clear what happens in this patch after reading the
above paragraph.

I would rather continue the previous thought by saying that the
enumeration happens by binding the int3401_thermal driver to the
INT3401 platform device.  Thus CONFIG_INT340X_THERMAL is in fact
necessary for enumerating it, so checking CONFIG_INTEL_SOC_DTS_THERMAL
in int340x_thermal_handler_attach() is pointless and INT340X_THERMAL
may as well be selected by INTEL_SOC_DTS_THERMAL.

> Fixes: 014d9d5d0cc1 ("ACPI/int340x_thermal: enumerate INT3401 for Intel S=
oC DTS thermal driver")

Why do you want this tag to be added?

> Signed-off-by: Slawomir Rosek <srosek@google.com>
> ---
>  drivers/acpi/dptf/int340x_thermal.c | 7 +------
>  drivers/thermal/intel/Kconfig       | 3 ++-
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int3=
40x_thermal.c
> index a222df059a16..947fe50c2ef6 100644
> --- a/drivers/acpi/dptf/int340x_thermal.c
> +++ b/drivers/acpi/dptf/int340x_thermal.c
> @@ -11,10 +11,9 @@
>
>  #include "../internal.h"
>
> -#define INT3401_DEVICE 0X01
>  static const struct acpi_device_id int340x_thermal_device_ids[] =3D {
>         {"INT3400"},
> -       {"INT3401", INT3401_DEVICE},
> +       {"INT3401"},
>         {"INT3402"},
>         {"INT3403"},
>         {"INT3404"},
> @@ -76,10 +75,6 @@ static int int340x_thermal_handler_attach(struct acpi_=
device *adev,
>  {
>         if (IS_ENABLED(CONFIG_INT340X_THERMAL))
>                 acpi_create_platform_device(adev, NULL);
> -       /* Intel SoC DTS thermal driver needs INT3401 to set IRQ descript=
or */
> -       else if (IS_ENABLED(CONFIG_INTEL_SOC_DTS_THERMAL) &&
> -                id->driver_data =3D=3D INT3401_DEVICE)
> -               acpi_create_platform_device(adev, NULL);
>         return 1;
>  }
>
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfi=
g
> index e0268fac7093..f9e275538e29 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -44,7 +44,8 @@ config INTEL_SOC_DTS_IOSF_CORE
>
>  config INTEL_SOC_DTS_THERMAL
>         tristate "Intel SoCs DTS thermal driver"
> -       depends on X86 && PCI && ACPI
> +       depends on X86_64 && PCI && ACPI

AFAICS NET needs to be added to the dependency list above or selecting
INT340X_THERMAL below may not actually cause it to be built.

> +       select INT340X_THERMAL
>         select INTEL_SOC_DTS_IOSF_CORE
>         help
>           Enable this to register Intel SoCs (e.g. Bay Trail) platform di=
gital
> --

