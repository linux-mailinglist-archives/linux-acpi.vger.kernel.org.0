Return-Path: <linux-acpi+bounces-12678-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AD4A7A18B
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 13:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1BB7A6054
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131F224BBF8;
	Thu,  3 Apr 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVJ0kbxE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968291DF975;
	Thu,  3 Apr 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743678251; cv=none; b=KSPxhS5YbhYqXfREKPbJUeRjA9kP10zVFkdokLu3isF8d6WRlKXz2n0QmZdlkSZkh5RTgHhNGG0Zfc1E5ynuUwVNdPCm1GwSFfQop/36AylXUwDt0ESNVXAmUAx6bnom1HGgljd47X0rukm8hyJte8IMRq6QP6A+4Vmq35QFuC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743678251; c=relaxed/simple;
	bh=2QeHOZ6m87E61wZmiIQ6dYN/+s8hph8dBv0jhrWmjoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyKSeyWGF3tVXSIPc52mNNjZdoymGOc7M9b88Zhr9RBpM0C5hvReoUxTYQomKYkrliOv6N3m78BjzLYagwtSQJPVxlzwr1qhKfDxzb/8Q1Dd05X30TT9fBM4SX3pmu9gqE45Mmy1wlpvvMJs8JxZYyJaNyk1Fn8i0hpVEc6JiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVJ0kbxE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743678250; x=1775214250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2QeHOZ6m87E61wZmiIQ6dYN/+s8hph8dBv0jhrWmjoA=;
  b=ZVJ0kbxEImOnfFIzc/Sd+c/XeD5jvzYrhMyC2KsMiltVVZwqRWBMYKd1
   la/946NJXpcBhUnaoplO6y7ZGrrJBA6QL0Kghs+JItiYlICuj6+2SyHXv
   bEfF5cYdmgcTT0Og7s2tEZrYogcW67wP4xQnKs6VEHcHFjE1PXXHf3+zL
   raPQlphUrGrf8nY6rWEFuT5hTZRLq6jInMdx4YGpM+nw1e+xrPcJwzcYs
   1na2AvfyL3SBXCG8M6xNW6fEEi9l0IUw4D+O3AqqtdNZGerHERX7whBOa
   9WZvpdhjQyQDz66y/dEF7nEhaZxwDXjw+xzLc+e7h19ZuKctoh+qPcakO
   Q==;
X-CSE-ConnectionGUID: 0is1ai8CSPCvQpSK/Z8eZQ==
X-CSE-MsgGUID: JuX1BePuTfKYiUxG5NMUZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="48740823"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="48740823"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 04:04:09 -0700
X-CSE-ConnectionGUID: qSt/64BKQAmw5vyD1Khd4g==
X-CSE-MsgGUID: Q0DRHy/oQj2zZvNDnTCN6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="126779340"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 04:04:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0IMe-00000008mZK-11Kl;
	Thu, 03 Apr 2025 14:04:04 +0300
Date: Thu, 3 Apr 2025 14:04:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 4/5] gpiolib: acpi: Reuse struct acpi_gpio_params in
 struct acpi_gpio_lookup
Message-ID: <Z-5rJDWaSJd58lTa@smile.fi.intel.com>
References: <20250402122301.1517463-1-andriy.shevchenko@linux.intel.com>
 <20250402122301.1517463-5-andriy.shevchenko@linux.intel.com>
 <20250403103506.GJ3152277@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403103506.GJ3152277@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 03, 2025 at 01:35:06PM +0300, Mika Westerberg wrote:
> On Wed, Apr 02, 2025 at 03:21:19PM +0300, Andy Shevchenko wrote:
> > Some of the contents of struct acpi_gpio_lookup repeats what we have
> > in the struct acpi_gpio_params. Reuse the latter in the former.

> > +	struct acpi_gpio_params par;
> 
> params is better name

It's been already used elsewhere in the code. Do you want renaming there as
well for consistency's sake?

...

> >  	struct acpi_gpio_lookup *lookup = data;
> > +	struct acpi_gpio_params *par = &lookup->par;
> 
> These are not changed I guess so can this be const?

They are, see below. So the answer, it can't.

But I will double check and add const where it makes sense.

...

> >  		if (lookup->info.quirks & ACPI_GPIO_QUIRK_ONLY_GPIOIO && gpioint)
> > -			lookup->index++;
> > +			par->crs_entry_index++;

E.g., ^^^

-- 
With Best Regards,
Andy Shevchenko



