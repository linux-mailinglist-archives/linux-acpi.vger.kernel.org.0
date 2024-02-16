Return-Path: <linux-acpi+bounces-3593-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 611DE857FA3
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 15:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5010B21547
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Feb 2024 14:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAE512EBE7;
	Fri, 16 Feb 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbuzP3/d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29A1E481
	for <linux-acpi@vger.kernel.org>; Fri, 16 Feb 2024 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094776; cv=none; b=EMNmphKbnoe6DkXfRgwqO4OeQWpMnitrCtzrOf2HgmissJvGZKC90g4ZaXwR6UBKbMTam7y5q1S8uiXaZZM/kHdwWH4YCLB4rws09PkrvXMRCJBBZcl1V0+YX6IGTBJf/72a9b08+sW/yPTrWSCwPk09Wzlsw7LtUS3ayuYEZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094776; c=relaxed/simple;
	bh=bxKYslPcYW+TaBQvEunZG5ysjpvjubNejuY1nyhmKaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJIsYUCwrvCVLNyGu242i9hY3oLAicrmQqGWlKtKJIGJgCI9jllpctFMbIEwL2D5omodMVqDdJ69KYqZRyvb3uR3pWA4HYr0HGEYRFpk2nila1WLWaYdQHYqa39DnISoI52FPaMe3rnQLuMkWLRVu2ojE+UQR9mrI0MwLkGQ1lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbuzP3/d; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708094774; x=1739630774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bxKYslPcYW+TaBQvEunZG5ysjpvjubNejuY1nyhmKaY=;
  b=ZbuzP3/dimLL/fpp+elHF4tW1f/9XGx5QzBGdBVUdiabI9B96voK17KA
   FS/VrpfCxJtoCOs7Yc2DNZWjX+mdIDbEDiVeUAa9v0dbqc2VGlvkGgSPU
   CtBRByPT7ptGIWrFz5mBnxv7UHRBAcqofT/4ZHLn9QFwedVolN90wtjDT
   SXqZXNo/FN9TBRjMPgdIAa71pONxMA4tTzkhaBqmc4SVgvyyv2fw6ziRN
   yu2u7lu7Tn5V4lgimnbkh3kyy6Z87Afe2cqreuFWXHEWcUxpyZ8ISv6XQ
   lENGDTxnDJba/xKDgnpYY5rn3IhlmktIgLKyiDe4Ne7hSWzJhGWLva+25
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="6050856"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="6050856"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 06:46:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="935856529"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="935856529"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Feb 2024 06:46:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id A6B9A2E9; Fri, 16 Feb 2024 16:46:10 +0200 (EET)
Date: Fri, 16 Feb 2024 16:46:10 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: aigilea <i@cpp.in>
Cc: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Kernel panic in ACPICA on HP Spectre X360 (Meteor Lake 155H)
 laptop
Message-ID: <20240216144610.GS8454@black.fi.intel.com>
References: <CABYkuAg3rcXT=0-=7EMX8NW3-mU0zYRvp+rOo5nq_7SHdb=cxA@mail.gmail.com>
 <20240216120211.GR8454@black.fi.intel.com>
 <CABYkuAhLYcLQp8PiBm-aTDC-AAV2NWVzN-79XLVcYvAfGtVhcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABYkuAhLYcLQp8PiBm-aTDC-AAV2NWVzN-79XLVcYvAfGtVhcQ@mail.gmail.com>

Hi,

On Fri, Feb 16, 2024 at 05:36:21PM +0300, aigilea wrote:
> Hi.
> 
> Booting with "modprobe.blacklist=intel_lpss_pci" on the kernel command
> line indeed works around this panic.
> I will try to find out what hardware depends on this driver.
> 
> Two years ago there was a similar issue with broken soundwire devices
> configuration in dsdt on tiger lake iteration of this laptop, it is
> not fixed by HP to this day.
> SOF guys in Intel ended up making a quirk for that case.
> So if the quirk (or some additional checks in parser?) path is not
> suitable for this issue I guess the most "proper" fix might be acpi
> overlay?

I understood HP did this fix to their BIOS but it might take some time
to get the confirmation and the BIOS version (working on this).

I will be out next week though, but adding Andy who will provide the
details once we know them.

