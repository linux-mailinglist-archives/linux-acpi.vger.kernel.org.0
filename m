Return-Path: <linux-acpi+bounces-12816-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D232BA7EC96
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 21:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FF2424305
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 19:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C583721B18A;
	Mon,  7 Apr 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9yrPiq5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49D622422B
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2025 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051881; cv=none; b=tYHjbLcJRWS9JWf29LCH/iLUEUd4asZI6UNVDgfpayiZRu/qJJp7vidnKeyYSKngFTX1jcjXZkVsTMqfZ9oVrREAaCP7fZ6/AkoI2pRto1EXPBwAwgoMWF6LmWawYHHAf2Vkf+I9gDjz1CCY4pvNu009S0PqFWciYoAP1nowClE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051881; c=relaxed/simple;
	bh=m8fcxrwIZ81oqP3+PTHU29MMELBlQeCLYlUr8QdX2B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUeU/Z3oANefi+FdYBKFCNFdlCqzBRQNOqyaI5glH3S7Nm4U99JU1XfERSjJgl5S1CvFkw0d74t3a30Yiv2Hb7wRDy4rUjl18Gy+y+WVwHy6wL52REss1gWv5hsep75KiW2tXezYHPeMDj9iUPmFa8s6dO/GKD23IxCfK3hZpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9yrPiq5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744051880; x=1775587880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m8fcxrwIZ81oqP3+PTHU29MMELBlQeCLYlUr8QdX2B4=;
  b=N9yrPiq5YdH2B6Azw1OV9imDh3a9Aff2bXBm7tAfAvmlvo0rtuOZQrSJ
   v0we4DNtQt2QtMSZ60yny7ZlyZDprwFISuKWB6AiorUiDH7QGA63cLqb/
   vtNZv+PwuiJs8nNei+8XG6K4UJpFbj1HTQOmm6zEdxNl94O5gJXBaVISb
   yEwAXo3t5mPOUMcNIwsu1NvzqGyao5zxrhgI1UU8XNVZmPvoIsLaTU2Xj
   eDy1xsMtTu2vd7pWvJshIXB/RMA/+yR5S92RIF0kyEnBEkk6DHL+mWQ5a
   +6T0sfkqNwtD6R6vk6p3yr5TvXddxZo+ORzCwUTbi4h6Ey6/qzomkwTa+
   w==;
X-CSE-ConnectionGUID: d9fgcxzXTJuyNXjDNG1Wvg==
X-CSE-MsgGUID: UOZArcfYS029OBTJ5bdr9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45356799"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45356799"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:51:19 -0700
X-CSE-ConnectionGUID: +tuUeOkeRIurk9EF5b6iqQ==
X-CSE-MsgGUID: B8/dhCOxSfatSDXpCylsuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="132764938"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:51:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1u1rYx-0000000AASv-0uIV;
	Mon, 07 Apr 2025 21:51:15 +0300
Date: Mon, 7 Apr 2025 21:51:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saket Dumbre <saket.dumbre@intel.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: ACPICA compilation error on x86_64_defconfig (W=1 build)
Message-ID: <Z_Qeot7pps5Q4vx7@smile.fi.intel.com>
References: <Z_Qd0x6bLSQjJ7Rw@smile.fi.intel.com>
 <CAJZ5v0j2Y3vPZhUGJmcWzn6esg9zv5an0KPEN4QfQuyGrd5=YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j2Y3vPZhUGJmcWzn6esg9zv5an0KPEN4QfQuyGrd5=YQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 07, 2025 at 08:49:41PM +0200, Rafael J. Wysocki wrote:
> On Mon, Apr 7, 2025 at 8:47 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > v6.15-rc1 (but seems older should also be problematic) fails to compile by
> > Clang 19 with `make W=1`.
> >
> >   CC      drivers/acpi/acpica/nsaccess.o
> >   drivers/acpi/acpica/nsaccess.c:295:6: error: variable 'num_carats' set but not used [-Werror,-Wunused-but-set-variable]
> >     295 |         u32 num_carats;
> >         |             ^
> >   1 error generated.
> >
> > I looked briefly in the code and I have no idea how to fix this, as probably
> > __maybe_unused not an option for ACPICA. Hence this report.
> >
> > Note, the in-tree defconfig is in use:
> >
> >         git checkout v6.15-rc1
> >         make x86_64_defconfig

> >         make W=1

Since it's a clang, this should have also something like LLVM=1.

> > should trigger it.

-- 
With Best Regards,
Andy Shevchenko



