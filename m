Return-Path: <linux-acpi+bounces-4048-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E615386DC3C
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 08:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016E81C2227F
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 07:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B4469957;
	Fri,  1 Mar 2024 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4YCnV59"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B498F69958
	for <linux-acpi@vger.kernel.org>; Fri,  1 Mar 2024 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709278935; cv=none; b=uta6D3shoE6oKyFf2G0ZVPb4eiYEq4AwTMk6oBNH2bpP4+Uu0FTPsfuBsvEWDywyBeN11iTt2qszBGWstUxKJ2lE34zvOSSYedciBFFk56mwurf5cEwKtQuKfgtA5w2p1gGAmeQwzMBkYb4uEpNOso/YNgXuFs6PNvPoXlMNNdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709278935; c=relaxed/simple;
	bh=v7KLKQWxhvcA3eN2jKJW1dy+PCySf1D1/MlbmysSSGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJAtoqf4s3rmBy3aumjZg+6nKfwF5EeU9CoAxnEh51zVZNw4euTz8HoSPxkz/3yg1T1ROzNAFWBbQg8U4RRNMrO3bh5ja+xbCORlOysqRW51xHe73uuaV7L3EMJHeG9Dz3XaAihcG3xveSuRTv54LUZRcUQDlXBEYIBPXaalnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4YCnV59; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709278934; x=1740814934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v7KLKQWxhvcA3eN2jKJW1dy+PCySf1D1/MlbmysSSGU=;
  b=G4YCnV59267yehc3d0K6Y+wduGs4F1jTCDZ/dyxyruhMnau/deLTZrJ4
   EQGb67QT+nKnQU6B49mhc6jbSEazpBG1t5UE711f8cEYXQtbpFMPuD4E8
   6hv6k4WopswiZMQsk7sahm/FLRHyYvyJLWzhGBUjU0PzZdlQWcHSJsNyE
   Xb4Zc1l3jQMKQV4OrxujpPAzdHgiZdlavQdcB+yVXXmKJncxqsdoq2q42
   F5dUVxYq229MUaFQnEsOxXGgz+/7trGx1BCLL6OK2dyJy1VTk7RTj3Mnz
   6C70qMGrco+m7q8v6RA8g9IlGXyL2f8wBd0Lv1mBkBog1sjwZBz2AZPs+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="26264276"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="26264276"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 23:42:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="937037117"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="937037117"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 23:42:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id BD55F3BC; Fri,  1 Mar 2024 09:42:09 +0200 (EET)
Date: Fri, 1 Mar 2024 09:42:09 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: aigilea <i@cpp.in>
Cc: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Kernel panic in ACPICA on HP Spectre X360 (Meteor Lake 155H)
 laptop
Message-ID: <20240301074209.GM8454@black.fi.intel.com>
References: <CABYkuAg3rcXT=0-=7EMX8NW3-mU0zYRvp+rOo5nq_7SHdb=cxA@mail.gmail.com>
 <20240216120211.GR8454@black.fi.intel.com>
 <CABYkuAhLYcLQp8PiBm-aTDC-AAV2NWVzN-79XLVcYvAfGtVhcQ@mail.gmail.com>
 <20240216144610.GS8454@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216144610.GS8454@black.fi.intel.com>

Hi again,

On Fri, Feb 16, 2024 at 04:46:10PM +0200, Mika Westerberg wrote:
> Hi,
> 
> On Fri, Feb 16, 2024 at 05:36:21PM +0300, aigilea wrote:
> > Hi.
> > 
> > Booting with "modprobe.blacklist=intel_lpss_pci" on the kernel command
> > line indeed works around this panic.
> > I will try to find out what hardware depends on this driver.
> > 
> > Two years ago there was a similar issue with broken soundwire devices
> > configuration in dsdt on tiger lake iteration of this laptop, it is
> > not fixed by HP to this day.
> > SOF guys in Intel ended up making a quirk for that case.
> > So if the quirk (or some additional checks in parser?) path is not
> > suitable for this issue I guess the most "proper" fix might be acpi
> > overlay?
> 
> I understood HP did this fix to their BIOS but it might take some time
> to get the confirmation and the BIOS version (working on this).

Unfortunately it turns out that HP only applied this fix for their Omen
Transcent system and apparently there is not going to be updates on any
other system that has this issue if it is not shipping with Linux :(

So we probably need to figure out an alternative. The root cause is that
the HP BIOS accidentally a device and a variable with the same name IC03
and that gets resolved to the device instead of the variable in the
_PS3() method where it calls Add(IC03, 1, 1).

This was fixed by renaming the device into something else but I'm not
entirely sure how this could be fixed in the kernel side or ACPICA.

