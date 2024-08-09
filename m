Return-Path: <linux-acpi+bounces-7458-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7AE94D030
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 14:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05A51F20944
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973A61940B7;
	Fri,  9 Aug 2024 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddfGGMqK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F41759F;
	Fri,  9 Aug 2024 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206558; cv=none; b=IJ8W/mhhgQAoGikTSDAfb5D6Ot0oDCkvPlfWoRoNttKMs5Psyf89zNfs+QVVzoscmkXxpF7b7owidgKEO3KHEQ22x25xi9HrqtA6diSDCEstjUeNQIxbzo3e2HppzRfqd+33cCDiXO1arO6tFjCVOro4510f1T2I+Pv7JZyQ1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206558; c=relaxed/simple;
	bh=XcDP5KWPeB+kmQNKXvErHxH3ZMeJJXcKzlyKYdRs3Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTjTD92JxyxpjOM/ln9DJVlvX9eBEnn1uUobW8rzvxrVVI9NR43r+bWgND70to0uzSGkYXxw2icZD1mkxOLzBPt65eCS0fIGCk9Y1A+kM1fhTQut0X+p4IpyKQEL9pQGckIz9bi6yM/Rf1qoUj3TmLROKvuww4L1l/ENmx227Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddfGGMqK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723206557; x=1754742557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XcDP5KWPeB+kmQNKXvErHxH3ZMeJJXcKzlyKYdRs3Rw=;
  b=ddfGGMqKfaFlFoDgY5oGDVD9PQJL5AjV9pZR+YDFqHKAJHo7BVZiXhWz
   2hmGPboTZOThL/lngFFDqeyeEdQGo7zyolJBXlcTos91uhPLC94R4s7QP
   NknCXQSwyHQSJKQ5TBvp1hyR95e7hrSSuerqyVrYLOlTPnh9Rlc081Rcd
   3ZByfqjyO3SZshqRD0+0s5ZoIdlQVcG9oLs9R1+DZQfox6aZ7v2FOLPQX
   2KStUSSYdfoMcTsKe2ig1P7YO9Ynu3KdPMmk0KKqlHu2IpvZldnWOQ3O0
   BqWuKW3w0WVY8oUzbjWUbCko7pYnI+OSlEnyIuvDpKwvp8Jc65tG+lu8g
   Q==;
X-CSE-ConnectionGUID: 3DLlhlUWSveNac/wl4tfnw==
X-CSE-MsgGUID: 52FNWroZRUOjYa9rXZbOaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25247473"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="25247473"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:29:16 -0700
X-CSE-ConnectionGUID: Z3wBRjV1S5KZKk12xh7rEw==
X-CSE-MsgGUID: MqDpwxSxTIS/UnF3UrkZfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57759140"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:29:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scOk3-0000000DPm3-30Tu;
	Fri, 09 Aug 2024 15:29:11 +0300
Date: Fri, 9 Aug 2024 15:29:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: put gpio_suffixes in a single compilation unit
Message-ID: <ZrYLl81Gpz4B60N_@smile.fi.intel.com>
References: <20240612184821.58053-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612184821.58053-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 12, 2024 at 08:48:21PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The gpio_suffixes array is defined in the gpiolib.h header. This means
> the array is stored in .rodata of every compilation unit that includes
> it. Put the definition for the array in gpiolib.c and export just the
> symbol in the header. We need the size of the array so expose it too.

Instead of having two exported variables you may just make the arrays be NULL
terminated. That's how, for example, ID tables are done.

-- 
With Best Regards,
Andy Shevchenko



