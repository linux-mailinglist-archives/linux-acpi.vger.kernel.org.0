Return-Path: <linux-acpi+bounces-15882-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 714D7B2F43F
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 11:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8D4188B5C8
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D7229BDA0;
	Thu, 21 Aug 2025 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrP0tRjk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E91DF74F;
	Thu, 21 Aug 2025 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769307; cv=none; b=tLNDRUFYoNZtMO+Fm9lJI1ntbMdOEgk8BujbmEh/wvZ4c1nOBDeW0S1fcOaXRqYCHgf/bSRbz66XMW/TqXjc5lwTqRn9UcFBR94Q94IbXy8V22I0GHvuVX01/HQQAZR2GVmfgqqP4MrJj/sB3bGC6uMK6O+wyGyhJ/FywaciZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769307; c=relaxed/simple;
	bh=8qvDfM5KuXtB5WWJHxoMuxu55HDyemsLUs1u8OsFRgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIyvSpk2a9ASl4lLFPrpWH6m39YrwcWkeVSZ2ddkZv4Kj3axILNIUi5WXvjcshdJy9hv/aDLICGFEUixrDksA12zHuLiF2r7ihxykwJi0pHQKyTToQBG0PZ5qZ++OwalLmtDKpaIECZipSVaCoLJt+z5TUM3jABFCQcRQY4V1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrP0tRjk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755769306; x=1787305306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8qvDfM5KuXtB5WWJHxoMuxu55HDyemsLUs1u8OsFRgk=;
  b=UrP0tRjkuH+ATeyHuYGSBRobLidQIkQFz/chXj9LFFFDyv0ZRGsp71Jm
   QOzzXaJSfxJJXL6vkl8nFWL6y0CRvCMPVCtYTi5FWcTautanpe/1nG5Qm
   EpAuR1CsUL8xk++dSqhCJztn/XgbTxlrLRYWS4pSY2TNAFVuTRJEXF0/V
   4wX9lDm3ibMMreVb1s69K4vx97mklaC/ErwqQEg8FNStBDvX5yuRWffG0
   K0vxc5H/2oaWTKFwzQuBHyjlD8eK0kgeulB2zdcRqySFJfPXEDPHdnd7p
   Ytzcy9xGV+nKMpldCWA8vyxjQwHJUD1Rb2Q7lMSYfh7519RCLpKi+6TR+
   w==;
X-CSE-ConnectionGUID: 3euJllX/TDG3ICgBsFvQ7g==
X-CSE-MsgGUID: S1qWKyBYTrSAzX7RXndD9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="80650374"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="80650374"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:41:34 -0700
X-CSE-ConnectionGUID: /lJi3n09RXmQV9M40wm11w==
X-CSE-MsgGUID: zc+cCRh1TS6D21KeDzmS8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="192053059"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:41:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1up1nV-00000007Bhv-2KI0;
	Thu, 21 Aug 2025 12:41:29 +0300
Date: Thu, 21 Aug 2025 12:41:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, westeri@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5] gpiolib: acpi: Program debounce when finding GPIO
Message-ID: <aKbpyT5wgfBtNfIg@smile.fi.intel.com>
References: <20250820233316.1433141-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820233316.1433141-1-superm1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 20, 2025 at 06:33:11PM -0500, Mario Limonciello (AMD) wrote:
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

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



