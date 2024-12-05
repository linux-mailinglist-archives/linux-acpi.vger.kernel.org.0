Return-Path: <linux-acpi+bounces-9946-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD79E586F
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 15:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9688C168981
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 14:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D2C21A42A;
	Thu,  5 Dec 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BndZfGOT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6333217F50;
	Thu,  5 Dec 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408712; cv=none; b=PRaWt4ccFEve6uvmGKnYEsJG5QkxOW0mMyavKksGGJZIzE6AgvYUcLziWiYE3LcjYsserweyEIdrR8KbgYT9dtsiEZBEz/xCFxz3R36RWUU5ETmFfC4Cb/qbAjpeMmFBkOyw4euWMkibeJ9UxZLpNcTNV0cco1qWQbkagJEGo4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408712; c=relaxed/simple;
	bh=leV5BYpOnvUuYFa1i48CRpajjVd2mDT4XFYu9CqImc4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SB/2GBV7i1w76mn2X0ePiSzvdsLzU/Mx0yeKImNtQ5UdLZcknRddRo4Aj9iHqHlmRS6otr1qQkyKMZZpIIxyhCxsdCYhBsK9RIr5MSf4DGLRp7gRGqfYu/bE2kdMZbP5PGnRDZwHHd3M5r8Ha3P0eP6XLR6zmbB8iP2DNjfFMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BndZfGOT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733408711; x=1764944711;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=leV5BYpOnvUuYFa1i48CRpajjVd2mDT4XFYu9CqImc4=;
  b=BndZfGOTkGfdnxc8S076oojDKQv3uqMBaluTBZCcSYs91rVuTdYQlppl
   ZUwOSHK584eUmlVYWkqdd5cw423tjeNpDKLNzHz6xS8tGxyW//MZFLU29
   KzE8sYDu62S5lKRq+MfjI72V5sQOjKme4jwRKE7XtnSRzHGEgZYD1zF+5
   DxllzPdu1XtZzxe1h5wZFE9uGNmD/7f8HNCWVjEsrSIKGOdxkOmwwT1Mk
   EKY4hexx24TTa9sN8Yq8ZQeeZE8txiVjf6+c3SuaCjTkIUbH60JK4/6Io
   ik+RNiTKFqAYjzRp30ZOlIFM7OlSKmPYoG6vF4T+DIYRBKabdLHOFD26U
   w==;
X-CSE-ConnectionGUID: dpwqmfjSSje9j2DgRaY6ng==
X-CSE-MsgGUID: oW0YeinXT466d11XC6SgxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="21308974"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="21308974"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 06:25:10 -0800
X-CSE-ConnectionGUID: tqlsjyFPTpqAZ1+Y9jMdJA==
X-CSE-MsgGUID: vaxjqjwKSXSHSDwkOzWAPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="94302806"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 06:25:02 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 16:24:59 +0200 (EET)
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
Subject: Re: [PATCH v9 19/22] ACPI: platform_profile: Notify class device
 from platform_profile_notify()
In-Reply-To: <20241202055031.8038-20-mario.limonciello@amd.com>
Message-ID: <99d8a69d-2d61-28c3-7dd4-273b24d32727@linux.intel.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com> <20241202055031.8038-20-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-611836726-1733408699=:932"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-611836726-1733408699=:932
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 1 Dec 2024, Mario Limonciello wrote:

> When a driver has called platform_profile_notify() both the legacy sysfs
> interface and the class device should be notified as userspace may listen
> to either.
>=20
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v8:
>  * notify only one dev
> ---
>  drivers/acpi/platform_profile.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index 16746d9b9aa7c..289b5d43638ae 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -401,6 +401,9 @@ void platform_profile_notify(struct platform_profile_=
handler *pprof)
>  {
>  =09if (!cur_profile)
>  =09=09return;
> +=09scoped_cond_guard(mutex_intr, return, &profile_lock) {
> +=09=09_notify_class_profile(pprof->class_dev, NULL);
> +=09}
>  =09sysfs_notify(acpi_kobj, NULL, "platform_profile");
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_notify);

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-611836726-1733408699=:932--

