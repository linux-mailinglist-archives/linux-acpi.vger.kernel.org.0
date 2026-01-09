Return-Path: <linux-acpi+bounces-20120-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 249B0D0B845
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 18:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872773038F58
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E9835A939;
	Fri,  9 Jan 2026 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MD7N6mok"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE572E4247;
	Fri,  9 Jan 2026 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978176; cv=none; b=beyvFHBjq4f8yaHFjaMIZpVjdTAc2QdQSSxJ6DWQYNFSyvipiBhJraeqnUnCuLrzgHIOoL8ce6qUr9sMNjkH7mtLGi0Kyu+DgVTYDf+bqpJbih/EvVaxCpmuPtxGJ0+FMNcRp296jFilmrIOqVuyzvMPnCvp3i2ubqQN8uRebt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978176; c=relaxed/simple;
	bh=84Cua4NIWUqkBuSlJe4Lflx0rzKyupieiyBmeHfYL7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVx0o8n+LDcHx4X7p1qcqLeCYNAf/RNCOrYzxu77S31KI46CaDmEVsKrH1y4BhwR5l4q1ETfJmAadn9ThGPIVzcwSpsqMy5UcrYFRVTeWANPB9kGDcbbp0PaJOyV2m7xOWYzpv9ZaIxdgXoW8oAifRACSSuATxMchaxmDvZRU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MD7N6mok; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767978175; x=1799514175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=84Cua4NIWUqkBuSlJe4Lflx0rzKyupieiyBmeHfYL7A=;
  b=MD7N6mok5/Overie2Xu4HrY2Z52uoISuzFxTU3nwNiUrROtbe1sXGA15
   f6PMwchPpzNsVPK6zA6eHFtCziXx92kLWFWAFM9kPAS/GD7stkxp9umOU
   hiDKsZxKXQZd0Vutf12qN0tQZmDq/pGfK+B+ud5tV0hej5ojCqlFzgExo
   O6E9J6psXumH+r/GfR8QeBrD39sqZiXVV66ooJk+vpny+I6vWqETrddkE
   wTeIGKofrQruA+9ZMH5MRbuxbLiDTKq9IOpES2SC53rlTIEqGN0cQbvgA
   SAZ2Lmf5kzpI9aKXR5uiwwxjry/nmtqx/Vc2xxNrbGD/YYQ3EwAikp7d0
   g==;
X-CSE-ConnectionGUID: r7SucwFfQOyqeLzwHaMoqw==
X-CSE-MsgGUID: gnJOzvagRzCfVkW948Kn9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="71936193"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="71936193"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 09:02:54 -0800
X-CSE-ConnectionGUID: hJvzM3avTSqOxMA8FhRgGw==
X-CSE-MsgGUID: z2qdpRqPSD2Po+ht0lVPxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="207667049"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 09:02:52 -0800
Date: Fri, 9 Jan 2026 19:02:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Kartik Rajput <kkartik@nvidia.com>, lenb@kernel.org,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: bus: Use OF match data for PRP0001 matched
 devices
Message-ID: <aWE0uuZjB1iMGF2B@smile.fi.intel.com>
References: <20260109095358.24265-1-kkartik@nvidia.com>
 <20260109101302.GW2275908@black.igk.intel.com>
 <aWDhEBjy9b9_uzoR@smile.fi.intel.com>
 <aWDmt3CA5h_i9Hij@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWDmt3CA5h_i9Hij@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 09, 2026 at 01:29:59PM +0200, Sakari Ailus wrote:
> On Fri, Jan 09, 2026 at 01:05:52PM +0200, Andy Shevchenko wrote:
> > On Fri, Jan 09, 2026 at 11:13:02AM +0100, Mika Westerberg wrote:
> > > On Fri, Jan 09, 2026 at 03:23:58PM +0530, Kartik Rajput wrote:
> > > > During pre-production development, drivers may provide both ACPI and OF
> > > > match tables while a formal ACPI HID for the device is not yet
> > > > allocated. Such devices are enumerated via PRP0001. In this case,
> > > > acpi_device_get_match_data() consults only the driver’s ACPI match table
> > > > and returns NULL, even though the device was successfully matched via
> > > > PRP0001.
> > > > 
> > > > This behavior also risks breaking existing PRP0001 setups if a driver
> > > > later gains an ACPI HID, as the presence of an ACPI match table changes
> > > > the match-data lookup path.
> > > > 
> > > > Explicitly detect PRP0001 and fetch match data from the driver's
> > > > OF match table via acpi_of_device_get_match_data().

...

> > > >  	const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
> > > > +	struct acpi_device *adev = ACPI_COMPANION(dev);
> > > >  	const struct acpi_device_id *match;
> > > >  
> > > > -	if (!acpi_ids)
> > > > +	if (!adev)
> > > > +		return NULL;
> > > > +
> > > > +	if (!strcmp(acpi_device_hid(adev), ACPI_DT_NAMESPACE_HID))
> > > >  		return acpi_of_device_get_match_data(dev);
> > 
> > On top of what Mika asked, shouldn't we check CID as well? Theoretically it's
> > possible that some device may have HID "blablabla" and CID PRP0001, I don't
> > remember what documentation says about this case, though.
> 
> According to Documentation/firmware-guide/acpi/enumeration.rst PRP0001 is
> also valid for _CID. So yes, I think this should be checked as well -- I'd
> loop over the &device->pnp.ids list.

Yeah, but if we have a device with

HID "blablabla"
CID "PRP0001"

and at the same time the driver has ACPI ID listed, we should probably use that
one as HID should have higher weight for matching. Logic here is not just as simple
as looping over pnp.ids how I see it.

-- 
With Best Regards,
Andy Shevchenko



