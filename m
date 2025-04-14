Return-Path: <linux-acpi+bounces-12996-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2593A8781E
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 08:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5F13A735E
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 06:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E1A1AC891;
	Mon, 14 Apr 2025 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqNq0tQ7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C04C74;
	Mon, 14 Apr 2025 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613273; cv=none; b=qiLfID4Uje5bv+0Xrk0EGPuwTF3+TQUlVqhs+hZicr3mR6bsTnjBP7YBPG6exbWC6O08iyG0TDHwZzb0P8Ppj+OOW5v0P4OwFNGBO5M0gWK63xHpmzENsSe0VLsdjvAYDPMS0zfHM7FKOR6gy5hR2mvt+HbGgvXmYytA4Qdf7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613273; c=relaxed/simple;
	bh=NnvFhqzJp+sQfGYnEmXYlEqZg74684Lg4+6wpOpPkYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7V+ioY3iPqbRl75OD1Itxt2869EZ8mf8lDWWVPonMvCYh7lqeehhLs/pA9fl7Ch3boiH2AJWW5HNaiElwcWMus9Aq/lYr0nWE5hth7oF16B7N9C3ISqOku3J/5v4T6nAKtJWDrUt8r3S6+FWb57mFmIcuCSGDmMWPSWKvkiCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqNq0tQ7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744613272; x=1776149272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NnvFhqzJp+sQfGYnEmXYlEqZg74684Lg4+6wpOpPkYU=;
  b=UqNq0tQ7eUTubYRMBHMkqYB93mJ+VX4u7AZwrf63NF51rDWZA69/dkiv
   Xh8BglPQp7HfFqy9LFkroGEZxaR9gTyXcZ5kIiGQkwr3pchvNOw6NHIGV
   MZsphRq9FCFJLy7O1D5rmEGIH775yk1ulVrre1p91k4tGGJuGwSWfjEOk
   2mOfb9920tLctR96HhgMtMyOR13/xFFTl9xxy1Pa19RDj+sB5wE4EMsWZ
   oOzUBu4hRdMK98EHx0YApR+2QcWGdcX57X5eqpIxTMgO1jLO5pD4RGeRo
   JtE63cJ1rLo9oO/bSlSY3iuVHBgAFhBcT1ElvdS06zQ3FPuX5nAFhAS8M
   A==;
X-CSE-ConnectionGUID: nyWqEV8jRfSFIH1XP5T7yA==
X-CSE-MsgGUID: JRb8TcGoRyCW6EooR9p7sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="46232217"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="46232217"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 23:47:51 -0700
X-CSE-ConnectionGUID: crWPcHSdT2KU4PmWj4rqAQ==
X-CSE-MsgGUID: 5l5K5hKjTPmdNeVpbS6qvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="134702329"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 23:47:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4Dbd-0000000C9fc-1CAO;
	Mon, 14 Apr 2025 09:47:45 +0300
Date: Mon, 14 Apr 2025 09:47:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] property: Use tidy for_each_named_* macros
Message-ID: <Z_yvkKTgI4XSlGya@smile.fi.intel.com>
References: <Z_ew4DN0z71nCX3C@mva-rohm>
 <Z_yvNl23GcEpOkK1@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_yvNl23GcEpOkK1@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 14, 2025 at 09:46:14AM +0300, Andy Shevchenko wrote:
> On Thu, Apr 10, 2025 at 02:52:00PM +0300, Matti Vaittinen wrote:
> > Implementing if-conditions inside for_each_x() macros requires some
> > thinking to avoid side effects in the calling code. Resulting code
> > may look somewhat awkward, and there are couple of different ways it is
> > usually done.
> > 
> > Standardizing this to one way can help making it more obvious for a code
> > reader and writer. The newly added for_each_if() is a way to achieve this.
> > 
> > Use for_each_if() to make these macros look like many others which
> > should in the long run help reading the code.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Thanks for cleaning these up!
> 
> > ---
> > The patch was crafted against the IIO/testing branch, and it depends on
> > the 76125d7801e5 ("property: Add functions to iterate named child").
> > Hence I'd suggest taking this via IIO tree (if this gets accepted).
> 
> I'm not sure why. The for_each_if() is part of v6.15-rc1.

Ah, I see, you are trying to fix newly introduced stuff? I would rather suggest
to make this straightforward against the current upstream and ask Jonathan to
rebase the testing to fold the fixes into a new APIs.

-- 
With Best Regards,
Andy Shevchenko



