Return-Path: <linux-acpi+bounces-11759-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F5EA4DC60
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 12:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB153B6827
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 11:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9E120127A;
	Tue,  4 Mar 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ESTqqWze"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BA1FF7CA;
	Tue,  4 Mar 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087021; cv=none; b=k9RmJ/39ySuBwg+gHpmT3QlwMOirVqcSDnZEl/xMV3MIQI3aghKNDfcOIn5yw0z4HdgW20Q46iqFZP20fQYN8/VmhV0UgGj6RauBvqhG4v0xa8Kgc4+lIJacPO1g2+JLgLI204JVnImenTy689IR6R9otU9biOAr9MRbgQno8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087021; c=relaxed/simple;
	bh=4/ismWdfnkMWExfouaTmKfv4VPmt/pQOLhoR6IrLNCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdNZpe3YK13vAkhpXi5Idy53u4cmhqETit+LFBUt+GUJtW+uCpYipssAyu3J1JCLFiRdXEu+tfWFTQX/M9KyxFs/AbxAjXJ3kJmsGdQ0/WSDvdkN8RDhSnEkqDCJtmx9okO5jAAAd4CDp3IVAzSDxKAd9o15uP4NDK+IGFfUyMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ESTqqWze; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741087020; x=1772623020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4/ismWdfnkMWExfouaTmKfv4VPmt/pQOLhoR6IrLNCI=;
  b=ESTqqWzeuZv+QqtfWwPz8xcC2MmrAhkCty8Fi7fPhKtPe+95mFbo0LGV
   b5NdVJby2mRkG3SnSQoUKenq7taTq21sxOxz4BTYmUbXYNrwN2vtqJAo9
   WE7znoLVtHOHUMTF6Rq25rkTcxkb6ze6xwCdxaO717FNtxwsxT6EvA+/4
   gL2TAMj9n9jvOE5O4vBxvSWkK2xyWrlewTH35lTpaR22AgLdUJCefz9C3
   HoMlrXCG4y5rPO6RaiMumQ5jh8HUa60TStgqUO9+N+8JHD+559z/0sBZ1
   TzNNZbqs7kPylJmZa1PB4XcpW6HaWmGXTby5V/PHIzqFf9L9e+bVgCC5V
   A==;
X-CSE-ConnectionGUID: r8A0ooQGQBO9VnOCSX9ZKQ==
X-CSE-MsgGUID: YnGO5Oo+T5OEtCqp2hyGfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41177149"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41177149"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:16:59 -0800
X-CSE-ConnectionGUID: U0/IBW+3TKqbq5A0AP+ZJA==
X-CSE-MsgGUID: 9JysdFC6Q+eSZEr9AV/APA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149277539"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:16:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpQGc-0000000H6Px-3QxS;
	Tue, 04 Mar 2025 13:16:54 +0200
Date: Tue, 4 Mar 2025 13:16:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v1 2/3] gpiolib: Rename gpio_set_debounce_timeout() to
 gpiod_do_set_debounce()
Message-ID: <Z8bhJq3kn_uw3iYE@smile.fi.intel.com>
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
 <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
 <20250304091804.GG3713119@black.fi.intel.com>
 <Z8bdDQGg_xcamZv2@smile.fi.intel.com>
 <20250304111157.GJ3713119@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304111157.GJ3713119@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 04, 2025 at 01:11:57PM +0200, Mika Westerberg wrote:
> On Tue, Mar 04, 2025 at 12:59:25PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 04, 2025 at 11:18:04AM +0200, Mika Westerberg wrote:
> > > On Mon, Mar 03, 2025 at 06:00:33PM +0200, Andy Shevchenko wrote:
> > > > In order to reduce the 'gpio' namespace when operate over GPIO descriptor
> > > > rename gpio_set_debounce_timeout() to gpiod_do_set_debounce().
> > > 
> > > To me anything that has '_do_' in their name sounds like an internal static
> > > function that gets wrapped by the actual API function(s).
> > > 
> > > For instance it could be 
> > > 
> > >   int gpio_set_debounce_timeout()
> > >   {
> > >   	...
> > > 	gpiod_do_set_debounce()
> > > 	...
> > > 
> > > However, gpiod_set_debounce_timeout() or gpiod_set_debounce() sounds good
> > > to me.
> > 
> > Then please propose the second name for gpiod_set_config_XXX to follow
> > the same pattern. The series unifies naming and reduces the current
> > inconsistency.

> gpiod_set_config()?

The problem is that

gpiod_set_debounce() and gpiod_set_config() are _existing_ public APIs.
That's why I considered "_do_" fitting the purpose.

-- 
With Best Regards,
Andy Shevchenko



