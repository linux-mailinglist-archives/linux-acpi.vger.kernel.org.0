Return-Path: <linux-acpi+bounces-18115-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 266EBBFDEA2
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 20:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CE33356FE5
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CEB34E761;
	Wed, 22 Oct 2025 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTto7CpE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3A34D93A;
	Wed, 22 Oct 2025 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158678; cv=none; b=gn2gydPR9gNorQTMR9zyn9BGn0/q/YCV3N4thDa/hOl6h/EHvxnwS9D/BuaO4euTZ91s21gZwOiPfDFKh0KMzuacSHsNEMzDX6mIowVTN3zMt4LAjIVPuH/hlMzCbrtOHgYHF2JlUYXCkQwQu4uUFG0xeTn89JGvng0hYEigPb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158678; c=relaxed/simple;
	bh=QwwtWpy3QSLzBXAJcPsDhpKT2HlCArvX9fz+YfxbgSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq2H20q+99vEUoxKSmQWRMjqOjHzT4rX78psFNRikfEEsZCHIHb/cVe9SFkm9VUszGmfQSVn/PqPAjWp2FkOcZqvA97y6pm8imd7RmsDZ1UlLswkWSrLDTeI9hk18KiDHVcmCsP6Foj5OS7iWU861o/boV7yhsQgT1XhVysJkVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTto7CpE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761158676; x=1792694676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QwwtWpy3QSLzBXAJcPsDhpKT2HlCArvX9fz+YfxbgSU=;
  b=LTto7CpEqIMsNTycBp5DxvmowOe34M6m5moyB9jMr1HsksKwBIEsx3Cw
   VajidfQ7uiJer8kUUa058oCVuishlB5Q9SDgLVi8frb1Oeq7OykPdlVZm
   DVaUNlJqGqfzTN+dmm4ciuNfBWDEznkge1eu2LBdvEcEJkrlFnChlrPtJ
   F6LFY5IXDvGJ8sBJYGbMOuFNP+cNhNJguMk3pKTliMFVfrMeulXCZEV+7
   OzTfy7mVUUX+f9KQoVNYx3RZd33CPE1J7HwW+HJcFyo0JCJDj6O6sNpJ3
   3oqxfDdn82TTldKAXyRHj2Ystcm6GSUgygE08SVulCp1G6nbc47jLsoU2
   w==;
X-CSE-ConnectionGUID: haEABsddRpifzNuCzn2zSQ==
X-CSE-MsgGUID: skyAlNBWQNijMDz7Iqg6KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88784637"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="88784637"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 11:44:35 -0700
X-CSE-ConnectionGUID: JJHfiBNIRQOnAJqQ8IIRWg==
X-CSE-MsgGUID: khceAgKZSfmLeR8hpdgxTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="183843979"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.83])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 11:44:32 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBdoz-00000001lgl-1nLp;
	Wed, 22 Oct 2025 21:44:29 +0300
Date: Wed, 22 Oct 2025 21:44:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 4/9] gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup
Message-ID: <aPkmDWJEKrjlMPnD@smile.fi.intel.com>
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
 <20251022-reset-gpios-swnodes-v2-4-69088530291b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-reset-gpios-swnodes-v2-4-69088530291b@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 22, 2025 at 03:41:03PM +0200, Bartosz Golaszewski wrote:
> 
> Looking up a GPIO controller by label that is the name of the software
> node is wonky at best - the GPIO controller driver is free to set
> a different label than the name of its firmware node. We're already being
> passed a firmware node handle attached to the GPIO device to
> swnode_get_gpio_device() so use it instead for a more precise lookup.

...

>  static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
>  {
> +	struct gpio_device *gdev __free(gpio_device_put) =
> +					gpio_device_find_by_fwnode(fwnode);
> +	if (!gdev)
> +		return ERR_PTR(-EPROBE_DEFER);
>  
>  	/*
>  	 * Check for a special node that identifies undefined GPIOs, this is
>  	 * primarily used as a key for internal chip selects in SPI bindings.
>  	 */
>  	if (IS_ENABLED(CONFIG_GPIO_SWNODE_UNDEFINED) &&
> +	    !strcmp(fwnode_get_name(fwnode), GPIOLIB_SWNODE_UNDEFINED_NAME))
>  		return ERR_PTR(-ENOENT);

Now we might get EPROBE_DEREF for the cases when previously it was ENOENT.
Why is this not a problem? (I haven't found the answer neither in the comment
above, nor in the commit message)

> +	return no_free_ptr(gdev);
>  }

-- 
With Best Regards,
Andy Shevchenko



