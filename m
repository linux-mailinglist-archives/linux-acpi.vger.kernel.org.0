Return-Path: <linux-acpi+bounces-6212-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D1D8FDD93
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 05:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBEE8B20B90
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 03:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409851D551;
	Thu,  6 Jun 2024 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xe89Cy/L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2619D89B;
	Thu,  6 Jun 2024 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717645296; cv=none; b=JpqHNtC4mMzdLI5wQbMuCzHxH6t33Z++bNZUDMrabJ3aQHO7BHfdtLsGDsyBLnrZXkgYrG6rojhDFf5bT2zpiMCZScM89t4FGo744C42+h9NqmQ4SZ6Fl07FbB19G0jnY21wgGRmAw4ZOiBti8IjCSI4EPDNkgbPZsbdQS2Ahq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717645296; c=relaxed/simple;
	bh=7i6qlJ4MQazUo2BFSri14hrv8zTgFKAa/wwxkpGrDJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DG0633jwNqWzRETbUtRnRWhJ/Hqk91ZULRiEd5l9uLc/MitdgKnRQKgI2uHgfpV+ClNTkhguVyaGMwl750iCZfJ2GIe0bhspvrdpjDYhZy7vWxlRLWMHhsnW1/OYzIvX4g2CcfZKBQwQjKhCpAC5wMDJnP+pf/TGa0hOa+jvK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xe89Cy/L; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717645294; x=1749181294;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7i6qlJ4MQazUo2BFSri14hrv8zTgFKAa/wwxkpGrDJs=;
  b=Xe89Cy/LicprldoK/VTM7H8g3JAdQTBlVbJgYUTm8U4TlXvenqpVPIH8
   uAvgjRbcRwKxHx4JJjBUGHlamUxjO2LXEYtvYu8v4agLxuuLBA1UNhPeK
   N87AYK3V06319hyAilmDlFEUOJrlZo+Zhtz3w4ZUFSqeA8QuiMeLhxzzk
   5Od/U66tOPRE4vroYaDvgDk+j78LfsqZfYS4JMgnQ2rh90KatA2e6kNRb
   6BIWn/sBwnhWQBO+V8XhRAy8O+oezJsrS9/puJr0TJGh6YbM0ncW0AZ8z
   voC0mNS2gfuZWn+ztpxMKa8cgptNGUIA+FQUOSn111Sp51XKe0v9UkS/c
   Q==;
X-CSE-ConnectionGUID: LV54aqIzSceklVXX3f6AYw==
X-CSE-MsgGUID: FLYnXbuGQoSiC4yHM2JTtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14248354"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14248354"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 20:41:33 -0700
X-CSE-ConnectionGUID: mAneGKfXSCeDwblX/sRntw==
X-CSE-MsgGUID: 65NTedZASW2d6VIZBDyesg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="37828634"
Received: from kbommu-mobl3.gar.corp.intel.com ([10.213.76.177])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 20:41:30 -0700
Message-ID: <cf24f2193c16ed070e5ec3b2f601650eb5b867ed.camel@linux.intel.com>
Subject: Re: [PATCH v1] thermal: core: Do not fail cdev registration because
 of invalid initial state
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
 <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,  Lukasz Luba <lukasz.luba@arm.com>, Zhang
 Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Laura Nao <laura.nao@collabora.com>
Date: Wed, 05 Jun 2024 20:41:22 -0700
In-Reply-To: <4569763.LvFx2qVVIh@kreacher>
References: <4569763.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 21:17 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> It is reported that commit 31a0fa0019b0 ("thermal/debugfs: Pass
> cooling
> device state to thermal_debug_cdev_add()") causes the ACPI fan driver
> to fail probing on some systems which turns out to be due to the _FST
> control method returning an invalid value until _FSL is first
> evaluated
> for the given fan.=C2=A0 If this happens, the .get_cur_state() cooling
> device
> callback returns an error and __thermal_cooling_device_register()
> fails
> as uses that callback after commit 31a0fa0019b0.
>=20
> Arguably, _FST should not return an inavlid
s/inavlid/invalid

Thanks,
Srinivas

>  value even if it is
> evaluated before _FSL, so this may be regarded as a platform firmware
> issue, but at the same time it is not a good enough reason for
> failing
> the cooling device registration where the initial cooling device
> state
> is only needed to initialize a thermal debug facility.
>=20
> Accordingly, modify __thermal_cooling_device_register() to pass a
> negative state value to thermal_debug_cdev_add() instead of failing
> if the initial .get_cur_state() callback invocation fails and adjust
> the thermal debug code to ignore negative cooling device state
> values.
>=20
> Fixes: 31a0fa0019b0 ("thermal/debugfs: Pass cooling device state to
> thermal_debug_cdev_add()")
> Closes:
> https://lore.kernel.org/linux-acpi/20240530153727.843378-1-laura.nao@coll=
abora.com
> Reported-by: Laura Nao <laura.nao@collabora.com>
> Tested-by: Laura Nao <laura.nao@collabora.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> =C2=A0drivers/thermal/thermal_core.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 11 +=
++++++----
> =C2=A0drivers/thermal/thermal_debugfs.c |=C2=A0=C2=A0=C2=A0 7 ++++++-
> =C2=A02 files changed, 13 insertions(+), 5 deletions(-)
>=20
> Index: linux-pm/drivers/thermal/thermal_core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -964,7 +964,8 @@ __thermal_cooling_device_register(struct
> =C2=A0{
> =C2=A0	struct thermal_cooling_device *cdev;
> =C2=A0	struct thermal_zone_device *pos =3D NULL;
> -	unsigned long current_state;
> +	unsigned long val;
> +	int current_state;
> =C2=A0	int id, ret;
> =C2=A0
> =C2=A0	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> @@ -1002,9 +1003,11 @@ __thermal_cooling_device_register(struct
> =C2=A0	if (ret)
> =C2=A0		goto out_cdev_type;
> =C2=A0
> -	ret =3D cdev->ops->get_cur_state(cdev, &current_state);
> -	if (ret)
> -		goto out_cdev_type;
> +	ret =3D cdev->ops->get_cur_state(cdev, &val);
> +	if (!ret && val >=3D 0 && val <=3D INT_MAX)
> +		current_state =3D val;
> +	else
> +		current_state =3D -1;
> =C2=A0
> =C2=A0	thermal_cooling_device_setup_sysfs(cdev);
> =C2=A0
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -421,6 +421,8 @@ void thermal_debug_cdev_state_update(con
> =C2=A0	cdev_dbg =3D &thermal_dbg->cdev_dbg;
> =C2=A0
> =C2=A0	old_state =3D cdev_dbg->current_state;
> +	if (old_state < 0)
> +		goto unlock;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Get the old state information in the durations list. If
> @@ -463,6 +465,7 @@ void thermal_debug_cdev_state_update(con
> =C2=A0
> =C2=A0	cdev_dbg->total++;
> =C2=A0
> +unlock:
> =C2=A0	mutex_unlock(&thermal_dbg->lock);
> =C2=A0}
> =C2=A0
> @@ -499,7 +502,9 @@ void thermal_debug_cdev_add(struct therm
> =C2=A0	 * duration will be printed by cdev_dt_seq_show() as
> expected if it
> =C2=A0	 * runs before the first state transition.
> =C2=A0	 */
> -	thermal_debugfs_cdev_record_get(thermal_dbg, cdev_dbg-
> >durations, state);
> +	if (state >=3D 0)
> +		thermal_debugfs_cdev_record_get(thermal_dbg,
> cdev_dbg->durations,
> +						state);
> =C2=A0
> =C2=A0	debugfs_create_file("trans_table", 0400, thermal_dbg->d_top,
> =C2=A0			=C2=A0=C2=A0=C2=A0 thermal_dbg, &tt_fops);
>=20
>=20
>=20
>=20


