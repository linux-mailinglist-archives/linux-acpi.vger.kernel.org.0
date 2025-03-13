Return-Path: <linux-acpi+bounces-12190-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD15A5F509
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 13:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FABF1710CE
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C882676E1;
	Thu, 13 Mar 2025 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NEGqvYJF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AD3266590;
	Thu, 13 Mar 2025 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870671; cv=none; b=OP679ktn34Z1h8dSnNR9b/uDiLbXOYxDPhv4fnUfE/FK7bHSTWJdEnppylRwREZFl1Fbec5SbBtxj+zCODHQiEJ0YygUm/v1v4v9DO5fchW1ClZnJlI6yQwQwQzYQYC3ZNjaMaCjA0Qo0vaGTyQ4USk2d+L2azgibXJsS/iNiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870671; c=relaxed/simple;
	bh=GXSrNVtULo+0+7K7FBMVP5WHNDAwiHeua2HaRBE75FU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LuEVMV/gOBxnV9FbV0df8k7o8vCMyMAm7orpzsh1a5C677HorPsvvEN0RSJFSdtWrNlRIeFfHbD0Jk/GM4CGDWcQn6lRCCV+olf5xqDKwpqWtkN7TXne+/JY3dAB9q24M4JuzECFFLItrnvdApX08UA1D5KYynxB65jbbBAzI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NEGqvYJF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741870670; x=1773406670;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GXSrNVtULo+0+7K7FBMVP5WHNDAwiHeua2HaRBE75FU=;
  b=NEGqvYJFuOIunpqE6iwdJKiJMI6g2Mdk9RQ7KJ8T2dnvOgSYBnInzf9V
   HPo1f+RzfNL5scfROqhVZH6aBJN9vSfyOO2MXH85dJolOPlhd9VXXn0Vu
   ZAZ5zIBKE0RbUUUg1Rg/pd7dOni9aelqk7Q1hVEs4cvEwH5OCEkk/h3AQ
   IKUOITK/BgBQZlls/Pzvgz8MrM2bZzmWEsG7ERCT6lURTH+POYRGiuSZN
   yHXTsUrvR8g3Vg6QEcUUXXhXPMEJKYycG5C2tpjX1OGZh7LHTsBce2a6w
   6/+VrEau7P4Bkx7ld4jNR8aHDoLZGvVSpX2JFx4INUFv2a4EYW1OnGUQ1
   A==;
X-CSE-ConnectionGUID: SD1MYQWdTIuIU9dgRUxopQ==
X-CSE-MsgGUID: GU3uGnT+S32N0NHQC4LXQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53620994"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53620994"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:57:49 -0700
X-CSE-ConnectionGUID: +WOJN2tWSdq6J7BX0EKXCw==
X-CSE-MsgGUID: oSCUU8f6RmSQdHJ35qKP5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120940794"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:57:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Mar 2025 14:57:40 +0200 (EET)
To: Mario Limonciello <superm1@kernel.org>
cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, "Luke D . Jones" <luke@ljones.dev>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:ACPI" <linux-acpi@vger.kernel.org>, 
    "Derek J . Clark" <derekjohn.clark@gmail.com>, 
    Antheas Kapenekakis <lkml@antheas.dev>, me@kylegospodneti.ch, 
    Denis Benato <benato.denis96@gmail.com>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    Yijun Shen <Yijun.Shen@dell.com>
Subject: Re: [PATCH] platform/x86/amd: pmf: Fix missing hidden options for
 Smart PC
In-Reply-To: <88e95b2f-3ffa-4876-a83b-38d25ac9cbc2@kernel.org>
Message-ID: <f29edbaa-90d8-10ce-76c6-4c786b90cd9b@linux.intel.com>
References: <20250306034402.50478-1-superm1@kernel.org> <50adcc9d-241d-19b6-7b03-2e91ef7d017b@linux.intel.com> <88e95b2f-3ffa-4876-a83b-38d25ac9cbc2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1089346082-1741870660=:1742"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1089346082-1741870660=:1742
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 12 Mar 2025, Mario Limonciello wrote:

>=20
>=20
> On 3/10/25 12:19, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 5 Mar 2025, Mario Limonciello wrote:
> >=20
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > >=20
> > > amd_pmf_get_slider_info() checks the current profile to report correc=
t
> > > value to the TA inputs.  If hidden options are in use then the wrong
> > > values will be reported to TA.
> > >=20
> > > Add the two compat options PLATFORM_PROFILE_BALANCED_PERFORMANCE and
> > > PLATFORM_PROFILE_QUIET for this use.
> > >=20
> > > Reported-by: Yijun Shen <Yijun.Shen@dell.com>
> > > Fixes: 9a43102daf64d ("platform/x86/amd: pmf: Add balanced-performanc=
e to
> > > hidden choices")
> > > Fixes: 44e94fece5170 ("platform/x86/amd: pmf: Add 'quiet' to hidden
> > > choices")
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/platform/x86/amd/pmf/spc.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/platform/x86/amd/pmf/spc.c
> > > b/drivers/platform/x86/amd/pmf/spc.c
> > > index f34f3130c3307..1d90f9382024b 100644
> > > --- a/drivers/platform/x86/amd/pmf/spc.c
> > > +++ b/drivers/platform/x86/amd/pmf/spc.c
> > > @@ -219,12 +219,14 @@ static int amd_pmf_get_slider_info(struct
> > > amd_pmf_dev *dev, struct ta_pmf_enact_
> > >     =09switch (dev->current_profile) {
> > >   =09case PLATFORM_PROFILE_PERFORMANCE:
> > > +=09case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
> > >   =09=09val =3D TA_BEST_PERFORMANCE;
> > >   =09=09break;
> > >   =09case PLATFORM_PROFILE_BALANCED:
> > >   =09=09val =3D TA_BETTER_PERFORMANCE;
> > >   =09=09break;
> > >   =09case PLATFORM_PROFILE_LOW_POWER:
> > > +=09case PLATFORM_PROFILE_QUIET:
> > >   =09=09val =3D TA_BEST_BATTERY;
> > >   =09=09break;
> > >   =09default:
> >=20
> > Hi Mario,
> >=20
> > Just for me to be sure what I'm supposed to do with all these patches
> > related to this platform profile legacy handling... :-)
> >=20
> > So this fix is necessary in addition to the 3 patches that got already
> > merged through Rafaels tree?
> >=20
> > What about this patch from Luke:
> >=20
> > https://patchwork.kernel.org/project/platform-driver-x86/patch/20250224=
223551.16918-1-luke@ljones.dev/
> >=20
> > Is that also needed?
> >=20
> > Thanks in advance.
> >=20
>=20
> Yes; this was another finding that Yijun discovered missing as part of te=
sting
> Rafael's tree.  It can go through your tree or Rafael's.  It doesn't real=
ly
> matter.

I took this into fixes branch.

> Luke's patch isn't needed anymore.

Okay, thanks.

--=20
 i.

--8323328-1089346082-1741870660=:1742--

