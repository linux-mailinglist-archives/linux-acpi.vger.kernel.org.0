Return-Path: <linux-acpi+bounces-9912-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D689E3B78
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 14:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4195B161992
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4666C1DF73E;
	Wed,  4 Dec 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+28Xtj3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507B1B87CE;
	Wed,  4 Dec 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319684; cv=none; b=Lu9AfiQh+I0vwbNguRKtHAVXUhN1QbM4n6PM3a0NoY/jmdcBKwbqIVoq0iwvClCP0V25NiPvrdCRgt57tpA9Z8W+D2HQZwWaLmZvcw7BjWW9+3kKb8/VE+R9XcQNO86IHlC5Yie4ikd2bpDTtQF1Lb8rO5g8f6NlyKYYblDlKAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319684; c=relaxed/simple;
	bh=OrUBrzA867BuM25tSmoSho1+xInsbkDy8p/o5TqA0Pc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p0a2AQP9dSQAvyewsqks8KupovasQq3uhvC82lzd9C+gptgkpfreGfyGnGHk359p3/GydY3kf0Xg5g+B5YFenLntLWlMjkxHzupYPOPpwpvgVuDYdz24nV495GFn2gIqSvON6mI4XbO+9rIUths4pMX/2Z6TwihP+eEPlGENLFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+28Xtj3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733319682; x=1764855682;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OrUBrzA867BuM25tSmoSho1+xInsbkDy8p/o5TqA0Pc=;
  b=e+28Xtj3qpXGuyANGWXwtfxpGBmgCCesPKu6pFOUNW4FGOEesCrMxbSt
   M+6/YUodXeljv1gNLo5jFDylFETOSiv2nwrdGqVdrKNPSerWF05ILzOeI
   gZpQ7YhR2mVH01/PmZJ3OsKcQ9tz80imeDzGv4Cd/uv78u9eVViRDH/90
   15mPIsT+V8heRaasUgPR1lXt5DwUCqnSWPC0SwrvpzKe7/XMvdHWjOGIW
   H3V9hbkxOg760saQEYXN/6s7cnEyuGk0EScXqcrB2BXqXHOLy0Cl+7gBf
   2by9k1HIRq9KV/cQffTkfIZr6KFbOO5YkU/1mfMBuX01e3HPEa+50w9M6
   A==;
X-CSE-ConnectionGUID: Me78Ql4yThC/fxUXo1OPLA==
X-CSE-MsgGUID: 5RCCAnVcQ9eMi+rg0ku/sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32927184"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="32927184"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 05:41:21 -0800
X-CSE-ConnectionGUID: 9P8O9cslRGKVO9efCilCog==
X-CSE-MsgGUID: sNMJU2HuQeazbzD+h/zPrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="94595871"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 05:41:15 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 4 Dec 2024 15:41:12 +0200 (EET)
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
Subject: Re: [PATCH v9 10/22] ACPI: platform_profile: Create class for ACPI
 platform profile
In-Reply-To: <20241202055031.8038-11-mario.limonciello@amd.com>
Message-ID: <9ab7b709-33eb-45fa-3e5d-a1f0c8c72e14@linux.intel.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com> <20241202055031.8038-11-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-281037050-1733319672=:904"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-281037050-1733319672=:904
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 1 Dec 2024, Mario Limonciello wrote:

> When registering a platform profile handler create a class device
> that will allow changing a single platform profile handler.
>=20
> The class and sysfs group are no longer needed when the platform profile
> core is a module and unloaded, so remove them at that time as well.
>=20
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
> v8:
>  * Use attr->mode
> ---
>  drivers/acpi/platform_profile.c  | 82 ++++++++++++++++++++++++++++++--
>  include/linux/platform_profile.h |  2 +
>  2 files changed, 79 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index a1f0378f15e62..11eb60b09bac4 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -5,6 +5,7 @@
>  #include <linux/acpi.h>
>  #include <linux/bits.h>
>  #include <linux/init.h>
> +#include <linux/kdev_t.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_profile.h>
>  #include <linux/sysfs.h>
> @@ -22,6 +23,12 @@ static const char * const profile_names[] =3D {
>  };
>  static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);
> =20
> +static DEFINE_IDA(platform_profile_ida);
> +
> +static const struct class platform_profile_class =3D {
> +=09.name =3D "platform-profile",
> +};
> +
>  static ssize_t platform_profile_choices_show(struct device *dev,
>  =09=09=09=09=09struct device_attribute *attr,
>  =09=09=09=09=09char *buf)
> @@ -101,8 +108,21 @@ static struct attribute *platform_profile_attrs[] =
=3D {
>  =09NULL
>  };
> =20
> +static int profile_class_registered(struct device *dev, const void *data=
)
> +{
> +=09return 1;
> +}
> +
> +static umode_t profile_class_is_visible(struct kobject *kobj, struct att=
ribute *attr, int idx)
> +{
> +=09if (!class_find_device(&platform_profile_class, NULL, NULL, profile_c=
lass_registered))
> +=09=09return 0;
> +=09return attr->mode;
> +}
> +
>  static const struct attribute_group platform_profile_group =3D {
> -=09.attrs =3D platform_profile_attrs
> +=09.attrs =3D platform_profile_attrs,
> +=09.is_visible =3D profile_class_is_visible,
>  };
> =20
>  void platform_profile_notify(struct platform_profile_handler *pprof)
> @@ -160,25 +180,77 @@ int platform_profile_register(struct platform_profi=
le_handler *pprof)
>  =09if (cur_profile)
>  =09=09return -EEXIST;
> =20
> -=09err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
> -=09if (err)
> -=09=09return err;
> +=09/* create class interface for individual handler */
> +=09pprof->minor =3D ida_alloc(&platform_profile_ida, GFP_KERNEL);
> +=09if (pprof->minor < 0)
> +=09=09return pprof->minor;
> +=09pprof->class_dev =3D device_create(&platform_profile_class, pprof->de=
v,
> +=09=09=09=09=09 MKDEV(0, 0), pprof, "platform-profile-%d",
> +=09=09=09=09=09 pprof->minor);
> +=09if (IS_ERR(pprof->class_dev)) {
> +=09=09err =3D PTR_ERR(pprof->class_dev);
> +=09=09goto cleanup_ida;
> +=09}
> =20
>  =09cur_profile =3D pprof;
> +
> +=09err =3D sysfs_update_group(acpi_kobj, &platform_profile_group);
> +=09if (err)
> +=09=09goto cleanup_cur;
> +
>  =09return 0;
> +
> +cleanup_cur:
> +=09cur_profile =3D NULL;
> +=09device_unregister(pprof->class_dev);
> +
> +cleanup_ida:
> +=09ida_free(&platform_profile_ida, pprof->minor);
> +
> +=09return err;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_register);
> =20
>  int platform_profile_remove(struct platform_profile_handler *pprof)
>  {
> +=09int id;
>  =09guard(mutex)(&profile_lock);
> =20
> -=09sysfs_remove_group(acpi_kobj, &platform_profile_group);
>  =09cur_profile =3D NULL;
> +
> +=09id =3D pprof->minor;
> +=09device_unregister(pprof->class_dev);
> +=09ida_free(&platform_profile_ida, id);
> +
> +=09sysfs_update_group(acpi_kobj, &platform_profile_group);
> +
>  =09return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);
> =20
> +static int __init platform_profile_init(void)
> +{
> +=09int err;
> +
> +=09err =3D class_register(&platform_profile_class);
> +=09if (err)
> +=09=09return err;
> +
> +=09err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
> +=09if (err)
> +=09=09class_unregister(&platform_profile_class);
> +
> +=09return err;
> +}
> +
> +static void __exit platform_profile_exit(void)
> +{
> +=09sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +=09class_unregister(&platform_profile_class);
> +}
> +module_init(platform_profile_init);
> +module_exit(platform_profile_exit);
> +
>  MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
>  MODULE_DESCRIPTION("ACPI platform profile sysfs interface");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_pr=
ofile.h
> index 8ec0b8da56db5..a888fd085c513 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -29,6 +29,8 @@ enum platform_profile_option {
>  struct platform_profile_handler {
>  =09const char *name;
>  =09struct device *dev;
> +=09struct device *class_dev;
> +=09int minor;
>  =09unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>  =09int (*profile_get)(struct platform_profile_handler *pprof,
>  =09=09=09=09enum platform_profile_option *profile);
>=20
--8323328-281037050-1733319672=:904--

