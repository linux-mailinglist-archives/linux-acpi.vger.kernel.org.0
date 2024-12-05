Return-Path: <linux-acpi+bounces-9951-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9179E59A0
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 16:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DDA166FA3
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 15:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4E721C174;
	Thu,  5 Dec 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsbMk/18"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCB21A45F;
	Thu,  5 Dec 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412186; cv=none; b=u3qO5d7xCiGtGXnjvc79NPvvJFCEz3oxE6DVn8h7O+9/40V86GcHGFHURjUuKuwufqgrW2l8ATzOQuaaeo8GsrGfXikHl++dR84qrQq0rysOwaCtCbQsloNAYqbNUEbEE+HM3CoKpTfd130J+dzVH1+sBILlPhppRy//V6z82EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412186; c=relaxed/simple;
	bh=68rT7eccfDXM34HjsNIijz2qZxZcnXarxT5+sJcC3tg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NB7Av3zMArUdqFqcccSZdnT7uWRS7C1ZvvafBOvx0ooNqlaN9usUgbKDd4xKc3jhDpABlO/JQPHHFJ//kzwm795jh6rTEMaV4LKwr3pE4n4+f0TGueIoNbxDsa3x76bzclk3r3/Ca84UWBrtKSo1EoH6CLykXNzuC5xSGkdJyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsbMk/18; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733412185; x=1764948185;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=68rT7eccfDXM34HjsNIijz2qZxZcnXarxT5+sJcC3tg=;
  b=nsbMk/18gzubS3Srz704txx13hme0lrErlNR69TCJX21vqnF3qA4eNmc
   nqIiGFyC0vskJ8Ldjq58XBgJFXrEp1YFCtLch44uFO7KYyIdcdE8j5+iA
   KZall3CK5IOz8A1NQ0FE+bJOB578HW0Hu7rb/I165G+oVEe4QwILXDmn/
   XEN0a+JI5/9CCKz/V85en5yDyO71SnMpzUzNheRMU81ctjaQJPIV0o+Ha
   bKqG/G6ir/reMUtLO16VfAETkYitWdblPOobw00I/UX6D1vEYsivsmEzj
   eKPwNAtdCkJeuiScJnsp9F1P4JHqA/XzfnhI/CGhOhu8pexQJKyHGr46v
   Q==;
X-CSE-ConnectionGUID: fYPqBRFYSVWMyABqk/gzhg==
X-CSE-MsgGUID: UDRy14bASS2ck69uFChyGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33787593"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33787593"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 07:23:04 -0800
X-CSE-ConnectionGUID: 0fDD1PntSMurCykIZOuhHQ==
X-CSE-MsgGUID: U0fUJ6ZbSIKM/Wl6WEsHFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="93804835"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 07:22:58 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 17:22:55 +0200 (EET)
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
    Matthew Schwartz <matthew.schwartz@linux.dev>, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v9 18/22] ACPI: platform_profile: Check all profile
 handler to calculate next
In-Reply-To: <bd079286-b7c9-4231-b8d1-1b0bcf937997@amd.com>
Message-ID: <b3a7ece2-c49c-5c5a-c53b-99acc10f68fc@linux.intel.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com> <20241202055031.8038-19-mario.limonciello@amd.com> <fc57acd9-396c-e047-12c1-14836e477d14@linux.intel.com> <bd079286-b7c9-4231-b8d1-1b0bcf937997@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1665401580-1733411137=:932"
Content-ID: <9e98b26f-af5a-2256-4705-1be36175a89c@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1665401580-1733411137=:932
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <0f545e1e-bc5a-2c56-463b-3e91969e5334@linux.intel.com>

On Thu, 5 Dec 2024, Mario Limonciello wrote:

> On 12/5/2024 08:22, Ilpo J=E4rvinen wrote:
> > On Sun, 1 Dec 2024, Mario Limonciello wrote:
> >=20
> > > As multiple platform profile handlers might not all support the same
> > > profile, cycling to the next profile could have a different result
> > > depending on what handler are registered.
> > >=20
> > > Check what is active and supported by all handlers to decide what
> > > to do.
> > >=20
> > > Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> > > Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > > Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/acpi/platform_profile.c | 30 +++++++++++++++++++++---------
> > >   1 file changed, 21 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/drivers/acpi/platform_profile.c
> > > b/drivers/acpi/platform_profile.c
> > > index d5f0679d59d50..16746d9b9aa7c 100644
> > > --- a/drivers/acpi/platform_profile.c
> > > +++ b/drivers/acpi/platform_profile.c
> > > @@ -407,25 +407,37 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
> > >     int platform_profile_cycle(void)
> > >   {
> > > -=09enum platform_profile_option profile;
> > > -=09enum platform_profile_option next;
> > > +=09enum platform_profile_option next =3D PLATFORM_PROFILE_LAST;
> > > +=09enum platform_profile_option profile =3D PLATFORM_PROFILE_LAST;
> > > +=09unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> > >   =09int err;
> > >   +=09set_bit(PLATFORM_PROFILE_LAST, choices);
> > >   =09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock=
) {
> > > -=09=09if (!cur_profile)
> > > -=09=09=09return -ENODEV;
> > > +=09=09err =3D class_for_each_device(&platform_profile_class, NULL,
> > > +=09=09=09=09=09    &profile, _aggregate_profiles);
> > > +=09=09if (err)
> > > +=09=09=09return err;
> > >   -=09=09err =3D cur_profile->profile_get(cur_profile, &profile);
> > > +=09=09if (profile =3D=3D PLATFORM_PROFILE_CUSTOM ||
> > > +=09=09    profile =3D=3D PLATFORM_PROFILE_LAST)
> > > +=09=09=09return -EINVAL;
> > > +
> > > +=09=09err =3D class_for_each_device(&platform_profile_class, NULL,
> > > +=09=09=09=09=09    choices, _aggregate_choices);
> > >   =09=09if (err)
> > >   =09=09=09return err;
> > >   -=09=09next =3D find_next_bit_wrap(cur_profile->choices,
> > > PLATFORM_PROFILE_LAST,
> > > +=09=09/* never iterate into a custom if all drivers supported it */
> > > +=09=09clear_bit(PLATFORM_PROFILE_CUSTOM, choices);
> >=20
> > I'm confused by the comment. I was under impression the custom "profile=
"
> > is just a framework construct when the _framework_ couldn't find a
> > consistent profile? How can a driver decide to "support it"? It sounds
> > like a driver overstepping its intended domain of operation.
> >=20
> > If the intention really is for the driver to "support" or "not support"
> > custom profile, then you should adjust the commit message of the patch
> > which introduced it.
> >=20
>=20
> Yes I had envisioned that a driver could potentially set custom as well.
>=20
> This idea was introduced by my RFC series that precluded doing the
> multiple driver handlers.
>
> The basic idea is that some drivers (for example asus-wmi and asus-armour=
y)
> have the ability for the user to change a sysfs file that represents sPPT=
 or
> fPPT directly.

I recall that series.
=20
> If this has been done they're "off the beating path" of a predfined
> profile because they're picking and choosing individual knobs.

The user would still not set it to "custom" nor driver "support" it,=20
right? But it's a consequence of tuning those other knobs? Or do you mean=
=20
user would first have to set "custom" and tuning the knobs is blocked=20
otherwise?

> So if a user touches those a driver could set profile as "custom" and if =
a
> user chooses the platform profile the driver will override all of those a=
nd
> report a pre-defined profile.
>=20
> So, yes I had that all in my mind but as you point out I definitely forgo=
t to
> mention it in the commit messages.
>=20
> Do you agree with it?  If so, I'll amend the next version where applicabl=
e
> (probably the patch that introduces custom and the documentation patch).

I'm a little worried about overloading the meaning from mere profile=20
disagreement to truly off the charted waters travel. Albeit, I suppose=20
that overloading is just between global "custom" vs per-driver "custom",=20
the latter would never be "custom" in case of mere profile disagreement,=20
if I've understood everything correctly?

--=20
 i.
--8323328-1665401580-1733411137=:932--

