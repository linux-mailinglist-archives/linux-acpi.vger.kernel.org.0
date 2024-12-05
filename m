Return-Path: <linux-acpi+bounces-9949-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28979E5889
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 15:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57372281550
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0F7218EB8;
	Thu,  5 Dec 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g67vFvUM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B2218AA2;
	Thu,  5 Dec 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409224; cv=none; b=ZN3nCRXazte/D6ALECcjSkeAcEzQRuraNl021PO+tyvDtB6S/U0TRIZ17Yz9XPCG4PqdN/4nO5Uu754XkBf1Zjv0XIS2qjQekUEC+6mt+OlYwkpY297heqEU7nmIA0awB1sqFJY0CLi2w2Uw9JM4USNm5q3Zz/9KFLdLuY5PSys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409224; c=relaxed/simple;
	bh=5/+qIqiUSdR4xMbXTCzJKGsu0WDoa3zH2SDdHu0Q1dw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AiqTTJoEsMS5VBoLBkfhhBXUOvSgvQhNaOsbxpwyEHbscSZENSobMunWGLqvUNihNN7lWV6Rc4a25uZDVTL+WAEdfkCq99VwNVG/9p/JrP8PKXQiNAESGneqMNKhmBMjFJdTg2NSyeJOguEJ27RoWQ12QoBNMjETFtwaC3PrYQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g67vFvUM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733409223; x=1764945223;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5/+qIqiUSdR4xMbXTCzJKGsu0WDoa3zH2SDdHu0Q1dw=;
  b=g67vFvUMaLN08eAXvtztdVASlS7M1NroPAuSEv3PmVXjikq5TslMKqUv
   pFPvD2b7QlU9u/hsJlsk3wJiC7e2DozP0qFydjTG2AsPzhhjKcwMaPdvd
   PnnHuGOt9n+0lBF+l16LgAhIvtH8GWfapC1sguip4Embs8VXv+AKp4f6x
   56yDG3nJ+Y9i/8iwmKKlKBsFwSU6ZmD9SyL59wXe4eb7yfqGlFhuZaILg
   IoLKQXIhZrHC32cW+5PMFSHoX3v7s4efCMmZE29D9SGlff0xg3G1C7U6V
   b/QXIVrEkrPiL3tEF/x2MGi5hsdjGt0wTUpVMBOlfe/jb6VMU3vhi70jI
   A==;
X-CSE-ConnectionGUID: tmSfwzanSKmlD+OvMNt5uQ==
X-CSE-MsgGUID: O6BDBXkYRyGieJApcMRM8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33854573"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33854573"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 06:33:42 -0800
X-CSE-ConnectionGUID: 546mDef9R0ywwNhIFTpHMw==
X-CSE-MsgGUID: 0AwMZG/pQi2dhZ+4LsDNfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="99148105"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 06:33:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 16:33:31 +0200 (EET)
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
Subject: Re: [PATCH v9 22/22] Documentation: Add documentation about class
 interface for platform profiles
In-Reply-To: <20241202055031.8038-23-mario.limonciello@amd.com>
Message-ID: <0eaaa896-5f99-1f40-54b1-8b4c8c6c4a79@linux.intel.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com> <20241202055031.8038-23-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1664960937-1733409211=:932"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1664960937-1733409211=:932
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 1 Dec 2024, Mario Limonciello wrote:

> The class interface allows changing multiple platform profiles on a syste=
m
> to different values. The semantics of it are similar to the legacy
> interface.
>=20
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  .../ABI/testing/sysfs-platform_profile        |  5 +++
>  .../userspace-api/sysfs-platform_profile.rst  | 31 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documenta=
tion/ABI/testing/sysfs-platform_profile
> index baf1d125f9f83..125324ab53a96 100644
> --- a/Documentation/ABI/testing/sysfs-platform_profile
> +++ b/Documentation/ABI/testing/sysfs-platform_profile
> @@ -33,3 +33,8 @@ Description:=09Reading this file gives the current sele=
cted profile for this
>  =09=09source such as e.g. a hotkey triggered profile change handled
>  =09=09either directly by the embedded-controller or fully handled
>  =09=09inside the kernel.
> +
> +=09=09This file may also emit the string 'custom' to indicate
> +=09=09that multiple platform profiles drivers are in use but
> +=09=09have different values.  This string can not be written to
> +=09=09this interface and is solely for informational purposes.
> diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Doc=
umentation/userspace-api/sysfs-platform_profile.rst
> index 4fccde2e45639..0aa384c75095a 100644
> --- a/Documentation/userspace-api/sysfs-platform_profile.rst
> +++ b/Documentation/userspace-api/sysfs-platform_profile.rst
> @@ -40,3 +40,34 @@ added. Drivers which wish to introduce new profile nam=
es must:
>   1. Explain why the existing profile names cannot be used.
>   2. Add the new profile name, along with a clear description of the
>      expected behaviour, to the sysfs-platform_profile ABI documentation.
> +
> +Multiple driver support
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +When multiple drivers on a system advertise a platform profile handler, =
the
> +platform profile handler core will only advertise the profiles that are
> +common between all drivers to the ``/sys/firmware/acpi`` interfaces.
> +
> +This is to ensure there is no ambiguity on what the profile names mean w=
hen
> +all handlers don't support a profile.
> +
> +Individual drivers will register a 'platform_profile' class device that =
has
> +similar semantics as the ``/sys/firmware/acpi/platform_profile`` interfa=
ce.
> +
> +To discover which driver is associated with a platform profile handler t=
he
> +user can read the ``name`` attribute of the class device.
> +
> +To discover available profiles from the class interface the user can rea=
d the
> +``choices`` attribute.
> +
> +If a user wants to select a profile for a specific driver, they can do s=
o
> +by writing to the ``profile`` attribute of the driver's class device.
> +
> +This will allow users to set different profiles for different drivers on=
 the
> +same system. If the selected profile by individual drivers differs the
> +platform profile handler core will display the profile 'custom' to indic=
ate
> +that the profiles are not the same.
> +
> +While the ``platform_profile`` attribute has the value ``custom``, writi=
ng a
> +common profile from ``platform_profile_choices`` to the platform_profile
> +attribute of the platform profile handler core will set the profile for =
all
> +drivers.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Thanks for doing all this. The series looks ready to me once the minor=20
nits I noted to individual patches are addressed.


--=20
 i.

--8323328-1664960937-1733409211=:932--

