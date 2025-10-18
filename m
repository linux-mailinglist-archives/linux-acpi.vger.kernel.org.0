Return-Path: <linux-acpi+bounces-17947-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7D2BED890
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 21:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC803AF5EA
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 19:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8016927B4FA;
	Sat, 18 Oct 2025 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nxm393cn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBBA1EE7B9;
	Sat, 18 Oct 2025 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760814866; cv=none; b=VnwhK2C13dsTppJYHHbu329QVdvBvuKG+E/RGEIFRJsD3U9LWxB1hzanZDeinZBoe+DULe/WDK4Je5tJWc5LkJ3x5hZTwHXehIvfnpM+eoGYtgMbDQryNa//l41m0WQ1ixeAVbFIL09eLMnuRV8jaWr8mqLZ8yPH1yDDV/zknKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760814866; c=relaxed/simple;
	bh=dBoaPphiu4f5Ip4gq8tI53CwbP/pBK7d8w8KBwBouuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJp2kt/pHk1U6tiFcUDDS65LHhBWlPXTcZxCcShKQ3mpT6QDQVtVP5dEbBw4MynYCct3tMYaZzUYuMuYMyUKSWfuNoBKy60XcWm5T/3iTFOAUAAJsFRs2sC6xcuicCg0JECDprgNM+dI54oII9xFSI2TfgzUVYUGlAseN1giW2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nxm393cn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760814864; x=1792350864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dBoaPphiu4f5Ip4gq8tI53CwbP/pBK7d8w8KBwBouuw=;
  b=Nxm393cneNGU429i19t0zJ5lTzOxw+Qy6BymtRfA3XdQleAYdcdlKbqx
   FZv8TPJQONIRgKsJyOiHWHsXyIuVllVXe+MaQO7aXgw3kYjsTRUH7yPAY
   7gkwARusvOJZK4nSlOJAmdaeA6eKELq/N8s4m0PrDsH9qnTo7U5bSdRj1
   H5ShiND3S4FCa5mJIxQrRImT4O2AULtHnsaAHkiL3894RsNaVGvlB1Jd2
   a81f7phN/fSrpXYY8TqmXEvIyAUnGF2jD0l10MJlZEt4tTxWGNo6TbbGB
   Chd2HpKUPkGdSKKFpKF5FD2TcJBgRKdank1Hy/K9redisUWQjL6n/sF1r
   Q==;
X-CSE-ConnectionGUID: FR8X+whgSuuvk5b5GGaLLw==
X-CSE-MsgGUID: EUb2zFYyQ0OB6mlMqcSt2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66866124"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="66866124"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:14:24 -0700
X-CSE-ConnectionGUID: 6nNR3t4ZRxyGwAJhiKJ41w==
X-CSE-MsgGUID: jZQvWAWFSfmAWn8X5lT6NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="183761838"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 12:14:22 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vACNf-00000000xLR-24A5;
	Sat, 18 Oct 2025 22:14:19 +0300
Date: Sat, 18 Oct 2025 22:14:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Thomas Richard <thomas.richard@bootlin.com>, rafael@kernel.org,
	regressions@lists.linux.dev, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	apatel@ventanamicro.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Daniele Cleri <DanieleCleri@aaeon.eu>
Subject: Re: [REGRESSION] in 6.18-rc1, failed to query a GPIO using a name in
 ACPI
Message-ID: <aPPnC6gSP4r46gBV@ashevche-desk.local>
References: <c321423b-3cdb-41a5-9939-dc5c846cfcd4@bootlin.com>
 <aPFwPR2A0CN6k1Vl@sunil-laptop>
 <1241f2b6-9b4e-4623-8a83-77db8774ac32@bootlin.com>
 <aPIUMoDxW-yl2nPm@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPIUMoDxW-yl2nPm@sunil-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 17, 2025 at 03:32:26PM +0530, Sunil V L wrote:
> On Fri, Oct 17, 2025 at 10:50:05AM +0200, Thomas Richard wrote:
> > On 10/17/25 12:22 AM, Sunil V L wrote:
> > > On Thu, Oct 16, 2025 at 02:47:40PM +0200, Thomas Richard wrote:
> > >>
> > >> While testing the AAEON UpBoard MFD driver with the v6.18-rc1 release, I
> > >> noticed a regression. The driver does not probe anymore and I get the
> > >> following error:
> > >>
> > >> [    1.977831] upboard-fpga AANT0F01:00: error -ENOENT: Failed to
> > >> initialize FPGA common GPIOs
> > >> [    1.977854] upboard-fpga AANT0F01:00: probe with driver upboard-fpga
> > >> failed with error -2
> > >>
> > >> The driver fails to get some GPIOs using a name [1] in the ACPI tables [2].
> > >>
> > >> I did a bisect and I found the commit which introduced the regression:
> > >> e121be784d35 ("ACPI: property: Refactor acpi_fwnode_get_reference_args()
> > >> to support nargs_prop")
> > > 
> > > Could you please try with below change and see if it resolves the issue?
> > > 
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index 1b997a5497e7..43d5e457814e 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -1107,7 +1107,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
> > >                                        size_t num_args,
> > >                                        struct fwnode_reference_args *args)
> > >  {
> > > -       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, index, num_args, args);
> > > +       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, num_args, index, args);
> > >  }
> > 
> > Yes your change fixes the issue !!
> 
> Thanks for confirming the fix!
> 
> I'll send out the patch shortly and include your Tested-by tag.
> 
> Apologies for the earlier issue, and thank you for your help.

I haven't received anything. Have you sent anything? Am I Cc'ed?

-- 
With Best Regards,
Andy Shevchenko



