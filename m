Return-Path: <linux-acpi+bounces-17228-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D88AB95CE5
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 14:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93DE2E5D25
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 12:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3932A322DAD;
	Tue, 23 Sep 2025 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/B5z0Xm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB91313D48
	for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629783; cv=none; b=DeMIqoQADGw0iCva07kFUJEoXe2L+usaE+BgTid8339Y/WDMHdd+JGmShzB2pl+Xa2rHKlKBSMxx7cAvI5F7DmPn0Z7K2pULyvsq8evQi98SrE8T2cbWEAliOtnzNDs/1M4PPsOaL1BJVhtPULjw1l8kQ9J8V+K0pw2YDrIBcfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629783; c=relaxed/simple;
	bh=onAIH1BP/hCHvY4ff9ZnzH9KjooBVNRPhLS+/jqM0V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPjUE/Ff5G+MiUZYeFuG3NKXxHTFym0rgGj+/0lVDSYdznhaASVYEZxkeMTrvq3q5wj/g0o5mnZ/QD4ohklNK11u6bLUNQNJMp+8yzZxUAa+P+kLIwnYPepkg6lM47WgMX4kwKDLRp5QlV/mOUSnyzoOnq+NRNg5yh3uFYGSAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/B5z0Xm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so7518144a12.3
        for <linux-acpi@vger.kernel.org>; Tue, 23 Sep 2025 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758629779; x=1759234579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUp5hVqBdVTJiqJx7CBSL/4eHZpd8ctRM9Gr/BWHC6Y=;
        b=L/B5z0XmYmzeYryC+z0gCepziq3AIuw9nyJRYqopexb6PBQy5N6Xq6iHWslMMw8LoM
         FuErEwGd1rWaijkZla9GzTyC+etp6u6pxyGLJPluarxI6b+AixUR7T806c9ytXq5uaOn
         kSoa7G8kTVsJW0EsWlNmvkf5K96VrnIl4GM8Rvrx8Wju8sttVUoPq8U9e34bl+yWQlAr
         q56mq8OAM34hT9SdPjdjN//tywh3mVMZOyGx+p2rZJVZ3USpaOsno9nDGU4sEkT6HdUX
         bzqX7GPL0lckmz+4Yy7ZBvF9hyGfGdPUMQMnSFVOou3knTZKeB1AlZoO5WvnjzJNorsS
         ycgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758629779; x=1759234579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUp5hVqBdVTJiqJx7CBSL/4eHZpd8ctRM9Gr/BWHC6Y=;
        b=bZ4VBaU2XwP+WdYN/dl/Ul+mz6ADkvebBq5PfLVppF6eeLnWv2QGSJICPdguKJRtFB
         xt4Yqlr/cvyeHCGldNIqjOpI/gYgVuWajBsRc12yvm/sZmXlPShilXyBqIfsp8P73d/e
         KvxC5CiQ9T0noqVvqwJaucCiMmAG73/ZK1CbsbI+0WuanrtLQcIkwkJyq/nDWzgyOpIQ
         1Yz/QV3ESI3E53ZJPHt5du1aW9MnDvu5SIDdTSy62r9vzyfjhwyNgDXNd4EuDkYVhxAF
         RcMybeijxO7NJXVeToGtvtJIAF1fS4nLNdsx2da/d3Yc5DC65F8zDn1Gyc9qsjkWvgXf
         5GpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyfTonYuANW9/5qytlHpv89d9M+77UeXH9o3ZUYtLQW7CyIZIyp4nbJmjDX1zU+954FtE8/LWKYf5D@vger.kernel.org
X-Gm-Message-State: AOJu0YycR0JkcuaYEBzMl0V/k+txjLUIKIQl0KehvuSwMItRWfxtxjUF
	X3KcYRTsm8n92If0BIbR4PJ2ahxEve3SnKup2TC5+amWJPQPh+xJolW226HMu5JZhXpirJuWVP5
	+jxzuqpifkQl7RAhrXDAx40wR0F+fKYpG1gri3U3m
X-Gm-Gg: ASbGnctNf3+hnLo39DZImIoV122ZepSiuq1xxRFM90E6Q4SkZq3o3oJjo6RccgsW6Xk
	O1oj0R2sE8AukVs87OUUMCJC37r+NJUsrJob14tS8ZpsChHaLAOXoIscRluuSciD2IQNCwwdRqg
	P7+jV4Pl8tpTsOHztDTFRG80tcD45us/COowHexiWgI6zo8EyhTU1zAy63+Si4XFjveNX3q+hzz
	XxtQx6YoETNvHg=
X-Google-Smtp-Source: AGHT+IEveYyZj5MyEVZQFYuTxHsz+ZNZHMmKqbmjzAUXJV1eHNokfwX3dejDcheTKNf1w0LWCArwX6JcEyNECgzztK0=
X-Received: by 2002:a05:6402:44c5:b0:62f:67bb:d399 with SMTP id
 4fb4d7f45d1cf-63467821ef0mr1635778a12.29.1758629779214; Tue, 23 Sep 2025
 05:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917120719.2390847-1-srosek@google.com> <20250917120719.2390847-2-srosek@google.com>
In-Reply-To: <20250917120719.2390847-2-srosek@google.com>
From: =?UTF-8?Q?S=C5=82awomir_Rosek?= <srosek@google.com>
Date: Tue, 23 Sep 2025 14:16:08 +0200
X-Gm-Features: AS18NWDjTSTwRkbeN9yfpQFAD42r3vE_yfc3SX-fB05uAP2BGFyAB0dWxsKkdng
Message-ID: <CAF3aWvHStokULYuGj9rZ4v9dESTxWYtzrx5H6FDP1kdjzfbjYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] ACPI: DPTF: Ignore SoC DTS thermal while scanning
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, AceLan Kao <acelan.kao@canonical.com>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Hans de Goede <hansg@kernel.org>, 
	Alex Hung <alexhung@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael

On Wed, Sep 17, 2025 at 2:07=E2=80=AFPM Slawomir Rosek <srosek@google.com> =
wrote:
>
> The Intel SoC DTS thermal driver on Baytrail platform uses IRQ 86 for
> critical overheating notification. The IRQ 86 is described in the _CRS
> control method of INT3401 device, thus Intel SoC DTS thermal driver
> requires INT3401 device to be enumerated.
>
> Since dependency on INT3401 device is unrelated to DPTF the IS_ENABLE()
> macro is removed from ACPI DPTF INT340X scan handler, instead Kconfig
> is updated to ensure proper enumeration of INT3401 device.
>
> Fixes: 014d9d5d0cc1 ("ACPI/int340x_thermal: enumerate INT3401 for Intel S=
oC DTS thermal driver")
> Signed-off-by: Slawomir Rosek <srosek@google.com>
> ---
>  drivers/acpi/dptf/int340x_thermal.c | 7 +------
>  drivers/thermal/intel/Kconfig       | 1 +
>  2 files changed, 2 insertions(+), 6 deletions(-)
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
> index e0268fac7093..47950859b790 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -45,6 +45,7 @@ config INTEL_SOC_DTS_IOSF_CORE
>  config INTEL_SOC_DTS_THERMAL
>         tristate "Intel SoCs DTS thermal driver"
>         depends on X86 && PCI && ACPI
> +       select INT340X_THERMAL

This selection does not meet INT340X_THERMAL requirements so
kernel tests are failing for randomly generated i386 config
https://lore.kernel.org/all/202509181359.fLTuROj6-lkp@intel.com/
I am considering two options:

1) Align SoC DTS thermal driver dependencies to match INT340X.
Currently X86_64 and NET are missing. This is quite simple fix
but after that enabling a SoC DTS thermal won't be possible
for i386. From the other hand the driver requires ATOM Silvermont
https://elixir.bootlin.com/linux/v6.17-rc7/source/drivers/thermal/intel/int=
el_soc_dts_thermal.c#L39
which is a 64bit architecture, so I am not sure if support
for i386 is really required.

2) Don't select INT340X driver (the original patch does not)
and use acpi_walk_namespace to enumerate INT3401 on the platform
bus just before intel_soc_dts_iosf_init is called
https://elixir.bootlin.com/linux/v6.17-rc7/source/drivers/thermal/intel/int=
el_soc_dts_thermal.c#L54
The code would be cleaned up later with next version of patch 5/6
and direct call to acpi_walk_namespace would be replaced with
dedicated function exported by acpi platform core. Eventually,
after the the last patch, there would be two drivers enumerating
INT3401 which shouldn't be an issue since the acpi_walk_namespace
uses global mutex while traversing the acpi device tree

Please let me know your comment so I can prepare the next version.

Thanks, Regards,
Slawek

>         select INTEL_SOC_DTS_IOSF_CORE
>         help
>           Enable this to register Intel SoCs (e.g. Bay Trail) platform di=
gital
> --
> 2.51.0.384.g4c02a37b29-goog
>

