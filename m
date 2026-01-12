Return-Path: <linux-acpi+bounces-20179-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC92D11597
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 09:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA2B30102A7
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 08:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3ED346797;
	Mon, 12 Jan 2026 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NP0JQfO6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8C3451A3;
	Mon, 12 Jan 2026 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208165; cv=none; b=oNlrcZNkowLeXXl97f7amTkOWHT6m0uB5OJIlQ8dqEw15FH7M/cQciDSCJRMZm+miqzi5fE4IpDQEriJCKAN80P66ySbyn7vPsjYjPOvpeCKsuFmbOT9LsIOBkLZuuBNxIFZZ6sBJO6M+0DuueOvrdfmQvrVD+e1klxoPC5XjY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208165; c=relaxed/simple;
	bh=SBExc/hApIz/IWUpu+VL4ScZY/oR+cuuRYGWapjolgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXAvsSFpBnEEJmtwYlaqOSnJ0QEV4E+cisI7NdDw8R1orm9GUuwpUE5iIALdvPOx0im4PLxLEfd2vb277/HYEmfohlcgeb+sVAs6StdZCrRgGYmudjTXPcnWy7dMOAtCpXaJWJnehcANGQkxBUUbiF1v2QFO0ogg0Un6DWcSm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NP0JQfO6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768208163; x=1799744163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SBExc/hApIz/IWUpu+VL4ScZY/oR+cuuRYGWapjolgw=;
  b=NP0JQfO6AhsqSLfPPt8BRd3hywXGTdCkTfP+ggNXVHk/quMRcGQ3zIn8
   Bt3/6n7n71QZ7D+6xneQWqElkDnIwJEK+Mrm6ebN9bYLBTSz1kWI4kpGl
   mNib28h70q+QFFF8IIoxF9B/oWjTudg7JmmFPdmmxM7hM269Koj9NF6c/
   YmZ8GJPDAOHQoYiQJuMzeBRsBNlI5FPVIrT7qEFA4jFoJC5HJSUTSFs5f
   wTWQEhGLCcXs3Z3Hm9Z+ZGMNuA4YjrKVMiKw48eFEmI8IOZbyaXIJuoH/
   CpSZNCRFY+iLW7VQtdcDOo/+f3ctayxhLtVAXD6achdGqe8mx97zWyhjQ
   A==;
X-CSE-ConnectionGUID: 4I7dZXVCQYmIOiYbfB74Hw==
X-CSE-MsgGUID: vqbnKi33TsOQQ5tDXMMq4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="57029084"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="57029084"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:56:02 -0800
X-CSE-ConnectionGUID: xK0ipO4EQb+uaQSgiB2cwQ==
X-CSE-MsgGUID: wUbHV2w/TbarN33/tmlfhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="204111892"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 00:56:00 -0800
Date: Mon, 12 Jan 2026 10:55:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kartik Rajput <kkartik@nvidia.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, lenb@kernel.org,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: bus: Use OF match data for PRP0001 matched
 devices
Message-ID: <aWS3HRIlZQqI1hP5@smile.fi.intel.com>
References: <20260109095358.24265-1-kkartik@nvidia.com>
 <20260109101302.GW2275908@black.igk.intel.com>
 <aWDhEBjy9b9_uzoR@smile.fi.intel.com>
 <aWDmt3CA5h_i9Hij@kekkonen.localdomain>
 <aWE0uuZjB1iMGF2B@smile.fi.intel.com>
 <CAJZ5v0ijTQC2cFTt+hW-ofJwMqdEeES8d5MMbbq8_Bqg+_9E3g@mail.gmail.com>
 <aWQdz37vK-SXVQBv@kekkonen.localdomain>
 <377fbbc3-5f79-424a-b986-4617048e5e3c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <377fbbc3-5f79-424a-b986-4617048e5e3c@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 12, 2026 at 02:12:49PM +0530, Kartik Rajput wrote:
> On 12/01/26 03:31, Sakari Ailus wrote:
> > On Fri, Jan 09, 2026 at 10:11:26PM +0100, Rafael J. Wysocki wrote:
> > > On Fri, Jan 9, 2026 at 6:02 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Jan 09, 2026 at 01:29:59PM +0200, Sakari Ailus wrote:
> > > > > On Fri, Jan 09, 2026 at 01:05:52PM +0200, Andy Shevchenko wrote:
> > > > > > On Fri, Jan 09, 2026 at 11:13:02AM +0100, Mika Westerberg wrote:
> > > > > > > On Fri, Jan 09, 2026 at 03:23:58PM +0530, Kartik Rajput wrote:

...

> > > > > > On top of what Mika asked, shouldn't we check CID as well? Theoretically it's
> > > > > > possible that some device may have HID "blablabla" and CID PRP0001, I don't
> > > > > > remember what documentation says about this case, though.
> > > > > 
> > > > > According to Documentation/firmware-guide/acpi/enumeration.rst PRP0001 is
> > > > > also valid for _CID. So yes, I think this should be checked as well -- I'd
> > > > > loop over the &device->pnp.ids list.
> > > > 
> > > > Yeah, but if we have a device with
> > > > 
> > > > HID "blablabla"
> > > > CID "PRP0001"
> > > > 
> > > > and at the same time the driver has ACPI ID listed, we should probably use that
> > > > one as HID should have higher weight for matching. Logic here is not just as simple
> > > > as looping over pnp.ids how I see it.
> > > 
> > > Right.
> > > 
> > > What about:
> > > 
> > > if (acpi_ids) {
> > >         match = acpi_match_device(acpi_ids, dev);
> > >         if (match)
> > >                 return (const void *)match->driver_data;
> > > }
> > > return acpi_of_device_get_match_data(dev);
> > 
> > That would mean that any ACPI (or PNP) ID has priority over compatible
> > matching, wouldn't it? AFAIU the documentation says effectively that
> > _HID/_CID priority is upheld, whether matching with PRP0001 or without.
> 
> Since we seem to be using __acpi_match_device() match the device.
> What if we directly utilise __acpi_match_device() here?
> 
> Something like:
> 
> 	if (!__acpi_match_device(adev, acpi_ids, of_ids, &acpi_id, &of_id))
> 		return NULL;
> 
> 	if (acpi_id)
> 		return (const void *)acpi_id->driver_data;
> 
> 	if (of_id)
> 		return of_id->data;
> 
> 	return NULL;
> 
> Then, we can also remove acpi_of_device_get_match_data()?

At brief look it's indeed seems to be a good optimisation as well.

-- 
With Best Regards,
Andy Shevchenko



