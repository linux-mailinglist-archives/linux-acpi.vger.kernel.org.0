Return-Path: <linux-acpi+bounces-2330-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E63B780F70B
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 20:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B17A1F21282
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Dec 2023 19:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CA96356F;
	Tue, 12 Dec 2023 19:41:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3B8AF;
	Tue, 12 Dec 2023 11:41:54 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-590a21e977aso174118eaf.1;
        Tue, 12 Dec 2023 11:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702410114; x=1703014914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vfqgrr2N4bZxxdApuCQE48QKvGsi7ju/E6qD7nQ10wE=;
        b=LJGPoeb+gs77qvnfLw2KYmXgpKfHFTm85pl0fS2MdIev1WQ56b57CNU6h8s/0zZXFg
         3jzS8BYTddMGrsrTaBX847n7H5WsT4GSXIVYMxLsYEfDy3e3ecdsxx9biD13M5v3pJka
         aLcvbI9I5RTeiIIqM0yIOy5NwhiqEpCm5QobC4TfjZah6kV+/r4sAa59spzhQhuVYlsX
         2IKieR0DM2YVqbEAJCrTS2nPqWLPhUv+wEm1z4TpXkjfpPyNNxbIPAC77lc+eKF+cudO
         9gUYz7YjYE4klcNdRv2z9PZ6zkr5D/sjTiMmextkBwuLvfqrWciTstcFLtYX2VtMklz1
         JPbg==
X-Gm-Message-State: AOJu0YzWTT4e5ZpUV72TTu6e1sxP1omszi7w2mtk7m3G3spIEnmn7DS7
	y3NGW33/YTVl8O1SmVhLm0U1w/6aMVwPKZQHvzc=
X-Google-Smtp-Source: AGHT+IFnrB2AuJl6E+EBFsgZt7vWZC6v+u054H2VGsFoCmLmva8xwPjRPX8dNT+wl2qE/DdVr1p/WLBoqPPufmakzaQ=
X-Received: by 2002:a4a:e9ae:0:b0:591:4861:6b07 with SMTP id
 t14-20020a4ae9ae000000b0059148616b07mr721743ood.0.1702410114008; Tue, 12 Dec
 2023 11:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211111430.3910049-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231211111430.3910049-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 20:41:43 +0100
Message-ID: <CAJZ5v0jzS=FhZ1EKY4tEzDrg1J-8=6QKSRjaP+jQjjVArx5-_A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: LPSS: Fix the fractional clock divider flags
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Raag Jadav <raag.jadav@intel.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Alex Vinarskis <alex.vinarskis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 12:14=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The conversion to CLK_FRAC_DIVIDER_POWER_OF_TWO_PS uses wrong flags
> in the parameters and hence miscalculates the values in the clock
> divider. Fix this by applying the flag to the proper parameter.
>
> Fixes: 82f53f9ee577 ("clk: fractional-divider: Introduce POWER_OF_TWO_PS =
flag")
> Reported-by: Alex Vinarskis <alex.vinarskis@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpss.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 79f4fc7d6871..6f454f61a432 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -453,8 +453,9 @@ static int register_device_clock(struct acpi_device *=
adev,
>                 if (!clk_name)
>                         return -ENOMEM;
>                 clk =3D clk_register_fractional_divider(NULL, clk_name, p=
arent,
> +                                                     0, prv_base, 1, 15,=
 16, 15,
>                                                       CLK_FRAC_DIVIDER_PO=
WER_OF_TWO_PS,
> -                                                     prv_base, 1, 15, 16=
, 15, 0, NULL);
> +                                                     NULL);
>                 parent =3D clk_name;
>
>                 clk_name =3D kasprintf(GFP_KERNEL, "%s-update", devname);
> --

Applied as 6.8 material, thanks!

