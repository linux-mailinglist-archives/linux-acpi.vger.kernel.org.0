Return-Path: <linux-acpi+bounces-8084-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 795A696897E
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A293C1C21F71
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBAB21019D;
	Mon,  2 Sep 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeWWXoqg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AB183CDC;
	Mon,  2 Sep 2024 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286180; cv=none; b=Ls3jRxoUrvO4cYOGGjtP8cUqmCW6AhZJ8CB9egGwVNaacL+TdddA2t2bqWzveDI5NijP+bX29EqfLvxyioLVZyS02t8sZaB7Zmntuss+d7s5WccKAbhYLMGYkVk0lyW8d4dGgWMH2bHKwijMXiraTYulKnn3i9dCjreoW9rVcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286180; c=relaxed/simple;
	bh=WzLlmfj8ZaZFS9RPHynAdrvd0IA2vC+R44QIE6StOK4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YIqYfojGb2SF+7l9/CaDT6tjaNAbCWW5gHrYnSuzVXJxBjrNwHcuFKnQQu3uKkB+AWPJ78bUPjk7QCDVi+L23cZ593e0LZs/4Hzr+MHbMtGi1QZlNIAJOB500n52Qb5ASpC/XBMgNWu5m5hb9JcrIpnZpF12lfJCIhYmfPWl0rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeWWXoqg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725286179; x=1756822179;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WzLlmfj8ZaZFS9RPHynAdrvd0IA2vC+R44QIE6StOK4=;
  b=BeWWXoqgc5B7k/oi3WJF4W5jFfnWLB0NLbb5rz8aR2qgg5vFwDM/E8gF
   QtEHyj1xTIaxB2d3a2sC1feHe/VNifZNb7OXgoExgBu3I5+TpGg7zyqjb
   iQ9ZvqdTByAPiu9qwlUANoAYwySzH0gSbv+HfaagR1d3CxWBsnXU0S2cN
   b8ppFJBxiaoys9pC7L58Mz2g1rMHzpMIpozeeYOYb3IMPlkIkf5dQDtMl
   qNg+r1QQRDb2D+f2zXi9p9qVM9vfKrHEFfrEUhyIv+PXfl9hCGIAFiQbs
   7RxS0/jGmagZ+U59tFpZasduSqIqZcYGhcjTXHKzsnnUiIpXYmChFHkm+
   w==;
X-CSE-ConnectionGUID: mubCWjOSSz6jfCZlKTtBjQ==
X-CSE-MsgGUID: 4/sX7z1nT4e986uOczbWYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="35237841"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="35237841"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 07:09:38 -0700
X-CSE-ConnectionGUID: 2DYSmZ0NSIyKmzFp4JLadw==
X-CSE-MsgGUID: +SDs2mJ+Qz+VtAQQ31t3LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64815095"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 07:09:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 2 Sep 2024 17:09:26 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: james@equiv.tech, jlee@suse.com, corentin.chary@gmail.com, luke@ljones.dev, 
    matan@svgalib.org, coproscefalo@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, linux@roeck-us.net, jdelvare@suse.com, 
    "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
    platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] hwmon: (hp-wmi-sensors) Check if WMI event data
 exists
In-Reply-To: <20240901031055.3030-2-W_Armin@gmx.de>
Message-ID: <c474bfef-a4d4-f1f5-463d-04ed6f69818e@linux.intel.com>
References: <20240901031055.3030-1-W_Armin@gmx.de> <20240901031055.3030-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2029501479-1725286166=:1156"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2029501479-1725286166=:1156
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 1 Sep 2024, Armin Wolf wrote:

> The BIOS can choose to return no event data in response to a
> WMI event, so the ACPI object passed to the WMI notify handler
> can be NULL.
>=20
> Check for such a situation and ignore the event in such a case.
>=20
> Fixes: 23902f98f8d4 ("hwmon: add HP WMI Sensors driver")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


> ---
>  drivers/hwmon/hp-wmi-sensors.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensor=
s.c
> index b5325d0e72b9..dfa1d6926dea 100644
> --- a/drivers/hwmon/hp-wmi-sensors.c
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -1637,6 +1637,8 @@ static void hp_wmi_notify(u32 value, void *context)
>  =09=09goto out_unlock;
>=20
>  =09wobj =3D out.pointer;
> +=09if (!wobj)
> +=09=09goto out_unlock;
>=20
>  =09err =3D populate_event_from_wobj(dev, &event, wobj);
>  =09if (err) {
> --
> 2.39.2
>=20
--8323328-2029501479-1725286166=:1156--

