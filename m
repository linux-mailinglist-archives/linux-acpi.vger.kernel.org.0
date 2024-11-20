Return-Path: <linux-acpi+bounces-9697-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA619D3DD4
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 15:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA76B2A0C7
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65F81ABEC5;
	Wed, 20 Nov 2024 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWootelV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114781A4F1F;
	Wed, 20 Nov 2024 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113757; cv=none; b=mEOF3TFSLvkJb2Ecx1L7s5Xvdrp1N1Io3nlCC9BTjI5sbJDjI8IvFAqE6XWPQPJJt/dUlC4U59l8H0djQ/IgQiSyFJV6B/TWHLXLYN7HB5d8k28cXzZFkYbeHrdTI8HogYsiIGNvPa9Nt4jsgLFBJynHE1zi92arrnnFvErI2rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113757; c=relaxed/simple;
	bh=QENu338zZ6Aq7HbLuXTTzHAI9oBt3+kblJsrtVG1GZo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h8D8Ne3QPKHJ2CidtIUQA5H7IxMtsowMVMHPwnAdX0pcfCQ18HkYFYmJt0wmRQGXMqfkckbaVSdFll2AsFFWcAqmKksRGmeWJQeA5SxdRofV9hZGBdVeGAjFSCl7HidO5bR7Dz476seskUIGmNVcYBIYkA9hZDSdhMpFuGBf6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWootelV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732113756; x=1763649756;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QENu338zZ6Aq7HbLuXTTzHAI9oBt3+kblJsrtVG1GZo=;
  b=eWootelVPA6pu1VDbvR8Dx364ZnaEMfOP06axiqP3zBDaugWQPlOVL3h
   Medvzg8hsxmXAU99lO94Fwasbs7AU3Tq77NNVcVde7Gr0DQLxHwLfZiwX
   5UG+anXYc6mb/bf1PrtBauXUgxJC9JFDyWrNCgUJjPrtOCxWNu0Uu7cL6
   KD8K7ZolDiJEg80TQeZ0swgpdNPC9wIhvKV9gEaJj2Yu1v3L7u4cPl1RJ
   ZHwecv9Lie70uQdh/46QhIbTmF0bL/qwYRperJ7fZXMGHppjy7lFyyEVW
   Pz27VX04msx69moa2afBg31kzXxlb2yEnKSU9PuGeiVJHi1USxEsP/KVh
   g==;
X-CSE-ConnectionGUID: zE79fsGGTgum3oRoiVk+lA==
X-CSE-MsgGUID: vIGw9THXTJWHdBMq5rR42w==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31547103"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="31547103"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 06:42:35 -0800
X-CSE-ConnectionGUID: gHjxPwd9Tf6lapFIaa6dfg==
X-CSE-MsgGUID: 1Ht3f4WMTYGNcI7pQ/wWMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90326984"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.15])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 06:42:28 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 20 Nov 2024 16:42:25 +0200 (EET)
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
Subject: Re: [PATCH v7 11/22] ACPI: platform_profile: Add name attribute to
 class interface
In-Reply-To: <20241119171739.77028-12-mario.limonciello@amd.com>
Message-ID: <04ea9948-d2cb-85f4-65a6-cee6cfa832cd@linux.intel.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com> <20241119171739.77028-12-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1967589960-1732113745=:981"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1967589960-1732113745=:981
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 19 Nov 2024, Mario Limonciello wrote:

> The name attribute shows the name of the associated platform profile
> handler.
>=20
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v7:
>  * Drop locking
> ---
>  drivers/acpi/platform_profile.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index 3524a2b4618ed..a9d7ec3c85844 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -25,8 +25,32 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFOR=
M_PROFILE_LAST);
> =20
>  static DEFINE_IDA(platform_profile_ida);
> =20
> +/**
> + * name_show - Show the name of the profile handler
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to

Add an empty line here after args.

> + * Return: The number of bytes written
> + */
> +static ssize_t name_show(struct device *dev,
> +=09=09=09 struct device_attribute *attr,
> +=09=09=09 char *buf)

This fits to less lines.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.

> +{
> +=09struct platform_profile_handler *handler =3D dev_get_drvdata(dev);
> +
> +=09return sysfs_emit(buf, "%s\n", handler->name);
> +}
> +
> +static DEVICE_ATTR_RO(name);
> +static struct attribute *profile_attrs[] =3D {
> +=09&dev_attr_name.attr,
> +=09NULL
> +};
> +ATTRIBUTE_GROUPS(profile);
> +
>  static const struct class platform_profile_class =3D {
>  =09.name =3D "platform-profile",
> +=09.dev_groups =3D profile_groups,
>  };
> =20
>  static ssize_t platform_profile_choices_show(struct device *dev,
>=20

--8323328-1967589960-1732113745=:981--

