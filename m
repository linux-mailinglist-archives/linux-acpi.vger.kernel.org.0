Return-Path: <linux-acpi+bounces-9318-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0AF9BD0C5
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 16:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF30B1C226CD
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Nov 2024 15:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41D71F95A;
	Tue,  5 Nov 2024 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BC+t4IwR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3663513A409;
	Tue,  5 Nov 2024 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821141; cv=none; b=dQwICqTtRBPzH3BCWdgfHn9Zgcfc4YVjk8GQhw3pW+Kd3fWRcn+Tv0M61wPdvJxIk4jjY0PEX6FbBbouOZha1teXzNbSdTwevy16px/68x6DHgWfMFdNwY5Xbd+gb13N5hWpm1t7wLyjTzaGWEoyEJmdXH20fRF3ylST2PIssmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821141; c=relaxed/simple;
	bh=lSYMITN9xGOGlPjRYwyC90WrOfPVKQ6Nh+LwhhwSiiI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hNUTDiMrq0MBQKGG+G2vOlqQ+Dwt1ORTv6+iOvHIjXDhDd4RI5Pg0KId7FBE+QwKh/knuIK91GTFX7U288Xvoq2WD4lmid1yy9IzOurv+i0TFqBRZvg3/ecOC+2Qg455xmkoS7uAgHFnODwZpqHZ8+Qo6i9laeUtN0pRLxuz9aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BC+t4IwR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730821140; x=1762357140;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lSYMITN9xGOGlPjRYwyC90WrOfPVKQ6Nh+LwhhwSiiI=;
  b=BC+t4IwRom6fZ77n3uja/GR1mcE4VkM1WED6kZh8ZQi9wZeNYndPtOjA
   SN+hf/sHfi6JNs5ov6uJpfjdZsL+Mws+MavXwWiY3qbMagCrkLoL7NpWt
   kfH6BJA74bx3Rj9rqjdzNprxPO13JBSI8hknZP4LlWjjHCJ05t84auQ9m
   KFdi572TTJY0P3j+ScqRTXIKbQl3dAZVx/rFzGFKavcA0AiJ4KX1HTOHP
   WkMGF5KYIepiNmq27nB/+G2P3a6j//VHkmkV2ZgvmN7LrBIX9kGzAtH78
   iIoY5RjZmuUlWw/bXtzguQiAyggZOaqlDlOWdFMWn7AqjRB3PXjLA4gSA
   w==;
X-CSE-ConnectionGUID: /AB6LK5GRVaCYcA/VXE97A==
X-CSE-MsgGUID: irvNXktYTyW6v/DKqt6rtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="33415958"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="33415958"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:38:58 -0800
X-CSE-ConnectionGUID: WW/vFsOZSfCs9cj29Y6WxA==
X-CSE-MsgGUID: LW6KXejcS4K1NpgNofDbDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="114860359"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:38:53 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 5 Nov 2024 17:38:50 +0200 (EET)
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
Subject: Re: [PATCH v4 06/20] ACPI: platform_profile: Move matching string
 for new profile out of mutex
In-Reply-To: <20241105153316.378-7-mario.limonciello@amd.com>
Message-ID: <47780252-0d09-ec4a-9e4b-924939e0df4a@linux.intel.com>
References: <20241105153316.378-1-mario.limonciello@amd.com> <20241105153316.378-7-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-259802314-1730821130=:949"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-259802314-1730821130=:949
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 5 Nov 2024, Mario Limonciello wrote:

> Holding the mutex is not necessary while scanning the string passed into
> platform_profile_store().
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index 4e8a155589c21..70e7f1ba68676 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -83,6 +83,11 @@ static ssize_t platform_profile_store(struct device *d=
ev,
>  {
>  =09int err, i;
> =20
> +=09/* Scan for a matching profile */
> +=09i =3D sysfs_match_string(profile_names, buf);
> +=09if (i < 0)
> +=09=09return -EINVAL;
> +
>  =09err =3D mutex_lock_interruptible(&profile_lock);
>  =09if (err)
>  =09=09return err;
> @@ -92,13 +97,6 @@ static ssize_t platform_profile_store(struct device *d=
ev,
>  =09=09return -ENODEV;
>  =09}
> =20
> -=09/* Scan for a matching profile */
> -=09i =3D sysfs_match_string(profile_names, buf);
> -=09if (i < 0) {
> -=09=09mutex_unlock(&profile_lock);
> -=09=09return -EINVAL;
> -=09}
> -
>  =09/* Check that platform supports this profile choice */
>  =09if (!test_bit(i, cur_profile->choices)) {
>  =09=09mutex_unlock(&profile_lock);
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-259802314-1730821130=:949--

