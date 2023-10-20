Return-Path: <linux-acpi+bounces-819-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D72A7D15E1
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 20:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B1A2825E3
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C872230C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4678520302
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 17:22:44 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986FB13E;
	Fri, 20 Oct 2023 10:22:40 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-57f137dffa5so61830eaf.1;
        Fri, 20 Oct 2023 10:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822560; x=1698427360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WExMwOi8yEvexXOlKKBpSe1onE84T9t/cK767zdHnCI=;
        b=bSDR9vzNmoK5uxNx/8K3cV6d4+2CIf1FOPrdcmW0LocSBZAlSueNa76IPmHdI3IrNb
         4ruFdYZOpyjjFiidRq4v/wkXaCV3/PGqNkk82RTpTrRt3ziCwUMWsbqBjZdwQeBWEAVD
         T1OVk22RVMBSylQJD+pnXbH8TkFDqE4dKK82zzZ56pNWn6zKTjGtsgnGR27BynnF1RXQ
         tuASOHz1p38cnrTC5yBnTsCvkSctsI5+q1SKo6XX8wCAlY52DNIn75rYoUEt/kvF5MyW
         Fi7pNWMn1I9u4kTathvK2Bwcg07viTblAEZQPU2xvjSd2iWhpOJjJQIG1CSLXUvPKHTI
         e7aA==
X-Gm-Message-State: AOJu0YzoxW3U/SaRl8ISZNqo95J3eJgha6YkkwrAMau8qqRKGBNPrJcT
	pLe3aX1h3kelrlJie4oVMrcw9Jv/XHLIGQR9xJQ=
X-Google-Smtp-Source: AGHT+IH9r9pBkMk4eODC0OIDRDLecdjQbDcsz5fF3rVx/e5d06YRe98srBD0VUQXPGsNansNseJslea96o8USjeX9rg=
X-Received: by 2002:a4a:bd84:0:b0:581:ed38:5505 with SMTP id
 k4-20020a4abd84000000b00581ed385505mr2726894oop.0.1697822559885; Fri, 20 Oct
 2023 10:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231020084732.17130-1-raag.jadav@intel.com> <20231020084732.17130-7-raag.jadav@intel.com>
In-Reply-To: <20231020084732.17130-7-raag.jadav@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Oct 2023 19:22:28 +0200
Message-ID: <CAJZ5v0g7kkFhk8tNp1PMxuKkS7jv5rp16X-jvK0kc1TO0NTwFQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] perf: qcom: use acpi_device_uid() for fetching _UID
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com, 
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org, 
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 10:48=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> =
wrote:
>
> Convert manual _UID references to use standard ACPI helpers.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/perf/qcom_l3_pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
> index 2887edb4eb0b..f16783d03db7 100644
> --- a/drivers/perf/qcom_l3_pmu.c
> +++ b/drivers/perf/qcom_l3_pmu.c
> @@ -742,8 +742,8 @@ static int qcom_l3_cache_pmu_probe(struct platform_de=
vice *pdev)
>
>         l3pmu =3D devm_kzalloc(&pdev->dev, sizeof(*l3pmu), GFP_KERNEL);
>         name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "l3cache_%s_%s",
> -                     acpi_dev_parent(acpi_dev)->pnp.unique_id,
> -                     acpi_dev->pnp.unique_id);
> +                     acpi_device_uid(acpi_dev_parent(acpi_dev)),
> +                     acpi_device_uid(acpi_dev));
>         if (!l3pmu || !name)
>                 return -ENOMEM;
>
> --

Applied as 6.7 material.

QCom perf maintainers, if you'd rather take this yourselves, please let me =
know.

Thanks!

