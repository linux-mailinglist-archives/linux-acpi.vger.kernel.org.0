Return-Path: <linux-acpi+bounces-13727-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB44AB812F
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 10:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB1E3B2ED5
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 08:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6675288512;
	Thu, 15 May 2025 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6h9nulR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4A2882D7;
	Thu, 15 May 2025 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298526; cv=none; b=WXlBiEoXoy83BQ1yW1mRj57etZGhV0n4JqVndunTByp3cJrdiDB70usj8iZA4GlbazgOhut37Hdg+hTvAHy4M0RZf2GZv82W7zMiS8n1OkCGiaSovkn8p1HVEOP0lRPZjFxvU+WaTq95XTF+4nNk3uD7qL1cg6HTe4eFjySumL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298526; c=relaxed/simple;
	bh=WA53SyaXxqx8jUy/6y2Ek2SkqpLEoHxJAyAEecrQAs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQDIXTCRW6BEvzA2w6dVwSRqlO96OYDO6tnyVv04BhLGQA3NbPfXHMNFaJsXourCrC8m69H0qdZqfSMa9OT0cbFFUa+Kp5RCmgvFEnogcB8gVUPpNc05jYWcvES8oF5IKpr5UGjWK1DKH99ZuN+oG7JR7BbaclQsxCPSss+qYlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6h9nulR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747298526; x=1778834526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WA53SyaXxqx8jUy/6y2Ek2SkqpLEoHxJAyAEecrQAs0=;
  b=n6h9nulR99YMyJfGjq5h2b3gI6w77GxAE0sR8Xk7W4vd9z64CDKdGcal
   Uyt5T1kpHoNrW2OvzSc+QqxliXZFGXYTspRHveUNdir7TQ7cdlBWIzpMi
   pNWGCPnZHYlhlEPQkrktlmxjy0MV2S7XWrNWrFOMIct2nKYD6P0VVQI6M
   Eda3dKBKsczxSLsbZjZgcqvTbShZnbh9ufPG1rF1yYthCa/h6Ujp3qTwk
   Uz/wbrExOTT883wfeUuttGtyw307LxBP57jQ3gw6eSSITQD97Sza+wRaa
   Wf+P00tBcuHPPL0EMpTer1cvSYT4AH+XA4QD7vo9LQeS7Ls2lJgCPvJ34
   g==;
X-CSE-ConnectionGUID: Ih2LJLC8Rw6tPlBHDvC15w==
X-CSE-MsgGUID: JPROBiL8R7i45Q5aRcCBNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66628706"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="66628706"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:42:05 -0700
X-CSE-ConnectionGUID: b7FbhWKZR8CxG/PJvul1qA==
X-CSE-MsgGUID: K7nZxeroTnuo5poOlASYBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138351846"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:42:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uFUAB-00000001nGL-3JsO;
	Thu, 15 May 2025 11:41:59 +0300
Date: Thu, 15 May 2025 11:41:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 0/4] gpiolib: acpi: Split quirks to its own file
Message-ID: <aCWo19FjcvZzP1H7@smile.fi.intel.com>
References: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
 <20250514155955.GS88033@black.fi.intel.com>
 <aCWgBp4ZD5aesvRw@smile.fi.intel.com>
 <20250515083451.GT88033@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515083451.GT88033@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 15, 2025 at 11:34:51AM +0300, Mika Westerberg wrote:
> On Thu, May 15, 2025 at 11:04:22AM +0300, Andy Shevchenko wrote:
> > On Wed, May 14, 2025 at 06:59:55PM +0300, Mika Westerberg wrote:
> > > On Tue, May 13, 2025 at 01:00:30PM +0300, Andy Shevchenko wrote:
> > > > The GPIO ACPI helpers use a few quirks which consumes approximately 20%
> > > > of the file. Besides that the necessary bits are sparse and being directly
> > > > referred. Split them to a separate file. There is no functional change.
> > > > 
> > > > For the new file I used the Hans' authorship of Hans as he the author of
> > > > all those bits (expect very tiny changes made by this series).
> > > > 
> > > > Hans, please check if it's okay and confirm, or suggest better alternative.
> > > > 
> > > > Andy Shevchenko (4):
> > > >   gpiolib: acpi: Switch to use enum in acpi_gpio_in_ignore_list()
> > > >   gpiolib: acpi: Handle deferred list via new API
> > > >   gpiolib: acpi: Add acpi_gpio_need_run_edge_events_on_boot() getter
> > > >   gpiolib: acpi: Move quirks to a separate file
> > > > 
> > > >  drivers/gpio/Makefile                         |   1 +
> > > >  .../{gpiolib-acpi.c => gpiolib-acpi-core.c}   | 344 +----------------
> > > >  drivers/gpio/gpiolib-acpi-quirks.c            | 363 ++++++++++++++++++
> > > >  drivers/gpio/gpiolib-acpi.h                   |  15 +
> > > 
> > > All this -foo-core things look redundant to me. Why not just split it out
> > > and call it gpiolib-quirks.c and put there all the quirks not just ACPI? I
> > > Don't think we want to have gpiolib-of-quirks.c and gpiolog-swnode-quirks.c
> > > and so on.
> > 
> > That's might be the next step to have for all of them, but these are ACPI
> > specific. In any case they can't be put to gpiolib-quirks.c due to module
> > parameters. If we do that we will need a dirty hack to support old module
> > parameters (see 8250 how it's done there, and even author of that didn't like
> > the approach).
> 
> Hmm, how does it affect module paremeters? I thought they are
> gpiolib.something as all these object files are linked to it?

gpiolib_acpi.FOO because the object file is gpiolib-acpi.o.

> At least can we drop the gpiolib-acpi-core.c rename?

Unfortunately no due to the above.

-- 
With Best Regards,
Andy Shevchenko



