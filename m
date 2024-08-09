Return-Path: <linux-acpi+bounces-7473-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4904494D414
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 17:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B42E1C20E7B
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7A0198E70;
	Fri,  9 Aug 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+LM+5o+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB544198E6E;
	Fri,  9 Aug 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219182; cv=none; b=hXBCpVtPi4Bdlg3uxasOnuajuKu+XwPsX5+NIRa3zown+8LX+r/WwLlIv8u4V44GXZ0IpqDdqW7C6BN88OwKMePNumtjNhvcxZq6prhxwDch2FjFnADXevqC5AvBjBbll3wWl0xO6YncbBfEPP8yGtDw+TLUb4wj6TCPq0MWvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219182; c=relaxed/simple;
	bh=vpnP2tgla/xZEJUsNA+ATZINZPaYxLHd6/0iTSkf7Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMgfr9jBjnL/wKqSFU0xYaixVjKKU6cHXCplU4kUzGaXLvQVACFncalQ7fMn4A1apc5bRTBtfAayoB6P70HVRQs0eSpl0yrU5j8UNU2BAAG8V/3rlUzcvi4ja8cvA5BfjDrozwPqtZt1Er9lsT81kPjLCEu4nvDil9JzY2PrCgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+LM+5o+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723219181; x=1754755181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vpnP2tgla/xZEJUsNA+ATZINZPaYxLHd6/0iTSkf7Jo=;
  b=j+LM+5o+PDqPtukKLLfxtOrahAvGkcYvfShlPtY5J7yU5l8Tzyu6yyd9
   HChEMlz/WpkNETcQtLISN9u1FOOuXOzEbqOFPo/bZQ5rS1CGGK8t9ast7
   PqRK7speLnT6C+b7dOq7ZBhVZkiq1Sv/NiU8u0sdn5/WkzxQH1Vm1ZVd/
   pySK7kFRyHeqcTl12zRCaIsx0BMZN3s6WecQ3v2p9gyNHOFG1K9YY08xh
   5sjN9VZ93V5a9aeun131dHQyYo8zo7dDYa0aDs60aS1eyCWjvHdkgacoC
   fiGVYj60tvzAejfGCpW0c7X3xUEz06KcVTO8XfeE3rPUAWaGHI8YXdLRo
   g==;
X-CSE-ConnectionGUID: rMtZ3SzcQ9G/9Wg2l8VP+Q==
X-CSE-MsgGUID: F9QXu+FyQ2ySjLKaFdO9sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="32022940"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="32022940"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:59:40 -0700
X-CSE-ConnectionGUID: F9+AT1F9SF6ve329GAjNLA==
X-CSE-MsgGUID: peMcEwRvQXSuA/uTzXEARA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="62447282"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 08:59:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scS1f-0000000DTDc-2RUQ;
	Fri, 09 Aug 2024 18:59:35 +0300
Date: Fri, 9 Aug 2024 18:59:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sanket Goswami <Sanket.Goswami@amd.com>
Subject: Re: [PATCH v1] ACPI: APD: Add AMDI0015 as platform device
Message-ID: <ZrY854CyoKwQfQXi@smile.fi.intel.com>
References: <20240718152324.3449253-1-Shyam-sundar.S-k@amd.com>
 <7c550151-39a8-4155-ae9e-4796d9463cd4@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c550151-39a8-4155-ae9e-4796d9463cd4@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 09, 2024 at 09:08:22PM +0530, Shyam Sundar S K wrote:
> +Andy
> 
> On 7/18/2024 20:53, Shyam Sundar S K wrote:
> > Add AMDI0015 to the ACPI APD support list to ensure correct clock settings
> > for the I3C device on the latest AMD platforms.

...

> >  	{ "AMD0040", APD_ADDR(fch_misc_desc)},
> >  	{ "AMDI0010", APD_ADDR(wt_i2c_desc) },
> >  	{ "AMDI0019", APD_ADDR(wt_i2c_desc) },
> > +	{ "AMDI0015", APD_ADDR(wt_i3c_desc) },

Please, keep it sorted.

...

> FYI..

Thanks!

> AMDI0015 is for MIPI I3C (we call it I3C legacy) version of the
> implementation.
> 
> and.. MIPI0100 is for HCI based implementation of the MIPI I3C
> Specification.

This is fine as long as there is no collision, i.e. if a new (HCI I3C _HID is
required the new one should be allocated).

-- 
With Best Regards,
Andy Shevchenko



