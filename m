Return-Path: <linux-acpi+bounces-10599-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F1DA10977
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4ED162643
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53664147C71;
	Tue, 14 Jan 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyZhaqu6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA64232437;
	Tue, 14 Jan 2025 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865215; cv=none; b=UruQWNqtu3s78HesdMCoTlntpascSI6jQzqk8vpFtw1gQRaZMRGo+mnOJJOOnAudBQWTF7jsdt2sh+6SsDII407FiWoIfPPYEhc/bEEBeOfRxnEhIl6qpRoNaStD2QoBNvDvLobRRPg5he7eg8qUkBE3mDQ1J5giAQObLmwaAp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865215; c=relaxed/simple;
	bh=+p0a7Qpgx/8UNlXrlPhrD2NzEEQtfFTWpS0COnc0UbM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R3DvnHWC3CkSqftB5+kUHRKSyjfPBU6lW8vrZ4G4XCzdTCDOj9niY7aCHJzqkGWSbtiJ724qJLGcGIUG5cDTZC0/bPUxdVZ+CnSTq0jyJWdv6iad0LQue7EWXBcauqXytqb+ztjHCvtKpkk23zPPD51ZITBpjtZ405depX5OH/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LyZhaqu6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736865214; x=1768401214;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=+p0a7Qpgx/8UNlXrlPhrD2NzEEQtfFTWpS0COnc0UbM=;
  b=LyZhaqu6r4gbr1p/6YbuRLbFO72rO+O+SB+qEE5H2RTL6DJOM1og8y19
   RytnygWJ6zREg9+aTesyMtcfLqGJYnO28HsLP02FAQGWZSUsCmcB6ruW1
   cQdRPgFdwoY/YO2Coad6t+EyWcZmFesefnFRLt55ukhgqU9L216PvB72S
   swXxS45JkvmSxgZ2UOmyHkoLsv08tohVpq3LMZ8laIrTlC1EEFrTIbCWL
   zFGg9SW+Vf3XJWAA3a6+yVm037mVrvZussebOt/oxILIfEry+8H1lGNUp
   NOgSd5TWsALxbv/O33jc/iUHaGo0M422p56Zp6bZZWxIw8aQVxK8D2vvE
   A==;
X-CSE-ConnectionGUID: LqE7jjgCSWm1Nw7wxb4svw==
X-CSE-MsgGUID: RSTYQj8UQOu7TxUe7Gzx3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="48164634"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="48164634"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 06:33:33 -0800
X-CSE-ConnectionGUID: e1670AI8THCLsvPMveL6cw==
X-CSE-MsgGUID: 9rmFUu5DRvig9bjjBkaUvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105311887"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 06:33:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 Jan 2025 16:33:25 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org, 
    W_Armin@gmx.de, Hans de Goede <hdegoede@redhat.com>, lenb@kernel.org, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    mario.limonciello@amd.com, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    soyer@irl.hu
Subject: Re: [PATCH v2 1/2] ACPI: platform_profile: Add
 devm_platform_profile_register()
In-Reply-To: <CAJZ5v0jRkDx1E+mW0dhD2f9Ow8GxeT-8AvYjcZOvoYC2+J07jg@mail.gmail.com>
Message-ID: <925e1bb3-f21a-553e-24ce-6ef09ef7b4e7@linux.intel.com>
References: <20241224140131.30362-2-kuurtb@gmail.com> <20241224140131.30362-4-kuurtb@gmail.com> <CAJZ5v0jRkDx1E+mW0dhD2f9Ow8GxeT-8AvYjcZOvoYC2+J07jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1032797698-1736864604=:1077"
Content-ID: <e41dab97-0fc5-ed4d-e9bb-bcda59b38e41@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1032797698-1736864604=:1077
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <fe274342-d328-b63c-2d26-ae89786d195c@linux.intel.com>

On Tue, 14 Jan 2025, Rafael J. Wysocki wrote:

> On Tue, Dec 24, 2024 at 3:02=E2=80=AFPM Kurt Borja <kuurtb@gmail.com> wro=
te:
> >
> > Platform profile's lifetime is usually tied to a device's lifetime,
> > therefore add a device managed version of platform_profile_register().
> >
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>=20
> This is fine by me, so
>=20
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> and I think that it would be better to route it via platform/x86 along
> with the second patch.

That's were it already is among the other platform profile changes.

We still have one big platform profile series pending (though Kurt needs=20
to do small tweaks still into it before it can be applied):

https://lore.kernel.org/all/20250109150731.110799-1-kuurtb@gmail.com/

--=20
 i.

> > ---
> >  drivers/acpi/platform_profile.c  | 29 +++++++++++++++++++++++++++++
> >  include/linux/platform_profile.h |  1 +
> >  2 files changed, 30 insertions(+)
> >
> > diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pr=
ofile.c
> > index 75a1415190ac..4c4200a0b1a6 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -519,6 +519,35 @@ int platform_profile_remove(struct platform_profil=
e_handler *pprof)
> >  }
> >  EXPORT_SYMBOL_GPL(platform_profile_remove);
> >
> > +static void devm_platform_profile_release(struct device *dev, void *re=
s)
> > +{
> > +       struct platform_profile_handler **pprof =3D res;
> > +
> > +       platform_profile_remove(*pprof);
> > +}
> > +
> > +int devm_platform_profile_register(struct platform_profile_handler *pp=
rof)
> > +{
> > +       struct platform_profile_handler **dr;
> > +       int ret;
> > +
> > +       dr =3D devres_alloc(devm_platform_profile_release, sizeof(*dr),=
 GFP_KERNEL);
> > +       if (!dr)
> > +               return -ENOMEM;
> > +
> > +       ret =3D platform_profile_register(pprof);
> > +       if (ret) {
> > +               devres_free(dr);
> > +               return ret;
> > +       }
> > +
> > +       *dr =3D pprof;
> > +       devres_add(pprof->dev, dr);
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_platform_profile_register);
> > +
> >  static int __init platform_profile_init(void)
> >  {
> >         int err;
> > diff --git a/include/linux/platform_profile.h b/include/linux/platform_=
profile.h
> > index 0682bb4c57e5..f1cd4b65e351 100644
> > --- a/include/linux/platform_profile.h
> > +++ b/include/linux/platform_profile.h
> > @@ -41,6 +41,7 @@ struct platform_profile_handler {
> >
> >  int platform_profile_register(struct platform_profile_handler *pprof);
> >  int platform_profile_remove(struct platform_profile_handler *pprof);
> > +int devm_platform_profile_register(struct platform_profile_handler *pp=
rof);
> >  int platform_profile_cycle(void);
> >  void platform_profile_notify(struct platform_profile_handler *pprof);
> >
> > --
> > 2.47.1
> >
>=20
--8323328-1032797698-1736864604=:1077--

