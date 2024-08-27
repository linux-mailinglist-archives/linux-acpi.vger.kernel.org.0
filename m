Return-Path: <linux-acpi+bounces-7863-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 916BC96047F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 10:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4E42841F1
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 08:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA57315534E;
	Tue, 27 Aug 2024 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+TdtujK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2620683A14;
	Tue, 27 Aug 2024 08:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747651; cv=none; b=m1E9BUJD/DwZbgQQRrfy9/TIGjjkw1hDwWvYznjZrM+E6dUwDr4EC5M0kMcRMzo+kQYNro2zAOployihlG4UzUQ7tcKEqRyfqJ4xVaIdYi+Qs99TmKlPRUP/4k98AA8tfJAGTmdDeTMA2XcPgFJq+voe8SRD1jMbIyBApVD41O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747651; c=relaxed/simple;
	bh=ROcOpXUf+MF3DWscuVVNdpIk8d/XGSXmvt/LSU2Z/0s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yoomg/qfGzAqkqpw/ywuB0PKX1LCbo97M6KCTZ0R6K37nzL19vM7FOnafQMYIAZ4eeXri6jmK1aAr5ht/DDsgMy5d5SHOrf8giU8YU79F3K5yCyf67DVWBEUwt+0Ghb7v2JschAxs+RxvoZt0aGJmELR0HNzsw970ik7O3boF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+TdtujK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724747650; x=1756283650;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ROcOpXUf+MF3DWscuVVNdpIk8d/XGSXmvt/LSU2Z/0s=;
  b=A+TdtujKyuzNoh9XZOJKBmb/ohbJRr3f/FX3vmnTw6XSRjDK+nlwMJWh
   JYnihaGlvw9ajKOmgHy+bydP2H5Pntln/IxiAdEQVr3+7T4kWxqHxYRqa
   TxTLkT/dzHzZvUKJ761V+TNkJkD0vHv5QVcwZCDRs1sBZW7q9/QLU5J8j
   hxr9JXdhHVS2pIWNvLfOlwGHzZKubPdshjq2brqBfJs5Iwh1frIPQVSe3
   J/+yGJQxiB8jAcetrTY9WhQwPKg8WPq/WluO2DjAtH+kcQgWoD1ThUziC
   79dlFqtVbDAUFMYl2JWelx8gCazSYdoJt0Hra4lxmqXVSjF3X10caSk9l
   Q==;
X-CSE-ConnectionGUID: jcsDa736QbqxFo3C7wxqDw==
X-CSE-MsgGUID: 38sn6W/CScuu+vh48Ke+uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="27005826"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="27005826"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 01:33:51 -0700
X-CSE-ConnectionGUID: hAd0yXdATaqVBI7bx9tp3g==
X-CSE-MsgGUID: XzgK2+XHQ2qJwEmKsvyUPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67603056"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.17])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 01:33:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Aug 2024 11:33:41 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: james@equiv.tech, jlee@suse.com, corentin.chary@gmail.com, luke@ljones.dev, 
    matan@svgalib.org, coproscefalo@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
    platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] platform/x86: wmi: Remove wmi_get_event_data()
In-Reply-To: <20240822173810.11090-4-W_Armin@gmx.de>
Message-ID: <4a0f59a3-476b-baf0-d070-0e0ad3b09f81@linux.intel.com>
References: <20240822173810.11090-1-W_Armin@gmx.de> <20240822173810.11090-4-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1975892734-1724747621=:1032"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1975892734-1724747621=:1032
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Aug 2024, Armin Wolf wrote:

> Since the WMI driver core now takes care of retrieving the
> WMI event data even for legacy WMI notify handlers, this
> function is no longer used.
>=20
> Remove it to prevent WMI drivers from messing up the ACPI
> firmware on some machines.
>=20
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1975892734-1724747621=:1032--

