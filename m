Return-Path: <linux-acpi+bounces-12023-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAEFA59D58
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 18:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3073A5106
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C92A230BC8;
	Mon, 10 Mar 2025 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WudoEEmA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C618DB24;
	Mon, 10 Mar 2025 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627176; cv=none; b=mw0/j3Wm/FufYjcQRC9nY41vx4FUOjMtNjggsFndeZFpnWMEawupDzGf4l1gj1C+OLK1jXgj7qagRaYKxTu4zxOXGauX8Yhs19UwSVX9kt6WByEasbcafPAUomNpzgtwM3+v1pglDAuDc7iOhJJMet6VYPXc9SPGS1FmA6TAbMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627176; c=relaxed/simple;
	bh=1+Q8YC08zubE/6BRvuVB6y5VTJRChZzHOcbWbQ7rDjM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BXMEJ54DpyIZjVNFKX+3ha+Q6t2V//z+GZlpLYHsO0KpUfjiCnbNS6vtDXxdN0giX/vgxi6ZDb3FHhxmtYMU6sikcnaetMciRTZWPALLwR92cwSntaaipH0bMBwtFb3btQiFDUpO+3fA+GcSFs4PH3oOqdZkeOF8LQfjcZ1yS+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WudoEEmA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741627175; x=1773163175;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1+Q8YC08zubE/6BRvuVB6y5VTJRChZzHOcbWbQ7rDjM=;
  b=WudoEEmAWyDfwW4Upr2LeyIRJceMlnqahbcg1MeRHYqOT+m6LK424QNP
   3S9xRoqiIthmrNsf1YpMRQExovLfW0epTmMmV9vIcaMWZl7mdFn2wzUnQ
   hkuL3fuKpytO9ybGlT2wPWEzkUmEECH5C4kBgOcvFsI8k2tEw75tSt/lk
   qLNaATlCKwe5ekL1bJ28Z6wEt1mvQBmaEAm7Bo6Qx+iT6UCnvqWQgeXkL
   EE+XlM3SMAVpfyRONpFS3TCoByP8cXKL1MSm2yVdpfTwUrUbzgW6YWj1M
   i1VF5nPbIgOMTI6yALD6Xc3FKGxF2EyPkseJRdSRTz2dCfn9/uVowElZV
   g==;
X-CSE-ConnectionGUID: iPLTIwgMQnKbZVO0zmDdGw==
X-CSE-MsgGUID: cWJKFY7kRO62N3B3PgLpqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42485881"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42485881"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:19:34 -0700
X-CSE-ConnectionGUID: KL2SRA7gSWqj4R1lhSlYzw==
X-CSE-MsgGUID: Shp/u2yAQ0+R6aQ0rwAumA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120945827"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.59])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:19:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Mar 2025 19:19:25 +0200 (EET)
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
    Mario Limonciello <mario.limonciello@amd.com>, 
    Yijun Shen <Yijun.Shen@dell.com>
Subject: Re: [PATCH] platform/x86/amd: pmf: Fix missing hidden options for
 Smart PC
In-Reply-To: <20250306034402.50478-1-superm1@kernel.org>
Message-ID: <50adcc9d-241d-19b6-7b03-2e91ef7d017b@linux.intel.com>
References: <20250306034402.50478-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Mar 2025, Mario Limonciello wrote:

> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> amd_pmf_get_slider_info() checks the current profile to report correct
> value to the TA inputs.  If hidden options are in use then the wrong
> values will be reported to TA.
> 
> Add the two compat options PLATFORM_PROFILE_BALANCED_PERFORMANCE and
> PLATFORM_PROFILE_QUIET for this use.
> 
> Reported-by: Yijun Shen <Yijun.Shen@dell.com>
> Fixes: 9a43102daf64d ("platform/x86/amd: pmf: Add balanced-performance to hidden choices")
> Fixes: 44e94fece5170 ("platform/x86/amd: pmf: Add 'quiet' to hidden choices")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/amd/pmf/spc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
> index f34f3130c3307..1d90f9382024b 100644
> --- a/drivers/platform/x86/amd/pmf/spc.c
> +++ b/drivers/platform/x86/amd/pmf/spc.c
> @@ -219,12 +219,14 @@ static int amd_pmf_get_slider_info(struct amd_pmf_dev *dev, struct ta_pmf_enact_
>  
>  	switch (dev->current_profile) {
>  	case PLATFORM_PROFILE_PERFORMANCE:
> +	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
>  		val = TA_BEST_PERFORMANCE;
>  		break;
>  	case PLATFORM_PROFILE_BALANCED:
>  		val = TA_BETTER_PERFORMANCE;
>  		break;
>  	case PLATFORM_PROFILE_LOW_POWER:
> +	case PLATFORM_PROFILE_QUIET:
>  		val = TA_BEST_BATTERY;
>  		break;
>  	default:

Hi Mario,

Just for me to be sure what I'm supposed to do with all these patches 
related to this platform profile legacy handling... :-)

So this fix is necessary in addition to the 3 patches that got already 
merged through Rafaels tree?

What about this patch from Luke:

https://patchwork.kernel.org/project/platform-driver-x86/patch/20250224223551.16918-1-luke@ljones.dev/

Is that also needed?

Thanks in advance.

-- 
 i.

