Return-Path: <linux-acpi+bounces-8717-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5AB99A546
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 15:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216731F233A4
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 13:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9E218D79;
	Fri, 11 Oct 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnD1lEUY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F1804;
	Fri, 11 Oct 2024 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654090; cv=none; b=PDnC+kg4Kv6zSc0g/TIDdGZMQWkwkK6HrS60VQo0vz8QROp5ZMlQzqbUsV8J5/J4igBgVeJWnLaF2OzXMmCXETA4VdaKqIXZeLP4N8Q0satanL5ztgdTYw8mxbL2HeagqodFiCnjveTvyKYCGhJOXtqgIlb9TTpYA/irlQQMYs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654090; c=relaxed/simple;
	bh=w7w9rsajH//bYko69/flstLIvY32Xup0RimFtfWy7fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEVqTY0rwpBvy/kIQjgGrftHLXO0sj9NDmTs2Yksjf2BjLIihWpQpSdDWztGoP45cwYD7hBT5py4EAcQ9/EP8FULQ8S8jwR3004T1EVyuHRYJylYc6/a1Lnl9+oOqSByEpb6khtFw5RsaItlpytZCrRHDhVMpc+PwTyvIBHUbI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnD1lEUY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728654089; x=1760190089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w7w9rsajH//bYko69/flstLIvY32Xup0RimFtfWy7fA=;
  b=LnD1lEUYB7c1MFNgE2sALoCL1162yHmfRba9OscQYPS1cbmSImTglIqp
   A7DmchhCFW2/t98M1kVjMSMo6+kAnGG9Tfm4KpTYkVWKI5BhjAuLF+K8y
   ZKq9cwncXIIVQ80wzRxDgwBZAQaMqpSuQv1UUO/DGlyRV80jwyoZcLCA9
   BshPPeEpMB6M+VMN7WlxZMQPBsVGNL2WGjn53Xv2qPpKCV/93hIngYNhs
   dGk6RLKPIkGW1FqUSnR+TGT0Ho9m0w7udZEYg2W9yWke8LysyvUtXM7WL
   5YXv+owL/BwWZKdSCYnnEwfuE/h28c9aqvRXb/C9jiq3G+o05ywkKdFDm
   g==;
X-CSE-ConnectionGUID: ZF16gCDAQp2cuEjctGD+Mw==
X-CSE-MsgGUID: E8TvOzfES8KooYh2It7NAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="50599710"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="50599710"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 06:41:28 -0700
X-CSE-ConnectionGUID: 5FGioOX1STOa+j1Ac7jCxg==
X-CSE-MsgGUID: n2V+7ihTQuS3AfB73Jq9AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="80927854"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 06:41:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szFtT-00000001uAB-0cDa;
	Fri, 11 Oct 2024 16:41:23 +0300
Date: Fri, 11 Oct 2024 16:41:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] acpi: allow building without CONFIG_HAS_IOPORT
Message-ID: <ZwkrAhBIu4SV6B-O@smile.fi.intel.com>
References: <20241011061948.3211423-1-arnd@kernel.org>
 <20241011061948.3211423-2-arnd@kernel.org>
 <Zwj1p3uMEA24a0sU@smile.fi.intel.com>
 <de65a5c8-1bbd-47b3-9dc5-de4ad93c41b8@app.fastmail.com>
 <ZwkIFREb1Ia90hSR@smile.fi.intel.com>
 <e135bc0a-7c06-4ee2-b149-100595a29d7e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e135bc0a-7c06-4ee2-b149-100595a29d7e@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 11:40:05AM +0000, Arnd Bergmann wrote:
> On Fri, Oct 11, 2024, at 11:12, Andy Shevchenko wrote:
> > On Fri, Oct 11, 2024 at 09:59:46AM +0000, Arnd Bergmann wrote:
> >> On Fri, Oct 11, 2024, at 09:53, Andy Shevchenko wrote:
> >> > On Fri, Oct 11, 2024 at 06:18:18AM +0000, Arnd Bergmann wrote:
> >> >> +	if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
> >> >> +		*value = BIT_MASK(width);
> >> >> +		return AE_NOT_IMPLEMENTED;
> >> >
> >> > Perhaps it has already been discussed, but why do we need to file value with
> >> > semi-garbage when we know it's invalid anyway?
> >> 
> >> It's not strictly necessary, just precaution for possible callers
> >> that use the resulting data without checking the error code.
> >
> > Do you have any examples of that in the kernel?
> 
> drivers/acpi/processor_throttling.c:            acpi_os_read_port((acpi_io_address) throttling->status_register.
> --
> drivers/cpufreq/acpi-cpufreq.c-
> drivers/cpufreq/acpi-cpufreq.c: acpi_os_read_port(reg->address, &val, reg->bit_width);
> 
> $ git grep ^[^=]*acpi_os_read_port 
> drivers/acpi/processor_throttling.c:            acpi_os_read_port(\ (acpi_io_address) throttling->status_register.
> drivers/cpufreq/acpi-cpufreq.c: acpi_os_read_port(reg->address, &val, reg->bit_width);

May be we can add checks to them, but dunno...

> >> The all-ones data is what an x86 PC would see when an I/O
> >> port is read that is not connected to any device.
> >
> > Yes, but it's not what your code does.
> 
> My bad, I was confused about what BIT_MASK() does.
> I'll change it to "GENMASK(width, 0)", which should
> do what I intended.

Okay. Maybe also adding a comment that it's usual behaviour in response to
the read from non-existing IO port?

(Or for the curios it's all comes from the Data Bus on hardware being Open
 Drain an hence use of pull-up resistors and when there is no response on
 the bus, the default will be "All 1:s").

-- 
With Best Regards,
Andy Shevchenko



