Return-Path: <linux-acpi+bounces-13728-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D402AB8142
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 10:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106D94C0A71
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 08:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1564A289E2B;
	Thu, 15 May 2025 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEIillir"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1928C2DE;
	Thu, 15 May 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298854; cv=none; b=aD2CUo6PRCcJVe/mHIIZlU4+MSvMFbjGKDWYTlQaE9a4KJ448xT40zMzv8HFP9kEepwz9caqFpALT/hSx2RycTe0fgGTVhUine3rcxdHTwI/CNecCOuVQ3u3DpfrrsngJ8IQhuSrdOPxY/6mNQ0g6Eg1ldmxSzJ4KqFz6YiH57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298854; c=relaxed/simple;
	bh=JQf0KUYpClVXmPjP/iEdYMIu0hxOkVfy6nTVgFHTH2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0IkgNQ5d/wZztxPhY472acOF4QigjMtNd2KbY4UMGJpT4xBoUcTK7URLKbbRwrhO8YYlXFrHcSEc9AheVuuB80if1b8O6dde2Mkm2GNyuUkCURQndGZk5h8/r2O9sFr/6p+6/KAQ5mxbI612QtxHOBhY2N+J8kbZRPtz0mLbDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEIillir; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747298852; x=1778834852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JQf0KUYpClVXmPjP/iEdYMIu0hxOkVfy6nTVgFHTH2I=;
  b=EEIillirghYcZrDSbXEty2vWNBCARAtO+Mo91TXK5CPT5TtqEEJtN306
   nNaRHlRx5Uhe8663CnsJAWzeCHwDiKoTrc9odx3fmJj+NdOwPZqGzDErq
   6j18kfhqr5KyEGY2/PpzLDLCK0U0OSd/R8ldBrZzqd4JT6iesC8i5dlRd
   Z7bfNhdM4Jwc0bPSju/CZPefZbkpINvuFYa9mL3s6wthVsqIwywsZ31Uo
   RUfRw7eAc+UXLPUURBJ9tc6fiY+0UgW3Pd1feKOwWmLyLnC+pnmIRuIN2
   OJgYsjQcBHIM3aEilleBufJZhrAJcDeRDR1cTkAOKvLUU2vMlYefzxiUJ
   g==;
X-CSE-ConnectionGUID: 6oLsw2M2SzCiQ5eG+jxm5Q==
X-CSE-MsgGUID: jMqX6Zu2QT2qTX4gASBwyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49091930"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="49091930"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:47:31 -0700
X-CSE-ConnectionGUID: mPH9vmttQH6yA7EjgzTlbA==
X-CSE-MsgGUID: D06Ny8/XRlekEOeluAOCJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="169232332"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 15 May 2025 01:47:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0CDBB23F; Thu, 15 May 2025 11:47:27 +0300 (EEST)
Date: Thu, 15 May 2025 11:47:27 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 0/4] gpiolib: acpi: Split quirks to its own file
Message-ID: <20250515084727.GU88033@black.fi.intel.com>
References: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
 <20250514155955.GS88033@black.fi.intel.com>
 <aCWgBp4ZD5aesvRw@smile.fi.intel.com>
 <20250515083451.GT88033@black.fi.intel.com>
 <aCWo19FjcvZzP1H7@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCWo19FjcvZzP1H7@smile.fi.intel.com>

On Thu, May 15, 2025 at 11:41:59AM +0300, Andy Shevchenko wrote:
> On Thu, May 15, 2025 at 11:34:51AM +0300, Mika Westerberg wrote:
> > On Thu, May 15, 2025 at 11:04:22AM +0300, Andy Shevchenko wrote:
> > > On Wed, May 14, 2025 at 06:59:55PM +0300, Mika Westerberg wrote:
> > > > On Tue, May 13, 2025 at 01:00:30PM +0300, Andy Shevchenko wrote:
> > > > > The GPIO ACPI helpers use a few quirks which consumes approximately 20%
> > > > > of the file. Besides that the necessary bits are sparse and being directly
> > > > > referred. Split them to a separate file. There is no functional change.
> > > > > 
> > > > > For the new file I used the Hans' authorship of Hans as he the author of
> > > > > all those bits (expect very tiny changes made by this series).
> > > > > 
> > > > > Hans, please check if it's okay and confirm, or suggest better alternative.
> > > > > 
> > > > > Andy Shevchenko (4):
> > > > >   gpiolib: acpi: Switch to use enum in acpi_gpio_in_ignore_list()
> > > > >   gpiolib: acpi: Handle deferred list via new API
> > > > >   gpiolib: acpi: Add acpi_gpio_need_run_edge_events_on_boot() getter
> > > > >   gpiolib: acpi: Move quirks to a separate file
> > > > > 
> > > > >  drivers/gpio/Makefile                         |   1 +
> > > > >  .../{gpiolib-acpi.c => gpiolib-acpi-core.c}   | 344 +----------------
> > > > >  drivers/gpio/gpiolib-acpi-quirks.c            | 363 ++++++++++++++++++
> > > > >  drivers/gpio/gpiolib-acpi.h                   |  15 +
> > > > 
> > > > All this -foo-core things look redundant to me. Why not just split it out
> > > > and call it gpiolib-quirks.c and put there all the quirks not just ACPI? I
> > > > Don't think we want to have gpiolib-of-quirks.c and gpiolog-swnode-quirks.c
> > > > and so on.
> > > 
> > > That's might be the next step to have for all of them, but these are ACPI
> > > specific. In any case they can't be put to gpiolib-quirks.c due to module
> > > parameters. If we do that we will need a dirty hack to support old module
> > > parameters (see 8250 how it's done there, and even author of that didn't like
> > > the approach).
> > 
> > Hmm, how does it affect module paremeters? I thought they are
> > gpiolib.something as all these object files are linked to it?
> 
> gpiolib_acpi.FOO because the object file is gpiolib-acpi.o.

Ah okay.

> > At least can we drop the gpiolib-acpi-core.c rename?
> 
> Unfortunately no due to the above.

This does not work?

gpiolib-acpi-y                 := gpiolib-acpi.o gpiolib-acpi-quirks.o

