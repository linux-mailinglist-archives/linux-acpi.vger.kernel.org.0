Return-Path: <linux-acpi+bounces-14696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47239AEA0F3
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 16:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266281887D48
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A0A2EAB8A;
	Thu, 26 Jun 2025 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWw6tdhY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C782EAB7F;
	Thu, 26 Jun 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948531; cv=none; b=rBUSf0FIqWazedSg87dw4dCOOy5ZsQeR+tqnyVJawmD3I9edAudLmILYHUxnks2V6jCOvjezZicCGY9h35+5oKEHrVmiKb/sFXEzCY1gbOd0udVL0GuSrTJ5Knx48VbX7an3PC8l641uxuulXDCxdsOynSYcIObtj6RVRvaBB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948531; c=relaxed/simple;
	bh=u6Cb7btngty8OfoJXcvr5JbIB2Gkz2Muobtwau7/iPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8SCSgl3EGOreVI5gekZbhS0CGRM8iHqR9BBJx3PoiTdgPuxOppRmtViSotwfO8koYQ3HXCD2BcSjUu5KzdCIExa6XX11cJ1g6xroGXu0cb9wkMT1XqggnMobZhBMYt18eOLU5r3Ajv8JkRCUv6RE+FRjnhZP0azf+6ccNt3uDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWw6tdhY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750948530; x=1782484530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u6Cb7btngty8OfoJXcvr5JbIB2Gkz2Muobtwau7/iPA=;
  b=FWw6tdhYrNKGNUsmaan9435+8xPpcmQmAeFHc2kiUgMUKoHys6CqDaIG
   4jEhmp5AEthusM+oTmwIaXUxChulg8r+MtLRxMzjqAr8mbBTo4SDQiJAa
   2mHTUVfHS0vIXoGbR8kVG0o49caiPzQjlU6Cq+DoOk3Tgln0BIfxuljbj
   I3mHswkxM1QT6elHyOjWpMAaoYScTqX92GdbIa6CEp+LfO+qRoF5mzZGm
   2QCXniAfsl1Mjnx+TrNZ2K++e7KlBTcUu8K9qcRmX6mO6eOrTjKDFiDlx
   VYIikUzBDc4mLX+i1Eo/ISfg7d8hbTElrhj33+c6L6diYPPvE8m+rqXQG
   w==;
X-CSE-ConnectionGUID: QmKYcQffRXy52f8mNnC5GA==
X-CSE-MsgGUID: JG1aHA0ARf+ZgDxVPiJCEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70677000"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="70677000"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:35:16 -0700
X-CSE-ConnectionGUID: lR/QX+sGR6Ovj9wQXhkGkA==
X-CSE-MsgGUID: EcVsQynBTta7FfyFaRSPIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="152830571"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:35:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uUnh0-0000000ACXp-32dy;
	Thu, 26 Jun 2025 17:35:10 +0300
Date: Thu, 26 Jun 2025 17:35:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 0/4] Fix soc-button-array debounce
Message-ID: <aF1anq07UAkHCfPO@smile.fi.intel.com>
References: <20250625215813.3477840-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625215813.3477840-1-superm1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 04:58:09PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> I have some hardware in front of me that uses the soc-button-array
> driver but the power button doesn't work.
> 
> Digging into it, it's because the ASL prescribes a debounce of 0 for
> the power button, but the soc-button-array driver hardcodes 50ms.
> 
> Hardcoding it to what the ASL expects the power button works.
> 
> I looked at the callpath into the GPIO core and I believe it's
> because the debounce value from _CRS is never programmed to the
> hardware the way that the GPIO gets setup.
> 
> This series add that programming path and then sets the hardcoded
> value on on some quirked systems.  Hopefully Hans can confirm this
> continues to work on the hardware that he originally developed the
> hardcoding for.

There is no a note about routing the patch in upstream. My proposal to take
GPIO ACPI library patch and provide and immutable tag for others.

-- 
With Best Regards,
Andy Shevchenko



