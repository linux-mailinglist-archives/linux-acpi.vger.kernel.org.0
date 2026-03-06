Return-Path: <linux-acpi+bounces-21489-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id emJBBmbOqml4XQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21489-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:53:58 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E03221115
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C95C1302C6F5
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF35288530;
	Fri,  6 Mar 2026 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8bsKCJl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB89289E17;
	Fri,  6 Mar 2026 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801065; cv=none; b=pcsKE9uJU060NSPNBhtUDgcje9MFUYEXqpB4sNvJwcrE6sh5BXocZpskCGhixcQNAryQGX3J2+1T/LgVi9pc2tQDlpWWBoULLGTVIRqhSEmzKRU+IAgN0oXbvWj3kalRuyfGdsoL4EFJ+44WhUfDy+Iw2Mim1htnTlaT2fVEqUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801065; c=relaxed/simple;
	bh=Tq1d43LGzegHgS7nbs7ynJ8NqJPbG38gDZGWn7nBmhU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NHMOurch2/Dl2dckTJNidbLi4CbCWB9WL4r/nU9C6zT0HKqVB9FByOGkcOaaW6ml6S/DuO2bFHFQgoLpFrJJSPSXOpXawSywW4shLGkTjx5GVp4ng1Y1uSwuZuDiVD7qBZu1C6Lb5ky9B9RFDQ9EEVnJ7WvDqJL6SlsSMidxapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8bsKCJl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772801061; x=1804337061;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Tq1d43LGzegHgS7nbs7ynJ8NqJPbG38gDZGWn7nBmhU=;
  b=k8bsKCJlcHdl38VS0SQaNeWvdFRSVfeCNuSYUPfyF/wMb7ng5JB3pguW
   /XkgmFgWLPtWQ6PjdG4VFrec2ZoY3TVKo5z0cVJXY/vV00AWniEFdcodN
   EiR51z1Llz1J22EKevkwph14FM9QCdieMtvBXZ7rfyHfOvmjyoO7gM7ro
   i+z+0aGV+FQ+OIPTC691b9dN//0WWZKjpha8sYxbwJGBkpp9wJWM9pCvT
   ReVd4Zq+6Ro6hJiM7vPAaVLvjJuUNtKmcsU2oYNb1L6S5UM0+p6hiYT4S
   NqPhH5JtQ1Uk+xfmv1Z/d22AS8osey84VTfTLvTPeiSp86+uP/tFzdWR7
   w==;
X-CSE-ConnectionGUID: bR/AIwS/RXuSxBzaw/dLxg==
X-CSE-MsgGUID: UhIU8ftGRByCb/WHpJxFgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="77777580"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="77777580"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:44:20 -0800
X-CSE-ConnectionGUID: OtofVhFTTyOSIeT4q7K2KA==
X-CSE-MsgGUID: MGdmFMJNQ6aArM44PPNKoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223123793"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.235])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:44:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 6 Mar 2026 14:44:12 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Linux ACPI <linux-acpi@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
    Alex Deucher <alexander.deucher@amd.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v1 9/9] ACPI: AC: Define ACPI_AC_CLASS in one place
In-Reply-To: <2787819.X9hSmTKtgW@rafael.j.wysocki>
Message-ID: <ba409fad-7b2e-6fb1-eeee-8d9cacf4cb74@linux.intel.com>
References: <4505861.ejJDZkT8p0@rafael.j.wysocki> <2787819.X9hSmTKtgW@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-151852091-1772801052=:1000"
X-Rspamd-Queue-Id: 77E03221115
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21489-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-151852091-1772801052=:1000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 5 Mar 2026, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> The ACPI_AC_CLASS symbol is defined in several places in the same way
> which is rather unfortunate.
>=20
> Instead, define it in one common header file (acpi_bus.h) that is
> already included by all of its users.

It's a bit misleading to say it like that as acpi_bus.h is included only=20
through another include (at least acpi/acpi.h) for most of the=20
cases.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/ac.c                         |    1 -
>  drivers/acpi/sbs.c                        |    1 -
>  drivers/gpu/drm/amd/include/amd_acpi.h    |    2 --
>  drivers/gpu/drm/radeon/radeon_acpi.c      |    2 --
>  drivers/platform/x86/hp/hp-wmi.c          |    2 --
>  drivers/platform/x86/lenovo/wmi-capdata.c |    1 -
>  include/acpi/acpi_bus.h                   |    2 ++
>  7 files changed, 2 insertions(+), 9 deletions(-)
>=20
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -21,7 +21,6 @@
>  #include <linux/acpi.h>
>  #include <acpi/battery.h>
> =20
> -#define ACPI_AC_CLASS=09=09=09"ac_adapter"
>  #define ACPI_AC_FILE_STATE=09=09"state"
>  #define ACPI_AC_NOTIFY_STATUS=09=090x80
>  #define ACPI_AC_STATUS_OFFLINE=09=090x00
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -26,7 +26,6 @@
> =20
>  #include "sbshc.h"
> =20
> -#define ACPI_AC_CLASS=09=09=09"ac_adapter"
>  #define ACPI_SBS_DEVICE_NAME=09=09"Smart Battery System"
>  #define ACPI_BATTERY_DIR_NAME=09=09"BAT%i"
>  #define ACPI_AC_DIR_NAME=09=09"AC0"
> --- a/drivers/gpu/drm/amd/include/amd_acpi.h
> +++ b/drivers/gpu/drm/amd/include/amd_acpi.h
> @@ -26,8 +26,6 @@
> =20
>  #include <linux/types.h>
> =20
> -#define ACPI_AC_CLASS           "ac_adapter"
> -
>  struct atif_verify_interface {
>  =09u16 size;=09=09/* structure size in bytes (includes size field) */
>  =09u16 version;=09=09/* version */
> --- a/drivers/gpu/drm/radeon/radeon_acpi.c
> +++ b/drivers/gpu/drm/radeon/radeon_acpi.c
> @@ -44,8 +44,6 @@ bool radeon_atpx_dgpu_req_power_for_disp
>  static inline bool radeon_atpx_dgpu_req_power_for_displays(void) { retur=
n false; }
>  #endif
> =20
> -#define ACPI_AC_CLASS           "ac_adapter"
> -
>  struct atif_verify_interface {
>  =09u16 size;=09=09/* structure size in bytes (includes size field) */
>  =09u16 version;=09=09/* version */
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -58,8 +58,6 @@ enum hp_ec_offsets {
>  #define HP_POWER_LIMIT_DEFAULT=09 0x00
>  #define HP_POWER_LIMIT_NO_CHANGE 0xFF
> =20
> -#define ACPI_AC_CLASS "ac_adapter"
> -
>  #define zero_if_sup(tmp) (zero_insize_support?0:sizeof(tmp)) // use when=
 zero insize is required
> =20
>  enum hp_thermal_profile_omen_v0 {
> --- a/drivers/platform/x86/lenovo/wmi-capdata.c
> +++ b/drivers/platform/x86/lenovo/wmi-capdata.c
> @@ -53,7 +53,6 @@
>  #define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE01=
8154"
>  #define LENOVO_FAN_TEST_DATA_GUID "B642801B-3D21-45DE-90AE-6E86F164FB21"
> =20
> -#define ACPI_AC_CLASS "ac_adapter"
>  #define ACPI_AC_NOTIFY_STATUS 0x80
> =20
>  #define LWMI_FEATURE_ID_FAN_TEST 0x05
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -613,6 +613,8 @@ struct acpi_bus_event {
>  =09u32 data;
>  };
> =20
> +#define ACPI_AC_CLASS=09"ac_adapter"
> +
>  extern struct kobject *acpi_kobj;
>  extern int acpi_bus_generate_netlink_event(const char*, const char*, u8,=
 int);
>  void acpi_bus_private_data_handler(acpi_handle, void *);

--8323328-151852091-1772801052=:1000--

