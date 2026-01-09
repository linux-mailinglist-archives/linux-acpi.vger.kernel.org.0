Return-Path: <linux-acpi+bounces-20111-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8457D08F2D
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 12:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C017830185E4
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 11:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E643563C0;
	Fri,  9 Jan 2026 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVY6g/IA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6773596FB;
	Fri,  9 Jan 2026 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958191; cv=none; b=X1vqq7fr06irrO/0NP73xah0iVgr9E8s9wLoNMoJjKFSyvhPhXkkPGQaZ6uCASF62Pt1rzWd7Jy9ZBamXRmxxS6nLXA1eYdhu6aoLRekl1DntaV6/D+1dgqOBB+HrX6WrBDazWHns04m31hpwnuMvSwlrOek5tpHQ0TW1XUhtNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958191; c=relaxed/simple;
	bh=YJuFhW0nEd/Ks6tuyv/6BYzhfJaqtDs0R3CuE8YedCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLx7X2Jl2Zc7uYldtffFGqV1Vk0zUc1CAy41oatjDfJljagWBC51owzwztL+XMJBtRHEHQOyNE66aGzdmRaICdaj7w+S4XILi2PGMM+T4cKsTj0CaMCxAMG7fy/Hz+zqjVVzaHd067XOR5xvs/aTJsxfpq2qQwRaGrq0G+XPlXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OVY6g/IA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767958190; x=1799494190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YJuFhW0nEd/Ks6tuyv/6BYzhfJaqtDs0R3CuE8YedCE=;
  b=OVY6g/IADljRo+PVyjbPjHv1Fyd6vxtitZ6NmP3w7yfABWSKJdgnHH5V
   0FttPfCgtZ31LcDVqijw7RESzjBGG+IZM6BMSH+Yatj7AuT8fbmGoS3A3
   2Uu9a/MCMHQtqdREuIVL1/3uW3lLZ/BQ3SE/JpkR3Fiphnd4+2AKqCdll
   gbDFmKI42GhveqfOVdNi1epSQgKx5b1UWf3Qcf/hjmVcZHrVKvpEZ/Ihx
   e9I+seaCkGNjLfBXSMp7rn3XWNjaJmQOVwRvLEGPIOm0T1lH6P99OsWZg
   6hQyHEK66mCY+5ggruXs/Qg/0ZUpIXLGwbqWOlOoooFGU9lRU8EBrQ1UH
   w==;
X-CSE-ConnectionGUID: n8Gahc9rTq+Jh72yg0OIDg==
X-CSE-MsgGUID: lyNnLnM9R/O8FdhJzER2Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="68343423"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="68343423"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 03:29:50 -0800
X-CSE-ConnectionGUID: 6lxO+x37ThesjC2MLKjYzg==
X-CSE-MsgGUID: t4AFROuKTdWvFuMaFtlITA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="202568007"
Received: from vverma7-desk1.amr.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.124.223.84])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 03:29:48 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 7D992120D05;
	Fri, 09 Jan 2026 13:29:59 +0200 (EET)
Date: Fri, 9 Jan 2026 13:29:59 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Kartik Rajput <kkartik@nvidia.com>, lenb@kernel.org,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: bus: Use OF match data for PRP0001 matched
 devices
Message-ID: <aWDmt3CA5h_i9Hij@kekkonen.localdomain>
References: <20260109095358.24265-1-kkartik@nvidia.com>
 <20260109101302.GW2275908@black.igk.intel.com>
 <aWDhEBjy9b9_uzoR@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWDhEBjy9b9_uzoR@smile.fi.intel.com>

Hi Andy,

On Fri, Jan 09, 2026 at 01:05:52PM +0200, Andy Shevchenko wrote:
> On Fri, Jan 09, 2026 at 11:13:02AM +0100, Mika Westerberg wrote:
> > On Fri, Jan 09, 2026 at 03:23:58PM +0530, Kartik Rajput wrote:
> > > During pre-production development, drivers may provide both ACPI and OF
> > > match tables while a formal ACPI HID for the device is not yet
> > > allocated. Such devices are enumerated via PRP0001. In this case,
> > > acpi_device_get_match_data() consults only the driver’s ACPI match table
> > > and returns NULL, even though the device was successfully matched via
> > > PRP0001.
> > > 
> > > This behavior also risks breaking existing PRP0001 setups if a driver
> > > later gains an ACPI HID, as the presence of an ACPI match table changes
> > > the match-data lookup path.
> > > 
> > > Explicitly detect PRP0001 and fetch match data from the driver's
> > > OF match table via acpi_of_device_get_match_data().
> 
> ...
> 
> > >  	const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
> > > +	struct acpi_device *adev = ACPI_COMPANION(dev);
> > >  	const struct acpi_device_id *match;
> > >  
> > > -	if (!acpi_ids)
> > > +	if (!adev)
> > > +		return NULL;
> > > +
> > > +	if (!strcmp(acpi_device_hid(adev), ACPI_DT_NAMESPACE_HID))
> > >  		return acpi_of_device_get_match_data(dev);
> 
> On top of what Mika asked, shouldn't we check CID as well? Theoretically it's
> possible that some device may have HID "blablabla" and CID PRP0001, I don't
> remember what documentation says about this case, though.

According to Documentation/firmware-guide/acpi/enumeration.rst PRP0001 is
also valid for _CID. So yes, I think this should be checked as well -- I'd
loop over the &device->pnp.ids list.

-- 
Regards,

Sakari Ailus

