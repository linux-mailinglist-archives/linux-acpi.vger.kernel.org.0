Return-Path: <linux-acpi+bounces-14254-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72343AD2767
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 22:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15451895221
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 20:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2839B220F47;
	Mon,  9 Jun 2025 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHjhKnjo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80926220694;
	Mon,  9 Jun 2025 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499762; cv=none; b=nLA3i+uGBBmQkhfb8XBunEYp/DwLUqmiKDcqKc8NpQVUcRQoPE4PMSbB1F5RW4/lzEM4iJnC73zmSRDAHD7dSouJ4fLPeq8w2zUdwnfW3Tkqe8BeP0n1mk7bkmnn4oHJZ0D532XVNCV//zc33gj7dDxu8NpUNhtgeI6pNSW9W/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499762; c=relaxed/simple;
	bh=S3bte22PViz/0FPvqp4iZzYMLNZuqqba7A5crqD8d+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F77OGBADRRWhMiV7RPNKHaxgmI8sAfVdYXlS0+cgx4Qfs+XcWzSXf6CXFPL+Nizt91jBuTjb064HuCVwLa9yCOpNQTbuL6nuUiW/vTTPcdMxKpubQM7l4ByIO6v5k9YHj41XVzz5My0uIou+p/XC/Oo4JEWxFDQtsMH9c6mGYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHjhKnjo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749499761; x=1781035761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S3bte22PViz/0FPvqp4iZzYMLNZuqqba7A5crqD8d+Y=;
  b=KHjhKnjouevZLtltRkO/z1o39DTWr/1L3I0YglLF8F4c927ZEsCXJX0H
   0apfXT06bsZeACYndAd2FoMmkDOZB2ZW4P+12YAq0CZ0kvEw2iy08gQpN
   pYuuvJHyiXur8mikFQAKbeDpKqhXbKJJUFyAYhqxZCUVi2rhM+RcrtISR
   oQHvd/Wcf9PgPypU26UsL5RZK1jL4wKBKqFyjFlcuoTOd5bKGslCTfXhs
   16lROdqxKWtIBwbGAVBx47Cw9AjhRz1oicnxfuo+hfDqjr8iuN67asfjA
   U/a6W2jJmDEmxKmgbYEr26KQwPjbEHIuBkeAiWdAfkqsCy3+hn3dRk9vz
   w==;
X-CSE-ConnectionGUID: Y78awuB4RY6THwjS5maINA==
X-CSE-MsgGUID: 9eX4yUQWS86Z3GYPOnhs8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55257021"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55257021"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 13:09:20 -0700
X-CSE-ConnectionGUID: t8QaCJz1SvmUEiuPsIZKow==
X-CSE-MsgGUID: ntpQDI6UT9W/Pss3AnGz0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="147550992"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 13:09:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uOinz-000000059U6-0Chw;
	Mon, 09 Jun 2025 23:09:15 +0300
Date: Mon, 9 Jun 2025 23:09:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
	westeri@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add a quirk for Acer Nitro V15
Message-ID: <aEc_auwSLQLoCsJT@smile.fi.intel.com>
References: <20250609023424.372827-1-superm1@kernel.org>
 <20250609060717.GF88033@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609060717.GF88033@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 09, 2025 at 09:07:17AM +0300, Mika Westerberg wrote:
> On Sun, Jun 08, 2025 at 09:34:08PM -0500, Mario Limonciello wrote:
> > 
> > It is reported that on Acer Nitro V15 suspend only works properly if the
> > keyboard backlight is turned off. In looking through the issue Acer Nitro
> > V15 has a GPIO (#8) specified in _AEI but it has no matching notify device
> > in _EVT. The values for GPIO #8 change as keyboard backlight is turned on
> > and off.
> > 
> > This makes it seem that GPIO #8 is actually supposed to be solely for
> > keyboard backlight.  Turning off the interrupt for this GPIO fixes the issue.
> > Add a quirk that does just that.
> > 
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4169
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Acked-by: Mika Westerberg <westeri@kernel.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



