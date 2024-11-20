Return-Path: <linux-acpi+bounces-9698-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD779D3E00
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 15:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316FFB2200A
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C731CACDB;
	Wed, 20 Nov 2024 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVwJjCsn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D341C9ED7;
	Wed, 20 Nov 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114053; cv=none; b=dOM1GyaRnMx7wOzXQDsjohGwQB8gxnbVPqzrXV3DssqsaG40QyTrKXHTg30we2oQxfcgBgvWteLZCiYGYQRvldoiw/vTokRuA+b10D2k9miJbdpWVxXwWsDwAxKxFcP85mcmUGJtYKsDFd8xiOiOIj3gbstQXzUO1eC3TqwsR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114053; c=relaxed/simple;
	bh=NEh5kHvuaI5Z/k82e5dQRIh65WcFcOSUPtgH/sJkJ1I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=crOX1kJLjIR4fmegYbQGhA52th9/9wPfJHhMUfhyqyqcrFbMXJcNL9ScMGbcVvQqHe7FitATS4yQK60sTEfzhOkv+LzNuLKVQJjtRX3C+2oVwWCrlmcz+LGXallssVAtRWGi1DwiUpAysdDBV+BA6px/rwbLiV/mTmNVMD5swTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVwJjCsn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732114051; x=1763650051;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NEh5kHvuaI5Z/k82e5dQRIh65WcFcOSUPtgH/sJkJ1I=;
  b=cVwJjCsn25YszMIyvaqIbK4ppkczK3Ye00VQbsTrmvXbjKjEyZH5RiO0
   o3TNrsCpHvpQS6lKpu6aVySxBq1Kiq/nzhIgVPeaN3Bx0yOsJNoN2zorm
   dQE0zw0OKXsmuHzc3Utz6MQuFpYRtk2sNWwxDWCnRrlkBc+EAa8caUNbg
   7TXykMEipNw592SKd8ckR3i87CuXJBpvlwnf0zjgez3YHGqm9l5ErhMTd
   dkVirUThjUS3a+2s5jrPMD/EARjN1qfzidy+ApSk3f7bWO2xlgfn8w5Pt
   h7l5tNVeqaKeVrJ8o7JOwIPPFdVsBwcbWy6XXMlOcjSQX2XU457EZhaRE
   Q==;
X-CSE-ConnectionGUID: URXAGkPkRSuGi4k4TUpJew==
X-CSE-MsgGUID: bj+yVys5TDqqmkd+QyOlng==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="49709422"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="49709422"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 06:47:30 -0800
X-CSE-ConnectionGUID: /+9vmP1BRwy1n59YYoMKWw==
X-CSE-MsgGUID: 4asMDlTIR1+AIW7PbKT7qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="94761380"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.15])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 06:47:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 20 Nov 2024 16:47:16 +0200 (EET)
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
Subject: Re: [PATCH v7 12/22] ACPI: platform_profile: Add choices attribute
 for class interface
In-Reply-To: <20241119171739.77028-13-mario.limonciello@amd.com>
Message-ID: <82d5282a-08f5-6986-3dfc-489f62b7c456@linux.intel.com>
References: <20241119171739.77028-1-mario.limonciello@amd.com> <20241119171739.77028-13-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-959228983-1732114036=:981"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-959228983-1732114036=:981
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 19 Nov 2024, Mario Limonciello wrote:

> The `choices` file will show all possible choices that a given platform
> profile handler can support.
>=20
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v7:
>  * Drop locking
> v5:
>  * Fix kdoc
>  * Add tag
>  * Fix whitespace
>  * Adjust mutex use
> ---
>  drivers/acpi/platform_profile.c | 39 +++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index a9d7ec3c85844..9d6ead043994c 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -25,6 +25,27 @@ static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFOR=
M_PROFILE_LAST);
> =20
>  static DEFINE_IDA(platform_profile_ida);
> =20
> +/**
> + * _commmon_choices_show - Show the available profile choices
> + * @choices: The available profile choices
> + * @buf: The buffer to write to

Add empty line.

> + * Return: The number of bytes written
> + */

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--
 i.


> +static ssize_t _commmon_choices_show(unsigned long *choices, char *buf)
> +{
> +=09int i, len =3D 0;
> +
> +=09for_each_set_bit(i, choices, PLATFORM_PROFILE_LAST) {
> +=09=09if (len =3D=3D 0)
> +=09=09=09len +=3D sysfs_emit_at(buf, len, "%s", profile_names[i]);
> +=09=09else
> +=09=09=09len +=3D sysfs_emit_at(buf, len, " %s", profile_names[i]);
> +=09}
> +=09len +=3D sysfs_emit_at(buf, len, "\n");
> +
> +=09return len;
> +}
> +
>  /**
>   * name_show - Show the name of the profile handler
>   * @dev: The device
> @@ -41,9 +62,27 @@ static ssize_t name_show(struct device *dev,
>  =09return sysfs_emit(buf, "%s\n", handler->name);
>  }
> =20
> +/**
> + * choices_show - Show the available profile choices
> + * @dev: The device
> + * @attr: The attribute
> + * @buf: The buffer to write to
> + */
> +static ssize_t choices_show(struct device *dev,
> +=09=09=09    struct device_attribute *attr,
> +=09=09=09    char *buf)
> +{
> +=09struct platform_profile_handler *handler =3D dev_get_drvdata(dev);
> +
> +=09return _commmon_choices_show(handler->choices, buf);
> +}
> +
>  static DEVICE_ATTR_RO(name);
> +static DEVICE_ATTR_RO(choices);
> +
>  static struct attribute *profile_attrs[] =3D {
>  =09&dev_attr_name.attr,
> +=09&dev_attr_choices.attr,
>  =09NULL
>  };
>  ATTRIBUTE_GROUPS(profile);
>=20

--8323328-959228983-1732114036=:981--

