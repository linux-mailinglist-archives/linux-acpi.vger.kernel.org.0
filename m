Return-Path: <linux-acpi+bounces-18165-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B73C03202
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 21:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837E319C5123
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 19:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98AF34B407;
	Thu, 23 Oct 2025 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBxltq1H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C329A322
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246207; cv=none; b=Vy58ArLlEdjR4QGFSM/y0xaYHWK1fPPlxW3MIP5TRJjwZcI1xRjnnaSOYMw/QEVnDZtdwLcgFbNBTpIH+fl2LPXx21+ere76JUVptk/ExtlCV/uqX7LB8BgBbNLVlmWi+BMZRbAlGvhIzVzEX10qd9t+4frxFjZ/azWRAIQu8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246207; c=relaxed/simple;
	bh=jF4QxaOOV7BenJ0JZ6Ow6uSb2fxSAcL6IJ/z1Z5H/lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHv8x9WmEVelGShoKmIbSUO55Ano4hg3ws1rU6fzOZhz1CO8HESXlftPHgmTGVd0mgEHQ43f86C5CwqyZFVDKa2xbfchf7cbEmpAsoErs2ZgMHiVkJnOSPk6CmFlHl1fmNo5cm2sP9Cz0SR4YjaKM79bSGn10+3bPPOWFPSKzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBxltq1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E1DC4CEFD
	for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761246207;
	bh=jF4QxaOOV7BenJ0JZ6Ow6uSb2fxSAcL6IJ/z1Z5H/lM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PBxltq1HSz7wGLkbSNpYCnm0mC9Ys8TzbXORIPbxotWACCgL9Xfj5hl+r/qHyV2ig
	 4lnjDlB4/UtYaHs5D81RCJf+GnBmCn6F9SQV+HQ6rbtjDRM+AFVhjzojC9k8FzZMkX
	 M+tXVAQ4btTv5M+QV5SfnVbZwgNCWjqOjHP7a2h8Fn+86/DzQzI/tJhWH69cj3XbLK
	 5Bdqqu6VIWfcfrJf6igaZLFVlM7XWuz1iBQiUAvu6Per2ifGtaze4casXprsbZyFI1
	 iTKWb+cgjbabU9AmJurjMLDLWC5Na0If8sPg5SGk2Lhr6mux74uJmYAbMPpeISVZ2G
	 ZRZmZ+/OlXZEA==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-43fb60c5f75so270383b6e.1
        for <linux-acpi@vger.kernel.org>; Thu, 23 Oct 2025 12:03:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGUWkIKOdY8LK91KfHw3s9qARPgXf5LhU7maqni7QFH+vSFErQwq2u9PI6WmQ5+Q108v5tN6Ihm3A+@vger.kernel.org
X-Gm-Message-State: AOJu0YxfefTPC2I1/zJXgkuaPIiiprLuoBSgtTXs+xQHZd2WLjuUCLuf
	67lekz++AagRPKhr6uvDJ2li270vllj62DdmlkG5fgPEWXkfPd3QOaiPAMNESSwbLz6zZyudbqj
	aHOnaxxUVMyv4GW15DPcy8ZK/JkH1O4A=
X-Google-Smtp-Source: AGHT+IEPRBHAjsdcilrTqwwguunsLPHTYuaz5DDb0+ikA4JiSTezczQo7UoF0rcuBIerbAUkyM7gTcWYeF4lZqFVkW8=
X-Received: by 2002:a05:6808:4f50:b0:43f:b3e0:7959 with SMTP id
 5614622812f47-443a30139b7mr11630703b6e.49.1761246206614; Thu, 23 Oct 2025
 12:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007234149.2769-1-W_Armin@gmx.de> <20251007234149.2769-4-W_Armin@gmx.de>
In-Reply-To: <20251007234149.2769-4-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 21:03:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hA3eqJEmr=TCdRTQXybdpudLc31Xfre7ea72aHgzpXbw@mail.gmail.com>
X-Gm-Features: AS18NWAa4GfxmMauVB78Bvpyahe4TIiqnrwsgYvENjy10G0GKjOiJqhjR95cR9k
Message-ID: <CAJZ5v0hA3eqJEmr=TCdRTQXybdpudLc31Xfre7ea72aHgzpXbw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ACPI: fan: Use platform device for devres-related actions
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 1:42=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Device-managed resources are cleaned up when the driver unbinds from
> the underlying device. In our case this is the platform device as this
> driver is a platform driver. Registering device-managed resources on
> the associated ACPI device will thus result in a resource leak when
> this driver unbinds.
>
> Ensure that any device-managed resources are only registered on the
> platform device to ensure that they are cleaned up during removal.
>
> Fixes: 35c50d853adc ("ACPI: fan: Add hwmon support")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/fan.h       | 4 ++--
>  drivers/acpi/fan_core.c  | 2 +-
>  drivers/acpi/fan_hwmon.c | 8 ++++----
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index 022bc215cdbc..0d73433c3889 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -98,9 +98,9 @@ int acpi_fan_create_attributes(struct acpi_device *devi=
ce);
>  void acpi_fan_delete_attributes(struct acpi_device *device);
>
>  #if IS_REACHABLE(CONFIG_HWMON)
> -int devm_acpi_fan_create_hwmon(struct acpi_device *device);
> +int devm_acpi_fan_create_hwmon(struct device *dev);
>  #else
> -static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device)=
 { return 0; };
> +static inline int devm_acpi_fan_create_hwmon(struct device *dev) { retur=
n 0; };
>  #endif
>
>  #endif
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index ea2c646c470c..46e7fe7a506d 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -347,7 +347,7 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
>         }
>
>         if (fan->has_fst) {
> -               result =3D devm_acpi_fan_create_hwmon(device);
> +               result =3D devm_acpi_fan_create_hwmon(&pdev->dev);
>                 if (result)
>                         return result;
>
> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> index 5581aa6fdfa0..47a02ef5a606 100644
> --- a/drivers/acpi/fan_hwmon.c
> +++ b/drivers/acpi/fan_hwmon.c
> @@ -162,12 +162,12 @@ static const struct hwmon_chip_info acpi_fan_hwmon_=
chip_info =3D {
>         .info =3D acpi_fan_hwmon_info,
>  };
>
> -int devm_acpi_fan_create_hwmon(struct acpi_device *device)
> +int devm_acpi_fan_create_hwmon(struct device *dev)
>  {
> -       struct acpi_fan *fan =3D acpi_driver_data(device);
> +       struct acpi_fan *fan =3D dev_get_drvdata(dev);
>         struct device *hdev;
>
> -       hdev =3D devm_hwmon_device_register_with_info(&device->dev, "acpi=
_fan", fan,
> -                                                   &acpi_fan_hwmon_chip_=
info, NULL);
> +       hdev =3D devm_hwmon_device_register_with_info(dev, "acpi_fan", fa=
n, &acpi_fan_hwmon_chip_info,
> +                                                   NULL);
>         return PTR_ERR_OR_ZERO(hdev);
>  }
> --

Applied as 6.18-rc material, thanks!

