Return-Path: <linux-acpi+bounces-6717-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3440C91E738
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 20:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B511C20F1A
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 18:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E4F16DEBD;
	Mon,  1 Jul 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgvUlOgC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7CE14BF8F;
	Mon,  1 Jul 2024 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857540; cv=none; b=qZ50TgpH7Qo9kyH2BbVTOdpr1aJ/MICGGG1X09HuB2Tr2gH2FLIAMmmWOi2DceHAw+njFZ3pL0s/b871vEtiXmAA+5FT426+EzBUtiACAJe6miYvC6mnc5oZGTmDpcD31vWSLAlJvvtazxtCBbzxDz1XAyPBZwbz/JsfzDsvjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857540; c=relaxed/simple;
	bh=ndWsAOia4WnVSxp0z9wn1/Y9JHHFhLWK7tqCxcJLoSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHldlIi34sAiPupBFc0PjMfFnxa3hhU7CzAPnrnyNYOfw05g9+VQ8iImEzuVzoUpB5Di6AKGlWy9HCdjxID2C+Bm/ivQwxnbYM3ksoDi3ajBWFeNHIBUTk8UVmjA0D7AHcISyxtkpa3K7ofBiJZgLSRpYOFjJLbo75FlkYeAsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgvUlOgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8A6C32781;
	Mon,  1 Jul 2024 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719857540;
	bh=ndWsAOia4WnVSxp0z9wn1/Y9JHHFhLWK7tqCxcJLoSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jgvUlOgCCBI5mqKbbnb2IiV1wIlvnm7JcOuch0JAZAv0cuh8N5PRMnWusqVtA6OBg
	 xir5QkVys7EYBq8Ooiu4Bh23T86oSaE77Ln7ueDjljdwFppkc2KDYzUYO8x6oDOPuI
	 47U3GItTbFRrf/aC1oi5blsBXQUNIv7mQuuf4IaWgiXWw2Q2zdKgOYRFIn8oXfg6/u
	 MukIrrxmLOmr+gpPJd/Q4bngvzv7dKTQTZTnp9Z0m4BClW16czevnPaKAmG+KpWPli
	 xtdg1s/JZlpIXHEX7CDAodE8FuBshUFicKqZlwhFBgykQKeg1NBB4GJtvQ9yrvgayq
	 YhQsl2KxQ1jVw==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25d0f8d79ebso487219fac.0;
        Mon, 01 Jul 2024 11:12:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzvCohjg4oQjmPC70YcgvNPj7nY4G8eFxUZ22nkrjfx16GOKaJo3OJ9BXztTx13TZ9XhoEug1wns9aX9I45/wZwR/l5VDOOvuPtN9fajG1IyDMDOQoxNmb7b7iibZsMPG53gtT/I6Z/eAOgEM0i3UKQsPcnQBEsR3adKF+FawM53xaB6pW3ZPwMA==
X-Gm-Message-State: AOJu0Yz6ZDGIv7MiLBKNkb9/ytqTZQPc/F3f/BHa07xM7pVi8QNblrnk
	kmvksmhNV4mH/NvHAEOgmkqcxyjLn2E+PoNcPGtKvsboHOWtktb4zZxFjb3XUMBMlmZ+maeeP2B
	FEzNqyBiA9COXzg0VUKUG3WdPN9o=
X-Google-Smtp-Source: AGHT+IGkHU8gGCwWculrKktL7Tykcy0bLso97IDN39fFEMkNLo1ZVdhdoINCWlMaFA4QgoyHLDzsf3ncUnGICuZYmCU=
X-Received: by 2002:a05:6870:c68a:b0:254:a7df:721b with SMTP id
 586e51a60fabf-25db36a5391mr6349750fac.5.1719857539722; Mon, 01 Jul 2024
 11:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a6c9b1bcdf259adabbcaf91183d3f5ab87a98600.1719644292.git.christophe.jaillet@wanadoo.fr>
 <6e881b24-e1fe-40fe-b19e-69ee0091839f@redhat.com>
In-Reply-To: <6e881b24-e1fe-40fe-b19e-69ee0091839f@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 20:12:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hyryu8t7wntnOb9-moqcwV3GSXzgEbVORMXvFGbW+23g@mail.gmail.com>
Message-ID: <CAJZ5v0hyryu8t7wntnOb9-moqcwV3GSXzgEbVORMXvFGbW+23g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PMIC: Constify struct pmic_table
To: Hans de Goede <hdegoede@redhat.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 12:06=E2=80=AFPM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi,
>
> On 6/29/24 8:58 AM, Christophe JAILLET wrote:
> > 'struct pmic_table' is not modified in these drivers.
> >
> > Constifying this structure moves some data to a read-only section, so
> > increase overall security.
> >
> > On a x86_64, with allmodconfig, as an example:
> > Before:
> > =3D=3D=3D=3D=3D=3D
> >    text          data     bss     dec     hex filename
> >    3811           786       0    4597    11f5 drivers/acpi/pmic/intel_p=
mic_xpower.o
> >
> >    text          data     bss     dec     hex filename
> >    4147           450       0    4597    11f5 drivers/acpi/pmic/intel_p=
mic_xpower.o
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Compile tested-only
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied as 6.11 material, thanks!


> > ---
> >  drivers/acpi/pmic/intel_pmic.c          | 2 +-
> >  drivers/acpi/pmic/intel_pmic.h          | 4 ++--
> >  drivers/acpi/pmic/intel_pmic_bxtwc.c    | 4 ++--
> >  drivers/acpi/pmic/intel_pmic_bytcrc.c   | 4 ++--
> >  drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 4 ++--
> >  drivers/acpi/pmic/intel_pmic_chtwc.c    | 2 +-
> >  drivers/acpi/pmic/intel_pmic_xpower.c   | 4 ++--
> >  7 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_p=
mic.c
> > index f20dbda1a831..134e9ca8eaa2 100644
> > --- a/drivers/acpi/pmic/intel_pmic.c
> > +++ b/drivers/acpi/pmic/intel_pmic.c
> > @@ -31,7 +31,7 @@ struct intel_pmic_opregion {
> >
> >  static struct intel_pmic_opregion *intel_pmic_opregion;
> >
> > -static int pmic_get_reg_bit(int address, struct pmic_table *table,
> > +static int pmic_get_reg_bit(int address, const struct pmic_table *tabl=
e,
> >                           int count, int *reg, int *bit)
> >  {
> >       int i;
> > diff --git a/drivers/acpi/pmic/intel_pmic.h b/drivers/acpi/pmic/intel_p=
mic.h
> > index d956b03a6ca0..006f0780ffab 100644
> > --- a/drivers/acpi/pmic/intel_pmic.h
> > +++ b/drivers/acpi/pmic/intel_pmic.h
> > @@ -21,9 +21,9 @@ struct intel_pmic_opregion_data {
> >                                         u32 reg_address, u32 value, u32=
 mask);
> >       int (*lpat_raw_to_temp)(struct acpi_lpat_conversion_table *lpat_t=
able,
> >                               int raw);
> > -     struct pmic_table *power_table;
> > +     const struct pmic_table *power_table;
> >       int power_table_count;
> > -     struct pmic_table *thermal_table;
> > +     const struct pmic_table *thermal_table;
> >       int thermal_table_count;
> >       /* For generic exec_mipi_pmic_seq_element handling */
> >       int pmic_i2c_address;
> > diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/i=
ntel_pmic_bxtwc.c
> > index e247615189fa..c332afbf82bd 100644
> > --- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
> > +++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
> > @@ -24,7 +24,7 @@
> >  #define VSWITCH1_OUTPUT         BIT(4)
> >  #define VUSBPHY_CHARGE          BIT(1)
> >
> > -static struct pmic_table power_table[] =3D {
> > +static const struct pmic_table power_table[] =3D {
> >       {
> >               .address =3D 0x0,
> >               .reg =3D 0x63,
> > @@ -177,7 +177,7 @@ static struct pmic_table power_table[] =3D {
> >       } /* MOFF -> MODEMCTRL Bit 0 */
> >  };
> >
> > -static struct pmic_table thermal_table[] =3D {
> > +static const struct pmic_table thermal_table[] =3D {
> >       {
> >               .address =3D 0x00,
> >               .reg =3D 0x4F39
> > diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/=
intel_pmic_bytcrc.c
> > index 2b09f8da5400..b4c21a75294a 100644
> > --- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
> > +++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
> > @@ -16,7 +16,7 @@
> >
> >  #define PMIC_A0LOCK_REG              0xc5
> >
> > -static struct pmic_table power_table[] =3D {
> > +static const struct pmic_table power_table[] =3D {
> >  /*   {
> >               .address =3D 0x00,
> >               .reg =3D ??,
> > @@ -134,7 +134,7 @@ static struct pmic_table power_table[] =3D {
> >       }, /* V105 -> V1P05S, L2 SRAM */
> >  };
> >
> > -static struct pmic_table thermal_table[] =3D {
> > +static const struct pmic_table thermal_table[] =3D {
> >       {
> >               .address =3D 0x00,
> >               .reg =3D 0x75
> > diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmi=
c/intel_pmic_chtdc_ti.c
> > index 79f9df552524..ecb36fbc1e7f 100644
> > --- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> > +++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
> > @@ -23,7 +23,7 @@
> >  #define CHTDC_TI_BPTHERM     0x58
> >  #define CHTDC_TI_GPADC               0x5a
> >
> > -static struct pmic_table chtdc_ti_power_table[] =3D {
> > +static const struct pmic_table chtdc_ti_power_table[] =3D {
> >       { .address =3D 0x00, .reg =3D 0x41 }, /* LDO1 */
> >       { .address =3D 0x04, .reg =3D 0x42 }, /* LDO2 */
> >       { .address =3D 0x08, .reg =3D 0x43 }, /* LDO3 */
> > @@ -39,7 +39,7 @@ static struct pmic_table chtdc_ti_power_table[] =3D {
> >       { .address =3D 0x30, .reg =3D 0x4e }, /* LD14 */
> >  };
> >
> > -static struct pmic_table chtdc_ti_thermal_table[] =3D {
> > +static const struct pmic_table chtdc_ti_thermal_table[] =3D {
> >       {
> >               .address =3D 0x00,
> >               .reg =3D CHTDC_TI_GPADC
> > diff --git a/drivers/acpi/pmic/intel_pmic_chtwc.c b/drivers/acpi/pmic/i=
ntel_pmic_chtwc.c
> > index 25aa3e33b09a..81caede51ca2 100644
> > --- a/drivers/acpi/pmic/intel_pmic_chtwc.c
> > +++ b/drivers/acpi/pmic/intel_pmic_chtwc.c
> > @@ -70,7 +70,7 @@
> >   * "regulator: whiskey_cove: implements Whiskey Cove pmic VRF support"
> >   * https://github.com/intel-aero/meta-intel-aero/blob/master/recipes-k=
ernel/linux/linux-yocto/0019-regulator-whiskey_cove-implements-WhiskeyCove-=
pmic-V.patch
> >   */
> > -static struct pmic_table power_table[] =3D {
> > +static const struct pmic_table power_table[] =3D {
> >       {
> >               .address =3D 0x0,
> >               .reg =3D CHT_WC_V1P8A_CTRL,
> > diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/=
intel_pmic_xpower.c
> > index 43c5850b4bf3..49bda5e0c8aa 100644
> > --- a/drivers/acpi/pmic/intel_pmic_xpower.c
> > +++ b/drivers/acpi/pmic/intel_pmic_xpower.c
> > @@ -26,7 +26,7 @@
> >  #define AXP288_ADC_TS_CURRENT_ON_ONDEMAND            (2 << 0)
> >  #define AXP288_ADC_TS_CURRENT_ON                     (3 << 0)
> >
> > -static struct pmic_table power_table[] =3D {
> > +static const struct pmic_table power_table[] =3D {
> >       {
> >               .address =3D 0x00,
> >               .reg =3D 0x13,
> > @@ -129,7 +129,7 @@ static struct pmic_table power_table[] =3D {
> >  };
> >
> >  /* TMP0 - TMP5 are the same, all from GPADC */
> > -static struct pmic_table thermal_table[] =3D {
> > +static const struct pmic_table thermal_table[] =3D {
> >       {
> >               .address =3D 0x00,
> >               .reg =3D XPOWER_GPADC_LOW
>

