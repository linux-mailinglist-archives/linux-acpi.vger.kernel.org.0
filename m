Return-Path: <linux-acpi+bounces-375-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765227B6BC5
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 16:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 28FF6281725
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1100E31A82
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 14:35:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF27266AD
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 13:42:42 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F44A9;
	Tue,  3 Oct 2023 06:42:40 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ae18567f42so41423b6e.1;
        Tue, 03 Oct 2023 06:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696340559; x=1696945359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyIKspFtMayiapsJ86xU9pdBx1KfreD3J7SC3GNfXTs=;
        b=mdC0bvp7n8soKi8VbYUpv8yiiht5UEWMnABrn6zjV7tvuEJcydYNE4nDebKHgRfkMw
         6JWMZgNVgF6/RO+CQvvtuxelOBaP1YAcFxsmyYezjoMgmEfxKHgHrNEXMaqCILZK1kSE
         943uyXe0za36TzfsiX7cybafvl8cQcfLaCOgGTJ77tdDKEO5VAHmkMnQqfRC+xc08Ee8
         neCMatpyUmF+0+BDxelpK2meHe/OCUbDl7dBLLBdLYN9kOs9FibDDGNR5CbFboRA5iwx
         QN/6s9C8aeKvVtwnTY4NjDhidgbWuwANQijBq0u4ygDIEjyYRYLry3cE16vqkjM29dIg
         c8zQ==
X-Gm-Message-State: AOJu0Yy6AAx1F+feBSwwRI4uFJAcYJTG7f2+yoALgFxw9pkc7r+RwLdp
	js6tOWgLb+GtsRZmymxRMIJL3G1eNi4Jcim7RjM=
X-Google-Smtp-Source: AGHT+IEb8HKbgTJqu07uIJK3FIYlGeaYFo8/xLcyGluWrdgFuwsCMImV5NGlgZocEv1orRPT2/9RZdkdGsNfQWu2j5g=
X-Received: by 2002:a05:6808:1997:b0:3af:6453:2d83 with SMTP id
 bj23-20020a056808199700b003af64532d83mr17907420oib.2.1696340559567; Tue, 03
 Oct 2023 06:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003082233.30118-1-raag.jadav@intel.com>
In-Reply-To: <20231003082233.30118-1-raag.jadav@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 15:42:28 +0200
Message-ID: <CAJZ5v0ieF8RJu9Fr7QvbuAnXtswDQ49God=cofa3tFBPygXtbQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: LPSS: drop BayTrail and Lynxpoint pinctrl HIDs
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, linus.walleij@linaro.org, 
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mallikarjunappa.sangannavar@intel.com, 
	bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 10:22=E2=80=AFAM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> Platform devices are now created by ACPI core on device enumeration
> on acpi_bus_scan() -> acpi_bus_attach() path after commit 48459340b92b
> ("ACPI / scan: use platform bus type by default for _HID enumeration").
> No need to create them from LPSS unless we explicitly need to set
> acpi_lpss_pm_domain for them.
>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpss.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 539e700de4d2..d54cd42c1280 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -368,7 +368,6 @@ static const struct acpi_device_id acpi_lpss_device_i=
ds[] =3D {
>         { "INT33C4", LPSS_ADDR(lpt_uart_dev_desc) },
>         { "INT33C5", LPSS_ADDR(lpt_uart_dev_desc) },
>         { "INT33C6", LPSS_ADDR(lpt_sdio_dev_desc) },
> -       { "INT33C7", },
>
>         /* BayTrail LPSS devices */
>         { "80860F09", LPSS_ADDR(byt_pwm_dev_desc) },
> @@ -376,8 +375,6 @@ static const struct acpi_device_id acpi_lpss_device_i=
ds[] =3D {
>         { "80860F0E", LPSS_ADDR(byt_spi_dev_desc) },
>         { "80860F14", LPSS_ADDR(byt_sdio_dev_desc) },
>         { "80860F41", LPSS_ADDR(byt_i2c_dev_desc) },
> -       { "INT33B2", },
> -       { "INT33FC", },
>
>         /* Braswell LPSS devices */
>         { "80862286", LPSS_ADDR(lpss_dma_desc) },
> @@ -396,7 +393,6 @@ static const struct acpi_device_id acpi_lpss_device_i=
ds[] =3D {
>         { "INT3434", LPSS_ADDR(lpt_uart_dev_desc) },
>         { "INT3435", LPSS_ADDR(lpt_uart_dev_desc) },
>         { "INT3436", LPSS_ADDR(lpt_sdio_dev_desc) },
> -       { "INT3437", },
>
>         /* Wildcat Point LPSS devices */
>         { "INT3438", LPSS_ADDR(lpt_spi_dev_desc) },
> @@ -657,10 +653,9 @@ static int acpi_lpss_create_device(struct acpi_devic=
e *adev,
>         int ret;
>
>         dev_desc =3D (const struct lpss_device_desc *)id->driver_data;
> -       if (!dev_desc) {
> -               pdev =3D acpi_create_platform_device(adev, NULL);
> -               return IS_ERR_OR_NULL(pdev) ? PTR_ERR(pdev) : 1;
> -       }
> +       if (!dev_desc)
> +               return -EINVAL;
> +
>         pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
>         if (!pdata)
>                 return -ENOMEM;
> --

Applied as 6.7 material, thanks!

