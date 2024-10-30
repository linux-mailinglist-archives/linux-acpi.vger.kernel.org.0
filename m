Return-Path: <linux-acpi+bounces-9137-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0D59B6B04
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 18:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F3BB20A94
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 17:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09981198E89;
	Wed, 30 Oct 2024 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eblCK4/+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980301BD9F8;
	Wed, 30 Oct 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309485; cv=none; b=X+km8/6W6GTDIYGmVqAU8HRsUUgvfRnfEYxhVHiIgE9a7ePl55/BmzN/0e01DvaV0WxIW2/UyClYlAMTywTt3UC6zebh+ECJIlw6IpG9iaa93ln6Ko7n/LKRvXS/IneCtzcXN/VLuKD482p0gg6e0HYxBIZtum069uREIgl0zu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309485; c=relaxed/simple;
	bh=6jimK2Rs9bsOHVdKo2onra9aRBEI9duWzKEoauQJTv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e47bxx31bPRLS4i7nOF+t05cjZs+AKxUz6nvuHixWjjiqWX2Rp0UzSChlHFzVoew7+0QLeYdidCD+bUQxXEtXglJ0+8pL0HCTkfy9nrh+0VmbPzpvZhOhdngFm7NW+fIPBG8xpMIqDPYBTTvv8Yv0EvrAYWqsa+4IpjWC4kCa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eblCK4/+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730309479; x=1761845479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6jimK2Rs9bsOHVdKo2onra9aRBEI9duWzKEoauQJTv4=;
  b=eblCK4/+GUe3DpZE1OwIKzLDc8GSz2Yfi15uOxcYIg8V5fzrfdDsB/Cw
   e+So4IBJ/VbK1gHfQQWP9TaWfAbe0HiT/cZ5z7sGU26jvglLAi6P52AxD
   0EsThBsoGFhJoh5FxsaaJrnRhEtRPtGos/yWk15sW9+yeCrTiFyktekEP
   Oh8Q22ab3WExoewa5qBflx/gulsJwNkFN15zFWhpvUSTujr61njZvffXV
   it45LPMNXdQhWjZY8F4zzGkSSG0AWG4SnzEHWI813V0gsLYFQkeJMHrmR
   zig/1LZPi95rU4mKmQX9uhdbnNSkuwii7VgXvXiruRqvPgxRGcA7URN5u
   Q==;
X-CSE-ConnectionGUID: KJFDdXUBS46QumQ/7mgwhw==
X-CSE-MsgGUID: k3PiAY1cSJKe6r+NJ4RI+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29880697"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29880697"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 10:31:16 -0700
X-CSE-ConnectionGUID: ZLanJ1rIQx2+LFw00Z7EUA==
X-CSE-MsgGUID: ageelKuVTiaAlOq8kof67Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82808611"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 10:31:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6CXI-000000097J6-0w2b;
	Wed, 30 Oct 2024 19:31:12 +0200
Date: Wed, 30 Oct 2024 19:31:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: battery: Check for error code from
 devm_mutex_init() call
Message-ID: <ZyJtXzIReSHfKkd_@smile.fi.intel.com>
References: <20241030162754.2110946-1-andriy.shevchenko@linux.intel.com>
 <63b16433-9f80-492f-9389-633a9852a223@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63b16433-9f80-492f-9389-633a9852a223@weissschuh.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 30, 2024 at 10:42:18AM -0600, Thomas Weiﬂschuh wrote:
> Oct 30, 2024 10:28:03 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

...

> Assuming you found this via some sort of tool and you already fixed up all
> the other places in the tree missing these checks,

The tool is called `git grep`.

> wouldn't it make sense to mark devm_mutex_init() as __must_check?

It's macro, any idea how to do that for the macros?

...

> Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Thanks!

-- 
With Best Regards,
Andy Shevchenko



