Return-Path: <linux-acpi+bounces-6470-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 306BB90BB4E
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 21:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32CD21C2148A
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 19:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E180C187542;
	Mon, 17 Jun 2024 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCgwTQ0C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B2011CAB;
	Mon, 17 Jun 2024 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653330; cv=none; b=CqEHw8YOEKau0ZaSMQ+ggr6zV6K6ZXEH7qxgcI75qCPlXMdYNOYMLa4tdPe3AmW5g+XSi37UzvMWpqXMxEGXMItcKIRXojPzLTVvehYOeqX7FkkiJw9b9D6ZVP3UMtqlU4JFanbtyozUbt4TO7damGLsl05gVTKLhkbhnr/MwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653330; c=relaxed/simple;
	bh=vBDskFgZmOdls58QIaWwG3DV5vl0qEwWkCN2RVnQTyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRXKGuvLlb8p2cCtyHVocFhR6MLcpZBC2/TbPc8FHRzFSy6b+DQI32Uo0rkTFB1W9lkiOZyMt4QwMSWnazDdIHEj6im08mTAXiJ+BoT6RUz/CUur1Jz9vCFbUhdzvvyGbkGd3E341JBXb6PPqUxnDg/F56Hb0lVQCee+pOb1GnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCgwTQ0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99220C4AF48;
	Mon, 17 Jun 2024 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718653330;
	bh=vBDskFgZmOdls58QIaWwG3DV5vl0qEwWkCN2RVnQTyk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DCgwTQ0C5PWT7go4sugstvNcHRawPQvRPU/LEw/gAR2YEv+fGjb0LzLNva9Yqlzmg
	 tbV8W7swp8ATb1UdVRnWsIC9TxOCSdkxcCl2OdUN2ZFN/3d3kFrwSpT5UG/SvmA7xA
	 6c+EPc2xlZFIyQdFolMb42kPUdFNi1ZHkngDyJRYl3fxM/qcqsB5hrhvphjE99eIsi
	 wsWoLVl8s9vbhKRJ/3pTMmmZTs7vX8DmhJ/rVhaMQZOjZ/X8PO6Zul6OwIcXW5G3Pg
	 B/4k1TRzdikrWezFwBrBcf4R6C3tcfmkIaVPGrt7jaiONGXW0YYuOngPxqzI2bseki
	 DuqGqBeBjgXag==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-250aa23752dso513348fac.3;
        Mon, 17 Jun 2024 12:42:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZly6vNUueqTHSvudvREykfZ9eJnfHAI/sX8nIMzImqiQ0JDR6q8JoAcMxdeXLzgZaJCKO3TE+VWKSuAFkpy6YWmfHj2pjXfcRVJiaY2rNhGeP6QuoXU8OOGlbl0YKGBLJOA==
X-Gm-Message-State: AOJu0YyE6k6140oXtAxMCynxap2avy0j4Onkrw0DTxQy9lgnJx27sm6N
	U4L2L2ebtvjJo67FQ9M8ztG2wVnKvdLpkrZVkWhETwuAeHYCliHRNV8DqZRpQs5cPrLm//x00l8
	MwH2CmjnHn1nYK2HBPg9SG6NI5pw=
X-Google-Smtp-Source: AGHT+IGH4ir5exZtJaaX9vKUn92mx4ZHIRJBwLEJ4r+Z0U7OwCg3DyH27ODHTwh7wcB0fEE+Jp5zdqzepxY/0slgaoQ=
X-Received: by 2002:a05:6870:469f:b0:254:d417:351f with SMTP id
 586e51a60fabf-258429511admr11464083fac.1.1718653329860; Mon, 17 Jun 2024
 12:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612104220.22219-1-hdegoede@redhat.com>
In-Reply-To: <20240612104220.22219-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Jun 2024 21:41:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iZPs9gdaeCG+c-FAuEeoHDTbyR2TsmFLC837fy+TQrvQ@mail.gmail.com>
Message-ID: <CAJZ5v0iZPs9gdaeCG+c-FAuEeoHDTbyR2TsmFLC837fy+TQrvQ@mail.gmail.com>
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

Applied as 6.10-rc material, along with the [2/2], with the following chang=
elog:

"Dell laptops with IPU6 camera (the Tiger Lake, Alder Lake and Raptor
Lake generations) have broken ACPI MIPI DISCO information (this results
from an OEM attempt to make Linux work by supplying it with custom data
in the ACPI tables which has never been supported in the mainline).

Instead of adding a lot of DMI quirks for this, check for Dell platforms
based on the processor generations in question and drop the ACPI graph
port nodes, likely to be created with the help of invalid data, on all
of them."

Thanks!

