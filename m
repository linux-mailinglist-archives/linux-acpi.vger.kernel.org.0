Return-Path: <linux-acpi+bounces-20081-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDCED05568
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 19:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B3BE30158C4
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 18:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B6E2EC571;
	Thu,  8 Jan 2026 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RjZx2wDW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883912512FF;
	Thu,  8 Jan 2026 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895536; cv=none; b=PUoSDci5NJuLSznS+MV+Aa0PmKRAbOfhn9EN6jqy4nRrTKZtHxEjaK2feynRFrvSk3WSqVxt9AFidW5U2/2KJPmc2UK5HCQcQ7XIzH6b8dy53CNjACjQFKDFbL/NbBuMVDlYmSJSK81DCecycTeBvXHR2X8D8zVBwqfQEbvANrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895536; c=relaxed/simple;
	bh=R4XFNhTmxo0LGWqC/1K+ZQHaJb5xfOwPTbu9fCckLx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chAEQdbYDSnPoZd3twp/Mzk7hQqQcEMWJ/QeQPCvOSv4Zafd4DEiuna/7kR8dtMLwS897IimKWSiDbA5VPRFEc2Lys9pd6YzBjn8R5xKiGt/cRrwI9b1lVoPF5M498T8nlgUCxxwGf6ukQfMgCWMY9MLYd4bIuQ/PGELC3oRUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RjZx2wDW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767895535; x=1799431535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R4XFNhTmxo0LGWqC/1K+ZQHaJb5xfOwPTbu9fCckLx0=;
  b=RjZx2wDWokhlmQtn2FQb0SQ7Rs3hGtA4q0T07g3hMZuea80p/S4rgzNW
   qU+lXzSAgvH8o6QGqvB92WYd3abahNEPetrXGa5BZEFfyBhmgrMxPxQLy
   c/hq1TFddWfq+Lrq+VonyijHLW1C4JxZMiLRslYQR8T51Imy68q7FH6om
   a+Le4JAFylRXh+jWfUTAvVIALlwWGoyNmnzzHyfoaY0ArCVLANblsOOb0
   5fH9CRMh5CAZoJQrlBii4dE7ShmrjXY37vBxP1vnGgC7ULI4pChIt8oYm
   g9CNul2VaT93SC19HhjgMXOYjuRd14QnoHBMNpSN2vkA7S+0AJ9EoMo5t
   g==;
X-CSE-ConnectionGUID: QJ36UViQSYOmXdOHm2JIqQ==
X-CSE-MsgGUID: aVWy5cFZQ0mVs3om2HmUDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69182238"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69182238"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 10:05:35 -0800
X-CSE-ConnectionGUID: DrBQNgtpRumax1R077eKow==
X-CSE-MsgGUID: YaXOM4UISCiTPQdlL/pU2w==
X-ExtLoop1: 1
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.60])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 10:05:32 -0800
Date: Thu, 8 Jan 2026 20:05:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: lenb@kernel.org, sakari.ailus@linux.intel.com,
	mika.westerberg@linux.intel.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: bus: Use OF match data for PRP0001 matched
 devices
Message-ID: <aV_x6nlu0Rlqn2ZQ@smile.fi.intel.com>
References: <20260107120318.13130-1-kkartik@nvidia.com>
 <aV6ALdPCjaAYHM7-@smile.fi.intel.com>
 <abfdb44d-108a-49d5-98ad-949d184f4f98@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abfdb44d-108a-49d5-98ad-949d184f4f98@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 08, 2026 at 05:57:35PM +0530, Kartik Rajput wrote:
> On 07/01/26 21:17, Andy Shevchenko wrote:
> > On Wed, Jan 07, 2026 at 05:33:18PM +0530, Kartik Rajput wrote:

> > > When a device is matched via PRP0001, the driver's OF (DT) match table
> > > must be used to obtain the device match data. If a driver provides both
> > > an acpi_match_table and an of_match_table, the current
> > > acpi_device_get_match_data() path consults the driver's acpi_match_table
> > > and returns NULL (no ACPI ID matches).
> > 
> > Since we have both tables, why the actual ACPI HID of the device in question
> > (actually which one?) can't be used?
> > 
> > > Explicitly detect PRP0001 and fetch match data from the driver's
> > > of_match_table via acpi_of_device_get_match_data().
> > 
> > In principle we can go this way, but can you tell a bit more of a story?
> > Why the device in question can't use existed or a newly allocated ACPI HID for
> > that?
> 
> While testing PRP0001-based matching with the Tegra fuse driver on an SoC that does
> not yet have an allocated ACPI HID,

Which means in the production you do not need this patch. Allocate ID and go with it.

> device_get_match_data() returned NULL because
> the driver also provides an acpi_match_table.
> 
> Commit 886ca88be6b3 ("ACPI / bus: Respect PRP0001 when retrieving device match data")
> was intended to address this by honoring PRP0001 when retrieving match data. However,
> when a driver provides an ACPI match table, acpi_device_get_match_data() currently
> consults only that table, resulting in NULL match data despite a successful
> PRP0001 match.

Which is expected behaviour. So there are two cases I can see that might make
this patch valid:

1) the preproduction development when the driver has both tables and formal
ACPI HID is not allocated yet (this what has to be the main "why" point
in the commit message);

2) a driver that got ACPI HID from somebody else and breaks the PRP0001 setups
for others (no evidences so far, but I admit there is a potential to have a
such).

That said, having the Fixes tag is unrequired.

-- 
With Best Regards,
Andy Shevchenko



