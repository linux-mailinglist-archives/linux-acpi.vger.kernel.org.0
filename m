Return-Path: <linux-acpi+bounces-11760-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB863A4DC9F
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 12:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03F2174549
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A4A1FECCC;
	Tue,  4 Mar 2025 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8ZppfDG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137DD1F03C0;
	Tue,  4 Mar 2025 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087902; cv=none; b=mMIYd6usjgwuxjswe/Zc7YDMHOpGblyTRX2khYVoDBK3f+5D2F70oc0o5ifWydFvOeoZInAQGwer1hUe8xQejVWJVTVJcWTypPNxdHG3GlpChdYJJ8pO/6N5TiyMQ1nZqtlA6MCPU7rSSUKUwJ0l4filfcy1jdZ4SGngneFEYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087902; c=relaxed/simple;
	bh=elPONmB0TpBBxiaOHB9mepOupJuUGPnO7V2zIu0YQts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFVEZXtUCSpHifiGFhXxHLVaI/ocZLIegnSv+KxHRyBSWFcHFwUMh54Ok6t7rDjhnUhG1trJjsS5eG+GB71qk/4u5srhdQq/xmo0ekjyAiu1Tc/tzlNvkd5CuyU7PflcFi3WAMhbf2mLA+tAxIKIvhHL7paNI7+IrgHDnHXFWJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8ZppfDG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741087901; x=1772623901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=elPONmB0TpBBxiaOHB9mepOupJuUGPnO7V2zIu0YQts=;
  b=D8ZppfDG14YBnoPLxjRNgOQKdJntbZKHRViS97CJH9UO8eslQ8sCcCZn
   JnHYtxkv+wnntTJra75RBvb/w0RY2wcC3psTCkm75O1nbhH2PRf1l+7uS
   P8KSaVBLVBnkae6IQmtKIelfhvpNFIrnSXbgHxDfJ0z27yw2IqKK85Clr
   +qaCwicSxj0YovbJLbru3+4i0DcVIAUrynwQYmhIY8+5OIKhaPqT2Ffc0
   bJ4IvFXtO1llwZA0X9K8vbqceZgtexDxgsJLdoGWmj7FTHe2czcXc49uZ
   +iTQuR7ukMFpeRWPfZ3b5DHZUqiJXXy8ePtRoJm0U1JrkTHLgnZzZuUpy
   Q==;
X-CSE-ConnectionGUID: md5Fz32iR2ebLQW7d/Shxg==
X-CSE-MsgGUID: B11F2EqvSlG4w07Fvw7i1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="42028821"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="42028821"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:31:39 -0800
X-CSE-ConnectionGUID: 4mqCbS0RRuqTxn368GpBEg==
X-CSE-MsgGUID: q8/JbYRCTPOj2ky8/USUVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118160036"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 04 Mar 2025 03:31:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 4BDE61A5; Tue, 04 Mar 2025 13:31:35 +0200 (EET)
Date: Tue, 4 Mar 2025 13:31:35 +0200
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
Message-ID: <20250304113135.GK3713119@black.fi.intel.com>
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
 <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
 <20250304091804.GG3713119@black.fi.intel.com>
 <Z8bdDQGg_xcamZv2@smile.fi.intel.com>
 <20250304111157.GJ3713119@black.fi.intel.com>
 <Z8bhJq3kn_uw3iYE@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8bhJq3kn_uw3iYE@smile.fi.intel.com>

On Tue, Mar 04, 2025 at 01:16:54PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 04, 2025 at 01:11:57PM +0200, Mika Westerberg wrote:
> > On Tue, Mar 04, 2025 at 12:59:25PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 04, 2025 at 11:18:04AM +0200, Mika Westerberg wrote:
> > > > On Mon, Mar 03, 2025 at 06:00:33PM +0200, Andy Shevchenko wrote:
> > > > > In order to reduce the 'gpio' namespace when operate over GPIO descriptor
> > > > > rename gpio_set_debounce_timeout() to gpiod_do_set_debounce().
> > > > 
> > > > To me anything that has '_do_' in their name sounds like an internal static
> > > > function that gets wrapped by the actual API function(s).
> > > > 
> > > > For instance it could be 
> > > > 
> > > >   int gpio_set_debounce_timeout()
> > > >   {
> > > >   	...
> > > > 	gpiod_do_set_debounce()
> > > > 	...
> > > > 
> > > > However, gpiod_set_debounce_timeout() or gpiod_set_debounce() sounds good
> > > > to me.
> > > 
> > > Then please propose the second name for gpiod_set_config_XXX to follow
> > > the same pattern. The series unifies naming and reduces the current
> > > inconsistency.
> 
> > gpiod_set_config()?
> 
> The problem is that
> 
> gpiod_set_debounce() and gpiod_set_config() are _existing_ public APIs.
> That's why I considered "_do_" fitting the purpose.

I see.

Hmm, we have:

int gpiod_set_debounce(struct gpio_desc *desc, unsigned int debounce)
{
        unsigned long config;

        config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
        return gpiod_set_config(desc, config);
}

and

int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
{
	int ret;

	ret = gpio_set_config_with_argument_optional(desc,
						     PIN_CONFIG_INPUT_DEBOUNCE,
						     debounce);
	if (!ret)
		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);

	return ret;
}

I wonder if there is an opportunity to consolidate? ;-)

