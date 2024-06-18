Return-Path: <linux-acpi+bounces-6493-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDB390CF9D
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 15:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94481F20DD3
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9800815F303;
	Tue, 18 Jun 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq2x1f4M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71B15EFD7;
	Tue, 18 Jun 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714979; cv=none; b=WMwDfEVB5fOsDdtIIKBT3fPWRoKNynVc+09kH+G7xlFuYJh8C3Yuwi6AqFpy4k0EVU0chddHCnX22Kd9SuBp5Tx76vvz4wxCZxdysIrJ2KAazlnD13Y8vKnOC7SnAv2+UI5xdek9H+jVk9eGRpN9aGMEzqmgnVnd+Wg9fLbrnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714979; c=relaxed/simple;
	bh=pvKuTQXeTdHWkaU7owlxXJas/B5Bsu+t9hMJ7b3lfmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEJS6WNyt6cvprDg76kpE/h0EFotG+Qms4BG0pQNvyijMjGdoVAGxsCxtqJphp8utKiXzvaiSDARG64oHX3tmKdFyHywD+67+JuYrZppdhuBG5THbHZN8c+A2CzuEvD5BGp1nOXEtaMBhM4F70/Jf869r5CE5UpLMtxVn71543o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq2x1f4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3720EC4AF49;
	Tue, 18 Jun 2024 12:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714979;
	bh=pvKuTQXeTdHWkaU7owlxXJas/B5Bsu+t9hMJ7b3lfmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xq2x1f4MoFHkZyUqM+42LzMwLvTiTu2Ce5EgUNoNQQ3+S8prjfd6AzLrZ8u+l18UP
	 9pevTJrWpRkDntGZ2OHwyKY/ZLsh9BPhIdXMnSuogyY6vLeH4RKDFop1xlJpk2oWzB
	 9mK/7FxsCsAIV9pnLOS458SOQ6lLbSZ9PvnphZIyN9bq8mxOp2Bm3DdBGLez9R27fT
	 R8kWsh+8f0MK1fwuFgglf/v87MBzUNxgRq+j2v79W94pVNNdux9tmawYELQqFgN0xj
	 8QdtXtpUEQmKSwb2oi88nqfTORhyENLSI4rW0zIA87katUOCPPG+vshbaRKT88P2H+
	 k97P1WAB1K0QA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5b97f09cde3so480014eaf.0;
        Tue, 18 Jun 2024 05:49:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWilo2LlDbsA5+AUGL98W0DZwmZQSkbGcWIKXLXb5NO7unyfeMl3GT56imIRXrM0BLWObG9awiMxmesSZwxv6fd3e5V7OsOZ9GjPGlR77ZMa5364XTA7iKdV4TMul1+KGqqjg==
X-Gm-Message-State: AOJu0Yx2rK/JJZgFyo4q/baU2eGZ7S340ZRsGxhQqbatCg9189YcSc6t
	eI3NFKVF+fU709lGyZ4oUx82GGWooB8ksPHvt/GjiEvlpgDFCQSVhjMaaBhxtUn1XK9sVpKJDh7
	rEO/QN24gTNZwkohQ6xJsS+/Ny1A=
X-Google-Smtp-Source: AGHT+IGENF47U7LCEYJtZ238v6tC3dD2VWsftOYb87R6jPhLFIrNlJVcnkX2+XtMtOMXu2nieOpFkB00M7KKg2h8RAs=
X-Received: by 2002:a4a:de45:0:b0:5ba:ca86:a025 with SMTP id
 006d021491bc7-5bdad9f3f2dmr12463466eaf.0.1718714978342; Tue, 18 Jun 2024
 05:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612104220.22219-1-hdegoede@redhat.com> <CAJZ5v0iZPs9gdaeCG+c-FAuEeoHDTbyR2TsmFLC837fy+TQrvQ@mail.gmail.com>
 <ZnCYwPFyIM1HYkt3@kekkonen.localdomain>
In-Reply-To: <ZnCYwPFyIM1HYkt3@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Jun 2024 14:49:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hg-EMzgce5FH10uQqY1d37sGW3dyyZ-P8Uizg2i8+MOA@mail.gmail.com>
Message-ID: <CAJZ5v0hg-EMzgce5FH10uQqY1d37sGW3dyyZ-P8Uizg2i8+MOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: scan: Ignore camera graph port nodes on all
 Dell Tiger, Alder and Raptor Lake models
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Mon, Jun 17, 2024 at 10:12=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Jun 17, 2024 at 09:41:57PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 12, 2024 at 12:42=E2=80=AFPM Hans de Goede <hdegoede@redhat=
.com> wrote:
> > >
> > > It seems that all Dell laptops with IPU6 camera or the Tiger Lake,
> > > Alder Lake and Raptor Lake generations have broken ACPI MIPI DISCO
> > > information.
> > >
> > > Instead of adding a lot of DMI quirks for this, check for these CPU
> > > generations and disable ACPI MIPI DISCO support on all Dell laptops
> > > with these CPU generations.
> > >
> > > Fixes: bd721b934323 ("ACPI: scan: Extract CSI-2 connection graph from=
 _CRS")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > ---
> > >  drivers/acpi/internal.h       |  4 ++++
> > >  drivers/acpi/mipi-disco-img.c | 28 +++++++++++++++++++---------
> > >  2 files changed, 23 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> > > index 2a0e9fc7b74c..601b670356e5 100644
> > > --- a/drivers/acpi/internal.h
> > > +++ b/drivers/acpi/internal.h
> > > @@ -302,6 +302,10 @@ void acpi_mipi_check_crs_csi2(acpi_handle handle=
);
> > >  void acpi_mipi_scan_crs_csi2(void);
> > >  void acpi_mipi_init_crs_csi2_swnodes(void);
> > >  void acpi_mipi_crs_csi2_cleanup(void);
> > > +#ifdef CONFIG_X86
> > >  bool acpi_graph_ignore_port(acpi_handle handle);
> > > +#else
> > > +static inline bool acpi_graph_ignore_port(acpi_handle handle) { retu=
rn false; }
> > > +#endif
> > >
> > >  #endif /* _ACPI_INTERNAL_H_ */
> > > diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-=
img.c
> > > index d05413a0672a..0ab13751f0db 100644
> > > --- a/drivers/acpi/mipi-disco-img.c
> > > +++ b/drivers/acpi/mipi-disco-img.c
> > > @@ -725,14 +725,20 @@ void acpi_mipi_crs_csi2_cleanup(void)
> > >                 acpi_mipi_del_crs_csi2(csi2);
> > >  }
> > >
> > > -static const struct dmi_system_id dmi_ignore_port_nodes[] =3D {
> > > -       {
> > > -               .matches =3D {
> > > -                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > -                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315")=
,
> > > -               },
> > > -       },
> > > -       { }
> > > +#ifdef CONFIG_X86
> > > +#include <asm/cpu_device_id.h>
> > > +#include <asm/intel-family.h>
> > > +
> > > +/* CPU matches for Dell generations with broken ACPI MIPI DISCO info=
 */
> > > +static const struct x86_cpu_id dell_broken_mipi_disco_cpu_gens[] =3D=
 {
> > > +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
> > > +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
> > > +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
> > > +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
> > > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
> > > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
> > > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
> > > +       {}
> > >  };
> > >
> > >  static const char *strnext(const char *s1, const char *s2)
> > > @@ -761,7 +767,10 @@ bool acpi_graph_ignore_port(acpi_handle handle)
> > >         static bool dmi_tested, ignore_port;
> > >
> > >         if (!dmi_tested) {
> > > -               ignore_port =3D dmi_first_match(dmi_ignore_port_nodes=
);
> > > +               if (dmi_name_in_vendors("Dell Inc.") &&
> > > +                   x86_match_cpu(dell_broken_mipi_disco_cpu_gens))
> > > +                       ignore_port =3D true;
> > > +
> > >                 dmi_tested =3D true;
> > >         }
> > >
> > > @@ -794,3 +803,4 @@ bool acpi_graph_ignore_port(acpi_handle handle)
> > >         kfree(orig_path);
> > >         return false;
> > >  }
> > > +#endif
> > > --
> >
> > Applied as 6.10-rc material, along with the [2/2], with the following c=
hangelog:
> >
> > "Dell laptops with IPU6 camera (the Tiger Lake, Alder Lake and Raptor
> > Lake generations) have broken ACPI MIPI DISCO information (this results
> > from an OEM attempt to make Linux work by supplying it with custom data
> > in the ACPI tables which has never been supported in the mainline).
>
> I was expecting to see v2 with fixed changelog from Hans.

Hans asked me offline to take care of this.

> These issues with these (full list unknown) Dell laptops have nothing to =
do
> with DisCo for Imaging, not the spec nor the implementation. Instead the
> DSDT partially aligns with Documentation/firmware-guide/acpi/dsd/graph.rs=
t
> but lacks e.g. IVSC from the graph as well as ACPI power resources for
> devices related to camera. IOW it's always been unusable.

The code related to DisCo for Imaging ends up using them and failing,
though, IIUC.

So what should I change in the paragraph quoted above?

> >
> > Instead of adding a lot of DMI quirks for this, check for Dell platform=
s
> > based on the processor generations in question and drop the ACPI graph
> > port nodes, likely to be created with the help of invalid data, on all
> > of them."

Am I guessing correctly that the remaining part of it is fine?

