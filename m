Return-Path: <linux-acpi+bounces-9319-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C339BD11C
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C3491C219E7
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D5613D881;
	Tue,  5 Nov 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0+UgyEe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A21824BD;
	Tue,  5 Nov 2024 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822070; cv=none; b=lKjq3XCy2GIlU2Hb8O7+aoSBROgHyc3CgKB3DYbH/F2kzZzGajJnbtA8fQrwhhdDFpJxb3GJb3tIcN6ad41vvbqEUOc/nL8E3Jvq9tLylgl/6QQJ/6oG2hZlJ4juEvRNhFMos2veD8Yl7VtO//nnK5SbFB705fvwbc7nJBMomrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822070; c=relaxed/simple;
	bh=BGPFAVlm3k3zXnI1wXGr2t00y+WfCF4NssA0VmQIOhs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eobdmyBxLn2/q+Q/coJZzE25fSYp9CJd/xgE81zJ1HXPX8uCz1BIgv9AYcMDjXdgIiTgA8QnbpOJUh7L13wF4vn14c7ahn4guaEAQidpNiasSmmy1U2Tj9cppOcv7zOnV0vNkYP9MjQRi4lQoyt9/eLO5ac6TKC+blh9zgway1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0+UgyEe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730822069; x=1762358069;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BGPFAVlm3k3zXnI1wXGr2t00y+WfCF4NssA0VmQIOhs=;
  b=c0+UgyEe89WLC2OtvQS+dV5EOrz+h1QKgtLzrLhySIXnTROJuz0iQzc3
   Ur2duqjw5H/jfyQkW5L7n+RmLh0Z4qlHmE/GWLrmADM0CpIVB7MK4LVDd
   9qK/HaXP2YWOAO+NLpboANQFus55Z9TPPLQPzI+TmvxiB208qyQTCfnDH
   ZrxFkKc/SikGcgKgqSzhd8Dq0REa8gS2YgRjQhHrRAxELus2pAGRmjpAX
   yl1i2cyV7u8+Zz6i97XNaIvNowgEAB78HIcp22MXDI4UgyFVlWk0gzlIC
   8dyKIKT6inCHeirrpXIlHhGv5HzSZhO30CNJoroM62/yl358AxUp8Mv69
   w==;
X-CSE-ConnectionGUID: M5oQtnA2Q/ywwlZx87iP1w==
X-CSE-MsgGUID: oxccfTU1QtOGIbfzIku5AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="41949492"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="41949492"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:54:19 -0800
X-CSE-ConnectionGUID: 3X29JoASSECyBTaniMj7jQ==
X-CSE-MsgGUID: uoOVPAKuSWWXtgIessZcnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="88579678"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:54:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 5 Nov 2024 17:54:08 +0200 (EET)
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
Subject: Re: [PATCH v4 08/20] ACPI: platform_profile: Use
 `scoped_cond_guard`
In-Reply-To: <20241105153316.378-9-mario.limonciello@amd.com>
Message-ID: <8634a0f9-fe38-08f9-8a75-6b5b1bcd3b7e@linux.intel.com>
References: <20241105153316.378-1-mario.limonciello@amd.com> <20241105153316.378-9-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2016531546-1730822048=:949"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2016531546-1730822048=:949
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 5 Nov 2024, Mario Limonciello wrote:

> Migrate away from using an interruptible mutex to scoped_cond_guard
> in all functions.
>=20
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 114 ++++++++++++--------------------
>  1 file changed, 44 insertions(+), 70 deletions(-)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index 4454c4a903c8f..fd1c4e9dccf0a 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -27,25 +27,21 @@ static ssize_t platform_profile_choices_show(struct d=
evice *dev,
>  =09=09=09=09=09char *buf)
>  {
>  =09int len =3D 0;
> -=09int err, i;
> -
> -=09err =3D mutex_lock_interruptible(&profile_lock);
> -=09if (err)
> -=09=09return err;
> -
> -=09if (!cur_profile) {
> -=09=09mutex_unlock(&profile_lock);
> -=09=09return -ENODEV;
> -=09}
> -
> -=09for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
> -=09=09if (len =3D=3D 0)
> -=09=09=09len +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
> -=09=09else
> -=09=09=09len +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
> +=09int i;
> +
> +=09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +=09=09if (!cur_profile)
> +=09=09=09return -ENODEV;
> +
> +=09=09for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST) {
> +=09=09=09if (len =3D=3D 0)
> +=09=09=09=09len +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
> +=09=09=09else
> +=09=09=09=09len +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
> +=09=09}
>  =09}
>  =09len +=3D sysfs_emit_at(buf, len, "\n");
> -=09mutex_unlock(&profile_lock);
> +
>  =09return len;
>  }
> =20
> @@ -56,20 +52,15 @@ static ssize_t platform_profile_show(struct device *d=
ev,
>  =09enum platform_profile_option profile =3D PLATFORM_PROFILE_BALANCED;
>  =09int err;
> =20
> -=09err =3D mutex_lock_interruptible(&profile_lock);
> -=09if (err)
> -=09=09return err;
> +=09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +=09=09if (!cur_profile)
> +=09=09=09return -ENODEV;
> =20
> -=09if (!cur_profile) {
> -=09=09mutex_unlock(&profile_lock);
> -=09=09return -ENODEV;
> +=09=09err =3D cur_profile->profile_get(cur_profile, &profile);
> +=09=09if (err)
> +=09=09=09return err;
>  =09}
> =20
> -=09err =3D cur_profile->profile_get(cur_profile, &profile);
> -=09mutex_unlock(&profile_lock);
> -=09if (err)
> -=09=09return err;
> -
>  =09/* Check that profile is valid index */
>  =09if (WARN_ON((profile < 0) || (profile >=3D ARRAY_SIZE(profile_names))=
))
>  =09=09return -EIO;
> @@ -88,28 +79,20 @@ static ssize_t platform_profile_store(struct device *=
dev,
>  =09if (i < 0)
>  =09=09return -EINVAL;
> =20
> -=09err =3D mutex_lock_interruptible(&profile_lock);
> -=09if (err)
> -=09=09return err;
> +=09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +=09=09if (!cur_profile)
> +=09=09=09return -ENODEV;
> =20
> -=09if (!cur_profile) {
> -=09=09mutex_unlock(&profile_lock);
> -=09=09return -ENODEV;
> -=09}
> +=09=09/* Check that platform supports this profile choice */
> +=09=09if (!test_bit(i, cur_profile->choices))
> +=09=09=09return -EOPNOTSUPP;
> =20
> -=09/* Check that platform supports this profile choice */
> -=09if (!test_bit(i, cur_profile->choices)) {
> -=09=09mutex_unlock(&profile_lock);
> -=09=09return -EOPNOTSUPP;
> +=09=09err =3D cur_profile->profile_set(cur_profile, i);
> +=09=09if (err)
> +=09=09=09return err;
>  =09}
> =20
> -=09err =3D cur_profile->profile_set(cur_profile, i);
> -=09if (!err)
> -=09=09sysfs_notify(acpi_kobj, NULL, "platform_profile");
> -
> -=09mutex_unlock(&profile_lock);
> -=09if (err)
> -=09=09return err;
> +=09sysfs_notify(acpi_kobj, NULL, "platform_profile");

Hi Mario,

While I think it's fine, could you please mention about this move outside=
=20
of the lock in the commit message.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

>  =09return count;
>  }
> =20
> @@ -140,36 +123,27 @@ int platform_profile_cycle(void)
>  =09enum platform_profile_option next;
>  =09int err;
> =20
> -=09err =3D mutex_lock_interruptible(&profile_lock);
> -=09if (err)
> -=09=09return err;
> +=09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +=09=09if (!cur_profile)
> +=09=09=09return -ENODEV;
> =20
> -=09if (!cur_profile) {
> -=09=09mutex_unlock(&profile_lock);
> -=09=09return -ENODEV;
> -=09}
> +=09=09err =3D cur_profile->profile_get(cur_profile, &profile);
> +=09=09if (err)
> +=09=09=09return err;
> =20
> -=09err =3D cur_profile->profile_get(cur_profile, &profile);
> -=09if (err) {
> -=09=09mutex_unlock(&profile_lock);
> -=09=09return err;
> -=09}
> +=09=09next =3D find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE=
_LAST,
> +=09=09=09=09=09  profile + 1);
> =20
> -=09next =3D find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LA=
ST,
> -=09=09=09=09  profile + 1);
> +=09=09if (WARN_ON(next =3D=3D PLATFORM_PROFILE_LAST))
> +=09=09=09return -EINVAL;
> =20
> -=09if (WARN_ON(next =3D=3D PLATFORM_PROFILE_LAST)) {
> -=09=09mutex_unlock(&profile_lock);
> -=09=09return -EINVAL;
> +=09=09err =3D cur_profile->profile_set(cur_profile, next);
> +=09=09if (err)
> +=09=09=09return err;
>  =09}
> =20
> -=09err =3D cur_profile->profile_set(cur_profile, next);
> -=09mutex_unlock(&profile_lock);
> -
> -=09if (!err)
> -=09=09sysfs_notify(acpi_kobj, NULL, "platform_profile");
> -
> -=09return err;
> +=09sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +=09return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_cycle);
> =20
>=20
--8323328-2016531546-1730822048=:949--

