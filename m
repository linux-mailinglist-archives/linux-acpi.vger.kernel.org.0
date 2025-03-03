Return-Path: <linux-acpi+bounces-11736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B337A4C680
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 17:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0831C170292
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 16:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1CC23498E;
	Mon,  3 Mar 2025 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fU2yHPpv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317AC21B9C3;
	Mon,  3 Mar 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018168; cv=none; b=XJ0P+pfR08YVpHDoeIjSoGOFbGgzglfcOsp15CMC1MYHzKbiUM/MHOra7Fq9bV1eDtwDY8IE8aTOChpTK7em+D+0CVJJbmPqurdLF4HIzzXN1Ji4eVm8STU06M7EWkl88uHjt+x5UDxVkfV13PN21bWhxYgwu6rnggXLjrzNtAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018168; c=relaxed/simple;
	bh=Bbur522PKr26lQbrZOuRbC4ZeP7+GMbA+yItAhu0OzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jb8cFzeAdrYFqFLO1QDeibyP+fToql5LDIvqdN4qaeEtrzE2la2clQc5l3U222fkaFVU3noc4DQDvYc+vWAj754EUJi/yOIhZ8msO9ESr/EOVbS7Cn0PLHTtxmAGmBSx1Rh/kEdOZAVPj4olMe8MUmt277dns+FRFE4+JFzZpK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fU2yHPpv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741018167; x=1772554167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bbur522PKr26lQbrZOuRbC4ZeP7+GMbA+yItAhu0OzY=;
  b=fU2yHPpvMk2JVU32C70zwaDT/0Wb9hzzp/VnQXxZklenSE2uzd5Tfypx
   wfGUGnrZZ/2mfXd2HKanJwxuLMvwe9TlYngiTXYUs/7PgNf6lPO0XIj7b
   bQGIAx0SOUCQ4Xe16fAjrRcoZiRs8IXY6AJ2SRKXC4lpUZzKTrdyCn94s
   cg37+fUE6Bmrhn+zLFeV74xvABVc3OPp2k2nY+XZVaDfooAwzztgVtvve
   KwAqAeOqWK4YqxlYHRaovrTNbuckxMFGzABn1ce9+Cjv5vWw/pdJbc6Zx
   AvlYgEypf2cONScMxG5/49wYa3G/EqmrXe00RjYc9j+dQojcm7cH9STZ8
   A==;
X-CSE-ConnectionGUID: y7F99MkNRUGvuifpG3+02w==
X-CSE-MsgGUID: Sq3p52W7SJKBKxaF41fi/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52878159"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="52878159"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:09:26 -0800
X-CSE-ConnectionGUID: INAV7lvPQAGOgLyCQawUfg==
X-CSE-MsgGUID: cN8iAshRSJiqrvq4nqT8vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="118065042"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:09:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp8M5-0000000GrJe-45zn;
	Mon, 03 Mar 2025 18:09:21 +0200
Date: Mon, 3 Mar 2025 18:09:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v1 3/3] gpiolib: Rename gpio_do_set_config() -->
 gpiod_do_set_config()
Message-ID: <Z8XUMRAlR3H13zha@smile.fi.intel.com>
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
 <20250303160341.1322640-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303160341.1322640-4-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 03, 2025 at 06:00:34PM +0200, Andy Shevchenko wrote:
> In order to reduce the 'gpio' namespace when operate over GPIO descriptor
> rename gpio_do_set_config() to gpiod_do_set_config().

This change was made against my custom tree and I forgot about that.
I will wait for the overall response to this series and if okay I
may issue the correct patch.

-- 
With Best Regards,
Andy Shevchenko



