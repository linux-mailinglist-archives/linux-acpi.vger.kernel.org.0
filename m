Return-Path: <linux-acpi+bounces-17208-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC67EB92754
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 19:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653692A1211
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51509315D25;
	Mon, 22 Sep 2025 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+nVwbB0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C3313D72
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562711; cv=none; b=fehBtkKPTwtc/5/cRwWO+EOlPKOHYO3+nFL1DESv6W+3ko2zszpcY5dw8tp4cD9OomApJoClB1tYwFq/YXClLz8hEJuqv0Y6HRluD48KH1Rl5yZ7c8WVCSzOaOL44xXT24nw1G6phsMn53FE/39avoR3rtggVV+yj9helwOk4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562711; c=relaxed/simple;
	bh=eU0Qi2CGcTFYUF4HkWtlFQv9q6YwGrMPF6VOALGnCQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pk9oGJVeiGtOoc1uMPjUZLFnX5xmsPxDpXRo/8QKSMgB1BKx9oUos4EgVCtGTIiNRryeWDnRmmInr0UL3l8eL2gaHlRM0V7iu45GOEvN214jDHB5cs19OGdghCA4vrB/700aFjjJYrWUXHzacEwlluJS+gfJEnR1f4H87zEaW8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+nVwbB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A789FC116C6
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758562710;
	bh=eU0Qi2CGcTFYUF4HkWtlFQv9q6YwGrMPF6VOALGnCQ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c+nVwbB0wM1Y+tcE+4kTfiRtZxGQ5LidHiU4DznXbd1GtWJfvJ9JQ8MjFmdPzqjut
	 qlc5PcL4SBFqeF6xgOQ3Z9JYVZgG7xcPL06nZMqbp4FmHAR866MHqbCZmCHZj5DMqg
	 1kN/HfeHt8b0KAxeq2kbW3fBg+g+yieghoiel9ILbjExzI/S+vf1NiepXPu8pVPukE
	 Xd0Ow7Pgj7+5KLJhNCKBqFUvTl4DmxK2oBRwmO8z+0J6DLAxDs2c39/RHsB2gm5zIK
	 YSxBDLJV5ScFxs+MNNoiWIsFDOJeYI6nxqVkzapQq9AmT2jLoBqhZf87LyPfFj6Lxx
	 8TAfiGwrhCp6g==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-631a5958ddbso206982eaf.2
        for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 10:38:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxSIsfnd8zjePMrjqRYE8MysYsA4LpJeyaNbEBUm0R6Cf/ajgkwLtwHRH3fwtscHh+EX+uxFdL/cn1@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHff14l+l8lmSSS/eJnMsoCDa2DRi00/S/1NIoP+leq2wNYRT
	22ALRPz7C9LCx9UugJMox5SegFd8kZo33cx5HvbGJK2/wJHtvcx5sD9+7On5Uz32JyWWpTAbJQF
	sldvJWabHLWgP/t4fEdSgIy1avMEFxFg=
X-Google-Smtp-Source: AGHT+IHV8cxuy9k/9N7RcLszKXs9o+2mQp6Yq49waAg/Mhc6x9R9wm6g/wkI/0I98/zEQpcH3t/csIJgb08H6E9dSVs=
X-Received: by 2002:a05:6808:1814:b0:438:8ad:16bb with SMTP id
 5614622812f47-43d6c2476b0mr5907174b6e.28.1758562709955; Mon, 22 Sep 2025
 10:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922070354.485296-1-lihuisong@huawei.com> <20250922070354.485296-2-lihuisong@huawei.com>
In-Reply-To: <20250922070354.485296-2-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Sep 2025 19:38:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gWSRE1WX0GTVqHhpDZW8ZaWpviuQ+zEyS4E6ne4rutLQ@mail.gmail.com>
X-Gm-Features: AS18NWDJFw4P-xoaY_5kyOWubWW-AtUuyTgvwJbUIiLXXTIp3LEQgQ5T_5eOJJw
Message-ID: <CAJZ5v0gWSRE1WX0GTVqHhpDZW8ZaWpviuQ+zEyS4E6ne4rutLQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] ACPI: processor: Do not expose the global
 acpi_idle_driver variable
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 9:04=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> Currently, processor_driver just use the global acpi_idle_driver variable
> to check if the cpuidle driver is acpi_idle_driver. Actually, there is no
> need to expose this global variable defined in processor_idle.c to outsid=
e.
> So move the related check to acpi_processor_power_init() and limit the
> global variable to a static one.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_driver.c |  3 +--
>  drivers/acpi/processor_idle.c   | 12 +++++++++++-
>  include/acpi/processor.h        |  1 -
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dri=
ver.c
> index de17c1412678..5d824435b26b 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -166,8 +166,7 @@ static int __acpi_processor_start(struct acpi_device =
*device)
>         if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
>                 dev_dbg(&device->dev, "CPPC data invalid or not present\n=
");
>
> -       if (cpuidle_get_driver() =3D=3D &acpi_idle_driver)
> -               acpi_processor_power_init(pr);
> +       acpi_processor_power_init(pr);
>
>         acpi_pss_perf_init(pr);
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 698d14c19587..42948495f4f1 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -51,7 +51,7 @@ module_param(latency_factor, uint, 0644);
>
>  static DEFINE_PER_CPU(struct cpuidle_device *, acpi_cpuidle_device);
>
> -struct cpuidle_driver acpi_idle_driver =3D {
> +static struct cpuidle_driver acpi_idle_driver =3D {
>         .name =3D         "acpi_idle",
>         .owner =3D        THIS_MODULE,
>  };
> @@ -1402,8 +1402,18 @@ void acpi_processor_unregister_idle_driver(void)
>
>  void acpi_processor_power_init(struct acpi_processor *pr)
>  {
> +       struct cpuidle_driver *drv =3D cpuidle_get_driver();

This variable is not needed any more.

>         struct cpuidle_device *dev;
>
> +       /*
> +        * Normally, the ACPI idle driver has already been registered bef=
ore
> +        * CPU online. But the 'drv' may be NULL if register idle driver =
failed.
> +        * So do not anything if the idle driver isn't acpi_idle_driver o=
r the
> +        * 'drv' is NULL.

And this comment can be much shorter, maybe something like "The code
below only works if acpi_idle_driver is the current cpuidle driver."

> +        */
> +       if (drv !=3D &acpi_idle_driver)
> +               return;
> +
>         if (disabled_by_idle_boot_param())
>                 return;
>
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 24fdaa3c2899..7146a8e9e9c2 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -417,7 +417,6 @@ static inline void acpi_processor_throttling_init(voi=
d) {}
>  #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
>
>  /* in processor_idle.c */
> -extern struct cpuidle_driver acpi_idle_driver;
>  #ifdef CONFIG_ACPI_PROCESSOR_IDLE
>  void acpi_processor_power_init(struct acpi_processor *pr);
>  void acpi_processor_power_exit(struct acpi_processor *pr);
> --
> 2.33.0
>

