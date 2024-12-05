Return-Path: <linux-acpi+bounces-9943-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7442A9E5501
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 13:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4E428721D
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 12:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9589A21773D;
	Thu,  5 Dec 2024 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maIL140T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9291DF971;
	Thu,  5 Dec 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400451; cv=none; b=LW6kU5Np7mFkwXom4uG13ylotVfRrg/MbXwTcONwX8f7ffJB91ski+mnXDxakirUZb1xf0Q9XRq8Q1vO9yhWqyE5kIDS41hYquMtq2JBlPI0ow1LOPGY6EkqL70JaDlHm/38lmJHXMQc6nwCJYK9kQdQxPSnU9gqI9bLT4XKHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400451; c=relaxed/simple;
	bh=j74VPbSRiXpar4o6mewBxkcfcwojp/Cg0B8Nv/uYEoE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PkfYL4uI6afPtufqQL/AN3EQIdbYwXCJz5hQB1vFHLciVLPwSkZIroTvyLlozKdFpA2rGcFA98u/9GtMmUMJvhfdvXRFA/RasaOhemp9XZmuHYinLSQF/1RKuLXWz573t58QlKN7RqCnWKxrsCJkZA9KGwoDkvCt4DIyFpvh1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maIL140T; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733400450; x=1764936450;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=j74VPbSRiXpar4o6mewBxkcfcwojp/Cg0B8Nv/uYEoE=;
  b=maIL140TrNU3bngX6akp6di+7qy1s2k90wBSHY85RvW4182j1iI7fSki
   NB/ahh46S4Urk+/H3D7HnaLbBN3CSAW/8Tsmp7SQkeCXsngrthhHf8d6X
   H/B7PU5bWPsT+tDP0+Zwl0u/KrqogexI8f6dEF0TcNiHkY6hXR4uOrcGB
   +d4VDRRjDynL0BmY73M/iIMgEiRHhVPls8wLDssOUsxSVFEf/Rs9w/60z
   tp67uzzO9KkBQKLQugh/09zr0VHymSRs/lEGKrD7JtCGPdoPvd+Vwd/eq
   Oa57l8nkcU9Mf0hYR1fsp9tTIrD2B55LApn5Sr394USMldCzP+d621e1V
   w==;
X-CSE-ConnectionGUID: XkxUS0qkStmudwN1Z5H8iQ==
X-CSE-MsgGUID: S9+rcyosTOGNovtxl4mXxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="45086751"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="45086751"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 04:07:29 -0800
X-CSE-ConnectionGUID: 3n40lhloQ/OSY4Vffte3/Q==
X-CSE-MsgGUID: Uo43ypmjTxeG1Iw/EUoUNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="98143774"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 04:07:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 14:07:17 +0200 (EET)
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
Subject: Re: [PATCH v9 17/22] ACPI: platform_profile: Make sure all profile
 handlers agree on profile
In-Reply-To: <20241202055031.8038-18-mario.limonciello@amd.com>
Message-ID: <db9f4923-168f-2688-5f1d-f7c04273f58e@linux.intel.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com> <20241202055031.8038-18-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-509302721-1733400374=:932"
Content-ID: <bbb1f25c-d76d-8d22-711d-8b6c6d36dab3@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-509302721-1733400374=:932
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <6fac8fbb-2520-a2e7-57a9-70200d1faec9@linux.intel.com>

On Sun, 1 Dec 2024, Mario Limonciello wrote:

> If for any reason multiple profile handlers don't agree on the profile
> return the custom profile.
>=20
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 119 ++++++++++++++++++++++++++------
>  1 file changed, 96 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index a9cd13c5fd39b..d5f0679d59d50 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -66,6 +66,22 @@ static int _store_class_profile(struct device *dev, vo=
id *data)
>  =09return handler->profile_set(handler, *bit);
>  }
> =20
> +/**
> + * _notify_class_profile - Notify the class device of a profile change
> + * @dev: The class device
> + * @data: Unused
> + */
> +static int _notify_class_profile(struct device *dev, void *data)
> +{
> +=09struct platform_profile_handler *handler =3D dev_get_drvdata(dev);
> +
> +=09lockdep_assert_held(&profile_lock);
> +=09sysfs_notify(&handler->class_dev->kobj, NULL, "profile");
> +=09kobject_uevent(&handler->class_dev->kobj, KOBJ_CHANGE);
> +
> +=09return 0;
> +}
> +
>  /**
>   * get_class_profile - Show the current profile for a class device
>   * @dev: The class device
> @@ -246,51 +262,108 @@ static ssize_t platform_profile_choices_show(struc=
t device *dev,
>  =09return _commmon_choices_show(aggregate, buf);
>  }
> =20
> +/**
> + * _aggregate_profiles - Aggregate the profiles for legacy sysfs interfa=
ce
> + * @dev: The device
> + * @data: The profile to return

Please leave an empty row after args (obviously with the * continuation).=
=20
Check all kerneldocs in the series for this.

> + * Return: 0 on success, -errno on failure
> + */
> +static int _aggregate_profiles(struct device *dev, void *data)
> +{
> +=09enum platform_profile_option *profile =3D data;
> +=09enum platform_profile_option val;
> +=09int err;
> +
> +=09err =3D get_class_profile(dev, &val);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (*profile !=3D PLATFORM_PROFILE_LAST && *profile !=3D val)
> +=09=09*profile =3D PLATFORM_PROFILE_CUSTOM;
> +=09else
> +=09=09*profile =3D val;
> +
> +=09return 0;
> +}
> +
> +/**
> + * _store_and_notify - Atomically store and notify a class from legacy s=
ysfs interface

I'm a bit unsure what "atomically" means in this context. If it relates to=
=20
_store_class_profile() only, that function didn't use "atomically" in its=
=20
kerneldoc.

> + * @dev: The device
> + * @data: The profile to return
> + * Return: 0 on success, -errno on failure
> + */
> +static int _store_and_notify(struct device *dev, void *data)
> +{
> +=09enum platform_profile_option *profile =3D data;
> +=09int err;
> +
> +=09err =3D _store_class_profile(dev, profile);
> +=09if (err)
> +=09=09return err;
> +=09return _notify_class_profile(dev, NULL);
> +}
> +
> +/**
> + * platform_profile_show - Show the current profile for legacy sysfs int=
erface
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to
> + * Return: The number of bytes written
> + */
>  static ssize_t platform_profile_show(struct device *dev,
> -=09=09=09=09=09struct device_attribute *attr,
> -=09=09=09=09=09char *buf)
> +=09=09=09=09     struct device_attribute *attr,
> +=09=09=09=09     char *buf)
>  {
> -=09enum platform_profile_option profile =3D PLATFORM_PROFILE_BALANCED;
> +=09enum platform_profile_option profile =3D PLATFORM_PROFILE_LAST;
>  =09int err;
> =20
>  =09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -=09=09if (!cur_profile)
> -=09=09=09return -ENODEV;
> -
> -=09=09err =3D cur_profile->profile_get(cur_profile, &profile);
> +=09=09err =3D class_for_each_device(&platform_profile_class, NULL,
> +=09=09=09=09=09    &profile, _aggregate_profiles);
>  =09=09if (err)
>  =09=09=09return err;
>  =09}
> =20
> -=09/* Check that profile is valid index */
> -=09if (WARN_ON((profile < 0) || (profile >=3D ARRAY_SIZE(profile_names))=
))
> -=09=09return -EIO;
> +=09/* no profile handler registered any more */
> +=09if (profile =3D=3D PLATFORM_PROFILE_LAST)
> +=09=09return -EINVAL;
> =20
>  =09return sysfs_emit(buf, "%s\n", profile_names[profile]);
>  }
> =20
> +/**
> + * platform_profile_store - Set the profile for legacy sysfs interface
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to read from
> + * @count: The number of bytes to read
> + * Return: The number of bytes read
> + */
>  static ssize_t platform_profile_store(struct device *dev,
> -=09=09=09    struct device_attribute *attr,
> -=09=09=09    const char *buf, size_t count)
> +=09=09=09=09      struct device_attribute *attr,
> +=09=09=09=09      const char *buf, size_t count)
>  {
> -=09int err, i;
> +=09unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +=09int ret;
> +=09int i;
> =20
>  =09/* Scan for a matching profile */
>  =09i =3D sysfs_match_string(profile_names, buf);
> -=09if (i < 0)
> +=09if (i < 0 || i =3D=3D PLATFORM_PROFILE_CUSTOM)
>  =09=09return -EINVAL;
> -
> +=09set_bit(PLATFORM_PROFILE_LAST, choices);
>  =09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -=09=09if (!cur_profile)
> -=09=09=09return -ENODEV;
> -
> -=09=09/* Check that platform supports this profile choice */
> -=09=09if (!test_bit(i, cur_profile->choices))
> +=09=09ret =3D class_for_each_device(&platform_profile_class, NULL,
> +=09=09=09=09=09    choices, _aggregate_choices);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09if (!test_bit(i, choices))
>  =09=09=09return -EOPNOTSUPP;
> =20
> -=09=09err =3D cur_profile->profile_set(cur_profile, i);
> -=09=09if (err)
> -=09=09=09return err;
> +=09=09ret =3D class_for_each_device(&platform_profile_class, NULL, &i,
> +=09=09=09=09=09    _store_and_notify);
> +=09=09if (ret)
> +=09=09=09return ret;
>  =09}
> =20
>  =09sysfs_notify(acpi_kobj, NULL, "platform_profile");
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.
--8323328-509302721-1733400374=:932--

