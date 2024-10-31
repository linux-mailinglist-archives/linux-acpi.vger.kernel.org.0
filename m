Return-Path: <linux-acpi+bounces-9187-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 288D39B787C
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 11:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD342286B78
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9FB196450;
	Thu, 31 Oct 2024 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3NsXq98"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B8813A25F;
	Thu, 31 Oct 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369797; cv=none; b=hsOjGxYQfet+6HdSkVwqraz6f1YyN3pI7vyLTKb9VvNR//0Gh2AypbdjcK+C4VnHZ4lK+yzuNZ5KMr8ET6C6JYNCPNhoNUfIWqVoKCfEbwmNKev92+FH81Zs6P4vTqrodu2kB6BZREWHcYP3SfIlBbMlIY5YJAlAOgLkrEcxI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369797; c=relaxed/simple;
	bh=R45U818TsTT439/28WfuENUkuMgXATy9yx7t0VaBemk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Sqh9Qdw7E1DURjs1HDbe7FKZkH48dI68//YvNLJ//hJwkQthTPuXHSPXzVfyyrgRHlCUjFaraEPoIiTifS9FVh3wEpBEq0G3tBegZqOlzQ4V3zsNRQZYrUh9FGIkaryhCCIwxDOGZMG6IIShNdyuDmdPXR/QNCnyLaj3IYL5b1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3NsXq98; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730369796; x=1761905796;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=R45U818TsTT439/28WfuENUkuMgXATy9yx7t0VaBemk=;
  b=S3NsXq98dimWaMSV4yPLVIMViJe+oQpHH+ywhA1eyTD/QAJ6tMdtEKVB
   mzmNQR3HrYxgDswYBWvPKBdTktj0APJPM9YpaYgaMyKehCel5LXRjWuhk
   ABboDv2oCH4yREzWbqF70a74DGIYhmVKl5a3+2qVTj492LtsaTjC6Rq0P
   PaN4T0cIlCN0HOvigDuRNOuJEQxJRHRGthgM09AnuUSK6UFAY6IIsjmte
   pWFiwqK7TVHC2RioZHHhajadfUePhnBZ4HT3tGsETGficPzvZUyFskAx3
   iiHQD2wBMJ0ucuo66kot+F7LK4Af6KG5/zvMY9DSWxXEaVyacOPHGuP5K
   w==;
X-CSE-ConnectionGUID: G0UNEwo1Q1Gd8bzzy3n96g==
X-CSE-MsgGUID: M+WUBqkSRkqBChKVscuXlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47559642"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47559642"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:16:35 -0700
X-CSE-ConnectionGUID: z/3Q3sipTRa4f6OKD8+nyA==
X-CSE-MsgGUID: Xfp3OHcSRNOtCzOF9Trmow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87379401"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.160])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:16:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 31 Oct 2024 12:16:24 +0200 (EET)
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
Subject: Re: [PATCH v3 07/22] ACPI: platform_profile: Use guard(mutex) for
 register/unregister
In-Reply-To: <20241031040952.109057-8-mario.limonciello@amd.com>
Message-ID: <63acd502-bee4-ab00-1446-0f76686737ef@linux.intel.com>
References: <20241031040952.109057-1-mario.limonciello@amd.com> <20241031040952.109057-8-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-231554225-1730369784=:939"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-231554225-1730369784=:939
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 30 Oct 2024, Mario Limonciello wrote:

> guard(mutex) can be used to automatically release mutexes when going
> out of scope.
>=20
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index f2f2274e4d83e..cc2037147c0fd 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -191,34 +191,29 @@ int platform_profile_register(struct platform_profi=
le_handler *pprof)
>  =09=09return -EINVAL;
>  =09}
> =20
> -=09mutex_lock(&profile_lock);
> +=09guard(mutex)(&profile_lock);
>  =09/* We can only have one active profile */
> -=09if (cur_profile) {
> -=09=09mutex_unlock(&profile_lock);
> +=09if (cur_profile)
>  =09=09return -EEXIST;
> -=09}
> =20
>  =09err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
> -=09if (err) {
> -=09=09mutex_unlock(&profile_lock);
> +=09if (err)
>  =09=09return err;
> -=09}
>  =09list_add_tail(&pprof->list, &platform_profile_handler_list);
> =20
>  =09cur_profile =3D pprof;
> -=09mutex_unlock(&profile_lock);
>  =09return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_register);
> =20
>  int platform_profile_remove(struct platform_profile_handler *pprof)
>  {
> +=09guard(mutex)(&profile_lock);
> +
>  =09list_del(&pprof->list);
> =20
>  =09sysfs_remove_group(acpi_kobj, &platform_profile_group);
> -=09mutex_lock(&profile_lock);
>  =09cur_profile =3D NULL;
> -=09mutex_unlock(&profile_lock);
>  =09return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);
>=20

For patches 1-7,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-231554225-1730369784=:939--

