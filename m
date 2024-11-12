Return-Path: <linux-acpi+bounces-9509-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB52F9C629E
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 21:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844AB285118
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 20:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6979421744D;
	Tue, 12 Nov 2024 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5gbDIys"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F611FA829;
	Tue, 12 Nov 2024 20:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443511; cv=none; b=Xxsvth+39vFwT6ZUkyCSDZ6sQf4wvWp15Wt/+JHWdfGkrOwVcCVywj60JEUvzWAtYTtoM5Wg/nY+53GFDpYGdeGOt08Nzhch5PkNhAIu/rLbYFOKwP6kgrjhVsTzYhi2D6Ns7sX0OWgm+TOy9PUVVlBGcPiKZYunRc9Bml+fmi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443511; c=relaxed/simple;
	bh=Vmax3Tuvzl57cSsETLbOFeimPWCC3vGcF1gZYgUf94M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3BloNQQe0Ckoe+67oCESeBrUF8FsIZlwdgggjt5q1Y23btCHdG2lOQcDjEo6b65K0ksbGw3JvjhVmFP3iHXwWRZKrmwBtMNNERS4KIpU1sRzqx3GDcg1TgakeHqDX6HF/PRjHfciMoXkEuKIGCbIx0TIa1O/UFWkFn0A36uXHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5gbDIys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA1FC4AF09;
	Tue, 12 Nov 2024 20:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731443510;
	bh=Vmax3Tuvzl57cSsETLbOFeimPWCC3vGcF1gZYgUf94M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M5gbDIysrUsVYMkQpf9bq7RotMqJHZH6Ja21nAk/JjhzAX5XduRm0/r4YcKPZrTGa
	 QRoFpkwTrrxCU31S0keRhVJL1fPnzwnvt1KWxzwGQpDNqFwJ0hEL7mkeIkmaagPfDB
	 V9KHE9vNIIoXd+ULPI3rQ821vDBFLW6RZlDCuShD7fjormgerNsE2zoHSHnvnVRS49
	 b2d2YmNjUm5/hYI+5ww4RaI5hwaSS5lfiwkIMSqofF1STY07fNMlCuDBSHm8zXwmZR
	 QIII7nnxUwE3elAAbyXdUXVSoeBXHFxyE897uzvq4UMzPCoOA+MvVx3zp2PMNH4/bD
	 2UnXHoW4knI/A==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ee1c3dbeb9so16785eaf.1;
        Tue, 12 Nov 2024 12:31:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTqgfWqngqG6FwOQtSF5iQK2SrKgH90Cr+zfLrPqQfALgXTC8q+gsslshrO4FluNKawZTsl2v7NCKe@vger.kernel.org, AJvYcCXmSuRGbZxUHMcH9pobZn4ZJxYGs0duQufSjKzi7Nw480KNcJoPGACFy5nNJ6UlozqOH1XxQpbrARUryNqd@vger.kernel.org
X-Gm-Message-State: AOJu0YxNomoEN/XmumxJAjUrAvVzAoLHsU2caj12Ulb4moGvxo+5D7It
	T25dW+VdyhjUrWgV5rOW0hdsue6RFvRkMhAdVsM5kHNOi7DaxGRTHKX6sdBJoHhqmcLdewa/Bhx
	gl4kb/tWH866fEg7jw4vzJvWzFdo=
X-Google-Smtp-Source: AGHT+IF6/p0VwVNq80mBEBDvMCJXT3Yq1gN5MghCXjg/bWCIjoopcZ1c9l1NFYR1PWd+VGliibxZjf8j/sozRiaJejM=
X-Received: by 2002:a05:6820:2706:b0:5d6:ab0:b9a6 with SMTP id
 006d021491bc7-5ee589ffcf5mr10299274eaf.4.1731443510025; Tue, 12 Nov 2024
 12:31:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9ee1a9813f53698be62aab9d810b2d97a2a9f186.1731397722.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <9ee1a9813f53698be62aab9d810b2d97a2a9f186.1731397722.git.u.kleine-koenig@baylibre.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 21:31:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jra=hyUWGNNjyuXrO=gDWyVH_+4v1d-HDVRX3ZZsgKaA@mail.gmail.com>
Message-ID: <CAJZ5v0jra=hyUWGNNjyuXrO=gDWyVH_+4v1d-HDVRX3ZZsgKaA@mail.gmail.com>
Subject: Re: [PATCH] acpi: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Ben Cheatham <Benjamin.Cheatham@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Avadhut Naik <Avadhut.Naik@amd.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 9:35=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
>
> Convert all platform drivers below drivers/acpi to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>
> I did a single patch for all of drivers/acpi. While I usually prefer
> to do one logical change per patch, this seems to be overengineering
> here as the individual changes are really trivial and shouldn't be much
> in the way for stable backports. But I'll happily split the patch if you
> prefer it split. Also if you object the indentation stuff, I can rework
> that.
>
> This is based on yesterday's next, if conflicts arise when you apply it
> at some later time and don't want to resolve them, feel free to just
> drop the changes to the conflicting files. I'll notice and followup at a
> later time then. Or ask me for a fixed resend. (Having said that, I
> recommend b4 am -3 + git am -3 which should resolve most conflicts just
> fine.)
>
> Best regards
> Uwe
>
>  drivers/acpi/ac.c                 | 2 +-
>  drivers/acpi/acpi_pad.c           | 2 +-
>  drivers/acpi/acpi_tad.c           | 2 +-
>  drivers/acpi/apei/einj-core.c     | 2 +-
>  drivers/acpi/apei/ghes.c          | 2 +-
>  drivers/acpi/arm64/agdi.c         | 2 +-
>  drivers/acpi/dptf/dptf_pch_fivr.c | 2 +-
>  drivers/acpi/dptf/dptf_power.c    | 2 +-
>  drivers/acpi/evged.c              | 2 +-
>  drivers/acpi/fan_core.c           | 2 +-
>  drivers/acpi/pfr_telemetry.c      | 2 +-
>  drivers/acpi/pfr_update.c         | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 7c5b040a83e8..1f69be8f51a2 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -290,7 +290,7 @@ static void acpi_ac_remove(struct platform_device *pd=
ev)
>
>  static struct platform_driver acpi_ac_driver =3D {
>         .probe =3D acpi_ac_probe,
> -       .remove_new =3D acpi_ac_remove,
> +       .remove =3D acpi_ac_remove,
>         .driver =3D {
>                 .name =3D "ac",
>                 .acpi_match_table =3D ac_device_ids,
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 42b7220d4cfd..4ec20fd56985 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -462,7 +462,7 @@ MODULE_DEVICE_TABLE(acpi, pad_device_ids);
>
>  static struct platform_driver acpi_pad_driver =3D {
>         .probe =3D acpi_pad_probe,
> -       .remove_new =3D acpi_pad_remove,
> +       .remove =3D acpi_pad_remove,
>         .driver =3D {
>                 .dev_groups =3D acpi_pad_groups,
>                 .name =3D "processor_aggregator",
> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index b831cb8e53dc..825c2a8acea4 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -684,7 +684,7 @@ static struct platform_driver acpi_tad_driver =3D {
>                 .acpi_match_table =3D acpi_tad_ids,
>         },
>         .probe =3D acpi_tad_probe,
> -       .remove_new =3D acpi_tad_remove,
> +       .remove =3D acpi_tad_remove,
>  };
>  MODULE_DEVICE_TABLE(acpi, acpi_tad_ids);
>
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.=
c
> index 5c22720f43cc..04731a5b01fa 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -880,7 +880,7 @@ static struct platform_device *einj_dev;
>   * triggering a section mismatch warning.
>   */
>  static struct platform_driver einj_driver __refdata =3D {
> -       .remove_new =3D __exit_p(einj_remove),
> +       .remove =3D __exit_p(einj_remove),
>         .driver =3D {
>                 .name =3D "acpi-einj",
>         },
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ada93cfde9ba..a2491905f165 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1605,7 +1605,7 @@ static struct platform_driver ghes_platform_driver =
=3D {
>                 .name   =3D "GHES",
>         },
>         .probe          =3D ghes_probe,
> -       .remove_new     =3D ghes_remove,
> +       .remove         =3D ghes_remove,
>  };
>
>  void __init acpi_ghes_init(void)
> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
> index f5f21dd0d277..e0df3daa4abf 100644
> --- a/drivers/acpi/arm64/agdi.c
> +++ b/drivers/acpi/arm64/agdi.c
> @@ -88,7 +88,7 @@ static struct platform_driver agdi_driver =3D {
>                 .name =3D "agdi",
>         },
>         .probe =3D agdi_probe,
> -       .remove_new =3D agdi_remove,
> +       .remove =3D agdi_remove,
>  };
>
>  void __init acpi_agdi_init(void)
> diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_p=
ch_fivr.c
> index d202730fafd8..624fce67ce43 100644
> --- a/drivers/acpi/dptf/dptf_pch_fivr.c
> +++ b/drivers/acpi/dptf/dptf_pch_fivr.c
> @@ -158,7 +158,7 @@ MODULE_DEVICE_TABLE(acpi, pch_fivr_device_ids);
>
>  static struct platform_driver pch_fivr_driver =3D {
>         .probe =3D pch_fivr_add,
> -       .remove_new =3D pch_fivr_remove,
> +       .remove =3D pch_fivr_remove,
>         .driver =3D {
>                 .name =3D "dptf_pch_fivr",
>                 .acpi_match_table =3D pch_fivr_device_ids,
> diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_powe=
r.c
> index 8023b3e23315..3d3edd81b172 100644
> --- a/drivers/acpi/dptf/dptf_power.c
> +++ b/drivers/acpi/dptf/dptf_power.c
> @@ -242,7 +242,7 @@ MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
>
>  static struct platform_driver dptf_power_driver =3D {
>         .probe =3D dptf_power_add,
> -       .remove_new =3D dptf_power_remove,
> +       .remove =3D dptf_power_remove,
>         .driver =3D {
>                 .name =3D "dptf_power",
>                 .acpi_match_table =3D int3407_device_ids,
> diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
> index 11778c93254b..5c35cbc7f6ff 100644
> --- a/drivers/acpi/evged.c
> +++ b/drivers/acpi/evged.c
> @@ -185,7 +185,7 @@ static const struct acpi_device_id ged_acpi_ids[] =3D=
 {
>
>  static struct platform_driver ged_driver =3D {
>         .probe =3D ged_probe,
> -       .remove_new =3D ged_remove,
> +       .remove =3D ged_remove,
>         .shutdown =3D ged_shutdown,
>         .driver =3D {
>                 .name =3D MODULE_NAME,
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 7cea4495f19b..3ea9cfcff46e 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -448,7 +448,7 @@ static const struct dev_pm_ops acpi_fan_pm =3D {
>
>  static struct platform_driver acpi_fan_driver =3D {
>         .probe =3D acpi_fan_probe,
> -       .remove_new =3D acpi_fan_remove,
> +       .remove =3D acpi_fan_remove,
>         .driver =3D {
>                 .name =3D "acpi-fan",
>                 .acpi_match_table =3D fan_device_ids,
> diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
> index a32798787ed9..32bdf8cbe8f2 100644
> --- a/drivers/acpi/pfr_telemetry.c
> +++ b/drivers/acpi/pfr_telemetry.c
> @@ -422,7 +422,7 @@ static struct platform_driver acpi_pfrt_log_driver =
=3D {
>                 .acpi_match_table =3D acpi_pfrt_log_ids,
>         },
>         .probe =3D acpi_pfrt_log_probe,
> -       .remove_new =3D acpi_pfrt_log_remove,
> +       .remove =3D acpi_pfrt_log_remove,
>  };
>  module_platform_driver(acpi_pfrt_log_driver);
>
> diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
> index 8b2910995fc1..031d1ba81b86 100644
> --- a/drivers/acpi/pfr_update.c
> +++ b/drivers/acpi/pfr_update.c
> @@ -565,7 +565,7 @@ static struct platform_driver acpi_pfru_driver =3D {
>                 .acpi_match_table =3D acpi_pfru_ids,
>         },
>         .probe =3D acpi_pfru_probe,
> -       .remove_new =3D acpi_pfru_remove,
> +       .remove =3D acpi_pfru_remove,
>  };
>  module_platform_driver(acpi_pfru_driver);
>
>
> base-commit: 6d59cab07b8d74d0f0422b750038123334f6ecc2
> --

Applied as 6.13 material, thanks!

