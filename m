Return-Path: <linux-acpi+bounces-9125-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B35B09B6791
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 16:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EE41F21E3F
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 15:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1980621B442;
	Wed, 30 Oct 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuSNTO19"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C881EF0AB;
	Wed, 30 Oct 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301270; cv=none; b=H7KTAGHfEOAsdXshYvNlE1T3GeORMBAg9PdAPjkuUhepvaz/Cd14s5yKZV3bskiU+qLay8jBtRaMnpZhvTnhJNZGa31v4Ly9s0a72id6wxzsjtmTeNzcT3dKZNySm3OGqvjnReYuXtl+4dG7ki7GkFFx7EEMbcC/8mEfTAWb5Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301270; c=relaxed/simple;
	bh=SF+DFnGwBf0wPHw6Ve5gYSusu2nTXyqic282rhwzNYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUBceLWJM7Yd3PGM0KHkGywB3gb4LG/Ji9cjXk8xzYNSJxhi5rK52OmJXy12Ypt688VARUmW5+QFqV+b3HDkP8Hw2HL2jtbLbXJkcJpeUP7JUiIrCD+WtXPyypp1a4MIRE39XUiIvK/z+Dp4kEJTEdX3E9j43LrPNX+XcDZDNdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuSNTO19; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730301268; x=1761837268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SF+DFnGwBf0wPHw6Ve5gYSusu2nTXyqic282rhwzNYw=;
  b=UuSNTO19RCQ3edjD5HEeJB8qgBna9yFIf+x4Cndq+uluw5fGNNzE1+4t
   VNvnwngSGCKnTUWKiFD/43yFdITXySq1zHsi78BtlPwe8DVGizXf3rkmj
   dpZL4Kic2i/UOG3ukSYqHRQvErIR8qVvtv7zzWa7MnZV3c8HjF4iqEIxh
   tnc62i7PiR+QedTA/bCwzAIYJupN4K5yHQuyhBHWXPGCjaTITp+jT4Ffx
   fX5iWaF0WPFt5cMotnP3UKRgCq0+0LWJABVM3sUfVEwLcpCGEPgw7AO/0
   qw/m3sdPNDzu9wM9ppVWTp99a8DARGpqNGDUFkuSfBZj5M8+9GdT1eprv
   g==;
X-CSE-ConnectionGUID: 3HIWzH8JQjSh8sFgt5pdOA==
X-CSE-MsgGUID: prE1ZmcgRH6raIyxHZul0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52565841"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52565841"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 08:14:27 -0700
X-CSE-ConnectionGUID: HOPTn93fRv6ropdiyC7mjg==
X-CSE-MsgGUID: qIh28UwvSK2JD5uCOhIF4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="86278895"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 08:14:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6AOs-000000094ob-0nlZ;
	Wed, 30 Oct 2024 17:14:22 +0200
Date: Wed, 30 Oct 2024 17:14:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Len Brown <lenb@kernel.org>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] [v3] acpi: allow building without CONFIG_HAS_IOPORT
Message-ID: <ZyJNTQSv3bNbgPf_@smile.fi.intel.com>
References: <20241030123701.1538919-1-arnd@kernel.org>
 <20241030123701.1538919-2-arnd@kernel.org>
 <ZyJNC44r11a83FlI@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJNC44r11a83FlI@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 30, 2024 at 05:13:15PM +0200, Andy Shevchenko wrote:
> On Wed, Oct 30, 2024 at 12:36:41PM +0000, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > CONFIG_HAS_IOPORT will soon become optional and cause a build time
> > failure when it is disabled but a driver calls inb()/outb(). At the
> > moment, all architectures that can support ACPI have port I/O, but this
> > is not necessarily the case in the future on non-x86 architectures.
> > The result is a set of errors like:
> > 
> > drivers/acpi/osl.c: In function 'acpi_os_read_port':
> > include/asm-generic/io.h:542:14: error: call to '_inb' declared with attribute error: inb()) requires CONFIG_HAS_IOPORT
> > 
> > Nothing should actually call these functions in this configuration,
> > and if it does, the result would be undefined behavior today, possibly
> > a NULL pointer dereference.
> > 
> > Change the low-level functions to return a proper error code when
> > HAS_IOPORT is disabled.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> > +	if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
> > +		/*
> > +		 * set all-1 result as if reading from non-existing
> > +		 * I/O port
> > +		 */
> 
> Don't know if Rafael can / want to tweak this, but would be nice to follow
> standard style for multi-line comments.
> 
> 		/*
> 		 * Set all-1 result as if reading from non-existing
> 		 * I/O port.
> 		 */
> 
> > +		*value = GENMASK(width, 0);

Actually, shouldn't this be width - 1 ?

> > +		return AE_NOT_IMPLEMENTED;
> > +	}

-- 
With Best Regards,
Andy Shevchenko



