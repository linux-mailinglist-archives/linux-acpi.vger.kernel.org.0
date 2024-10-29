Return-Path: <linux-acpi+bounces-9084-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F1D9B4FCB
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 17:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 969D5B23321
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB3E1A0700;
	Tue, 29 Oct 2024 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0iCu+bq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD219A2A3;
	Tue, 29 Oct 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220652; cv=none; b=ge81LmMumX552yrFrBsaEJfbWMWdwtt0Hs/DWivEIgQcM2j7GzXwvkTLSeajXjY89gXGLBJwjz/FOSzqzJLYa/ZD2e9IljfiVdaH1t8VbIiYx5NwS4SA0zJsKHAcXh5gE9tw8406SVHvmsqPdLtHGaC1HoqfHBi0SvgaCentoYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220652; c=relaxed/simple;
	bh=/JLFGbEBdIsMO3f/VULfeC0oqd2lpISi2IVf10Hub/U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=trPUeB+jBSuNKbb2DETH9ohKLcH3FGqWrJa6BlHZuQKdh8EB6zelyzFplCaBkKJNy4AnTIAu/B3zpWjTC2MCFZ9NeXFpo3IHnEPg+L5MAfIV8zI7KUIMtKElwlwou11n6FuOcgeTKydX9sIgW8LsKZbeDFTS/1via9qgN9qMVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0iCu+bq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730220650; x=1761756650;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=/JLFGbEBdIsMO3f/VULfeC0oqd2lpISi2IVf10Hub/U=;
  b=Y0iCu+bqZgEQj0hM8Mx2ddNgGOfjskMBKVvh32wTwiO3PyM/nTywwHeP
   XnmRp3fHXOgQhwOTaIamsupSat+v7RRia4xAsn5UqmRtJcEhGKXVn7akt
   stTpC0I1Qi+5jzYaZTe45Ifusrj9e8Hp8mD2jhqTa92rYsk2F1nGZZ8w/
   rjutb6QToa6is46HlSLgI84KnF3nU7m/b66kGefhMR14OeF/575YZjBfS
   PtwhEnAeYMmqRBfGhByY/5sBMmjv/KeJdkq0rZ/3riIOb47tOizOp6mJu
   LUsO8N9MF2QKZzi7Sn0/WjUvkOdiWCc6Pe/tFclt0slTWR4Pi++DSM1BX
   Q==;
X-CSE-ConnectionGUID: H5eFNjSuSuyaRlzz7tJcGA==
X-CSE-MsgGUID: Am2CF7oKQe21yEthXMTxFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47338098"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47338098"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 09:50:49 -0700
X-CSE-ConnectionGUID: 1Y+iafVoQuSJ1cbsokGDbg==
X-CSE-MsgGUID: Xtj+9gXxThe9cc+oA4pPJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82350133"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 09:50:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 18:50:40 +0200 (EET)
To: Mario Limonciello <mario.limonciello@amd.com>
cc: Hans de Goede <hdegoede@redhat.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Alexis Belmonte <alexbelm48@gmail.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
    Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:ACPI" <linux-acpi@vger.kernel.org>, 
    "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER" <platform-driver-x86@vger.kernel.org>, 
    "open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: Re: [PATCH v2 11/15] ACPI: platform_profile: Set profile for all
 registered handlers
In-Reply-To: <3fc47497-de43-4d77-8352-d6c0886e2db0@amd.com>
Message-ID: <f65998f4-6396-9cff-09a1-6ee2a49dc254@linux.intel.com>
References: <20241028020131.8031-1-mario.limonciello@amd.com> <20241028020131.8031-12-mario.limonciello@amd.com> <46e19bc3-2624-f4b9-a946-050c92c0591d@linux.intel.com> <3fc47497-de43-4d77-8352-d6c0886e2db0@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-271467047-1730220242=:951"
Content-ID: <b21a3af0-f730-498f-24ac-25c0ab2e6119@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-271467047-1730220242=:951
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <1105b7d3-591d-a080-82c3-384db45f4a66@linux.intel.com>

On Tue, 29 Oct 2024, Mario Limonciello wrote:

> On 10/29/2024 05:22, Ilpo J=E4rvinen wrote:
> > On Sun, 27 Oct 2024, Mario Limonciello wrote:
> >=20
> > > If multiple platform profile handlers have been registered then when
> > > setting a profile verify that all profile handlers support the reques=
ted
> > > profile and set it to each handler.
> > >=20
> > > If this fails for any given handler, revert all profile handlers back=
 to
> > > balanced and log an error into the kernel ring buffer.
> > >=20
> > > Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/acpi/platform_profile.c | 47 ++++++++++++++++++------------=
---
> > >   1 file changed, 26 insertions(+), 21 deletions(-)
> > >=20
> > > diff --git a/drivers/acpi/platform_profile.c
> > > b/drivers/acpi/platform_profile.c
> > > index a83842f05022b..db2ebd0393cf7 100644
> > > --- a/drivers/acpi/platform_profile.c
> > > +++ b/drivers/acpi/platform_profile.c
> > > @@ -105,37 +105,42 @@ static ssize_t platform_profile_store(struct de=
vice
> > > *dev,
> > >   =09=09=09    struct device_attribute *attr,
> > >   =09=09=09    const char *buf, size_t count)
> > >   {
> > > +=09struct platform_profile_handler *handler;
> > > +=09unsigned long choices;
> > >   =09int err, i;
> > >   -=09err =3D mutex_lock_interruptible(&profile_lock);
> > > -=09if (err)
> > > -=09=09return err;
> > > -
> > > -=09if (!cur_profile) {
> > > -=09=09mutex_unlock(&profile_lock);
> > > -=09=09return -ENODEV;
> > > -=09}
> > > -
> > >   =09/* Scan for a matching profile */
> > >   =09i =3D sysfs_match_string(profile_names, buf);
> > >   =09if (i < 0) {
> > > -=09=09mutex_unlock(&profile_lock);
> > >   =09=09return -EINVAL;
> > >   =09}
> > >   -=09/* Check that platform supports this profile choice */
> > > -=09if (!test_bit(i, cur_profile->choices)) {
> > > -=09=09mutex_unlock(&profile_lock);
> > > -=09=09return -EOPNOTSUPP;
> > > -=09}
> > > +=09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)=
 {
> >=20
> > You made guard() conversions in the earlier patch but for some reason
> > left scoped_cond_guard() ones mixed into other changes still. Is there
> > a very good reason for that?
> >=20
>=20
> Using scoped_cond_guard() requires changing the indentation which meant a=
 bit
> of back and forth with code coming and going.  If you think it makes more
> sense to split up even considering the indentation changes I'll do anothe=
r set
> of patches for the scoped_cond_guard changes only.

There are ways to combat indentation changes while reviewing. However,=20
it's a strange argument to bring up because now there are indentation=20
changes in these patches exactly because you chose to make the=20
scoped_cond_guard() change "while at it" rather than in a separate patch.

I believe the patches will become cleaner and easier to review if you do=20
scoped_cond_guard() change separate from any other logic changes.

--=20
 i.
--8323328-271467047-1730220242=:951--

