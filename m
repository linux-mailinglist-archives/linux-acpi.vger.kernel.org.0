Return-Path: <linux-acpi+bounces-20107-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB4DD08CD1
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 12:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 513BB3009D51
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 11:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3830F33B6FB;
	Fri,  9 Jan 2026 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWQfc1Kl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA0339705;
	Fri,  9 Jan 2026 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767956759; cv=none; b=LcfVb2x1d+pTDuTdVgXcI1JxlHSKoPO7m1ISb8iF0Q2USiB5hFj6dxHCqysHghBlIRdiRh8PG49nmt75gEE+YXXJBJkyzSBQMlo77eHW/xB93erTOJnqEvDfq/REnJUGKcRlzqfo9OxOPc0ga0dbov1AYD2oZ02Kek27rYw7OA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767956759; c=relaxed/simple;
	bh=EKVSdD9sLf1KIF2hnjWZch8Nyi+V0sb8pnwFj0s1yiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzxlp3gQE2UxKt/ge8J/YKupYwfg5GZeoJvtLJS0mxpDjiLAb8z2zmxZmBHoQrnzc9ZSia2L0JH0yc3dYux+Ju8S1PosjRD9436RqhnzqeJpp/Taw8E/jyJTL2UVEv0sa9pwWI876GgYbt3VaC5NARgPFYCBpKpy6ICF2SZKUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWQfc1Kl; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767956758; x=1799492758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EKVSdD9sLf1KIF2hnjWZch8Nyi+V0sb8pnwFj0s1yiw=;
  b=iWQfc1KlmaSEsB/1V4ljD3cyHA62IaHCVP3475can1pDokJQkRaYqNnN
   OftEjmbihB5Vb/U57fNnxc1Dw1X5B++2rDJRvJw2NzG6TiD4R+nWv2fj1
   9GaoBihlp0RDwuOxGeETT6OtuJxsUt6ESCikZ6q4UsQVQlIemahGcU472
   y3zevCXmZKOD+U9JmbaDE0ANBwVRCDsCxxUhxaJLIX3Lt3TjAgfwU7cQb
   /cfrhx6fcwioL0CGcj0/Ypr5Mu3G/q+EmsPAZggshtv1gxpDXbaaDyVIr
   lijtm7BmWoadbPAq4phXX6qHXSKVc6cdmxkY7pNfAdhkg4qBUephyGPXj
   w==;
X-CSE-ConnectionGUID: FQ3BX/P3TLKggV4scEb6Fg==
X-CSE-MsgGUID: j0KXsAE0QhKwhxObvgwN1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="86925864"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="86925864"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 03:05:57 -0800
X-CSE-ConnectionGUID: aZ6u4rSsSVu82HwmH3Gznw==
X-CSE-MsgGUID: JEaiYxMHTfq8guUQcEXmLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="208280153"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 03:05:54 -0800
Date: Fri, 9 Jan 2026 13:05:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Kartik Rajput <kkartik@nvidia.com>, lenb@kernel.org,
	sakari.ailus@linux.intel.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: bus: Use OF match data for PRP0001 matched
 devices
Message-ID: <aWDhEBjy9b9_uzoR@smile.fi.intel.com>
References: <20260109095358.24265-1-kkartik@nvidia.com>
 <20260109101302.GW2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109101302.GW2275908@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 09, 2026 at 11:13:02AM +0100, Mika Westerberg wrote:
> On Fri, Jan 09, 2026 at 03:23:58PM +0530, Kartik Rajput wrote:
> > During pre-production development, drivers may provide both ACPI and OF
> > match tables while a formal ACPI HID for the device is not yet
> > allocated. Such devices are enumerated via PRP0001. In this case,
> > acpi_device_get_match_data() consults only the driver’s ACPI match table
> > and returns NULL, even though the device was successfully matched via
> > PRP0001.
> > 
> > This behavior also risks breaking existing PRP0001 setups if a driver
> > later gains an ACPI HID, as the presence of an ACPI match table changes
> > the match-data lookup path.
> > 
> > Explicitly detect PRP0001 and fetch match data from the driver's
> > OF match table via acpi_of_device_get_match_data().

...

> >  	const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
> > +	struct acpi_device *adev = ACPI_COMPANION(dev);
> >  	const struct acpi_device_id *match;
> >  
> > -	if (!acpi_ids)
> > +	if (!adev)
> > +		return NULL;
> > +
> > +	if (!strcmp(acpi_device_hid(adev), ACPI_DT_NAMESPACE_HID))
> >  		return acpi_of_device_get_match_data(dev);

On top of what Mika asked, shouldn't we check CID as well? Theoretically it's
possible that some device may have HID "blablabla" and CID PRP0001, I don't
remember what documentation says about this case, though.

> >  	match = acpi_match_device(acpi_ids, dev);
> 
> Should you check with !acpi_ids still here?

-- 
With Best Regards,
Andy Shevchenko



