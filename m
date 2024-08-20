Return-Path: <linux-acpi+bounces-7719-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E6958A4F
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 16:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256011C21B79
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F884191F90;
	Tue, 20 Aug 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgK1iQh4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A2190477;
	Tue, 20 Aug 2024 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165753; cv=none; b=fnrzFbQDA7bmSWjZJc+FztsquCLtEVAT/958OwI4QpmmppGTWRrKFbhH6jMQxh5uXArM8LCXaF4Bsuc9YWGNyGD4dPsa1MupzO9U7dlqIEwLtd2BQPmb/ixSW/OXMSPreRIFHqKAFilHdYgVB7al5lkRf2RBiPaq/MnNyOh9DJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165753; c=relaxed/simple;
	bh=0ZOu3inMv6TGg0c6P8Xpu2xNmZ613jQlAGBpZEN8z08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srw/aj9W21t1OCqdPrHL0J7sTgYr12E7jzfGyNB2LOz9u1oqjlt+CwC78nQ7On7LyS/toLVQZxgGvbPLObqix0v5aEwfaMlLF5pyPmza2NgFeQk32Xy2ar7zHvvyjR7SBca0ia0hqpKAhgOsdOhdUsAvuO8xYGQZHwwbnNGc6h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgK1iQh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DD2C4AF13;
	Tue, 20 Aug 2024 14:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724165753;
	bh=0ZOu3inMv6TGg0c6P8Xpu2xNmZ613jQlAGBpZEN8z08=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FgK1iQh4RWOwOelEdQ9jeGUfZx+WnxkwYkczIBVkqVFn+rL0ri4YWp2O6ORwfc1ea
	 CL5XwX3vt8+v1vt9XBn/xqqX5AhV/lYdYFYW/MhJV1YakNKndJoR7TAzRpelgDBMjk
	 xIb4elNsp7Zs+v2W0bs4IaEoIPXsP1iDO3HYsulZIyRhKqmvTFxmgEutE0c3dc3Ulz
	 /R2zGjFVEbGOYJlQ8VEU7kvDApqiGy0WgE7DdcXNvpK28+WdjUnFADogi1IQNJwp6T
	 es6qiLQTaBjLi2C1nJiI7pWy8bn23WbY7CIF1qccAK0hWshPl4i2ncl0NH9sSBvsTs
	 pUVuhK1V/UkXg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5d5c324267aso3280473eaf.0;
        Tue, 20 Aug 2024 07:55:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHg866YW+kMQRwYzxlduzvqYY2VnHjkJY5odGpyI6dasqtsDAABSXkJHwaaU+WGFgUkPYY5WDfuUfex3Hb@vger.kernel.org, AJvYcCVHBjMs9xkQ7xElXPsivEQqmbdKXpd0dN5ewkW31/HaZXyxfYG1w0fRjbGN6fI0EPyehkISCHEByKCe@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxcd3O/mrVBxDRoZdsR2cfC4wXTq2MfHZ2IULlwo2PgzJ0wRtN
	G0UTvrbnI5t28pLPzfEBell4dJvAL8eim/wLNNgc8pOkZw2qSLNYotIQaORkdin8sja58TZ/mD5
	6Kf1OMZEAJm50VXxygTR0hjzzWnE=
X-Google-Smtp-Source: AGHT+IERmvMStpESs9VrqArXN+cb5EeE1Fq/0gAmtGZ11naWDvaXrGCSH5qncYXRCTOyrCOPzq+Yoeo8p8V7jLtU6NI=
X-Received: by 2002:a05:6820:1a0d:b0:5c4:e8d:58be with SMTP id
 006d021491bc7-5da98896595mr14771765eaf.3.1724165752262; Tue, 20 Aug 2024
 07:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812054647.1194716-1-jiaqing.zhao@linux.intel.com> <20240812054647.1194716-2-jiaqing.zhao@linux.intel.com>
In-Reply-To: <20240812054647.1194716-2-jiaqing.zhao@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Aug 2024 16:55:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hPtvVRM=Te2oPzCvE3tOy_rXYGJwaoQOfNc71z+pmkvA@mail.gmail.com>
Message-ID: <CAJZ5v0hPtvVRM=Te2oPzCvE3tOy_rXYGJwaoQOfNc71z+pmkvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPICA: Detect FACS in reduced hardware build
To: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 7:47=E2=80=AFAM Jiaqing Zhao
<jiaqing.zhao@linux.intel.com> wrote:
>
> According to Section 5.2.10 of ACPI Specification, FACS is optional
> in reduced hardware model. Enable the detection for "Hardware-reduced
> ACPI support only" build (CONFIG_ACPI_REDUCED_HARDWARE_ONLY=3Dy) also.
>
> Link: https://github.com/acpica/acpica/commit/ee53ed6b5452612bb44af542b68=
d605f8b2b1104
> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
> ---
>  drivers/acpi/acpica/acglobal.h |  6 +-----
>  drivers/acpi/acpica/tbutils.c  |  5 +----
>  drivers/acpi/acpica/utxfinit.c | 24 ++++++++++++------------
>  include/acpi/acconfig.h        |  1 -
>  4 files changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acgloba=
l.h
> index f4c90fc99be2..309ce8efb4f6 100644
> --- a/drivers/acpi/acpica/acglobal.h
> +++ b/drivers/acpi/acpica/acglobal.h
> @@ -29,11 +29,7 @@ ACPI_INIT_GLOBAL(u32, acpi_gbl_dsdt_index, ACPI_INVALI=
D_TABLE_INDEX);
>  ACPI_INIT_GLOBAL(u32, acpi_gbl_facs_index, ACPI_INVALID_TABLE_INDEX);
>  ACPI_INIT_GLOBAL(u32, acpi_gbl_xfacs_index, ACPI_INVALID_TABLE_INDEX);
>  ACPI_INIT_GLOBAL(u32, acpi_gbl_fadt_index, ACPI_INVALID_TABLE_INDEX);
> -
> -#if (!ACPI_REDUCED_HARDWARE)
> -ACPI_GLOBAL(struct acpi_table_facs *, acpi_gbl_FACS);
> -
> -#endif                         /* !ACPI_REDUCED_HARDWARE */
> +ACPI_INIT_GLOBAL(struct acpi_table_facs *, acpi_gbl_FACS, NULL);
>
>  /* These addresses are calculated from the FADT Event Block addresses */
>
> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.=
c
> index 15fa68a5ea6e..356700349b45 100644
> --- a/drivers/acpi/acpica/tbutils.c
> +++ b/drivers/acpi/acpica/tbutils.c
> @@ -18,7 +18,6 @@ ACPI_MODULE_NAME("tbutils")
>  static acpi_physical_address
>  acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size);
>
> -#if (!ACPI_REDUCED_HARDWARE)
>  /***********************************************************************=
********
>   *
>   * FUNCTION:    acpi_tb_initialize_facs
> @@ -37,8 +36,7 @@ acpi_status acpi_tb_initialize_facs(void)
>         struct acpi_table_facs *facs;
>
>         if (acpi_gbl_FADT.Xfacs &&
> -                  (!acpi_gbl_FADT.facs
> -                   || !acpi_gbl_use32_bit_facs_addresses)) {
> +           (!acpi_gbl_FADT.facs || !acpi_gbl_use32_bit_facs_addresses)) =
{
>                 (void)acpi_get_table_by_index(acpi_gbl_xfacs_index,
>                                               ACPI_CAST_INDIRECT_PTR(stru=
ct
>                                                                      acpi=
_table_header,

I'm not sure how this change is related to the rest of the patch.

It doesn't appear to be present in the original commit pointed to by
the Link tag.

> @@ -56,7 +54,6 @@ acpi_status acpi_tb_initialize_facs(void)
>
>         return (AE_OK);
>  }
> -#endif                         /* !ACPI_REDUCED_HARDWARE */
>
>  /***********************************************************************=
********
>   *
> diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfini=
t.c
> index 1915bec2b279..70ae0afa7939 100644
> --- a/drivers/acpi/acpica/utxfinit.c
> +++ b/drivers/acpi/acpica/utxfinit.c
> @@ -120,6 +120,18 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem=
(u32 flags)
>          */
>         acpi_gbl_early_initialization =3D FALSE;
>
> +       /*
> +        * Obtain a permanent mapping for the FACS. This is required for =
the
> +        * Global Lock and the Firmware Waking Vector
> +        */
> +       if (!(flags & ACPI_NO_FACS_INIT)) {
> +               status =3D acpi_tb_initialize_facs();
> +               if (ACPI_FAILURE(status)) {
> +                       ACPI_WARNING((AE_INFO, "Could not map the FACS ta=
ble"));
> +                       return_ACPI_STATUS(status);
> +               }
> +       }
> +
>  #if (!ACPI_REDUCED_HARDWARE)
>
>         /* Enable ACPI mode */
> @@ -137,18 +149,6 @@ acpi_status ACPI_INIT_FUNCTION acpi_enable_subsystem=
(u32 flags)
>                 }
>         }
>
> -       /*
> -        * Obtain a permanent mapping for the FACS. This is required for =
the
> -        * Global Lock and the Firmware Waking Vector
> -        */
> -       if (!(flags & ACPI_NO_FACS_INIT)) {
> -               status =3D acpi_tb_initialize_facs();
> -               if (ACPI_FAILURE(status)) {
> -                       ACPI_WARNING((AE_INFO, "Could not map the FACS ta=
ble"));
> -                       return_ACPI_STATUS(status);
> -               }
> -       }
> -
>         /*
>          * Initialize ACPI Event handling (Fixed and General Purpose)
>          *
> diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
> index d768d9c568cf..2da5f4a6e814 100644
> --- a/include/acpi/acconfig.h
> +++ b/include/acpi/acconfig.h
> @@ -67,7 +67,6 @@
>   *      General Purpose Events (GPEs)
>   *      Global Lock
>   *      ACPI PM timer
> - *      FACS table (Waking vectors and Global Lock)
>   */
>  #ifndef ACPI_REDUCED_HARDWARE
>  #define ACPI_REDUCED_HARDWARE           FALSE
> --
> 2.43.0
>
>

