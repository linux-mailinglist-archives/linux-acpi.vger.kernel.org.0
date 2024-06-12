Return-Path: <linux-acpi+bounces-6325-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487F9905239
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 14:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712571C2358C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 12:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141D16E896;
	Wed, 12 Jun 2024 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phJxqkNj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C215622F;
	Wed, 12 Jun 2024 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194646; cv=none; b=jn6whTUAEdVl3hcRJ3xp/yjxGLctsNyTR8UtR/CV2HC8uM32qdU1pDZAmHDZ20MvyR31sEWhBjma7Nb9T5rcwEB51WLC/57IMEx/tcPbJ2rGefpX72wakDelri78siyAYjT07a+kP+WN/MTHA/Iqxk/9eVLzv+z2oXwizqw7j4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194646; c=relaxed/simple;
	bh=OK6RBNIBJrsuPeE40nQddI4pBmK3lLNqRcT+e4yWd6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9knFRLrqRLhNIblznLRM+bbq8jkuTrqLQaSYC9xHdPnj9PeoiVTLza90sRDQjSrR0Wj+5N6aWVHJRce8vrZ7EwPTkFvjTZztv3TJEnYWvjnj0mqJuL36NTZu5+rxEu2NF+nVPhZiCIrs9oQvUvZClqenCyR/uQjQmIEfXPnYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phJxqkNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F0CC32789;
	Wed, 12 Jun 2024 12:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718194646;
	bh=OK6RBNIBJrsuPeE40nQddI4pBmK3lLNqRcT+e4yWd6I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=phJxqkNjhZPhrs0Hvvh7w7i01UquEt7qYT3Cmn9r7rIcDLjsvOXuvco9uNuaoQ44Y
	 oxPFPLBr/7RuvVCbIozrX61DI4tLUJ2Dv+tdf8D90itg798kNhAgMImwgXSUWgxSYx
	 pDn7iBXJBuX6cyZNEG7e9k33AhG4pX9LBbpMbT3+pIAne9EqFkh0Ip6MjJdRbSUq2Z
	 Gn4Kpqcv2wZQqj0VrAI2Mj7tVbUTYjxSe4kxjmqkEIWtLoMLE91VZTO4t6ia0VMkfA
	 Fz1M0/+C6XVxdeMe1VnVcX9eiA1eoj2+xMbmy288G8LOy0g6qVmeb/k+7qKaqRLW2I
	 p86vd9fWHEzWw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5b3364995b4so1193890eaf.0;
        Wed, 12 Jun 2024 05:17:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVX/ifIg22ONu/dWgvbcUg3mvFftOFLUN2xmpQUPMz6mW7ADb5xA9o870MKeEX9ymBLQOm/GuYdBcd@vger.kernel.org, AJvYcCXZODTpAobGXMgZlz6AFndjnM4id9THQ3vSqd0cP+iYlqm3Hap8W0f5oQen9ou5mcaHeZGBnAIc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2X7WhsHHaIuz3nMn18marrpHRm6zD5e6y0jh43RkWaCQFYL1c
	aHIZJCbwbvKAC67ntM6r36kH1GPO4DkX/NF2cf2f2hR6eMxcY6OnHuT0EF4/UAYbohpjXTZdtug
	e5N4qs1b0nRTLg9xH/IRzjxXq//g=
X-Google-Smtp-Source: AGHT+IGLlm8CM2bSrAa4NvOgJC2QdvKknVR4W2w13VQqqXgfYo8Zb/S97BwXqoTqtnR47PTlW1EWMSuC/Mac9oLpNOE=
X-Received: by 2002:a05:6870:3043:b0:24f:ea59:4e1c with SMTP id
 586e51a60fabf-255151838dcmr1616865fac.4.1718194645637; Wed, 12 Jun 2024
 05:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612104220.22219-1-hdegoede@redhat.com> <ZmmPjt2cCz-z7B1q@kekkonen.localdomain>
In-Reply-To: <ZmmPjt2cCz-z7B1q@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Jun 2024 14:17:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i2e_M3pt_VPSGi2FXviaCTVYiYhHTogks0agLMrbb6uA@mail.gmail.com>
Message-ID: <CAJZ5v0i2e_M3pt_VPSGi2FXviaCTVYiYhHTogks0agLMrbb6uA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: scan: Ignore camera graph port nodes on all
 Dell Tiger, Alder and Raptor Lake models
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Wed, Jun 12, 2024 at 2:07=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Hans,
>
> Thanks for the set.
>
> On Wed, Jun 12, 2024 at 12:42:20PM +0200, Hans de Goede wrote:
> > It seems that all Dell laptops with IPU6 camera or the Tiger Lake,
>
> "Seems that"? I don't argue against though as I have little information o=
n
> this, in fact only two systems.
>
> > Alder Lake and Raptor Lake generations have broken ACPI MIPI DISCO
> > information.
> >
> > Instead of adding a lot of DMI quirks for this, check for these CPU
> > generations and disable ACPI MIPI DISCO support on all Dell laptops
> > with these CPU generations.
>
> Is there still a need to include linux/dmi.h?
>
> >
> > Fixes: bd721b934323 ("ACPI: scan: Extract CSI-2 connection graph from _=
CRS")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/acpi/internal.h       |  4 ++++
> >  drivers/acpi/mipi-disco-img.c | 28 +++++++++++++++++++---------
> >  2 files changed, 23 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> > index 2a0e9fc7b74c..601b670356e5 100644
> > --- a/drivers/acpi/internal.h
> > +++ b/drivers/acpi/internal.h
> > @@ -302,6 +302,10 @@ void acpi_mipi_check_crs_csi2(acpi_handle handle);
> >  void acpi_mipi_scan_crs_csi2(void);
> >  void acpi_mipi_init_crs_csi2_swnodes(void);
> >  void acpi_mipi_crs_csi2_cleanup(void);
> > +#ifdef CONFIG_X86
> >  bool acpi_graph_ignore_port(acpi_handle handle);
> > +#else
> > +static inline bool acpi_graph_ignore_port(acpi_handle handle) { return=
 false; }
> > +#endif
> >
> >  #endif /* _ACPI_INTERNAL_H_ */
> > diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-im=
g.c
> > index d05413a0672a..0ab13751f0db 100644
> > --- a/drivers/acpi/mipi-disco-img.c
> > +++ b/drivers/acpi/mipi-disco-img.c
> > @@ -725,14 +725,20 @@ void acpi_mipi_crs_csi2_cleanup(void)
> >               acpi_mipi_del_crs_csi2(csi2);
> >  }
> >
> > -static const struct dmi_system_id dmi_ignore_port_nodes[] =3D {
> > -     {
> > -             .matches =3D {
> > -                     DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > -                     DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
>
> I believe the patch adding XPS 9320 has been merged so reverting that fir=
st
> might help backporting. Or maybe it's only in Rafael's testing/for-next
> branches and so can be dropped easily?

It was in a topic branch, so it could be dropped.

