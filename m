Return-Path: <linux-acpi+bounces-12774-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D1FA7D459
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 08:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76E43AAD62
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 06:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60A2253E9;
	Mon,  7 Apr 2025 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWfKNRQj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B12135A4;
	Mon,  7 Apr 2025 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008109; cv=none; b=IHMXjnsmvqeFTMxFwdk+AiIe9j/GXapSzXjO9MDglAGwMuyZk6Z6w+QDDBmZRYITKVKznX1ra7zdBOPpSk/NX/rMJPrSFEUDJngfVifEG/WiSmOLc7FHuLfCdH8uGkby1UoV9+07mZH943eSFviV2iy73nBRiWm403aQCz15WGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008109; c=relaxed/simple;
	bh=PCQiGG6B2DNaakC53prIZJdI+gBuGzvVt2GLvpU+2cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTGBA/v3X/ej8jxDBOouuXn83CtoFkCXqp94DWRftffZ4dDuM/I2+sGV2BL0aHPnAeUq00oyk85eLvd498SEpFsRRNcKOiJQgwztoLfMAfmWnx6m3dztNEpOYyVLjozC80l+3+l/sDYFwkQ7/hqj6WU4XWdZR7Cpw8pKZ/kJ1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWfKNRQj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744008108; x=1775544108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PCQiGG6B2DNaakC53prIZJdI+gBuGzvVt2GLvpU+2cE=;
  b=gWfKNRQjv7tDSGmUXG0+teaqCvd1+vV2KP0WX7wzDcnivYdYKWDWt/zj
   kGnq/KKlUEPlx7fHskHlu220fYFrneVXjm3W9H/KEeosPUzGEboJMxud5
   JWwhhAtC7LGI7uEJZHHti5Hg885Q6Okc2glezjQKb6AXffGzUVQ9UMWnf
   JlQb5bGpzzMBBjJ8ZYTJa5TQkGvFlXBTIAzd+2TQsN1C0anc3JDcThiiZ
   cgwFaQ4ZDozJH8qf6BKZKho3hthnu9DDESgwvDnYVOdpXZ73BeJFZoP3r
   UP17hmtt3eq6ks5Yvq4j6oXyLzYcgWIuPbaM9wJKEiqJWeRXtTmRuCm+F
   Q==;
X-CSE-ConnectionGUID: CSJ9rAG7T82RQ6MVRr6EVQ==
X-CSE-MsgGUID: kOVNx4PGSA2YfHVL9G2xuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="56739012"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="56739012"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 23:41:47 -0700
X-CSE-ConnectionGUID: 4PuUPLd0TvK25LbH6hG7Nw==
X-CSE-MsgGUID: RR+H+9wGQgGAI79CRQ80Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="158831349"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 23:41:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u1gAv-00000009yco-3xUB;
	Mon, 07 Apr 2025 09:41:41 +0300
Date: Mon, 7 Apr 2025 09:41:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 0/6] gpiolib: acpi: Refactor to shrink the code by ~8%
Message-ID: <Z_NzpTUiXMPffXmI@smile.fi.intel.com>
References: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
 <20250404044318.GL3152277@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404044318.GL3152277@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 04, 2025 at 07:43:18AM +0300, Mika Westerberg wrote:
> On Thu, Apr 03, 2025 at 06:59:11PM +0300, Andy Shevchenko wrote:
> > A simple refactoring of the GPIO ACPI library parts to get an impressive
> > ~8% code shrink on x86_64 and ~2% on x86_32. Also reduces a C code a bit.
> > 
> > add/remove: 0/2 grow/shrink: 0/5 up/down: 0/-1221 (-1221)
> > Function                                     old     new   delta
> > acpi_gpio_property_lookup                    425     414     -11
> > acpi_find_gpio.__UNIQUE_ID_ddebug478          56       -     -56
> > acpi_dev_gpio_irq_wake_get_by.__UNIQUE_ID_ddebug480      56       -     -56
> > acpi_find_gpio                               354     216    -138
> > acpi_get_gpiod_by_index                      462     307    -155
> > __acpi_find_gpio                             877     638    -239
> > acpi_dev_gpio_irq_wake_get_by                695     129    -566
> > Total: Before=15375, After=14154, chg -7.94%

> Looks good now,
> 
> Acked-by: Mika Westerberg <westeri@kernel.org>


Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



