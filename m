Return-Path: <linux-acpi+bounces-17092-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B832B81B5C
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 22:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5203AF9E8
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 20:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0454F24501B;
	Wed, 17 Sep 2025 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdTpAbYB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E14221F29
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139331; cv=none; b=dANpYdCcsqekx0+/lMiNfGX99KwJR55RYY7K7Bf6K8JDenGuNkf7ck9B9IdxKOwafjfH77UBUscGyP/PGwpLN9Ra/NgKUdyaQBIrQEbMvFnalriFGlA1pctNYwGiHzVnHf1z85gFmdWlYWyT1VC9dhC+BuKTMVUvaHkCdzzef0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139331; c=relaxed/simple;
	bh=ZD+WSYB80u9bCZ3Wp8c9KL0x353x2PWFiso5n0IU0Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfJKEIikEV9iJrVwRVeDDgC5Eg4GkQacGokC/EHjwjvbkyvoGK11NNPMYNIIkQayDYd+1GsluJLdFo51VF76AyQpvlLaXloLCaoGp5icKJfyuTqTQNbek/dSxHQ+1Q7nZ6KNC7r7SVEvyJ05KK7vEq2NF2hVtsakamE2S78e5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdTpAbYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B2EC4CEFE
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 20:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758139331;
	bh=ZD+WSYB80u9bCZ3Wp8c9KL0x353x2PWFiso5n0IU0Q4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hdTpAbYBbTc2DfYjr6wbwkGUMhgoqSajUDCxwToNVnnkiGd9gILhCijKKCBoZOXCr
	 a56bbxnaEvmiUGfQNpyExY+xnDz5pA8hCyvLUWDyjwN+BcC/QUs8zOESjbhXLnEFFL
	 QvQfesq1JwfROv1ZgBrfVeyJl4hYglhBibj8gYtF4ywZl2D88nPAS5IiQTphPM1sQV
	 J34CkkAaW7lVrsH0pSYhX+cHPJGcir9rdlJF1mtzrGmsuXHD6fiD5nbFbnerEdMqEA
	 ATbMOliUkkJCkjg/M4n6sY3zu9fjdhZTDvtQe+5jvK1mvvWRsEKxBkMXLXTBZvkfC4
	 JOBP+eDJxRAbg==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-750e52fb2deso242791a34.1
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 13:02:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkBRVy3BOWzhkRI+/rPzA4xlP70ucTgcj+T0I+mtgR45tuiOUw/6KAUwkNzYZC5IbzBJ9a2hq1Cx3K@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/66idkKx4rvazCIf83iX886cpPMY2V3cUBJkABX8od8MJDG4
	/5e46ayCdBC5ZhoIjX0RWu2yNB1cBOsotC7ltoumMbx2IXN9z7afzZGVSLXbMeqUmHYYLSpHCB3
	WnHnJxiNrQErwtWv8TfpZ5cblP/h4nXQ=
X-Google-Smtp-Source: AGHT+IFkjpRdCh1qZfJ0OjbhoBy7zXZfCwVVILxyYRaxXLTvDJXS+PVGClzjW3osEWYZ6+pSMlQa++RQ2clAsGHLvv8=
X-Received: by 2002:a05:6808:1506:b0:43d:1eec:aea7 with SMTP id
 5614622812f47-43d50d97cd9mr1976141b6e.45.1758139330621; Wed, 17 Sep 2025
 13:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911112408.1668431-1-lihuisong@huawei.com> <20250911112408.1668431-4-lihuisong@huawei.com>
In-Reply-To: <20250911112408.1668431-4-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Sep 2025 22:01:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hb19Xy8dOP4itU-F5F7OjDXBVNGYiwoxAVc_yGuUv=Aw@mail.gmail.com>
X-Gm-Features: AS18NWDO6uTE_MfULjEl-0mdzmM-7WVvhCx7N0JciMpQ0JH1SyhFMkqRMbTjpLE
Message-ID: <CAJZ5v0hb19Xy8dOP4itU-F5F7OjDXBVNGYiwoxAVc_yGuUv=Aw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ACPI: processor: Do not expose the global
 acpi_idle_driver variable
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 1:24=E2=80=AFPM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> Currently, processor_driver just use the global acpi_idle_driver variable
> to check if the cpuidle driver is acpi_idle_driver. Actually, there is no
> need to expose this global variable defined in processor_idle.c to outsid=
e.
> So move the related logical to acpi_processor_power_init() and do not
> expose it.

And it can also be made static, can't it?

Please do that too.

> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_driver.c | 3 +--
>  drivers/acpi/processor_idle.c   | 5 +++++
>  include/acpi/processor.h        | 1 -
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dri=
ver.c
> index bc9f58a02c1d..5d824435b26b 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -166,8 +166,7 @@ static int __acpi_processor_start(struct acpi_device =
*device)
>         if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
>                 dev_dbg(&device->dev, "CPPC data invalid or not present\n=
");
>
> -       if (!cpuidle_get_driver() || cpuidle_get_driver() =3D=3D &acpi_id=
le_driver)
> -               acpi_processor_power_init(pr);
> +       acpi_processor_power_init(pr);
>
>         acpi_pss_perf_init(pr);
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 5dacf41d7cc0..967fb13f38fa 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1404,6 +1404,11 @@ int acpi_processor_power_init(struct acpi_processo=
r *pr)
>  {
>         int retval;
>         struct cpuidle_device *dev;
> +       struct cpuidle_driver *drv;
> +
> +       drv =3D cpuidle_get_driver();
> +       if (drv && drv !=3D &acpi_idle_driver)
> +               return 0;
>
>         if (disabled_by_idle_boot_param())
>                 return 0;
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 6ee4a69412de..bd96dde5eef5 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -417,7 +417,6 @@ static inline void acpi_processor_throttling_init(voi=
d) {}
>  #endif /* CONFIG_ACPI_CPU_FREQ_PSS */
>
>  /* in processor_idle.c */
> -extern struct cpuidle_driver acpi_idle_driver;
>  #ifdef CONFIG_ACPI_PROCESSOR_IDLE
>  int acpi_processor_power_init(struct acpi_processor *pr);
>  int acpi_processor_power_exit(struct acpi_processor *pr);
> --

