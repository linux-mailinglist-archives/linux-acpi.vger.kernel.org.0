Return-Path: <linux-acpi+bounces-3784-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D22E85E146
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 16:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA2A1F25373
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086CB7FBBD;
	Wed, 21 Feb 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6SEBLng"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C96994A
	for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529656; cv=none; b=ttmcHwWpZBvo6fgjobiG6qbNDQQPPJtG35izHTa/k00jR9r53NLt1YJQ6mjmAU+3UBs84YTklEPvXVGDNXIbjwJ8rCGEV/2zkFpdHqi1sYKkHH6oxFP4RpmUwWP+L5vDoKrJvgnopUmmtZL3TjkAO0ZpIX5CqTH9/r8qNSfAkpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529656; c=relaxed/simple;
	bh=pCRAlbE7mMMt6S6v2tV6AbYIaqkOsyUzJw1YCKYxKNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aW/RzpzkF3O0jE1/0D30LdNM6FzFkFmp1QoNDyoZ7nMHS/vaVgZBHShLgsgpEPwdKtZzrIlE8f1VK1cdNaD7kpk4uvAYhpWBMZ2W7OG0JBSyYuTTB88V+ldQ0/tEHlDnvJeoFXoo+NWtXsUIsJs/pkDFaIM/oO8EmQgQINo4Y/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6SEBLng; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512b42b6697so4278184e87.1
        for <linux-acpi@vger.kernel.org>; Wed, 21 Feb 2024 07:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708529653; x=1709134453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFNTOWznuw3QWL+IXaT+QoQZyDq4kTDL0/IaVpqE03w=;
        b=e6SEBLngcJDwvNXojGMk0Cr+3ZZG1iO4UOmnjzXs2DGVe09qipwAqFmdsAPvxICrLn
         lhBAI2PZ91xdsMlXP6axZX1m3GGw7R+L09nhHLtqRCLI7GhXv36+bko5THEE4iKidr/r
         LsKphzlykSzYawI64h0wJTtl/WYOymHnFNAZHUVUFqTV2Ximq61l8FTlkzbMaz9yjat4
         QZwVC/S21o6e98NwTPU6ZSmmQLd5/Bp5+2+2mQbuSdQlEm709qntJE3KX3i25aczd0Cc
         4foQ5TdMQHx4kRIrjXVdkoplVlOgQHlKBSgDUklArfKC9FBn59mp8DLHdZ2972wY/9tT
         mrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529653; x=1709134453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFNTOWznuw3QWL+IXaT+QoQZyDq4kTDL0/IaVpqE03w=;
        b=RnHVy+yK7bB5b8/jcRV2GhL+XCQ9sm4bEmBLuiPT3ZPU6IXgoY9YVPsraV6AjjxYj8
         zp76dj7aCV4bpq7SSRM64aGYxZR43jrbvOno7vxQgXP9DflrgerW4EG3j//JxHrW8vLe
         K/tgaXgRIlulRnYnr3HZN6gttthaixBcignD8Qm34NWtQnw7IrZgZOGnOQ1Df91FqDe9
         CpmlB502W5TKRcAaBkcbyFLiscpY8wkIQN9bH4Ns1/RLxyNZkg2ScWc4zwDtjTWjTvGJ
         07lKouAAntKdyb2ZvsMdBvFsZ0UkoFyHTuFDMKihpzo4mCrjY41Q43XNzJTeahJwPttu
         a/IQ==
X-Gm-Message-State: AOJu0YyYxGOmyeDtwdPbj/G92tiS3dAUb4oaDg8UEg5HWtzAeVX+xGkp
	1bRAhQuYISdxu3samhuWuWwDwJTCvfzAe80awK8X7GHVZRBOTXRSCS0iLZe8sGOdLcAAHOvJe6l
	alr/kYwPeHBaXX4wWDXON775iwVEM8yjN+10JrA==
X-Google-Smtp-Source: AGHT+IFc/Duh1oYma3JV/AjJ1Uk7w9ay/EMuNllvuPV7LUVZhi14K2OUzfsJwyWSyfPrYmi73Ns15SiAh27vw40RKz8=
X-Received: by 2002:ac2:5589:0:b0:512:ab9e:3525 with SMTP id
 v9-20020ac25589000000b00512ab9e3525mr6480617lfg.40.1708529653142; Wed, 21 Feb
 2024 07:34:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213134606.383817-1-sakari.ailus@linux.intel.com>
 <20240213134606.383817-3-sakari.ailus@linux.intel.com> <ZdUl2eg8hM5RkrOL@surfacebook.localdomain>
 <ZdWes9XxXG1PzYJZ@kekkonen.localdomain>
In-Reply-To: <ZdWes9XxXG1PzYJZ@kekkonen.localdomain>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 21 Feb 2024 17:33:36 +0200
Message-ID: <CAHp75VdJMQ1HUMHWmtkSLH=m0KQYqpcEpDGb6cVbxYw_iNPwTA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: property: Ignore bad graph port nodes on
 Dell XPS 9315
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 8:56=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> I think Rafael has already applied this but I can send a new patch...

Depends if it's final or can be dropped.
If the former is the case, follow ups, please.

> On Wed, Feb 21, 2024 at 12:21:13AM +0200, andy.shevchenko@gmail.com wrote=
:
> > Tue, Feb 13, 2024 at 03:46:06PM +0200, Sakari Ailus kirjoitti:

...

> > >  void acpi_mipi_scan_crs_csi2(void);
> > >  void acpi_mipi_init_crs_csi2_swnodes(void);
> > >  void acpi_mipi_crs_csi2_cleanup(void);
> >
> > + blank line?
>
> The usa of blank lines elsewhere in the file is consistent with the above=
.
> These are all related.

Naming does not suggest that. I see either naming or semantic tights
issues here. Hence the proposal to have a blank line.

> > > +bool acpi_graph_ignore_port(acpi_handle handle);

...

> > > +static const struct dmi_system_id dmi_ignore_port_nodes[] =3D {
> > > +   {
> > > +           .matches =3D {
> > > +                   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > +                   DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
> > > +           },
> > > +   },
> > > +   { 0 }
> >
> > 0 is not needed. Moreover, it's a bit unusual.
>
> But also required by the C standard.

We have a lot of code that doesn't use that (yet this is valid C23,
and yes I know that we rely on C11).

> > > +};

...

> > > +static const char *strnext(const char *s1, const char *s2)
> > > +{
> > > +   s1 =3D strstr(s1, s2);
> > > +
> > > +   if (!s1)
> > > +           return NULL;
> > > +
> > > +   return s1 + strlen(s2);
> > > +}
> >
> > NIH str_has_prefix() ?
>
> It doesn't do the same thing. Yes, it could be used, but the code looks
> cleaner with this.

"Not Invented Here" was even at Nokia times, why do we repeat our mistakes?

...

> > > +/**
> > > + * acpi_graph_ignore_port - Tell whether a port node should be ignor=
ed
> > > + * @handle: The ACPI handle of the node (which may be a port node)
> > > + *
> > > + * Returns true if a port node should be ignored and the data to tha=
t should
> >
> > Please, run kernel-doc validation and fix the warnings.
>
> Running kernel-doc on the file doesn't produce any here.

You haven't run it correctly?

$ scripts/kernel-doc -v -none -Wall drivers/acpi/mipi-disco-img.c
drivers/acpi/mipi-disco-img.c:163: info: Scanning doc for function
acpi_mipi_check_crs_csi2
drivers/acpi/mipi-disco-img.c:384: info: Scanning doc for function
acpi_mipi_scan_crs_csi2
drivers/acpi/mipi-disco-img.c:703: info: Scanning doc for function
acpi_mipi_init_crs_csi2_swnodes
drivers/acpi/mipi-disco-img.c:718: info: Scanning doc for function
acpi_mipi_crs_csi2_cleanup
drivers/acpi/mipi-disco-img.c:749: info: Scanning doc for function
acpi_graph_ignore_port
drivers/acpi/mipi-disco-img.c:759: warning: No description found for
return value of 'acpi_graph_ignore_port'
1 warnings

> > > + * come from other sources instead (Windows ACPI definitions and
> > > + * ipu-bridge). This is currently used to ignore bad port nodes rela=
ted to IPU6
> > > + * ("IPU?") and camera sensor devices ("LNK?") in certain Dell syste=
ms with
> > > + * Intel VSC.
> > > + */

--=20
With Best Regards,
Andy Shevchenko

