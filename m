Return-Path: <linux-acpi+bounces-10332-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65119FE9DF
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 19:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DDD3A21BA
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Dec 2024 18:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19C413CA93;
	Mon, 30 Dec 2024 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIp/AyNf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA874EAD0;
	Mon, 30 Dec 2024 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583497; cv=none; b=bhKhuRpVUNHkv15OvmZ3kleZP93hRgYd4DxCEE8D3799Q1/FfxTAOTr34WZ4objH6lS9erYx/FfRmqQtyon602v9G5V4O54WHbvKFS9PkOqfHsB6jfMBT2fQjEyTqQXbj1wblko9AYnHg1hekyqqWI65IWQBBQ8BPfBzhcrohK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583497; c=relaxed/simple;
	bh=xOZVEgIkvhDHI5YeK3VfYneLXjUXlB8tMLYs8Gl047U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c0dEEGZJJYsBVgnxTCOXWg6utRveVghk9QTbSrlBN8cM1+Nsa+9FPr7Q80S1TGDSrwEiU81KKuYqF7Kmu/M0gn+3199WTGR/mSbZ+rhK6q5keDXkYyPGevNnio3uBl0CqpR6fKXBt4H++1YH6lw4ZavH0TyynACRn1ClmIIkcOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIp/AyNf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735583496; x=1767119496;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xOZVEgIkvhDHI5YeK3VfYneLXjUXlB8tMLYs8Gl047U=;
  b=AIp/AyNfK9m3Bye+5dmMQS/cPhokVRLzGmTS9GtsfozIVSSoBwfjAfVz
   QrqUaPvw203SysxnZisTBUYSEh/LzwPWIStl176k51Ra/maPDSj59/lF1
   71o51jc9VkSWr/FLfqaHIOB+fBjmUV6TM/AUVxJaXvBKQlUAhwuXWnOus
   NulUE0WEdwJ16ySTJWt+5Uuwn7MR8ZoLCs3by89Yy/ZESdxi1kiBtXbwe
   xoeSH517lTMKWZm+5eqZafx6vliIOm5obvAVgeVxXlKQ46Dfk+/Cuge4P
   W26Z2xloVuv3iSfR4ZVW7Lmd1Kz2wtEUjYpEhQfuV1fYmYzzrr4WM6+Oy
   A==;
X-CSE-ConnectionGUID: ReDsMA5mSby1iu1SgNQ/Kw==
X-CSE-MsgGUID: IVAkDGIzRYCAbdnfMkczSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11301"; a="35984977"
X-IronPort-AV: E=Sophos;i="6.12,277,1728975600"; 
   d="scan'208";a="35984977"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2024 10:31:35 -0800
X-CSE-ConnectionGUID: tpm57+TWRnuZgNJP8U5VrQ==
X-CSE-MsgGUID: 5NUG4qidRfOT+n6TzQR1hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="105925182"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.19])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2024 10:31:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Dec 2024 20:31:28 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: platform-driver-x86@vger.kernel.org, W_Armin@gmx.de, 
    Hans de Goede <hdegoede@redhat.com>, lenb@kernel.org, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    mario.limonciello@amd.com, Mark Pearson <mpearson-lenovo@squebb.ca>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, soyer@irl.hu
Subject: Re: [PATCH v2 0/2] Device managed platform_profile_register()
In-Reply-To: <20241224140131.30362-2-kuurtb@gmail.com>
Message-ID: <00b64207-ec35-5c99-9bdc-13c77e51e453@linux.intel.com>
References: <20241224140131.30362-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Dec 2024, Kurt Borja wrote:

> Hi :)
> 
> This is meant to be merged on the pdx86 tree.
> 
> ~ Kurt
> 
> v2:
>  - Replaced convoluted cast with intermediate variable (1/2)
>  - Restored dropped empty line (1/2)
>  - Couldn't incorporate Armin's second comment. I probably didn't
>    understand it (1/2)
> v1: 
>  - https://lore.kernel.org/platform-driver-x86/20241221070817.3764-2-kuurtb@gmail.com
> 
> Kurt Borja (2):
>   ACPI: platform_profile: Add devm_platform_profile_register()
>   alienware-wmi: Use devm_platform_profile_register()
> 
>  drivers/acpi/platform_profile.c           | 29 +++++++++++++++++++++++
>  drivers/platform/x86/dell/alienware-wmi.c | 10 +-------
>  include/linux/platform_profile.h          |  1 +
>  3 files changed, 31 insertions(+), 9 deletions(-)

Thanks. I've now applied these.

The first patch is already in the for-next branch and the second is 
currently in the review-ilpo-next branch (as I wanted to retain ability to 
easily separate changes into platform_profile.c from the rest, they go to 
their own branch first).

-- 
 i.


