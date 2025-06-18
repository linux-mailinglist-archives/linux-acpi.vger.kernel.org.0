Return-Path: <linux-acpi+bounces-14453-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5CDADF64F
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 20:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529033A47E8
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645072F49E0;
	Wed, 18 Jun 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doIhaOZs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3593085C7;
	Wed, 18 Jun 2025 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750272904; cv=none; b=lOr2Bc3q0+mndtSvO+SeCXXkgwurWGTS+i1Qs76apVI+thmQROvsTTRWUqeWqRrDiWknXGM+5TPh55aQJKl1L+Wdq0Xuu5MdAjnWRUTU1Vezjap/Kuu7P2D9mYq9wTVGM469jHJ7Hq0GbcWlb01PBXDGBzJCQmdBJ9SBja2m18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750272904; c=relaxed/simple;
	bh=85QQjICIurux2YN6mW3BFkT+PPwpAF8dNyOf5+nfzJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbkLRvQI1yr1azJQU8tlZiNdMFVgwfi+7djujo9+1VigEg2SvalA/cBGWtf+LGfWJE7a9CbAGnGav5n3CcIdzWksmTRj25RyHW89eRkHZo7sT6mpT1EZKKX4TU0KZCQugxdiX24zSMq/GN+v3/o2K84rpaJSJXPL8xmgM8EtJ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doIhaOZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29F7C4CEE7;
	Wed, 18 Jun 2025 18:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750272903;
	bh=85QQjICIurux2YN6mW3BFkT+PPwpAF8dNyOf5+nfzJM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=doIhaOZsJrDBCZbcvGNNSX2p+xSd0Q3/Pbo/cOzD11vkUS6z3Eu5Kk0MtZsn0syoo
	 oQ5D/Tj+OZmHsBLbUapyA3zhTVXXT+4qr8IdhsRAwity0ClDdXqTjUIxzWg0YekiZb
	 fnLMiMXqvFRo0whxw17KD63EKMV7QAfzXeNE/0/6kqtXUJLHYAThHdDTO5kcUyTAOI
	 C48AjcRzJ1xYXqIzNSOftMmc0nC2l9iSOilN6JHvbZEEwnSU8WHqLNk1XP0BgDN18W
	 cJA04ncZWHK7d1y4VrUWaoQxlH/n1YLtXXTa/O14wAtcgnInu0v1Tr0ELDvTHkElra
	 6rJNFdxPkXs3w==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-407a3c10d03so4512922b6e.2;
        Wed, 18 Jun 2025 11:55:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRcbgWycV1lE9H4/1lmTuLbmwO+kI/E+zhNc57Xwub/BUzTuljUrG/3qSHfjOlVqkE34T6pCoUGUt9oiqm@vger.kernel.org, AJvYcCVTs7RGdlW5GGdX8eMqbqbXr7wKPsef/T0v6Bexytrp+2XNtxle3OxHX+WRnh/SY5T+c1kcL9AtG6mg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs2RtXyl2YBcIQcdgXJUcZ3fzsEyNqi4qdtXX0zA2fbGBoOpXT
	zRxUA9FHMMvHXJclBiArCr2nG00kU1OCssVEMcRJHqMj1xK9xkpZsZHbrk5vY4paerb1M7jAc+P
	4vN3x9hiYKRCE/kDgUQWEO8e7JGd/GPs=
X-Google-Smtp-Source: AGHT+IG4w4VEQKYKg1rmq4AhXseetHUTRpBeIKfM053pFoyC2Jnx81M5P0/XVnmD5B64Fgsz9jwS3O6hl10SORn7THo=
X-Received: by 2002:a05:6808:4fe2:b0:401:e5fc:e726 with SMTP id
 5614622812f47-40a7c257553mr12506594b6e.31.1750272903069; Wed, 18 Jun 2025
 11:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617231824.3314507-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250617231824.3314507-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Jun 2025 20:54:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jim=krcEXvUHKvhjT5bZL8--bs=dK4VTpBEx_+OYn1vA@mail.gmail.com>
X-Gm-Features: AX0GCFs_TqzVg4hvOFhnSg4UdF1LEAuluZWtVR5LkLbblc_1bWh17SOE0_zo_IA
Message-ID: <CAJZ5v0jim=krcEXvUHKvhjT5bZL8--bs=dK4VTpBEx_+OYn1vA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: DPTF: Support for Wildcat Lake
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 1:18=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add Wildcat Lake ACPI IDs for DPTF.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/acpi/dptf/dptf_power.c                          | 2 ++
>  drivers/acpi/dptf/int340x_thermal.c                     | 7 +++++++
>  drivers/acpi/fan.h                                      | 1 +
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
>  drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
>  5 files changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_powe=
r.c
> index e8caf4106ff9..776914f31b9e 100644
> --- a/drivers/acpi/dptf/dptf_power.c
> +++ b/drivers/acpi/dptf/dptf_power.c
> @@ -238,6 +238,8 @@ static const struct acpi_device_id int3407_device_ids=
[] =3D {
>         {"INTC10A5", 0},
>         {"INTC10D8", 0},
>         {"INTC10D9", 0},
> +       {"INTC1100", 0},
> +       {"INTC1101", 0},
>         {"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
> diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int3=
40x_thermal.c
> index aef7aca2161d..a222df059a16 100644
> --- a/drivers/acpi/dptf/int340x_thermal.c
> +++ b/drivers/acpi/dptf/int340x_thermal.c
> @@ -61,6 +61,13 @@ static const struct acpi_device_id int340x_thermal_dev=
ice_ids[] =3D {
>         {"INTC10D7"},
>         {"INTC10D8"},
>         {"INTC10D9"},
> +       {"INTC10FC"},
> +       {"INTC10FD"},
> +       {"INTC10FE"},
> +       {"INTC10FF"},
> +       {"INTC1100"},
> +       {"INTC1101"},
> +       {"INTC1102"},
>         {""},
>  };
>
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index 15eba1c70e66..8a28a72a7c6a 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -20,6 +20,7 @@
>         {"INTC106A", }, /* Fan for Lunar Lake generation */ \
>         {"INTC10A2", }, /* Fan for Raptor Lake generation */ \
>         {"INTC10D6", }, /* Fan for Panther Lake generation */ \
> +       {"INTC10FE", }, /* Fan for Wildcat Lake generation */ \
>         {"PNP0C0B", } /* Generic ACPI fan */
>
>  #define ACPI_FPS_NAME_LEN      20
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 0e07693ecf59..ecb4ea443b9b 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -690,6 +690,7 @@ static const struct acpi_device_id int3400_thermal_ma=
tch[] =3D {
>         {"INTC1068", 0},
>         {"INTC10A0", 0},
>         {"INTC10D4", 0},
> +       {"INTC10FC", 0},
>         {}
>  };
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3403_thermal.c
> index 5a925a8df7b3..ba63796761eb 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> @@ -276,6 +276,7 @@ static const struct acpi_device_id int3403_device_ids=
[] =3D {
>         {"INTC1069", 0},
>         {"INTC10A1", 0},
>         {"INTC10D5", 0},
> +       {"INTC10FD", 0},
>         {"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
> --

Applied as 6.17 material, thanks!

