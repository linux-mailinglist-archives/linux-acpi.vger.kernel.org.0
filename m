Return-Path: <linux-acpi+bounces-10087-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60A9EC760
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FA5188C3C2
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710551D5ABA;
	Wed, 11 Dec 2024 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hu0zUNk/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886F1C4A1B;
	Wed, 11 Dec 2024 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905939; cv=none; b=krOfaN4WtHhDhCxyLhnKxloylO/bERIM4MfyDimA4XG1q+ALGfZSgAVGuwokHTiO3Y4VaxMOSoDtH4G9xXPJ7hCRyViUW/6riNARHtb6aVDi2FhWrBbBmnwF8QHJ3FgrU7T0+ic5brsmU1XOCL5Mb/QM2IQmfQl1dXVX2O1tfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905939; c=relaxed/simple;
	bh=ASSddga9/M67TA3gYuvbbIyqUT/9g38+NyFTLhOga1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeUORe4Z5jJE59FOSgkDbf6vm2pt8HTgP6ckT/EUBibworJjVI7C91e2cFVuyC63gtdR48HN448hXbIAAsBWDFi2xxLYnfZOL2ks09lna086FHFRbspLGbl/HmV060YZJOiEH76DLeUBPS3PeZfvacRtDPCq/5UHEZDmTU1QcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hu0zUNk/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733905938; x=1765441938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ASSddga9/M67TA3gYuvbbIyqUT/9g38+NyFTLhOga1A=;
  b=Hu0zUNk/hN240t21GhFl6wgKtqbt5RCYwXBseiaygn9u2tJseJt6tvy2
   RfdQTBqLrguPQ2l+QKSlGnG8+UKKVUWb46HC2Y7KIAPIkj1MbdcBXLFza
   11QgiRMjojzgwNXpXARp/2l23+U0Z3BM/ZvFruTEAibQdK4TrJW5UQ3v8
   bgTvRs0+r5HtJGENI2LtzXamfNtcDpXiFeVqOgCOOUMj8pFOUz5uyD5ev
   LWB6iJPfR8kTH+ITxZokNHULP+UdRlNNo9jAZVloGXrUERUYd1YgUN8LB
   eHPW44f212z7safQf2helRxjqIXIhn+EM23IppvRI0ZRQoBx6rzWNmKQr
   g==;
X-CSE-ConnectionGUID: p6PHFotqSDCEgAaqxlm8sQ==
X-CSE-MsgGUID: RmvcWNM1SyGXjLmhrM+WPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34197774"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34197774"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:32:15 -0800
X-CSE-ConnectionGUID: yGhZC1/aRCWJk+iRVq200Q==
X-CSE-MsgGUID: TmrSgisHTB2/5QcJNlGcEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="100536367"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:32:11 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id EE8DD11F71F;
	Wed, 11 Dec 2024 10:32:08 +0200 (EET)
Date: Wed, 11 Dec 2024 08:32:08 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 7/7] media: ipu-bridge: Remove unneeded conditional
 compilations
Message-ID: <Z1lOCGJvgFcqmR3R@kekkonen.localdomain>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
 <20241210-fix-ipu-v3-7-00e409c84a6c@chromium.org>
 <20241211091954.42a5c778@foz.lan>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211091954.42a5c778@foz.lan>

Hi Mauro,

On Wed, Dec 11, 2024 at 09:19:54AM +0100, Mauro Carvalho Chehab wrote:
> > @@ -768,15 +755,10 @@ static int ipu_bridge_ivsc_is_ready(void)
> >  	unsigned int i;
> >  
> >  	for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
> > -#if IS_ENABLED(CONFIG_ACPI)
> >  		const struct ipu_sensor_config *cfg =
> >  			&ipu_supported_sensors[i];
> >  
> >  		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> > -#else
> > -		while (false) {
> > -			sensor_adev = NULL;
> > -#endif
> >  			if (!ACPI_PTR(sensor_adev->status.enabled))
> >  				continue;
> >  
> > 
> 
> Considering that you drop patch 1, and keep the ACPI dependencies
> at the header, as proposed by patches 2-6:
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kerenel.org>

The 1st patch fixes a compilation warning when CONFIG_ACPI is disabled.
Merging that patch as a temporary solution is simply easier than making
arragements for merging the ACPI patches to the Media tree so the last
patch may be merged, too.

Besides, the fix should also be backported.

Ricardo: how about adding Cc: stable for that one?

-- 
Regards,

Sakari Ailus

