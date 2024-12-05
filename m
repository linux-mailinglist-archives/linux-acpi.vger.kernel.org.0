Return-Path: <linux-acpi+bounces-9941-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7249E547E
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 12:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2211675AC
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83CC213235;
	Thu,  5 Dec 2024 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BK2ihiRy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B4213229;
	Thu,  5 Dec 2024 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399267; cv=none; b=rD1e613wkjAN5c6CxXI6V6+paZRZzwDPGlRkBr/BhVVFgosoyYc26A5I+dh+5L5GMONKrltxxaCnCiBj1OfRktECfIw1UYHLJeq49BLXggx3o72Nhxt4db0uxUSBmiMxq74rPoaellHUWKRFgVz5byfjRX4KPSZZSLj9wjVnZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399267; c=relaxed/simple;
	bh=V/e/uNyI7Jm4sY0t8Aw33l/+eKGa/aBKJrKnCO6X2rc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MfXQAACCcfG2dYjC0YHsuLPeaEvuf5HWVUTK8i/n+bS2QMV2CRaLHQum5q5ZFMhXWhvIffdeBi/fG6mB3P3lq2E9EfNckyBY1MgYtXMCZkrZPQ+vRcDEWSFz+O8XeoUCCeikp44AmNgSOajeKsp8hl6nf2b4UGyg4x6S3D/laq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BK2ihiRy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733399266; x=1764935266;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=V/e/uNyI7Jm4sY0t8Aw33l/+eKGa/aBKJrKnCO6X2rc=;
  b=BK2ihiRyZt2wyK98gtZC/8MXqlQITTV2L4t4jUV0CD9Q1kh7NHuhayUf
   dqmpTwDkmg5mW9hCoX0eo0yoF3CZhW1y3XX4M1pmOTLXiTc2h9fJjs7RX
   LfeOd5eDQplx4W8LmSUBpkXPtt8Pb7TIisJxYsXmbHcCgKH7mTFGbk8Zo
   UNHXUWnwhrBDAoFJoQuEpmSoE83L3Yjvnm4Cdkfv3kmJ0uPK+LAdFZaEt
   qcquKvLCwGTRGvG7nak/hgkEUvCeVYwPakvXaVSZtEV6DQtYF6uk6UdoW
   E8YNQutfAnPq+CcoT1x3kNCsWmifx1rRdemjpuai7G/PbEy/xAKa7Ur2I
   w==;
X-CSE-ConnectionGUID: Jcx8ff3cT+OkDaoB63mpuw==
X-CSE-MsgGUID: WPvokuaSRgOxZJcpmG7sSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33838446"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33838446"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:47:45 -0800
X-CSE-ConnectionGUID: 7NqGZmhcR/Sibqo9GlSC/Q==
X-CSE-MsgGUID: SPp3w515RvOmQ6lMRolBlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="94423755"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:47:37 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 13:47:33 +0200 (EET)
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
Subject: Re: [PATCH v9 15/22] ACPI: platform_profile: Only show profiles
 common for all handlers
In-Reply-To: <20241202055031.8038-16-mario.limonciello@amd.com>
Message-ID: <eff0923a-0207-3a0f-43f8-699711dd15cc@linux.intel.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com> <20241202055031.8038-16-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1315692794-1733399253=:932"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1315692794-1733399253=:932
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 1 Dec 2024, Mario Limonciello wrote:

> If multiple platform profile handlers have been registered, don't allow
> switching to profiles unique to only one handler.
>=20
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/acpi/platform_profile.c | 52 ++++++++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index bb0178e52ff6b..40826876006b5 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -195,22 +195,54 @@ static const struct class platform_profile_class =
=3D {
>  =09.dev_groups =3D profile_groups,
>  };
> =20
> +/**
> + * _aggregate_choices - Aggregate the available profile choices
> + * @dev: The device
> + * @data: The available profile choices
> + * Return: 0 on success, -errno on failure
> + */
> +static int _aggregate_choices(struct device *dev, void *data)
> +{
> +=09struct platform_profile_handler *handler;
> +=09unsigned long *aggregate =3D data;
> +
> +=09lockdep_assert_held(&profile_lock);
> +=09handler =3D dev_get_drvdata(dev);
> +=09if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
> +=09=09bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
> +=09else
> +=09=09bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFIL=
E_LAST);
> +
> +=09return 0;
> +}
> +
> +/**
> + * platform_profile_choices_show - Show the available profile choices fo=
r legacy sysfs interface
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to
> + * Return: The number of bytes written
> + */
>  static ssize_t platform_profile_choices_show(struct device *dev,
> -=09=09=09=09=09struct device_attribute *attr,
> -=09=09=09=09=09char *buf)
> +=09=09=09=09=09     struct device_attribute *attr,
> +=09=09=09=09=09     char *buf)
>  {
> -=09int len =3D 0;
> -=09int i;
> +=09unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +=09int err;
> =20
> +=09set_bit(PLATFORM_PROFILE_LAST, aggregate);
>  =09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> -=09=09if (!cur_profile)
> -=09=09=09return -ENODEV;
> -=09=09for_each_set_bit(i, cur_profile->choices, PLATFORM_PROFILE_LAST)
> -=09=09=09len +=3D sysfs_emit_at(buf, len, len ? " %s": "%s", profile_nam=
es[i]);
> +=09=09err =3D class_for_each_device(&platform_profile_class, NULL,
> +=09=09=09=09=09    aggregate, _aggregate_choices);
> +=09=09if (err)
> +=09=09=09return err;
>  =09}
> -=09len +=3D sysfs_emit_at(buf, len, "\n");
> =20
> -=09return len;
> +=09/* no profile handler registered any more */
> +=09if (bitmap_empty(aggregate, PLATFORM_PROFILE_LAST))
> +=09=09return -EINVAL;
> +
> +=09return _commmon_choices_show(aggregate, buf);
>  }
> =20
>  static ssize_t platform_profile_show(struct device *dev,
>=20
--8323328-1315692794-1733399253=:932--

