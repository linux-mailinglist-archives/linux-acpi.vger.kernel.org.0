Return-Path: <linux-acpi+bounces-6378-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E2E907BFA
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 21:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E2B288AD2
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 19:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4DA14A092;
	Thu, 13 Jun 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP8y977d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972CF2F34;
	Thu, 13 Jun 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305462; cv=none; b=MDzOl89WOte6SnDMESg7wtSYdrL7s2Bnb6uFzacU9hhE1X8/Ri+FZE2U9g9VfceH4WI29qWFzCJkdf8lJXvdmWMEabLyn+qKaMQcdmfLAhKTr81GXZYvwkfFiotjYeeshOmo2Avdw73wJrIq+lwjUX+aihIdDr4u2BYjNcuIAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305462; c=relaxed/simple;
	bh=83XYunCG1dEwk3AHNlRvSoM4f8AlSZ1yS2PSrnjsbXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICim7y0T/TccqgPg3Pkkp8uQXexmHFkmi77NMERnIjyj2HiuPyOSXJfEATIpKr5V5tScaOvUD9UbmZgobYxOpdabbM5yzzNvUL32rMwXck+mTb0gIcQTY9AWGGHbw5mHBbz7dsGNZyD4pqXx3G26uO8ZIWQ1gTjPZOrMzG0Kjr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP8y977d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390F2C2BBFC;
	Thu, 13 Jun 2024 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718305462;
	bh=83XYunCG1dEwk3AHNlRvSoM4f8AlSZ1yS2PSrnjsbXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LP8y977dP4vvpnk+WAUgoFdS6UQvjnH0QFas/Qtj465zETm+PcurXKrV6rz5Tpvtb
	 VHvzsPQlHotSmMW7U5RIQwEbHPLhdDtg2AjU4f8ULxhvAvUHvDuhTrCjQWBIdwz7Zf
	 j2jw81HmDfs5ZAXblDU1TDXckQthRp3o2E/bDn/sETj/Q3IoM/upWJ9Ha80Y6eF3dv
	 qgmYU1/h+pIzfRhHKRtW/iBBim59zabd9jksMBRziSiWBa/+HVxLpURCGCEdnoY+aL
	 7jJ7Yu3LAJzWWvdKd3xClnCcojG+qMI54KMrjBd/o7PACOktLS8ZO/k+flfv8WJiSh
	 GqAk8oWoswnaQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2583e2930c7so64091fac.3;
        Thu, 13 Jun 2024 12:04:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuAIaMGuCnNbjCiRopa8T2f6t4S9Hc6Z1kN0bYsNFl6jI5/8/rKDEz4UwXNEljKnX3QYRDxrtIWA2d3dEyPSzI0nc/aPhTyAuwwpbh2ABS1sdprdIOQD0WAR6gqoaCqhoW+A==
X-Gm-Message-State: AOJu0YwLrqzkUNZ0yNwSSxrcGQR7+/KY84yPYoWVO1YmAYzyzuWLMFlp
	lZ5c96uOvlWxNGF413bOwrKQkF7kjd9DcJ3Q7ZSg6aTfLR0ddTAv+wHncy+a/4uIgL54wj+B/Ra
	wuT9Rog4uaMCiM190QpZyy2FooCE=
X-Google-Smtp-Source: AGHT+IFBt63zKoGRiLC/o2/QGaoN61RHUhVBhnG9ZpB7lL4VbREDfq5b35om2fy+Fv6gQLxJfqTmpAQUWdmFQW8S4dw=
X-Received: by 2002:a05:6820:287:b0:5ba:ca8a:6598 with SMTP id
 006d021491bc7-5bdad9f3131mr603137eaf.0.1718305461509; Thu, 13 Jun 2024
 12:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612104220.22219-1-hdegoede@redhat.com>
In-Reply-To: <20240612104220.22219-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 21:04:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jXuHHVxS=q1i-WrwTtFZB7fmfux1jc+hU_w1tdSc3ngA@mail.gmail.com>
Message-ID: <CAJZ5v0jXuHHVxS=q1i-WrwTtFZB7fmfux1jc+hU_w1tdSc3ngA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: scan: Ignore camera graph port nodes on all
 Dell Tiger, Alder and Raptor Lake models
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	linux-acpi@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 12:42=E2=80=AFPM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> It seems that all Dell laptops with IPU6 camera or the Tiger Lake,
> Alder Lake and Raptor Lake generations have broken ACPI MIPI DISCO
> information.
>
> Instead of adding a lot of DMI quirks for this, check for these CPU
> generations and disable ACPI MIPI DISCO support on all Dell laptops
> with these CPU generations.
>
> Fixes: bd721b934323 ("ACPI: scan: Extract CSI-2 connection graph from _CR=
S")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/internal.h       |  4 ++++
>  drivers/acpi/mipi-disco-img.c | 28 +++++++++++++++++++---------
>  2 files changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 2a0e9fc7b74c..601b670356e5 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -302,6 +302,10 @@ void acpi_mipi_check_crs_csi2(acpi_handle handle);
>  void acpi_mipi_scan_crs_csi2(void);
>  void acpi_mipi_init_crs_csi2_swnodes(void);
>  void acpi_mipi_crs_csi2_cleanup(void);
> +#ifdef CONFIG_X86
>  bool acpi_graph_ignore_port(acpi_handle handle);
> +#else
> +static inline bool acpi_graph_ignore_port(acpi_handle handle) { return f=
alse; }
> +#endif
>
>  #endif /* _ACPI_INTERNAL_H_ */
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.=
c
> index d05413a0672a..0ab13751f0db 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -725,14 +725,20 @@ void acpi_mipi_crs_csi2_cleanup(void)
>                 acpi_mipi_del_crs_csi2(csi2);
>  }
>
> -static const struct dmi_system_id dmi_ignore_port_nodes[] =3D {
> -       {
> -               .matches =3D {
> -                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
> -               },
> -       },
> -       { }
> +#ifdef CONFIG_X86
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
> +
> +/* CPU matches for Dell generations with broken ACPI MIPI DISCO info */
> +static const struct x86_cpu_id dell_broken_mipi_disco_cpu_gens[] =3D {
> +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
> +       {}
>  };
>
>  static const char *strnext(const char *s1, const char *s2)
> @@ -761,7 +767,10 @@ bool acpi_graph_ignore_port(acpi_handle handle)
>         static bool dmi_tested, ignore_port;
>
>         if (!dmi_tested) {
> -               ignore_port =3D dmi_first_match(dmi_ignore_port_nodes);
> +               if (dmi_name_in_vendors("Dell Inc.") &&
> +                   x86_match_cpu(dell_broken_mipi_disco_cpu_gens))
> +                       ignore_port =3D true;
> +
>                 dmi_tested =3D true;
>         }
>
> @@ -794,3 +803,4 @@ bool acpi_graph_ignore_port(acpi_handle handle)
>         kfree(orig_path);
>         return false;
>  }
> +#endif
> --

I'm inclined to apply this one with the changelog adjusted as
requested by Sakari.

Can you please make the changes in the changelog and resend?

