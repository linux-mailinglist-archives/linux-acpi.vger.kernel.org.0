Return-Path: <linux-acpi+bounces-5734-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C088C2719
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4632816D2
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CAB1708B1;
	Fri, 10 May 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6M65UEp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00B168AFC;
	Fri, 10 May 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715352381; cv=none; b=i+BqwmF1bQL5F55Lg9Pvi/m7xHWjEhnPCgyRCXgIv/SIOFJoPfiiQLDqm2/JWKka0NQpvb+hARuwSDLDqsLMj4bo2DGLyD8Ww2a58OOkkwpCzoNYhEl5S0dTJgPsIYIhmglh3WpZRgXqzo1glWcX8q2z8LcIPCotr8AjQFZbIZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715352381; c=relaxed/simple;
	bh=PiJqpHpxECsvIuqM1iLqQKFUGF/+tlUVyGz3yiigaxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN4QDnp+cxd8vvqkvT9xCA5Mms3qj0PN6JlqQAUcdNGmGDzuw443iTMk3V5xbwF9xQq5rrFU26usFXLTFZX9geiZMxWNG8GuZOYADScrABzTbMFFXgGYqR4LI/4b9ir5CLBBtjsua+CBY8CgFHtUi7jtxrHNgv0tVtS/00leelI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6M65UEp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715352380; x=1746888380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PiJqpHpxECsvIuqM1iLqQKFUGF/+tlUVyGz3yiigaxc=;
  b=e6M65UEpiVRZGk0vyMlIXzGZUZKg6wH/jXjxK2BE7w7J4vp2bJt0c/7m
   IXqdspOLU7ReSCBVN8yIupzT9f+RjgWaaUul5sXjXCbqcqngkrVt+wW9N
   4FCLHrHr2GBKRCVBqQf8Q+LKV1PGQ/cXjwBh95OSDjM7/e7FcGapepCvv
   /kJ47Z0RM6uDiwbHVJwptQcsT+0O+X2rH7Xc22hwZsIqiSNVi1+3+UwmR
   ei3JjUhMS8yEMTEfKwk0A7TVnMb+aqe1d3DEMcvZuZq97mYdz6QHaX9Qc
   qgGCpdozTk2a0oZ6eSxe1Ze8Jr1xdwsce5Cqywjyag+vW+mAEqBi+r7F6
   w==;
X-CSE-ConnectionGUID: kLZfFGoOT6mNfacOOXS0Sg==
X-CSE-MsgGUID: kwqZNo8TT6i7RG+TKneDYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11186325"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11186325"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:46:20 -0700
X-CSE-ConnectionGUID: JXtM5Uk0SgKoHE4imzvCnQ==
X-CSE-MsgGUID: vDUdxz2dS/2Nxpe5MFM+EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34284943"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:46:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s5RVm-000000068IS-1O6i;
	Fri, 10 May 2024 17:46:14 +0300
Date: Fri, 10 May 2024 17:46:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Laura Nao <laura.nao@collabora.com>
Cc: mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
	brgl@bgdev.pl, kernel@collabora.com, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	"kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] gpiolib: acpi: Add ACPI device NULL check to
 acpi_can_fallback_to_crs()
Message-ID: <Zj4zNefxGUGKjxha@smile.fi.intel.com>
References: <20240509104605.538274-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509104605.538274-1-laura.nao@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 09, 2024 at 12:46:05PM +0200, Laura Nao wrote:
> Check ACPI device for NULL inside acpi_can_fallback_to_crs(), so callers
> won't need to.

Thank you for the patch, one change seems good to have along this.

...

>  	/* Never allow fallback if the device has properties */
> -	if (acpi_dev_has_props(adev) || adev->driver_gpios)
> +	if (!adev || acpi_dev_has_props(adev) || adev->driver_gpios)

Right, since it was adev || _crs() combined.

>  		return false;

Now we may remove that check from __acpi_find_gpio():

--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -988,10 +988,10 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
 	}
 
 	/* Then from plain _CRS GPIOs */
-	if (!adev || !can_fallback)
-		return ERR_PTR(-ENOENT);
+	if (can_fallback)
+		return acpi_get_gpiod_by_index(adev, NULL, idx, info);
 
-	return acpi_get_gpiod_by_index(adev, NULL, idx, info);
+	return ERR_PTR(-ENOENT);
 }
 
 struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,


As a side effect it will make the comment better to understand.

With above suggestion applied, feel free to add mine
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

You might need to rephrase the commit message to say that

 "We also move the check in additional to the moving the function call
 outside of __acpi_find_gpio()."

or something similar, up to you.

-- 
With Best Regards,
Andy Shevchenko



