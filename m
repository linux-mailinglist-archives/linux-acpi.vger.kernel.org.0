Return-Path: <linux-acpi+bounces-13793-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A172ABBC17
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 13:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99E57AD4A2
	for <lists+linux-acpi@lfdr.de>; Mon, 19 May 2025 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60868274FEA;
	Mon, 19 May 2025 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YU/iSb4A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD126274650;
	Mon, 19 May 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653080; cv=none; b=ZUURORT7MyLOWRCOgyBaAAcy300NBZ9d4/uj+ygBCjuPyEuuYq6QkkH6AlCBy3yyfKhE4K2ITEqeCKlp6AlEE27+ijly6NoYCyvQFv2fBO9dDNP9VW7c5FvZmCmjolsFj3stWgS9rteTpxNjwz5Usa39hzLDnyTZqxFd0wMz9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653080; c=relaxed/simple;
	bh=5GtwPu1XQ8TBmmNN1t4iGr9B5teXkDVj+yP0t4kr79w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6nsPDt7xIbFFWjDyiv2s9JJYis+0YG+rwTFES6ng2yNS3LQY8hiB8uMbk+qhkSgeGHeEeIEVPgeINi6GJWuaiJHBHMiBl3cKhRCdwbxvRCAro8NKpkJFXNXBc8tTbbQhSOV7Y0l2rm6WX2AzKBl800jOaZQkRPfazv5osVaW1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YU/iSb4A; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747653079; x=1779189079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5GtwPu1XQ8TBmmNN1t4iGr9B5teXkDVj+yP0t4kr79w=;
  b=YU/iSb4ADYBsbxRcqxlDdXP8XDuWhbveGHUdqO8gj/jHWCCQf9ygyj1N
   SfhHywjPa9fY7dKIASAElRgEDSD+k3B8WRwHAToVF0GitiBazKNFh5zPi
   kgwbZzdDuVTOcJ7e7FDBlVeikJrem7aM/nydnb2HmYUwHqDMZUsHDEWe3
   l3srfXhrIVp9rOBm6C5D2nojitRF88gBBbUVSQy3z7dguULpSZSbqckx7
   E/5BvOxSMOmwke3KTXwlzLz+PY3akbmN6bz+/jDCj50ZyhRvUongRg5B2
   pqS1NYQ/k3vRqrhmYLu9cr7Hd91QmC/sQknhz9t1R9LEwWD2mOnrgOPHS
   w==;
X-CSE-ConnectionGUID: yGEakCBkR+e/x4IIddW+eg==
X-CSE-MsgGUID: L+dUplC1RvyGVQz/GAjuwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="49423205"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49423205"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:11:18 -0700
X-CSE-ConnectionGUID: k6PdiH+WS4uQi5W/EicJTg==
X-CSE-MsgGUID: ct0eKy6ORY+aLYZ2G5rkjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="162630146"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:11:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uGyOn-000000030td-3SOw;
	Mon, 19 May 2025 14:11:13 +0300
Date: Mon, 19 May 2025 14:11:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in GPIO ACPI SUPPORT
Message-ID: <aCsR0Y76nGTd2ZPf@smile.fi.intel.com>
References: <20250519065557.659674-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519065557.659674-1-lukas.bulwahn@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 19, 2025 at 08:55:57AM +0200, Lukas Bulwahn wrote:
> 
> Commit babb541af627 ("gpiolib: acpi: Move quirks to a separate file")
> splits drivers/gpio/gpiolib-acpi.c into two files, gpiolib-acpi-core.c and
> gpiolib-acpi-quirks.c, but misses to adjust the file entry in GPIO ACPI
> SUPPORT.
> 
> Adjust the file entry after this splitting into the two files.

Thank you for the patch. I hope it will be fixed starting from today's Linux
Next in the commit 288c1516ca11 ("gpiolib-acpi: Update file references in the
Documentation and MAINTAINERS")

-- 
With Best Regards,
Andy Shevchenko



