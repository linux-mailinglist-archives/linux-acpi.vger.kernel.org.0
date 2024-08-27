Return-Path: <linux-acpi+bounces-7864-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D53E2960490
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 10:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8D328430B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 08:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1725194AEA;
	Tue, 27 Aug 2024 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yq1PXH3l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D3A14A90;
	Tue, 27 Aug 2024 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747825; cv=none; b=YVFwnAd5CIA3zCfDzJZ6NMcGaz6i4XMpFF7o79/3qO3nLLDy+gcgeoCli6C88JgSt5dw0wfjWg9rXFbzfQ+jw6d4RtbGrcRjy4cErq2DU6SMWKGrcFVFjgsoBQ+GFASIGK7v7LtFd5Qy4pe3NiG7n4aKdNQ7kUH4X1FuyGylEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747825; c=relaxed/simple;
	bh=kxKmRko+Nd8/3GZyz7ozg6g0c2O31F21/uLhOODHrO8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K2fMLwrsTEejd9kNua67PR57IyWRhAzfSdy6ovXWO+WAIfjB4TBd/oUxScRpj92dWwL1OGAc8I6VoWNWxPir5Zyq1aMy4Pya+ZpDwc2myKEisuWLeorSnBhf2y3yclhQrJ9lqAzI23FzHv2FFZzt9yRprhOs/LuOfCdDCdjUcLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yq1PXH3l; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724747825; x=1756283825;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kxKmRko+Nd8/3GZyz7ozg6g0c2O31F21/uLhOODHrO8=;
  b=Yq1PXH3lan1mfHKWiE5Pfp3sK5r8MSxDHhecSMcyOJnghfvBYt7muLWL
   WZx4Y7r8eamAKv42VAlSFQko0Keih6KR8IWyljjVCb6WimWGSZwVAKOWe
   RmRif1VVErnmnsul9rejVnKo35J1Ova/JBTEu5pu5vSSrkVYzB7g+Z4Pu
   2LnM45Z6Hv31prYvuVmIbz/c8CWsnCm2IRWjB8y+Y98b8cWR0kLu4bbqJ
   tIQ2x/Jtz4os2MQ1xW5TsIGtWBleSosb1D9gJG6gGGONSAMnERxFZsCXb
   MjBig+57sHTf3Y8OgPC2wpEsIVAMAOJH1LWvSzuj5Eizi0ub55Id9glvW
   w==;
X-CSE-ConnectionGUID: yALKWO06RBGi3rK7UIty8A==
X-CSE-MsgGUID: 3NdYCANwSR2By+ZhSwq+0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23370536"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23370536"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 01:37:04 -0700
X-CSE-ConnectionGUID: HWjlfVLbS6WnaqtQCn3MLg==
X-CSE-MsgGUID: wfwH5x6QSvigaRb2ct9vVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="66923516"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.17])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 01:36:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Aug 2024 11:36:55 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: james@equiv.tech, jlee@suse.com, corentin.chary@gmail.com, luke@ljones.dev, 
    matan@svgalib.org, coproscefalo@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
    platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] platform/x86: wmi: Merge get_event_data() with
 wmi_get_notify_data()
In-Reply-To: <20240822173810.11090-5-W_Armin@gmx.de>
Message-ID: <eec3f62c-67b3-8504-b87e-69700970f3de@linux.intel.com>
References: <20240822173810.11090-1-W_Armin@gmx.de> <20240822173810.11090-5-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-584332887-1724747815=:1032"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-584332887-1724747815=:1032
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Aug 2024, Armin Wolf wrote:

> Since get_event_data() is only called by wmi_get_notify_data(), it
> makes sense to merge both functions.
>=20
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-584332887-1724747815=:1032--

