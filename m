Return-Path: <linux-acpi+bounces-9948-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6CC9E587F
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 15:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C5316B0A3
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647E91C3318;
	Thu,  5 Dec 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUP0lu1t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83782C60;
	Thu,  5 Dec 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409026; cv=none; b=I/4l+suQQYUA7I7TM99LuojwNxHcy/DclmMxr5Ma2oTp9FnEyNcSqhAgNvelZB/lSUaYJUDsIex7URGaqWpHR00gYMGRyaWnPiJewz2xeo/qIghSJD6W2aEz1OjCXx16et9ENnhbqaNuF+X7WP1zC3dsQZR6n5rdiZfr9GMw+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409026; c=relaxed/simple;
	bh=bg6Ck0rQwf90QMJ/myWSOUtXGRxnH99n2CYVN0qDAtE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M9JBNA08gOHXkB6mz2F0LZYpOZEwvtZd0LgVO2vAz+ouq5ccJmk/YKzDqMdPYC2t3XbtMpWRoAVr0N2mW1RZqh4wX35XZG8FByomBYxeHPqWNq7lWtBRvUZlpt89RD/rQyIbnc66k0c5PdKbpt7jhnJiThdB8Vkek09212ObggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUP0lu1t; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733409024; x=1764945024;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bg6Ck0rQwf90QMJ/myWSOUtXGRxnH99n2CYVN0qDAtE=;
  b=RUP0lu1txmp6M/ID19zlwGCIXAWKL48vl0ggtPTq0LvuR39TIMDNAdW/
   0yJpHcZk9cSpwPTq5qroSSp6sis+4Y+okeIX3CaFC+IjryHuw2DygzybP
   nELwSlNkZ4cdyQe1DJr+4PPSZj47njEnzoccTuHIwI90QxtFdVNYr+pAw
   dcbXSXD/NOa+xldax/u4CKvKfQ48pc5eZU69tgyoD8Rm4mpzF+cy1MblQ
   vF7R7AFHZQx+pIvZ1pJwoRla+3HLZdqA1/N863Ytwdwxai0e44wytDZqz
   8UgdHQUJj5esEwD1sBpBVhTLq7JY0ufiuWMiMN1zy5rdIRsB0bDCS8Nw4
   Q==;
X-CSE-ConnectionGUID: f2u1IOGMSAmI9ElDOFLyOw==
X-CSE-MsgGUID: swLWDKoDT3OVI6xcR6HSqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33638074"
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="33638074"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 06:30:23 -0800
X-CSE-ConnectionGUID: Wkk0ub/UTLOyaHiQ/Ol2Xw==
X-CSE-MsgGUID: Fy2DLq+2RR+/y5Q4BYSFGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,210,1728975600"; 
   d="scan'208";a="94586253"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 06:30:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 5 Dec 2024 16:30:12 +0200 (EET)
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
Subject: Re: [PATCH v9 21/22] platform/x86/amd: pmf: Drop all quirks
In-Reply-To: <20241202055031.8038-22-mario.limonciello@amd.com>
Message-ID: <5dd0cec6-8af1-2305-bbd6-68ef5c88b5f0@linux.intel.com>
References: <20241202055031.8038-1-mario.limonciello@amd.com> <20241202055031.8038-22-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1294625211-1733409012=:932"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1294625211-1733409012=:932
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 1 Dec 2024, Mario Limonciello wrote:

> As multiple platform profile handlers can now be registered, the quirks
> to avoid registering amd-pmf as a handler are no longer necessary.
> Drop them.
>=20
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd/pmf/Makefile     |  2 +-
>  drivers/platform/x86/amd/pmf/core.c       |  1 -
>  drivers/platform/x86/amd/pmf/pmf-quirks.c | 66 -----------------------
>  drivers/platform/x86/amd/pmf/pmf.h        |  3 --
>  4 files changed, 1 insertion(+), 71 deletions(-)
>  delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
>=20
> diff --git a/drivers/platform/x86/amd/pmf/Makefile b/drivers/platform/x86=
/amd/pmf/Makefile
> index 7d6079b02589c..6b26e48ce8ad2 100644
> --- a/drivers/platform/x86/amd/pmf/Makefile
> +++ b/drivers/platform/x86/amd/pmf/Makefile
> @@ -7,4 +7,4 @@
>  obj-$(CONFIG_AMD_PMF) +=3D amd-pmf.o
>  amd-pmf-objs :=3D core.o acpi.o sps.o \
>  =09=09auto-mode.o cnqf.o \
> -=09=09tee-if.o spc.o pmf-quirks.o
> +=09=09tee-if.o spc.o
> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/a=
md/pmf/core.c
> index 06a97c533cb85..01eb9ee1eccd9 100644
> --- a/drivers/platform/x86/amd/pmf/core.c
> +++ b/drivers/platform/x86/amd/pmf/core.c
> @@ -456,7 +456,6 @@ static int amd_pmf_probe(struct platform_device *pdev=
)
>  =09mutex_init(&dev->lock);
>  =09mutex_init(&dev->update_mutex);
> =20
> -=09amd_pmf_quirks_init(dev);
>  =09apmf_acpi_init(dev);
>  =09platform_set_drvdata(pdev, dev);
>  =09amd_pmf_dbgfs_register(dev);
> diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform=
/x86/amd/pmf/pmf-quirks.c
> deleted file mode 100644
> index 7cde5733b9cac..0000000000000
> --- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * AMD Platform Management Framework Driver Quirks
> - *
> - * Copyright (c) 2024, Advanced Micro Devices, Inc.
> - * All Rights Reserved.
> - *
> - * Author: Mario Limonciello <mario.limonciello@amd.com>
> - */
> -
> -#include <linux/dmi.h>
> -
> -#include "pmf.h"
> -
> -struct quirk_entry {
> -=09u32 supported_func;
> -};
> -
> -static struct quirk_entry quirk_no_sps_bug =3D {
> -=09.supported_func =3D 0x4003,
> -};
> -
> -static const struct dmi_system_id fwbug_list[] =3D {
> -=09{
> -=09=09.ident =3D "ROG Zephyrus G14",
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "GA403U"),
> -=09=09},
> -=09=09.driver_data =3D &quirk_no_sps_bug,
> -=09},
> -=09{
> -=09=09.ident =3D "ROG Ally X",
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "RC72LA"),
> -=09=09},
> -=09=09.driver_data =3D &quirk_no_sps_bug,
> -=09},
> -=09{
> -=09=09.ident =3D "ASUS TUF Gaming A14",
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "FA401W"),
> -=09=09},
> -=09=09.driver_data =3D &quirk_no_sps_bug,
> -=09},
> -=09{}
> -};
> -
> -void amd_pmf_quirks_init(struct amd_pmf_dev *dev)
> -{
> -=09const struct dmi_system_id *dmi_id;
> -=09struct quirk_entry *quirks;
> -
> -=09dmi_id =3D dmi_first_match(fwbug_list);
> -=09if (!dmi_id)
> -=09=09return;
> -
> -=09quirks =3D dmi_id->driver_data;
> -=09if (quirks->supported_func) {
> -=09=09dev->supported_func =3D quirks->supported_func;
> -=09=09pr_info("Using supported funcs quirk to avoid %s platform firmware=
 bug\n",
> -=09=09=09dmi_id->ident);
> -=09}
> -}
> diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/am=
d/pmf/pmf.h
> index a79808fda1d89..64ab532550ac3 100644
> --- a/drivers/platform/x86/amd/pmf/pmf.h
> +++ b/drivers/platform/x86/amd/pmf/pmf.h
> @@ -797,7 +797,4 @@ int amd_pmf_smartpc_apply_bios_output(struct amd_pmf_=
dev *dev, u32 val, u32 preq
>  void amd_pmf_populate_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf_e=
nact_table *in);
>  void amd_pmf_dump_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf_enact=
_table *in);
> =20
> -/* Quirk infrastructure */
> -void amd_pmf_quirks_init(struct amd_pmf_dev *dev);
> -
>  #endif /* PMF_H */
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1294625211-1733409012=:932--

