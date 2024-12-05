Return-Path: <linux-acpi+bounces-9947-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFD39E587A
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 15:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7F4286AFF
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF95A218AB4;
	Thu,  5 Dec 2024 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVXB7XDD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3F21C162;
	Thu,  5 Dec 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408836; cv=none; b=RNjamaMA41KhCZ0SHjwvLNE+hSo6ajclAQTk+GlVYmT2mt3rV8OvjKpG8fHe2T18c+tqxF5BI1DtEtv053+M/FAulVGfaFKl9r4ATV+uxTB7e9jUAQN0/4/nD7OgTZ77oLs+HCMQ9bsS9sFpkF1oNHRtz/AlbESUxIqd3z/6mE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408836; c=relaxed/simple;
	bh=TdHrru6HrKZsTuRgJP9+R3FgVkJlN0Fu+Onr/uxNQxk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gU97qG+vw4M9jC3kl/wd9Ql9qAZHo+J5VfYUoXTCkR+32HAyAn9QiMP44Z476QotEW54wD7/V2H68SsuLa2vbl19N7Ry28GP4NeGUarClC6sJNAlGM0+uiaEne8dDYkOHrUKLhxSjZFe4JvHVJsxglRapX9khokqzPL/1M450Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVXB7XDD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733408835; x=1764944835;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TdHrru6HrKZsTuRgJP9+R3FgVkJlN0Fu+Onr/uxNQxk=;
  b=NVXB7XDDl7qQ5jK4j9og68EvRdP+r/71giOL8wizPIwDXWYyLpWurR+I
   UCC6RB/dUDVu9f+mPDCOTo+K7WxSJBH/KCjO+I74h8m9Lx2jXWlj8ybx6
   kRH/NvRg4kBqA4F0MrFC31unQz0txbV3iG7P4ib733T1upyOxJFkOlr9I
   BOQdxWtkQPv79AVcf1bGBMyL+7ZQVEaMlbcD2ACZg/F3E1nWIPtjSTYX/
   yKn7NicbOF9V+sdB/tF1DvVeKWKWpwfsvtyid1PzyzoBCGtCnGYJwjC1a
   /i7BwL9pDVAMiMLq/7shbrsjVlpsTmgSxWwJOB6DP8jOKVxTKDK0376zz
   A==;
X-CSE-ConnectionGUID: U4KzeGOpTIGb2z9nHTd84A==
X-CSE-MsgGUID: 04oOsGjhSB+7SJUlj0XXng==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="56200568"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="56200568"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 06:27:14 -0800
X-CSE-ConnectionGUID: aUWcbiuCTYaljaysBIO2jQ==
X-CSE-MsgGUID: WjzM/8UlQFSQUkyU6nM6RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="93937382"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 06:27:07 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 16:27:03 +0200 (EET)
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
Subject: Re: [PATCH v9 20/22] ACPI: platform_profile: Allow multiple
 handlers
In-Reply-To: <20241202055031.8038-21-mario.limonciello@amd.com>
Message-ID: <e1653608-4073-3f2a-c8c9-9718320d071a@linux.intel.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com> <20241202055031.8038-21-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-629362536-1733408823=:932"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-629362536-1733408823=:932
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 1 Dec 2024, Mario Limonciello wrote:

> Multiple drivers may attempt to register platform profile handlers,
> but only one may be registered and the behavior is non-deterministic
> for which one wins.  It's mostly controlled by probing order.
>=20
> This can be problematic if one driver changes CPU settings and another
> driver notifies the EC for changing fan curves.
>=20
> Modify the ACPI platform profile handler to let multiple drivers
> register platform profile handlers and abstract this detail from userspac=
e.
>=20
> To avoid undefined behaviors only offer profiles that are commonly
> advertised across multiple handlers.
>=20
> If any problems occur when changing profiles for any driver, then the
> drivers that were already changed remain changed and the legacy sysfs
> handler will report 'custom'.
>=20
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index 289b5d43638ae..2e38aa410b3ad 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -10,7 +10,6 @@
>  #include <linux/platform_profile.h>
>  #include <linux/sysfs.h>
> =20
> -static struct platform_profile_handler *cur_profile;
>  static DEFINE_MUTEX(profile_lock);
> =20
>  static const char * const profile_names[] =3D {
> @@ -399,8 +398,6 @@ static const struct attribute_group platform_profile_=
group =3D {
> =20
>  void platform_profile_notify(struct platform_profile_handler *pprof)
>  {
> -=09if (!cur_profile)
> -=09=09return;
>  =09scoped_cond_guard(mutex_intr, return, &profile_lock) {
>  =09=09_notify_class_profile(pprof->class_dev, NULL);
>  =09}
> @@ -463,9 +460,6 @@ int platform_profile_register(struct platform_profile=
_handler *pprof)
>  =09}
> =20
>  =09guard(mutex)(&profile_lock);
> -=09/* We can only have one active profile */
> -=09if (cur_profile)
> -=09=09return -EEXIST;
> =20
>  =09/* create class interface for individual handler */
>  =09pprof->minor =3D ida_alloc(&platform_profile_ida, GFP_KERNEL);
> @@ -481,8 +475,6 @@ int platform_profile_register(struct platform_profile=
_handler *pprof)
> =20
>  =09sysfs_notify(acpi_kobj, NULL, "platform_profile");
> =20
> -=09cur_profile =3D pprof;
> -
>  =09err =3D sysfs_update_group(acpi_kobj, &platform_profile_group);
>  =09if (err)
>  =09=09goto cleanup_cur;
> @@ -490,7 +482,6 @@ int platform_profile_register(struct platform_profile=
_handler *pprof)
>  =09return 0;
> =20
>  cleanup_cur:
> -=09cur_profile =3D NULL;
>  =09device_unregister(pprof->class_dev);
> =20
>  cleanup_ida:
> @@ -505,8 +496,6 @@ int platform_profile_remove(struct platform_profile_h=
andler *pprof)
>  =09int id;
>  =09guard(mutex)(&profile_lock);
> =20
> -=09cur_profile =3D NULL;
> -
>  =09id =3D pprof->minor;
>  =09device_unregister(pprof->class_dev);
>  =09ida_free(&platform_profile_ida, id);
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-629362536-1733408823=:932--

