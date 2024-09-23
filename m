Return-Path: <linux-acpi+bounces-8368-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C9497EC58
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Sep 2024 15:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A661F21A7E
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Sep 2024 13:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB7199237;
	Mon, 23 Sep 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pd0cxYdi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3469038394;
	Mon, 23 Sep 2024 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098549; cv=none; b=WoUD1+KnbTZaB/EgkqPNo/bYFpxOLhXF040oxEGmQHWb5udjL7M08F/AOgSfTu0chjo9gIH0M2juTvnYhV4bdsU9dq+3rXUFaEGbj1JIsx2eu3PXnx+14aypFIv4ejwSWT3Q1sahwI2rEclJN+tjeSjvhvMVbKZoa3meE6T7LWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098549; c=relaxed/simple;
	bh=QiolusFNonU5H3QdL09kY/L86vkxnWUj2IpkCajjdUU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ev51gIXtUTvDq33g9xOSRxgrEy4Ad9ingc/MP+mAWnF3lcIZKAxt6oMdpYtrq4LdqANJ1rDtM9LmYlZnlbEi/b7Vt9GaJMo5VT1wKDdrj4XiTMESjBnOmaMYUq1b6Cb439+f3e8q4L4KB5/GaKxvYbPmCVFLrcAgQp029FReeMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pd0cxYdi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727098548; x=1758634548;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QiolusFNonU5H3QdL09kY/L86vkxnWUj2IpkCajjdUU=;
  b=Pd0cxYdiawKV9T1lWv5Pc1l6HlgokEzIgWQZ4n2bT9qpjFKpr5hfkhEU
   Yv+4KzT9EY+maQ1tHg+Cpo98crgt9uJrgJ7TVm1JJbMF1CmZ/Rp8/rw6h
   +h8/EdAkLLYx78hIaUSr2qIbKfZJWYEwSXE0QyjyU4YdiaCvn+Dy4x1MA
   qBEPBbp3AmuCx8Z+ChnvUCjFRyvglOfcjV1ZG48tOHMPCafwIuyv0xBLy
   XugarzaD47huo2gyakKxUfLATCAPqQEFuyHp+MI3O0Igkt70Pdw3q5+7I
   rkTyMhqOD1sJ7ZzWknhkRKxm5X1KNvdWc3IWVCmi98sl1Gv1pMzyFZGcp
   A==;
X-CSE-ConnectionGUID: Na0LmmX/TImOa6WhOWFGjA==
X-CSE-MsgGUID: f/4i64aDTZq4zQAwtbWTHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="43562734"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="43562734"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 06:35:47 -0700
X-CSE-ConnectionGUID: rB/mfvIiQJKd0eEVD6kiCA==
X-CSE-MsgGUID: KZOvXjsVSWSHVoga22sJrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="75837456"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.23])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 06:35:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 23 Sep 2024 16:35:39 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: mjg59@srcf.ucam.org, pali@kernel.org, dilinger@queued.net, 
    "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] ACPI: battery: Simplify battery hook locking
In-Reply-To: <20240922064026.496422-2-W_Armin@gmx.de>
Message-ID: <5b3e4ec1-e5a6-cb77-1d57-3515eb051cc2@linux.intel.com>
References: <20240922064026.496422-1-W_Armin@gmx.de> <20240922064026.496422-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-400505829-1727098539=:978"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-400505829-1727098539=:978
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 22 Sep 2024, Armin Wolf wrote:

> Move the conditional locking from __battery_hook_unregister()
> into battery_hook_unregister() and rename the low-level function
> to simplify the locking during battery hook removal.
>=20
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/acpi/battery.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index da3a879d638a..10e9136897a7 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -706,28 +706,28 @@ static LIST_HEAD(acpi_battery_list);
>  static LIST_HEAD(battery_hook_list);
>  static DEFINE_MUTEX(hook_mutex);
>=20
> -static void __battery_hook_unregister(struct acpi_battery_hook *hook, in=
t lock)
> +static void battery_hook_unregister_unlocked(struct acpi_battery_hook *h=
ook)
>  {
>  =09struct acpi_battery *battery;
> +
>  =09/*
>  =09 * In order to remove a hook, we first need to
>  =09 * de-register all the batteries that are registered.
>  =09 */
> -=09if (lock)
> -=09=09mutex_lock(&hook_mutex);
>  =09list_for_each_entry(battery, &acpi_battery_list, list) {
>  =09=09if (!hook->remove_battery(battery->bat, hook))
>  =09=09=09power_supply_changed(battery->bat);
>  =09}
>  =09list_del(&hook->list);
> -=09if (lock)
> -=09=09mutex_unlock(&hook_mutex);
> +
>  =09pr_info("extension unregistered: %s\n", hook->name);
>  }
>=20
>  void battery_hook_unregister(struct acpi_battery_hook *hook)
>  {
> -=09__battery_hook_unregister(hook, 1);
> +=09mutex_lock(&hook_mutex);
> +=09battery_hook_unregister_unlocked(hook);
> +=09mutex_unlock(&hook_mutex);
>  }
>  EXPORT_SYMBOL_GPL(battery_hook_unregister);
>=20
> @@ -753,7 +753,7 @@ void battery_hook_register(struct acpi_battery_hook *=
hook)
>  =09=09=09 * hooks.
>  =09=09=09 */
>  =09=09=09pr_err("extension failed to load: %s", hook->name);
> -=09=09=09__battery_hook_unregister(hook, 0);
> +=09=09=09battery_hook_unregister_unlocked(hook);
>  =09=09=09goto end;
>  =09=09}
>=20
> @@ -807,7 +807,7 @@ static void battery_hook_add_battery(struct acpi_batt=
ery *battery)
>  =09=09=09 */
>  =09=09=09pr_err("error in extension, unloading: %s",
>  =09=09=09=09=09hook_node->name);
> -=09=09=09__battery_hook_unregister(hook_node, 0);
> +=09=09=09battery_hook_unregister_unlocked(hook_node);
>  =09=09}
>  =09}
>  =09mutex_unlock(&hook_mutex);
> @@ -840,7 +840,7 @@ static void __exit battery_hook_exit(void)
>  =09 * need to remove the hooks.
>  =09 */
>  =09list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
> -=09=09__battery_hook_unregister(hook, 1);
> +=09=09battery_hook_unregister(hook);
>  =09}
>  =09mutex_destroy(&hook_mutex);
>  }
> --
> 2.39.5
>=20
--8323328-400505829-1727098539=:978--

