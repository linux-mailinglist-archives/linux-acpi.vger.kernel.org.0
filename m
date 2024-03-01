Return-Path: <linux-acpi+bounces-4059-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1508386E75C
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 18:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F591C23E2D
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513E5FC0F;
	Fri,  1 Mar 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjSJbWVL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C4646B3
	for <linux-acpi@vger.kernel.org>; Fri,  1 Mar 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314409; cv=none; b=StNuOahf6xHFTTwXMWva1i4/SiDwUNG3/9qT8pGi3nQVneIn7ZPPi8xHNHM2B+/yUjtbYyF0sqRv8iF66I/VjgI0uHceD7Eoo1r8tcV/FgWtNUidLcy9TdsP4IpMKXtEqLC1pi3Rd8LkblKm/Mns2sxuBg+CcMzdIfCm/Y9rmbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314409; c=relaxed/simple;
	bh=g36zWqRNFBfmztbjuqYnJMX+rYyCgvPnWzA3RuKdmVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYeSZjPZaa0tI4haw9QVcFnnwj4AGbqrUzqjpOK482MsX28JuFru7duji8OgJME/t0tpzGDKFCGCDvVo3rxvj5PS7lDQDwYeYX1D2PzEXbwbuLOLcEjPSFypDCz1bLJ517up8VJPIY7suOzmWKmJTCBM0ds0A1AuTHyjjXBlQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjSJbWVL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709314407; x=1740850407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=g36zWqRNFBfmztbjuqYnJMX+rYyCgvPnWzA3RuKdmVs=;
  b=OjSJbWVLorJmaPtPdxSnRuMBmzCNiWZtqIzld1x06M3VOQaCil7s48ye
   /pmi9/cZyC3CqHlvCpQJ4L/U3R3BXjUw9+3QWFsukgDB+rL9d/U3cTO/S
   2ROKwjn5+E09Lc/kDPl9tXlCNAB2QCWK0hBIRQbTrpl9hyGo4m1PH+ItI
   wTh5M8dNV5lIb8x+fZBYRu/K3PgkBmtFu1LG+Z57OMt9Nu9CWFCDF45Qb
   3Do27RlA/YDOPte5ALhEC/YwdesTSnxoPzDde1L2ww8vf3mkEAR1dy85z
   qNezQ092QNWR9ycN5SALH1wyNjg7GLtEw0WrRNT8UlbFU5QSeDyvi3Udb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15274097"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="15274097"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:33:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="914021068"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="914021068"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:33:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rg6l8-0000000913e-3lG6;
	Fri, 01 Mar 2024 19:33:22 +0200
Date: Fri, 1 Mar 2024 19:33:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: aigilea <i@cpp.in>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: Kernel panic in ACPICA on HP Spectre X360 (Meteor Lake 155H)
 laptop
Message-ID: <ZeIRYv0_Lxmggg4J@smile.fi.intel.com>
References: <CABYkuAg3rcXT=0-=7EMX8NW3-mU0zYRvp+rOo5nq_7SHdb=cxA@mail.gmail.com>
 <20240216120211.GR8454@black.fi.intel.com>
 <CABYkuAhLYcLQp8PiBm-aTDC-AAV2NWVzN-79XLVcYvAfGtVhcQ@mail.gmail.com>
 <20240216144610.GS8454@black.fi.intel.com>
 <20240301074209.GM8454@black.fi.intel.com>
 <CABYkuAi_vCc-kN_DSW0kPGACQKo+7B9GBckFiUsqGqTts7xXuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABYkuAi_vCc-kN_DSW0kPGACQKo+7B9GBckFiUsqGqTts7xXuQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 01, 2024 at 05:38:00PM +0300, aigilea wrote:
> Hello.
> 
> Renaming the IC03 variable to the closest unused IC08 in the DSDT
> overlay indeed fixes the crash.
> 
> Renaming/removing the device (as it looks like its only purpose is to
> trigger Windows update to install some HP software) might be a cleaner
> way but I'm not sure how to do this with overlays as this device is
> declared in one of SSDT tables under the widely used _SB_.PC00.
> 
> For me personally this is good enough, but I'm not sure if it's a good
> solution for a general case.
> 
> HP's attitude is unfortunate to say the least as the bug is so clear
> and the fix is so simple. We've only bought a trial batch of ten
> units, we'll return the ones that are still packed and go with some
> other vendor from now on.

I hope PR department of HP has a chance to read this...^^^

> On Fri, Mar 1, 2024 at 10:42 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Fri, Feb 16, 2024 at 04:46:10PM +0200, Mika Westerberg wrote:
> > > On Fri, Feb 16, 2024 at 05:36:21PM +0300, aigilea wrote:

> > > > Booting with "modprobe.blacklist=intel_lpss_pci" on the kernel command
> > > > line indeed works around this panic.
> > > > I will try to find out what hardware depends on this driver.
> > > >
> > > > Two years ago there was a similar issue with broken soundwire devices
> > > > configuration in dsdt on tiger lake iteration of this laptop, it is
> > > > not fixed by HP to this day.
> > > > SOF guys in Intel ended up making a quirk for that case.
> > > > So if the quirk (or some additional checks in parser?) path is not
> > > > suitable for this issue I guess the most "proper" fix might be acpi
> > > > overlay?
> > >
> > > I understood HP did this fix to their BIOS but it might take some time
> > > to get the confirmation and the BIOS version (working on this).
> >
> > Unfortunately it turns out that HP only applied this fix for their Omen
> > Transcent system and apparently there is not going to be updates on any
> > other system that has this issue if it is not shipping with Linux :(
> >
> > So we probably need to figure out an alternative. The root cause is that
> > the HP BIOS accidentally a device and a variable with the same name IC03
> > and that gets resolved to the device instead of the variable in the
> > _PS3() method where it calls Add(IC03, 1, 1).
> >
> > This was fixed by renaming the device into something else but I'm not
> > entirely sure how this could be fixed in the kernel side or ACPICA.

-- 
With Best Regards,
Andy Shevchenko



