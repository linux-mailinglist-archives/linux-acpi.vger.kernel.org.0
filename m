Return-Path: <linux-acpi+bounces-11757-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 958A5A4DBB6
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 12:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB431775FF
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AFD20011B;
	Tue,  4 Mar 2025 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbGttKor"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007DA1FCF60;
	Tue,  4 Mar 2025 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085973; cv=none; b=ecN9rHEg635q8nn+xuQ1eI0Va/DddDA9uUpykEUvg7YSTqy6jjByw4kQIos70TM7J0e3zbVl8NGaPyb5R34rudGxkzu/46O2dhVRKsgW5tQdo9vI1+6uwgvCblHDuINfgK5lyW1M5MkaPfqgErub6oaJ8zVKEO4ubPqimRJN7WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085973; c=relaxed/simple;
	bh=4DxI1dIFPwDf+w+uEy1bGnTlN2NFGh1gv21Gx3uL+VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMT2+mBJOB+B+4z2zydgqtvMpbc9siPqeb646Bd8vehW3k2WmldSyWAwW6PtRwMIyciNTKpv+/Cj8KUPJVdXZjrfajnyQbQVH2d+CsdBk0Dn+YzA+E4X3leXjXsqsyhseiJWfU+ptuQpes/C7pgETlBYgfx5ROk+/Tp9H0ojtK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbGttKor; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741085972; x=1772621972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4DxI1dIFPwDf+w+uEy1bGnTlN2NFGh1gv21Gx3uL+VA=;
  b=PbGttKorK3lb15+MY66vbFEpVehLkHrukzmtUrMWQ6tZsUfpAtvlpOzn
   jkPApc+m+CHBmmkj+T2h1PHuZmJ6c6lmA6mJx8PkyDwn4xj0mzev28KS8
   PeaHl7iN8ssqI6arjPY4IBtfAWjGu9LH1PYlu+GHUCcC94oRpMhsrJKGM
   a77vcQphKTcckV0ePsMj/0ocEQs8RBmWhT8BEAc76UjjMvoHH8xxVM/b/
   zliTt5hs/O5u7oihZd6fY3FDhn+3bKdLI7Te36j9YgnOqllm74IstyKus
   GkEhADwZR4gXvXngNwb1JX42joNzA7TUvaZb0UFk1mfRkX2/CUYu2K7rO
   A==;
X-CSE-ConnectionGUID: EMTROi2RSpuOFfamuOqQig==
X-CSE-MsgGUID: g/wGgtfEQNm6Y8yL9qmG7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52635595"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52635595"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 02:59:31 -0800
X-CSE-ConnectionGUID: kGiJ7T0uTJyij0Gw4V429Q==
X-CSE-MsgGUID: 3IN/Yw8RQWCvBXQB+slWTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118066666"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 02:59:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpPzh-0000000H6Ax-2bbs;
	Tue, 04 Mar 2025 12:59:25 +0200
Date: Tue, 4 Mar 2025 12:59:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v1 2/3] gpiolib: Rename gpio_set_debounce_timeout() to
 gpiod_do_set_debounce()
Message-ID: <Z8bdDQGg_xcamZv2@smile.fi.intel.com>
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
 <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
 <20250304091804.GG3713119@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304091804.GG3713119@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 04, 2025 at 11:18:04AM +0200, Mika Westerberg wrote:
> On Mon, Mar 03, 2025 at 06:00:33PM +0200, Andy Shevchenko wrote:
> > In order to reduce the 'gpio' namespace when operate over GPIO descriptor
> > rename gpio_set_debounce_timeout() to gpiod_do_set_debounce().
> 
> To me anything that has '_do_' in their name sounds like an internal static
> function that gets wrapped by the actual API function(s).
> 
> For instance it could be 
> 
>   int gpio_set_debounce_timeout()
>   {
>   	...
> 	gpiod_do_set_debounce()
> 	...
> 
> However, gpiod_set_debounce_timeout() or gpiod_set_debounce() sounds good
> to me.

Then please propose the second name for gpiod_set_config_XXX to follow
the same pattern. The series unifies naming and reduces the current
inconsistency.

-- 
With Best Regards,
Andy Shevchenko



