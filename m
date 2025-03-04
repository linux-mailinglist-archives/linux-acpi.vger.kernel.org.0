Return-Path: <linux-acpi+bounces-11755-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1D1A4D7C2
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 10:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B70C3ABAF5
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF121FCCEF;
	Tue,  4 Mar 2025 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiMN8go5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA881F8BCB;
	Tue,  4 Mar 2025 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079890; cv=none; b=UBpjIYVjyJEf2SYXx7w4+BLrzUMzk52Gkqv66toG9Lb8Lr76wXFAxLQeGF4p7q2keUNLfyah5L/i8WuW8RCQVEMM7zbW6XzVn5vCFyzaqjMiioeRWyOHFFB2TpbYhdd6MfpZDfH/NHUNuQhcU7aj6xEoO3736e2+fRv0d0eVsuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079890; c=relaxed/simple;
	bh=dEUuBGi+fZBZUh6pIwuiQnxwpPqstUiP3ToNVUPS6DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sz16/IK6UIciHEqvfv7njFEJI8eLO9j7SQVccox++MxQI7VlzHOUKcPnzfhjQIOEprZT6cjEa+vLk+mkt30rtUEnkKAD8j8saxlob+grmciox9x6282IFC7jFNt/vVWgDvboyFdGKPL+LqHnJEGPOC6WXDohSkMGrC9QVW82A9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiMN8go5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741079888; x=1772615888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dEUuBGi+fZBZUh6pIwuiQnxwpPqstUiP3ToNVUPS6DQ=;
  b=PiMN8go52f/t0VsJ+3GkYsalpQSGRsT5AA9rRquJ6/KkXVJ1I1mVm3wi
   yn/wQ27zSjA3cS4ljLQ03uPyjSHnF0seXev4dCNTvkaAQ6/n7gcscKHLO
   gaWeWmLttcWh40WRxQMGZ13yZLvHvWm/2xSOf1ZVZHBj2rlH1e+KbDsle
   4b8IQYe5w+yjpKdjHv0z1N/zszsLqcwDq2rvHsg7kznAZB5X7Lh1+XbnR
   hFBOE8zclyFFi4Ux6M03/eub5WMSUEm5yv7z1Rz6891V9Fk8zI5ytedP8
   hULbopeMuuXcjQzBYl9MbkrdaSFqEv+fEnkZi8Im+umuj472x6b3PDIHo
   g==;
X-CSE-ConnectionGUID: GIg4hGR0S4eVD160iwBwMw==
X-CSE-MsgGUID: mvXPCaPoShevwPf6gBPpWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52969271"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="52969271"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 01:18:08 -0800
X-CSE-ConnectionGUID: lAVuN9O+Ty+1aYl+l0C4gw==
X-CSE-MsgGUID: KsMe/U0oRPqD8PHR4rGjHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="122937324"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 04 Mar 2025 01:18:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 5512918F; Tue, 04 Mar 2025 11:18:04 +0200 (EET)
Date: Tue, 4 Mar 2025 11:18:04 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v1 2/3] gpiolib: Rename gpio_set_debounce_timeout() to
 gpiod_do_set_debounce()
Message-ID: <20250304091804.GG3713119@black.fi.intel.com>
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
 <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>

On Mon, Mar 03, 2025 at 06:00:33PM +0200, Andy Shevchenko wrote:
> In order to reduce the 'gpio' namespace when operate over GPIO descriptor
> rename gpio_set_debounce_timeout() to gpiod_do_set_debounce().

To me anything that has '_do_' in their name sounds like an internal static
function that gets wrapped by the actual API function(s).

For instance it could be 

  int gpio_set_debounce_timeout()
  {
  	...
	gpiod_do_set_debounce()
	...

However, gpiod_set_debounce_timeout() or gpiod_set_debounce() sounds good
to me.

