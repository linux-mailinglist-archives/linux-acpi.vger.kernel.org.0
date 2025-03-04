Return-Path: <linux-acpi+bounces-11796-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BACF1A4E82B
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 18:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DB188312C
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30656291FB7;
	Tue,  4 Mar 2025 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+/Mx3CL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C724EA82;
	Tue,  4 Mar 2025 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105367; cv=none; b=b/JzgwZK3qPMAVc2y/REed+7PYEIBRKwTP9xpp+9xThdD3Efao5KdIvDI2Vomv99x6MGNf1F9D4o8HwNh3TKPcP3PToIT78HAb9Ck7B6pP+t+3nU74Il/UzgmaBtl7XNLCJw5Pn4EDlUNZt5MZjFBFWFbE8TizQ/v1CHrUHhLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105367; c=relaxed/simple;
	bh=SnMOw90v2vmd9qk0jA8N1UVP2ygvNsK9ROnJOYtgP5g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S+sMgZ7Umm3CSRvmWH9CprgqBvWN9vVcuV9CqDaC40IYeEBLbqx8UAx3a85SWTAEo8EpmbbB1nxbuDfFQcArtbNMoYqAWfSSoUwO871A3W6DYiaDhvtkEqwmJCHO/su0iKGWhhBax/E9jSa841p/wTI36gmXrB82zi7qWO7edPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+/Mx3CL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741105366; x=1772641366;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SnMOw90v2vmd9qk0jA8N1UVP2ygvNsK9ROnJOYtgP5g=;
  b=e+/Mx3CLmhaMI4Wi70AhKE4TL1dYqMUFbbGYm/X2QHiqGZ2Mzffo0U8G
   QhoZM4wvgQzSYqK4Hi/zdeyyd7Wj8G/WnXJmaaTL+Ymnc0N1+coeC4jM4
   kS/Tp+Pg3zz9dZR5pp10M7X16fFBM60KFGihP4ssQw4iORowj8CamQNWd
   4nHfKz2RKQDiNefD5gOG7A23mAuiZPBSlxGViE4ozMgvAyvnz45BS3lvz
   8E0cg2hsQ4xtPwitym/7Q8Uqb1ITO38c9cc7ssms/yaCv8RKWMPq1I+zh
   nBO+2UMldVOv9t/LWuKDRptxwPMoGcdgPqvMYlMInnBql+w2kxds9yR4n
   Q==;
X-CSE-ConnectionGUID: BVdgBvyQRjy+gIZfFgSdjw==
X-CSE-MsgGUID: 1uErCET0RqiinRLF5dgzcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41890808"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="41890808"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:22:45 -0800
X-CSE-ConnectionGUID: 8U4xOCdzSEqyZVutfCu4kA==
X-CSE-MsgGUID: pR5bYTpwSXGdlbzDYTL/ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="123543625"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.220])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:22:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 4 Mar 2025 18:22:36 +0200 (EET)
To: Mario Limonciello <superm1@kernel.org>
cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, "Luke D . Jones" <luke@ljones.dev>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:ACPI" <linux-acpi@vger.kernel.org>, 
    "Derek J . Clark" <derekjohn.clark@gmail.com>, 
    Antheas Kapenekakis <lkml@antheas.dev>, me@kylegospodneti.ch, 
    Denis Benato <benato.denis96@gmail.com>, 
    Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 0/3] Add support for hidden choices to platform_profile
In-Reply-To: <20250228170155.2623386-1-superm1@kernel.org>
Message-ID: <bda43bf4-1d45-d1bf-8d5c-f27727ebc80e@linux.intel.com>
References: <20250228170155.2623386-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-704813475-1741105356=:931"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-704813475-1741105356=:931
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 28 Feb 2025, Mario Limonciello wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
>=20
> When two drivers provide platform profile handlers but use different
> strings to mean (essentially) the same thing the legacy interface won't
> export them because it only shows profiles common to multiple drivers.
>=20
> This causes an unexpected behavior to people who have upgraded from an
> earlier kernel because if multiple drivers have bound platform profile
> handlers they might not be able to access profiles they were expecting.
>=20
> Introduce a concept of a "hidden choice" that drivers can register and
> the platform profile handler code will utilize when using the legacy
> interface.
>=20
> There have been some other attempts at solving this issue in other ways.
> This serves as an alternative to those attempts.
>=20
> Link: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257=
-5b8fc6c24ac9@gmx.de/T/#t
> Link: https://lore.kernel.org/platform-driver-x86/CAGwozwF-WVEgiAbWbRCiUa=
Xf=3DBVa3KqmMJfs06trdMQHpTGmjQ@mail.gmail.com/T/#m2f3929e2d4f73cc0eedd14738=
170dad45232fd18
> Cc: Antheas Kapenekakis <lkml@antheas.dev>
> Cc: "Luke D. Jones" <luke@ljones.dev>
>=20
> Mario Limonciello (3):
>   ACPI: platform_profile: Add support for hidden choices
>   platform/x86/amd: pmf: Add 'quiet' to hidden choices
>   platform/x86/amd: pmf: Add balanced-performance to hidden choices
>=20
>  drivers/acpi/platform_profile.c    | 94 +++++++++++++++++++++++-------
>  drivers/platform/x86/amd/pmf/sps.c | 11 ++++
>  include/linux/platform_profile.h   |  3 +
>  3 files changed, 87 insertions(+), 21 deletions(-)
>=20
>=20

Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-704813475-1741105356=:931--

