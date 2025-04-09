Return-Path: <linux-acpi+bounces-12915-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A67AA8292E
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 17:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C751BC286F
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D457226770E;
	Wed,  9 Apr 2025 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pe5gwDei"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3BA2676F7;
	Wed,  9 Apr 2025 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210207; cv=none; b=dTSRgX5xxZq4bPTE2+oy1cAheEg1eft11K1eIxNTDxS0LhXoS0Az6syIlP/m8aJBUxKKhotckcCxJZT8dFJUBlamrf1e5JOm6BRMJCOFZJH2/kVN6GOGgQDwx8aDXTgmN/j+p4OXs+P3drg11rKwII9fdml/MYbk40MXKu+SMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210207; c=relaxed/simple;
	bh=Cz0c1otcz5ivBtfWQnjKI3YpuR7rHan3cgUck1PboH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKbBX8MF3/3cibKEKa9MS+cq1H9ZOokyQfMZFt1v66UxurmpTai89APC3f1KD8q9eLTTrIk5QXY32LltHKPMXhg05ZLrjQQMS/lFGE3OUlGIVOjhC/u7O33IzWtqYOi2ovrmjYY8lU6UmO1sgwjmGPHfB2H3XUhJdA8XK2ZbYMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pe5gwDei; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744210206; x=1775746206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cz0c1otcz5ivBtfWQnjKI3YpuR7rHan3cgUck1PboH8=;
  b=Pe5gwDei7ZA7gyHQWC/5b/+9mN2uiYETf0wYdqFgC9EKG2ffdZ6gV9HE
   N0WxgNxJvHOOOV3GNOtHJBCjFqxN2HbyUd7zX8yfEDJ9YsShhlEsBfb66
   RPoKXutepKErQuIz5Rl2dSDCbpq7CpX0rJhqiOrse5JGAsUwM/A54SVNC
   ZIsA5jJTRTuY9I1YwjLCDNt1BUI6mMryESVZfvV0YHQ2SCx3DF1ozNUZR
   Gyn5bXRXHMgyv7hje+qtR8163T9vbSAY1+rXUouu/9DLT646BDMi5sVRS
   4iWJq0rxvV2r86RQozNUUx/ZjVnF2Z1NxhTXfmWN4rX6ZAHV7YK5oUUyE
   Q==;
X-CSE-ConnectionGUID: /8YIi+OxS7mTgTrY9/lRDQ==
X-CSE-MsgGUID: WlGOY/HYRqmPsfH/h3yrdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45814560"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="45814560"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 07:50:04 -0700
X-CSE-ConnectionGUID: UOpZGCB0RiO368SS3Fd8vQ==
X-CSE-MsgGUID: N3FzkT0/R0OymyamC9Mkiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="129442429"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 07:50:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u2Wka-0000000AldU-15on;
	Wed, 09 Apr 2025 17:50:00 +0300
Date: Wed, 9 Apr 2025 17:50:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 0/2] gpiolib: acpi: Fix missing info filling
Message-ID: <Z_aJGKjVfKtc18Zk@smile.fi.intel.com>
References: <20250409132942.2550719-1-andriy.shevchenko@linux.intel.com>
 <20250409134443.GT3152277@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409134443.GT3152277@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 09, 2025 at 04:44:43PM +0300, Mika Westerberg wrote:
> On Wed, Apr 09, 2025 at 04:27:52PM +0300, Andy Shevchenko wrote:
> > Kees reported that code, while being refactored, missed the point of
> > filling the info structure which supplies GPIO flags to the upper layer.
> > Indeed, without that part the GPIO expander get no IRQ on Intel Edison,
> > for example. Fix this in this series.
> > 
> > Andy Shevchenko (2):
> >   gpiolib: acpi: Use temporary variable for struct acpi_gpio_info
> >   gpiolib: acpi: Make sure we fill struct acpi_gpio_info
> 
> Both,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



