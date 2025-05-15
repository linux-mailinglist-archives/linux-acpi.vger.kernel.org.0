Return-Path: <linux-acpi+bounces-13724-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A3BAB7FB1
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 10:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485528C6D77
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1742D2853E3;
	Thu, 15 May 2025 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ga1Q2mYI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4880B2820CD;
	Thu, 15 May 2025 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296270; cv=none; b=TTaZAKvFFSPoVPNgYAmSp5y+gqnEI1Bw4DPJ+1CsdKyOhZsOypuHUuU9reo8EA01NIzrSXBq7Ny5zpnAL3ZrMwSMEgPPr/NXixE9+ymEFeAl7zyv5fy/sXozOY4yPoM47lDAqFF2FFzUqQbJZy/uq0L0Iaaizfe5SlbXdSQv518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296270; c=relaxed/simple;
	bh=1M9gFt8zcx9pxQgfErGrv96mAUW3gZ4D8dDvbtfNJCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bizvqgcy/ZjTugV3DYlqQmofgROpUSaGL53iNxD9psW2U8iFVg+rcKIuOYUDeSSG5ANt9E3+Na1+DUpQHYC+Mx/uIGZYXaUUSZXNPqLgNKl3ZVi5V7MppYLEvVi2Hy7PDi7nH0aYo/O4dhlippzCtcmxAKKJKJdeMi4uk1Hhwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ga1Q2mYI; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747296269; x=1778832269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1M9gFt8zcx9pxQgfErGrv96mAUW3gZ4D8dDvbtfNJCk=;
  b=ga1Q2mYIgvtV4Dw4YYM65s/Eh7uSlnrSLHPR2pNp8qZcZDG+2pbwWyDi
   SDzQYE9+FSA9rQUokTWEZa/DqkmUesLYo19NR83Ljje4P4pET1zHJx6eQ
   bjoHS/CV5Z4DaxfgTM3BaHFnfpuGezfjvjDjSeyW08Mwfwgpk5EtgCG5b
   lEXsu5bavPxn8cJmVlZxKH5J5N9DbVspnwahr/iRH8c0Bx/JM7tFQ4vem
   KqnRHYqCYroOS7drirYIkKiUD/69BnAtmb2untskHq3A0lTuHWCvtIX5a
   accbOTaAQ11oO9HiQ8QfPzoCul8joP7ijCI/1/StxYlivzm2CX4O3WOh+
   w==;
X-CSE-ConnectionGUID: KRdKZPKnQPWDRwqLDXBOuA==
X-CSE-MsgGUID: i/ETMfAZQLucowgCcqWNpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49380465"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="49380465"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:04:28 -0700
X-CSE-ConnectionGUID: 8rn1t7pnS1+Vp/MKnVHVkg==
X-CSE-MsgGUID: bIueTCnlQoWnbt5TSlsEaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138340907"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:04:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uFTZm-00000001mmx-3BXQ;
	Thu, 15 May 2025 11:04:22 +0300
Date: Thu, 15 May 2025 11:04:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 0/4] gpiolib: acpi: Split quirks to its own file
Message-ID: <aCWgBp4ZD5aesvRw@smile.fi.intel.com>
References: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
 <20250514155955.GS88033@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514155955.GS88033@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 14, 2025 at 06:59:55PM +0300, Mika Westerberg wrote:
> On Tue, May 13, 2025 at 01:00:30PM +0300, Andy Shevchenko wrote:
> > The GPIO ACPI helpers use a few quirks which consumes approximately 20%
> > of the file. Besides that the necessary bits are sparse and being directly
> > referred. Split them to a separate file. There is no functional change.
> > 
> > For the new file I used the Hans' authorship of Hans as he the author of
> > all those bits (expect very tiny changes made by this series).
> > 
> > Hans, please check if it's okay and confirm, or suggest better alternative.
> > 
> > Andy Shevchenko (4):
> >   gpiolib: acpi: Switch to use enum in acpi_gpio_in_ignore_list()
> >   gpiolib: acpi: Handle deferred list via new API
> >   gpiolib: acpi: Add acpi_gpio_need_run_edge_events_on_boot() getter
> >   gpiolib: acpi: Move quirks to a separate file
> > 
> >  drivers/gpio/Makefile                         |   1 +
> >  .../{gpiolib-acpi.c => gpiolib-acpi-core.c}   | 344 +----------------
> >  drivers/gpio/gpiolib-acpi-quirks.c            | 363 ++++++++++++++++++
> >  drivers/gpio/gpiolib-acpi.h                   |  15 +
> 
> All this -foo-core things look redundant to me. Why not just split it out
> and call it gpiolib-quirks.c and put there all the quirks not just ACPI? I
> Don't think we want to have gpiolib-of-quirks.c and gpiolog-swnode-quirks.c
> and so on.

That's might be the next step to have for all of them, but these are ACPI
specific. In any case they can't be put to gpiolib-quirks.c due to module
parameters. If we do that we will need a dirty hack to support old module
parameters (see 8250 how it's done there, and even author of that didn't like
the approach).

-- 
With Best Regards,
Andy Shevchenko



