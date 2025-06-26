Return-Path: <linux-acpi+bounces-14694-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA02AEA09A
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 16:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE01188F83C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357772EA48F;
	Thu, 26 Jun 2025 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/ZUMFdB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB62F1FF0;
	Thu, 26 Jun 2025 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948289; cv=none; b=uZSDtLXrGvDryWzIoV5whtpRAfHmtVkLL4BaInN75B2kfbvbct4Kk8oUKucu1XIQC7UriRnUkElHzSvgDeFMnaT7P26e06hU/r/9JCOXHOiDSzh+MI17JaWxQAjrDYm51RVl0T/QTvr3GbBzQcrfFqrK+eF43rWGNjAxcAOwS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948289; c=relaxed/simple;
	bh=U5ICrpyiR4bA8dcmlzmWK23XdE586puy7xMo5vIe3zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkxbJRY1aN/g0c6hIQZKHKVi6SeRw8oeKWEHNPsZjsBEw8CJdKsX1NnySk9j4rp6lbW1culDHRa6sfMlJB4v85LAI8CvrmLtD4RArJuS/phM631Zw3SNwjcgN/BScTSt33lBD5mj+Y7yHYOwsUvHkgagnh7UP1uhVDOGPhfJ0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/ZUMFdB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750948288; x=1782484288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U5ICrpyiR4bA8dcmlzmWK23XdE586puy7xMo5vIe3zs=;
  b=L/ZUMFdBoN3bQaSG/uneu+6Fm+Pya7t+mIi/OtOd7EwPOYtD5XY/EsMa
   J2kyGhiPP8dcnA5+eZxwvNSxi37zjvZ6WSC6grRQ6NFyzGb1EnjK+4106
   t6hJvGsj+qwjD3S+jTfZhFSQi276OIf+iNjZUyDPWPxMrIJiBinPy5OaM
   0oG3KuBFQNNTFCbbYt1aVhcx9ocYOeKo1Bn3yxVQvOwQAfF6GZMEJX1zh
   1xqjJZhRBWXUNp9Fg0oZ1P9/u2BpdG07zkFowVbucII7yC+TurICVyLgy
   dyVESbD9NVLIhimw2Om+uZ9stZBRs85mpJl/8fXlEjpgcvsxn/A5/74fw
   g==;
X-CSE-ConnectionGUID: F0Ka+eSnSEGTmEk+xnNyRA==
X-CSE-MsgGUID: GxQA7cJmRWmS1nQ/OjLB8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70676029"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="70676029"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:31:27 -0700
X-CSE-ConnectionGUID: Be/jHUObS2WHzTSOfG8Crw==
X-CSE-MsgGUID: HMGY6vjTShaQ8a/b3Rgc2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="157096650"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:31:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uUndJ-0000000ACV4-0Lf0;
	Thu, 26 Jun 2025 17:31:21 +0300
Date: Thu, 26 Jun 2025 17:31:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 2/4] gpiolib: acpi: Program debounce when finding GPIO
Message-ID: <aF1ZuGJgXK7IW__-@smile.fi.intel.com>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625215813.3477840-3-superm1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 04:58:11PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> When soc-button-array looks up the GPIO to use it calls acpi_find_gpio()
> which will parse _CRS.
> 
> acpi_find_gpio.cold (drivers/gpio/gpiolib-acpi-core.c:953)
> gpiod_find_and_request (drivers/gpio/gpiolib.c:4598 drivers/gpio/gpiolib.c:4625)
> gpiod_get_index (drivers/gpio/gpiolib.c:4877)
> 
> The GPIO is setup basically, but the debounce information is discarded.
> The platform will assert what debounce should be in _CRS, so program it
> at the time it's available.

No objections, just a style nit-pick.

...

>  	acpi_gpio_update_gpiod_flags(dflags, &info);
>  	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);

+ blank line

> +	acpi_set_debounce_timeout(desc, info.debounce);

+ blank line (this one I'm not sure, need to check the other function style).

>  	return desc;

-- 
With Best Regards,
Andy Shevchenko



