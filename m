Return-Path: <linux-acpi+bounces-9940-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEDC9E542B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 12:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CF416340F
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 11:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6783F209691;
	Thu,  5 Dec 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="juw6fBuG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF60207E16;
	Thu,  5 Dec 2024 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398871; cv=none; b=SBYg646tNhOIPYS8Qa/5wXB1IAf4uMCM/C6xReJ26TD0Uo1FlAWAxprtwlnc97QIMX5vRSlsJLlnYsPnovqqKtMqJ62Kr6a5i1EmKBSRe2MPBUFcOxSu0VZSYkf8juwdTzXKgL2FNOKCMredkxOtgRVGXADJBu8qNSqtDp9/PE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398871; c=relaxed/simple;
	bh=prkes8uEj3iYakr3bZXZUj3FeRAXRPmf/dzG75uRGTY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R16INxI5mcfZkCzCvrIZIywBsOScaPALYLFQtZQubtb/tR8q6BbTrh4DTGUgeAUcDgIqnaH/rNQ7Z7/28+cZr7Uq8nkYEg9IVHN1Hd/pOZ52ycmw1hYoTIndQzVKD2qUvsIFQO5xR1OuiM0kNHNZGgkxAM5tLLE/RPmjC3FdnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=juw6fBuG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733398869; x=1764934869;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=prkes8uEj3iYakr3bZXZUj3FeRAXRPmf/dzG75uRGTY=;
  b=juw6fBuGCXzRsnRdbx9kEGtay3JnQJaqXoFeg0sQpQRbMh2Yv+R/Ax0o
   yVJRm1Jg4k3jvsg57S0pN1OtkNd3TwdW92owqyk6foyxQ8APIFoFgEuGZ
   gx/Wm6DdcEJ9y1ryUF3UcxhRuUFWsvugHKXMAUxq3nI/Bjv4nviyFyYDs
   UrtlHiHNPa7Obsi2I1kNHlGRmHVe0NkGNk5XlXYVFR3i9Wo9tyo2BjqFE
   Zu2ujPTOH2ZOo7Kho6YPEckd5XxGNXiQl1jThEmjX0CdKD0OD0WpSp4JI
   kkIJ6vvh2j4D1ilhStugU2Lupn5U/FJpgxN/82lhzzSdtqC7SpzqKZW4/
   A==;
X-CSE-ConnectionGUID: sgQo8BPgQKWgJiJN1SZHRQ==
X-CSE-MsgGUID: eXo4CmEbQUq35uOaSiXJNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="59109861"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="59109861"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:41:07 -0800
X-CSE-ConnectionGUID: YFY5WZ7lSs2Kl6PvWWfpKw==
X-CSE-MsgGUID: VXl5A4MUQjO/8c/AYI66QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="99149356"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 03:40:59 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 13:40:56 +0200 (EET)
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
Subject: Re: [PATCH v9 13/22] ACPI: platform_profile: Add profile attribute
 for class interface
In-Reply-To: <20241202055031.8038-14-mario.limonciello@amd.com>
Message-ID: <5b1a2aa1-b9be-744a-9c8d-074d981eaf30@linux.intel.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com> <20241202055031.8038-14-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-386674404-1733398856=:932"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-386674404-1733398856=:932
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 1 Dec 2024, Mario Limonciello wrote:

> Reading and writing the `profile` sysfs file will use the callbacks for
> the platform profile handler to read or set the given profile.
>=20
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>


Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
> v8:
>  * whitespace
>  * rename variables
> ---
>  drivers/acpi/platform_profile.c | 102 ++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index 885f41bca6c25..fdff374aab128 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -47,6 +47,52 @@ static ssize_t _commmon_choices_show(unsigned long *ch=
oices, char *buf)
>  =09return len;
>  }
> =20
> +/**
> + * _store_class_profile - Set the profile for a class device
> + * @dev: The class device
> + * @data: The profile to set
> + */
> +static int _store_class_profile(struct device *dev, void *data)
> +{
> +=09struct platform_profile_handler *handler;
> +=09int *bit =3D (int *)data;
> +
> +=09lockdep_assert_held(&profile_lock);
> +=09handler =3D dev_get_drvdata(dev);
> +=09if (!test_bit(*bit, handler->choices))
> +=09=09return -EOPNOTSUPP;
> +
> +=09return handler->profile_set(handler, *bit);
> +}
> +
> +/**
> + * get_class_profile - Show the current profile for a class device
> + * @dev: The class device
> + * @profile: The profile to return
> + * Return: 0 on success, -errno on failure
> + */
> +static int get_class_profile(struct device *dev,
> +=09=09=09     enum platform_profile_option *profile)
> +{
> +=09struct platform_profile_handler *handler;
> +=09enum platform_profile_option val;
> +=09int err;
> +
> +=09lockdep_assert_held(&profile_lock);
> +=09handler =3D dev_get_drvdata(dev);
> +=09err =3D handler->profile_get(handler, &val);
> +=09if (err) {
> +=09=09pr_err("Failed to get profile for handler %s\n", handler->name);
> +=09=09return err;
> +=09}
> +
> +=09if (WARN_ON(val >=3D PLATFORM_PROFILE_LAST))
> +=09=09return -EINVAL;
> +=09*profile =3D val;
> +
> +=09return 0;
> +}
> +
>  /**
>   * name_show - Show the name of the profile handler
>   * @dev: The device
> @@ -81,9 +127,65 @@ static ssize_t choices_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(choices);
> =20
> +/**
> + * profile_show - Show the current profile for a class device
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to
> + *
> + * Return: The number of bytes written
> + */
> +static ssize_t profile_show(struct device *dev,
> +=09=09=09    struct device_attribute *attr,
> +=09=09=09    char *buf)
> +{
> +=09enum platform_profile_option profile =3D PLATFORM_PROFILE_LAST;
> +=09int err;
> +
> +=09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +=09=09err =3D get_class_profile(dev, &profile);
> +=09=09if (err)
> +=09=09=09return err;
> +=09}
> +
> +=09return sysfs_emit(buf, "%s\n", profile_names[profile]);
> +}
> +
> +/**
> + * profile_store - Set the profile for a class device
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to read from
> + * @count: The number of bytes to read
> + *
> + * Return: The number of bytes read
> + */
> +static ssize_t profile_store(struct device *dev,
> +=09=09=09     struct device_attribute *attr,
> +=09=09=09     const char *buf, size_t count)
> +{
> +=09int index, ret;
> +
> +=09index =3D sysfs_match_string(profile_names, buf);
> +=09if (index < 0)
> +=09=09return -EINVAL;
> +
> +=09scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
> +=09=09ret =3D _store_class_profile(dev, &index);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
> +
> +=09sysfs_notify(acpi_kobj, NULL, "platform_profile");
> +
> +=09return count;
> +}
> +static DEVICE_ATTR_RW(profile);
> +
>  static struct attribute *profile_attrs[] =3D {
>  =09&dev_attr_name.attr,
>  =09&dev_attr_choices.attr,
> +=09&dev_attr_profile.attr,
>  =09NULL
>  };
>  ATTRIBUTE_GROUPS(profile);
>=20
--8323328-386674404-1733398856=:932--

