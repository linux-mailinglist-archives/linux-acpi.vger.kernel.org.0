Return-Path: <linux-acpi+bounces-13732-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 358B8AB837A
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 12:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07041B666DD
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E79F20CCE4;
	Thu, 15 May 2025 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlVE8kYI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD6A222586;
	Thu, 15 May 2025 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747303362; cv=none; b=RWaQjSX2cqNlmmF5jvf89r1bmWFbyH8PaL40kIdq2he9fvk6+U+a4onXZbPplSSV0Nt+8KwAk1fumbA4K28ZMfktB/4ukCc3fe44de7Z5xm7DOc+hORqq4cApzLe1MmLkJlHweCauDrg5exBNZ5wL0WPeObZFBqDEln95CZ50uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747303362; c=relaxed/simple;
	bh=7V+0sXGhrjXDWjjEqhgFc7TixWZcO1mFzorR7Ny6tVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmJxXfDHxG2UVr2h4Equ8tHwKgLJAkoxX3pCKXGuPVPVK3REQmYw1YANoI6dTcNT3pkLVyaGsIa6TiU9A0dpcJ4Hq6CyT0B7R8BoEyTXNDWkjHqWz7ZfmNvsA5Ej9+dTKDeKuHIiPxR73JMYvVoJ97kyR7LLxZnT4dyeNehG8ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlVE8kYI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747303360; x=1778839360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7V+0sXGhrjXDWjjEqhgFc7TixWZcO1mFzorR7Ny6tVE=;
  b=GlVE8kYI+kfX1kQIQGrPGu+YguDNq6gNs623FczsGWD3xaNgLSEVWXrh
   MsmDxaKPkoH6lwB5hWkEliPTQHMbAuUB5JAsTAwuFnsZWRHBcsq3x1NSw
   bIiysTq/85m0U22u8k+cge/fHxH7cgmbm/dS0QHqoP0gxxPqRCwvZcNtx
   7cBNJ4B4i0JrPnTRzZnXOU6mRAEaU9qQq/Kq1pquzPbidPtpq/Uzogk+U
   VC8z7yCaF8XSAno9FI/XVcThrYJO7ICvhjXa/FHWKRzv2MjUlvUNAXuO2
   qnSj181lXUv8PFMm8NuUz0Rat3d45QfyoENscrYSubLd/TbeDRmLE5Glx
   g==;
X-CSE-ConnectionGUID: 4P9xtCK3S3y3jErxczeANg==
X-CSE-MsgGUID: NJppuzI7Rg+A5uABdQBKOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="51868459"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="51868459"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 03:02:39 -0700
X-CSE-ConnectionGUID: 7q/X3VPPQzCJMbjpDDGX7Q==
X-CSE-MsgGUID: BFAj0XCCTa+EZV33FnPIQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138205390"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 03:02:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uFVQA-00000001oKi-1zxc;
	Thu, 15 May 2025 13:02:34 +0300
Date: Thu, 15 May 2025 13:02:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 0/4] gpiolib: acpi: Split quirks to its own file
Message-ID: <aCW7unjYEgPWYV_i@smile.fi.intel.com>
References: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
 <20250514155955.GS88033@black.fi.intel.com>
 <aCWgBp4ZD5aesvRw@smile.fi.intel.com>
 <20250515083451.GT88033@black.fi.intel.com>
 <aCWo19FjcvZzP1H7@smile.fi.intel.com>
 <20250515084727.GU88033@black.fi.intel.com>
 <aCWsuRc5ggJJFc5u@smile.fi.intel.com>
 <20250515093124.GV88033@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515093124.GV88033@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 15, 2025 at 12:31:24PM +0300, Mika Westerberg wrote:
> On Thu, May 15, 2025 at 11:58:33AM +0300, Andy Shevchenko wrote:
> > On Thu, May 15, 2025 at 11:47:27AM +0300, Mika Westerberg wrote:
> > > On Thu, May 15, 2025 at 11:41:59AM +0300, Andy Shevchenko wrote:
> > > > On Thu, May 15, 2025 at 11:34:51AM +0300, Mika Westerberg wrote:
> > > > > On Thu, May 15, 2025 at 11:04:22AM +0300, Andy Shevchenko wrote:
> > > > > > On Wed, May 14, 2025 at 06:59:55PM +0300, Mika Westerberg wrote:
> > 
> > ...
> > 
> > > > > > That's might be the next step to have for all of them, but these are ACPI
> > > > > > specific. In any case they can't be put to gpiolib-quirks.c due to module
> > > > > > parameters. If we do that we will need a dirty hack to support old module
> > > > > > parameters (see 8250 how it's done there, and even author of that didn't like
> > > > > > the approach).
> > > > > 
> > > > > Hmm, how does it affect module paremeters? I thought they are
> > > > > gpiolib.something as all these object files are linked to it?
> > > > 
> > > > gpiolib_acpi.FOO because the object file is gpiolib-acpi.o.
> > > 
> > > Ah okay.
> > > 
> > > > > At least can we drop the gpiolib-acpi-core.c rename?
> > > > 
> > > > Unfortunately no due to the above.
> > > 
> > > This does not work?
> > > 
> > > gpiolib-acpi-y                 := gpiolib-acpi.o gpiolib-acpi-quirks.o
> > 
> > No. You can't use the same name on left and right parts.
> 
> I see :( Okay then I guess there are no other options than name it like
> this.
> 
> [ Ideally we would drop the while gpiolib- prefix from all these so you have
> acpi.c, sysfs.c and so on without the redundancy but that's outside of
> scope of this work anyways ;-) ]

I also would like to have prefix to be dropped for the files, but the modules
(and it's can be achieved, but it's indeed out of scope here).

> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you!
I am going to push to my review and testing queue soon.

-- 
With Best Regards,
Andy Shevchenko



