Return-Path: <linux-acpi+bounces-20160-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AA7D10051
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 23:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A635E30268D2
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 22:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F15243968;
	Sun, 11 Jan 2026 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eo2GeAXI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7D225A35;
	Sun, 11 Jan 2026 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768168919; cv=none; b=Os0qTuXDKWdEDJxjl4FnoHV1v3jT7LQLvG4GrIDEDsMXDSQXKBZuH0hb/vI2ISlxd/ZYc03d+bsZg3yDEHt95WJySf9PiF2P20lZPA7kJFj7oEtL76WzpC6snkFbBZ0rfVe4YET7+S9zLRmCnPiJq+U2YK2/pzm9NLzNKhL26nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768168919; c=relaxed/simple;
	bh=Fm5CRRmsum1DonlTpS4fRjnNzK5iTjtutzs7skX0P0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHR7s/39fLrO2p2p2vNbh6vtrnHsjbMn2Cwj429QWd/KFGW5Js3C0nGgJnb2oJeJ9L7aftujZMPzMyUaZ5Jh/WhSgB+MoI+YZW41u1GUuJlcCpJpMLr6a+U7IO5XE9hTxlvfB2xC78plLnAlypoUzNW26uX6EcCJYDVzHAmudho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eo2GeAXI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768168918; x=1799704918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Fm5CRRmsum1DonlTpS4fRjnNzK5iTjtutzs7skX0P0I=;
  b=eo2GeAXI6TXwh2Zc2BNKKGosj2ejS+z1MsKDQ5cdHHZ315rh/TpxcRmc
   1+RPuE+KtZmCkXmjNrD0rtUTs66pEg5ps5+MNrTFgwtbwjcggvpQdIcOb
   j0cf6KjqUHSoO5wG37rXdaaDvRwenJHU1TGG0SE1GJvAOZNv1/Dl+zrUk
   MCCn1PACyCNPtK5ceQt6HgSB2+uRT4RFJ+RPW0yqsGdz4GsH7O5l8cQAr
   h6obC0qXm5VPRYvxgoevh/SfzXxUW1e3vwRqrhm3ciV1kYdGfYMdCWq7u
   kbOhLy+7C/ZEKe2u7rVFbOZti3Y+dtC08w1hbpTs/uy32UnVuRyeERv5z
   w==;
X-CSE-ConnectionGUID: uxz3fXG8QhWGucFvE7aRHw==
X-CSE-MsgGUID: q64izjktSn2Ov+rFvxP+KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69184627"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69184627"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 14:01:57 -0800
X-CSE-ConnectionGUID: aZgO7i/oTt+lj41cvasYTA==
X-CSE-MsgGUID: l6P4vHh6RJarE83AutnQ3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208428108"
Received: from amilburn-desk.amilburn-desk (HELO kekkonen.fi.intel.com) ([10.245.245.19])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 14:01:54 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id B7E3C11F9B2;
	Mon, 12 Jan 2026 00:01:51 +0200 (EET)
Date: Mon, 12 Jan 2026 00:01:51 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Kartik Rajput <kkartik@nvidia.com>, lenb@kernel.org,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ACPI: bus: Use OF match data for PRP0001 matched
 devices
Message-ID: <aWQdz37vK-SXVQBv@kekkonen.localdomain>
References: <20260109095358.24265-1-kkartik@nvidia.com>
 <20260109101302.GW2275908@black.igk.intel.com>
 <aWDhEBjy9b9_uzoR@smile.fi.intel.com>
 <aWDmt3CA5h_i9Hij@kekkonen.localdomain>
 <aWE0uuZjB1iMGF2B@smile.fi.intel.com>
 <CAJZ5v0ijTQC2cFTt+hW-ofJwMqdEeES8d5MMbbq8_Bqg+_9E3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ijTQC2cFTt+hW-ofJwMqdEeES8d5MMbbq8_Bqg+_9E3g@mail.gmail.com>

Hi Rafael, Andy,

On Fri, Jan 09, 2026 at 10:11:26PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 9, 2026 at 6:02 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Jan 09, 2026 at 01:29:59PM +0200, Sakari Ailus wrote:
> > > On Fri, Jan 09, 2026 at 01:05:52PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Jan 09, 2026 at 11:13:02AM +0100, Mika Westerberg wrote:
> > > > > On Fri, Jan 09, 2026 at 03:23:58PM +0530, Kartik Rajput wrote:
> > > > > > During pre-production development, drivers may provide both ACPI and OF
> > > > > > match tables while a formal ACPI HID for the device is not yet
> > > > > > allocated. Such devices are enumerated via PRP0001. In this case,
> > > > > > acpi_device_get_match_data() consults only the driver’s ACPI match table
> > > > > > and returns NULL, even though the device was successfully matched via
> > > > > > PRP0001.
> > > > > >
> > > > > > This behavior also risks breaking existing PRP0001 setups if a driver
> > > > > > later gains an ACPI HID, as the presence of an ACPI match table changes
> > > > > > the match-data lookup path.
> > > > > >
> > > > > > Explicitly detect PRP0001 and fetch match data from the driver's
> > > > > > OF match table via acpi_of_device_get_match_data().
> >
> > ...
> >
> > > > > >         const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
> > > > > > +       struct acpi_device *adev = ACPI_COMPANION(dev);
> > > > > >         const struct acpi_device_id *match;
> > > > > >
> > > > > > -       if (!acpi_ids)
> > > > > > +       if (!adev)
> > > > > > +               return NULL;
> > > > > > +
> > > > > > +       if (!strcmp(acpi_device_hid(adev), ACPI_DT_NAMESPACE_HID))
> > > > > >                 return acpi_of_device_get_match_data(dev);
> > > >
> > > > On top of what Mika asked, shouldn't we check CID as well? Theoretically it's
> > > > possible that some device may have HID "blablabla" and CID PRP0001, I don't
> > > > remember what documentation says about this case, though.
> > >
> > > According to Documentation/firmware-guide/acpi/enumeration.rst PRP0001 is
> > > also valid for _CID. So yes, I think this should be checked as well -- I'd
> > > loop over the &device->pnp.ids list.
> >
> > Yeah, but if we have a device with
> >
> > HID "blablabla"
> > CID "PRP0001"
> >
> > and at the same time the driver has ACPI ID listed, we should probably use that
> > one as HID should have higher weight for matching. Logic here is not just as simple
> > as looping over pnp.ids how I see it.
> 
> Right.
> 
> What about:
> 
> if (acpi_ids) {
>        match = acpi_match_device(acpi_ids, dev);
>        if (match)
>                return (const void *)match->driver_data;
> }
> return acpi_of_device_get_match_data(dev);

That would mean that any ACPI (or PNP) ID has priority over compatible
matching, wouldn't it? AFAIU the documentation says effectively that
_HID/_CID priority is upheld, whether matching with PRP0001 or without.

-- 
Regards,

Sakari Ailus

