Return-Path: <linux-acpi+bounces-20003-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C40CFCFEE55
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 17:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C17030C1B5E
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123EB33A005;
	Wed,  7 Jan 2026 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgqKDNGz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12087337B86;
	Wed,  7 Jan 2026 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800885; cv=none; b=m2a2TbAT771HndAmi4SOIDdWaRaycxBMblUU/4QGdlUzcv6NNzJvRkyzRTs3e8NliGXrdzLezxhnTsilTxQEl9Kxjvn/D1cKBI5Q5NBG39NOZMNNM2/qGOS24ZFfhXPxmep8Xbn1gSxAfFZTxcKcW4a8Os/wgcnvqUAiqK2jPtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800885; c=relaxed/simple;
	bh=juYm917GdCBqANd0VbtPMKzjb1p8E9CtfP6gnnWnkPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtbGYbK4b8tkjmQxHG5gNKF5JU1Er48aSaBKCZtbwxHR1lof8gQ4gYQ6dB8D91NIKPCcVKcOT3U5Y4YGKoP0h3d3Oa4fIGRS2sSCz5urp0gN6MdMks4K22lF4M5s9r3LLU9sEN8HveSjgG91GIhxPdd7hfCt/2daxHXZBUZKWps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgqKDNGz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767800883; x=1799336883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=juYm917GdCBqANd0VbtPMKzjb1p8E9CtfP6gnnWnkPI=;
  b=BgqKDNGz21xOQsaSRHh6AXn69GlrwloLGJXj44xtelnWbQit0EUAgyJJ
   L4nHuykWM27NWEjNp9ho9cktjZ65Lj1K453g2P7Wqv7Uz/l2aXNBTo5IY
   brNDwhv9P5lR8MasTxFfo1393Mz6uieh/PDg/buCDzn+g+mbn6cemhC+L
   mcnmRKOpGALEZ0oCYeZJujgY3vPUffy26jkfz8WGtq//YJubyIfuaCWtd
   qNNYOHaedJdg1GFhEMlfuej0KgJ83ncdMFDF4p9bNzvDwhaFGC2AT7j8d
   VUxwcmaoHCv3+mhTjO34EEvWej0sn8upYC8TAdW16dOwlZacACC5MMTHZ
   Q==;
X-CSE-ConnectionGUID: 27G60p3HS6+9yvHFd3o7Zg==
X-CSE-MsgGUID: o/0YQRPaTJGhiexbdJW6qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86760981"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="86760981"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 07:48:02 -0800
X-CSE-ConnectionGUID: 5z/AbqnNSjaXIxwI0/Pkgg==
X-CSE-MsgGUID: MdSKQLO2T86ysYTOX1Txgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="203217231"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 07:47:59 -0800
Date: Wed, 7 Jan 2026 17:47:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: lenb@kernel.org, sakari.ailus@linux.intel.com,
	mika.westerberg@linux.intel.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: bus: Use OF match data for PRP0001 matched
 devices
Message-ID: <aV6ALdPCjaAYHM7-@smile.fi.intel.com>
References: <20260107120318.13130-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107120318.13130-1-kkartik@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 07, 2026 at 05:33:18PM +0530, Kartik Rajput wrote:
> When a device is matched via PRP0001, the driver's OF (DT) match table
> must be used to obtain the device match data. If a driver provides both
> an acpi_match_table and an of_match_table, the current
> acpi_device_get_match_data() path consults the driver's acpi_match_table
> and returns NULL (no ACPI ID matches).

Since we have both tables, why the actual ACPI HID of the device in question
(actually which one?) can't be used?

> Explicitly detect PRP0001 and fetch match data from the driver's
> of_match_table via acpi_of_device_get_match_data().

In principle we can go this way, but can you tell a bit more of a story?
Why the device in question can't use existed or a newly allocated ACPI HID for
that?

...

> @@ -1031,8 +1031,9 @@ const void *acpi_device_get_match_data(const struct device *dev)
>  {
>  	const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
>  	const struct acpi_device_id *match;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);

Please, keep it in reversed xmas tree order.

> -	if (!acpi_ids)
> +	if (!strcmp(ACPI_DT_NAMESPACE_HID, acpi_device_hid(adev)))


>  		return acpi_of_device_get_match_data(dev);
>  
>  	match = acpi_match_device(acpi_ids, dev);

-- 
With Best Regards,
Andy Shevchenko



