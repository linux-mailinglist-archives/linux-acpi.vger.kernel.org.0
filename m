Return-Path: <linux-acpi+bounces-12891-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA875A81E53
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 09:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21A57B40F8
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 07:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B3421D00D;
	Wed,  9 Apr 2025 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTR7db3e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA5125B9;
	Wed,  9 Apr 2025 07:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183878; cv=none; b=Wnh7HLnngLSHxmBWfvlFvbh7AnnLzPDFNm4IgpWE+S0Wb2r4Po6fRqMRPDSbRFDtARMic7+Si5QAgaU2uwrYzxpd0m5EU68F6rt8mvoEW9reUaML39kYpFKTRIe0zDsdKn8Mj37DNfp5RdxISjtOI6qPfLdro7KEAIstwA00lIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183878; c=relaxed/simple;
	bh=XJ4yiMlPFZ0E5bm/nEKVZBLSD9bRDLtD5zJNPS/i5kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4oskdEfWpI9KGoDs/pSidZfWvkTHR9Bv53COrKHfpp9vCTjlmBpc/aWn1up6fFrjkw81n4bus+WHPIGB1BCXNaS2wOcXpgynTFM0cQzu6i/6TG7QLawBGzgW6M8FME0MYjCL0juIvQ6yV/N3nH+SYBTa91G3WggjWYUK01BrvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTR7db3e; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744183877; x=1775719877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XJ4yiMlPFZ0E5bm/nEKVZBLSD9bRDLtD5zJNPS/i5kM=;
  b=nTR7db3etmAMslOlNgHA+ou+qyuSbjqY3YsmYlVLxjVUkn1F/FNpvwlv
   ugeQBA8KHaSTOiT1TdZ61w+cPqglyDLfS0aGCImbCOPFOKpn3KxNGYkYN
   hSe6DKoawBFqDFTWqb6wpsaXNCim9tPbUkdeLgjhzSbaFxh8BST5JmgDl
   MMeDUYOviwD5MbYRuNEAddLvDoFMwCQ7fvokqbMPa08HPDB59jmg5om4o
   jHlEIOecS5+OlrAhNoc+9Q6nXD9KVKk6SzCxvKv3ZE9HNSYjovYksTOKF
   TSc50zy9WKcwBH7AJurijOEj3ehcrReP6QotA4AkfuQ3gTg7RqP/v87Fw
   g==;
X-CSE-ConnectionGUID: xGhPT4WpR8K7cwKlTybv9w==
X-CSE-MsgGUID: P5lfAww8QfKZlLguzgwnVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="33249071"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="33249071"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 00:31:16 -0700
X-CSE-ConnectionGUID: axqmlmtWSTiV2ZNdem3GEg==
X-CSE-MsgGUID: SdZDg75jT7WkFzie1NHoSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="133219310"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 00:31:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u2Ptv-0000000AeSi-2NP8;
	Wed, 09 Apr 2025 10:31:11 +0300
Date: Wed, 9 Apr 2025 10:31:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Bakker <kees@ijzerbout.nl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 6/6] gpiolib: acpi: Deduplicate some code in
 __acpi_find_gpio()
Message-ID: <Z_YiP91I9ojNnOi4@smile.fi.intel.com>
References: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
 <20250403160034.2680485-7-andriy.shevchenko@linux.intel.com>
 <9715c8dd-38df-48fd-a9d1-7a78163dc989@ijzerbout.nl>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9715c8dd-38df-48fd-a9d1-7a78163dc989@ijzerbout.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 08, 2025 at 10:09:25PM +0200, Kees Bakker wrote:
> Op 03-04-2025 om 17:59 schreef Andy Shevchenko:

...

> Please, check the changes in this function again.
> `__acpi_find_gpio` doesn't fill `info` anymore. The callers of this function
> will continue with
> an uninitialized struct.

My gosh, you are so right! Now I'm puzzled of what I was tested...
Nevertheless, I will fix this ASAP today, test (and double test to
be sure it works), and push it.

-- 
With Best Regards,
Andy Shevchenko



