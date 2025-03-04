Return-Path: <linux-acpi+bounces-11761-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215C7A4DD5B
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 13:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFA83A84BA
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B9E2046B2;
	Tue,  4 Mar 2025 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGf0MId/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A7820299C;
	Tue,  4 Mar 2025 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089642; cv=none; b=T04uSf066FHCEwHSeGidAD+MXJKO24kz2vvass7cg7Xe7oQgRNCwLoNQ3AB1aCd3s1VEIzrh2gWDVFwM68RlP/sHgUoMkKfalA1xqJHGV4TBmbWcHhANj9N9Yv3lEaLmHKMr4769F2GnvctvFo57WMc2vKV6NyK4dk83juaWYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089642; c=relaxed/simple;
	bh=6wApCoLMSXVB8edx9DKIU4Nhumb37SqKjTunRLTVUEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUFuyYk+uWFscNWp7Pf0aVGk+3KO46gJFK43yzwr6a2mRiv+5Rj1LG7KqgIEgZOp+uf1ve69ZJYCBKjvX1HHwzlDFRcAhPJYpDdJQcCk8s/1iNSrtPMOESda/4CwSVJDY6g76y7VPkRRzPZhC5O+M5DoLt5VsdTmVwwy0z7BcgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGf0MId/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741089641; x=1772625641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6wApCoLMSXVB8edx9DKIU4Nhumb37SqKjTunRLTVUEI=;
  b=oGf0MId/m4WzbqanIpJ4d9cVMDPv29CRleYZ3qAgeGDkZr1GLaINVf1+
   GEE4eEr1faJaZZkiMJZZbkKQQVZdw9q4fRfcHsARpq5izfid5LZAgnZW1
   TlhRFyf497AU95r2uRBU7PWAKYwvUOnBsFE+jRdpQwHJsRf3yCYcRD+Z2
   yNMeDuhheEI0pEGWMmygIu7Z/1l6yzIttUJnV/rv5QpKZhdUqggTjbDkU
   45OQB9tSPrr2yM20rCewjBw3hlZLuCRF31G+7k1Z0SCKnFq/Rxd9OzFQK
   zvwqk8D2SLPMYqovv4Womsm5iCoozk+LS0VLlE2B406Mr8VJVYioYqU9O
   g==;
X-CSE-ConnectionGUID: T16zAzFnRG6c+KKwgDvkyQ==
X-CSE-MsgGUID: N7bsDW79RySVxk5bNWuFHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="67372094"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="67372094"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 04:00:40 -0800
X-CSE-ConnectionGUID: ScBD1m1cRqanyIzYQCDmVw==
X-CSE-MsgGUID: 19ykq2lrTTa0U9bb0J1aiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149286735"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 04:00:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpQwt-0000000H7CU-0lwt;
	Tue, 04 Mar 2025 14:00:35 +0200
Date: Tue, 4 Mar 2025 14:00:34 +0200
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
Message-ID: <Z8brYjfL1yj_BvpN@smile.fi.intel.com>
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
 <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
 <20250304091804.GG3713119@black.fi.intel.com>
 <Z8bdDQGg_xcamZv2@smile.fi.intel.com>
 <20250304111157.GJ3713119@black.fi.intel.com>
 <Z8bhJq3kn_uw3iYE@smile.fi.intel.com>
 <20250304113135.GK3713119@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304113135.GK3713119@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 04, 2025 at 01:31:35PM +0200, Mika Westerberg wrote:
> On Tue, Mar 04, 2025 at 01:16:54PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 04, 2025 at 01:11:57PM +0200, Mika Westerberg wrote:
> > > On Tue, Mar 04, 2025 at 12:59:25PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Mar 04, 2025 at 11:18:04AM +0200, Mika Westerberg wrote:
> > > > > On Mon, Mar 03, 2025 at 06:00:33PM +0200, Andy Shevchenko wrote:
> > > > > > In order to reduce the 'gpio' namespace when operate over GPIO descriptor
> > > > > > rename gpio_set_debounce_timeout() to gpiod_do_set_debounce().
> > > > > 
> > > > > To me anything that has '_do_' in their name sounds like an internal static
> > > > > function that gets wrapped by the actual API function(s).
> > > > > 
> > > > > For instance it could be 
> > > > > 
> > > > >   int gpio_set_debounce_timeout()
> > > > >   {
> > > > >   	...
> > > > > 	gpiod_do_set_debounce()
> > > > > 	...
> > > > > 
> > > > > However, gpiod_set_debounce_timeout() or gpiod_set_debounce() sounds good
> > > > > to me.
> > > > 
> > > > Then please propose the second name for gpiod_set_config_XXX to follow
> > > > the same pattern. The series unifies naming and reduces the current
> > > > inconsistency.
> > 
> > > gpiod_set_config()?
> > 
> > The problem is that
> > 
> > gpiod_set_debounce() and gpiod_set_config() are _existing_ public APIs.
> > That's why I considered "_do_" fitting the purpose.
> 
> I see.
> 
> Hmm, we have:
> 
> int gpiod_set_debounce(struct gpio_desc *desc, unsigned int debounce)
> {
>         unsigned long config;
> 
>         config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
>         return gpiod_set_config(desc, config);
> }
> 
> and
> 
> int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
> {
> 	int ret;
> 
> 	ret = gpio_set_config_with_argument_optional(desc,
> 						     PIN_CONFIG_INPUT_DEBOUNCE,
> 						     debounce);
> 	if (!ret)
> 		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> 
> 	return ret;
> }
> 
> I wonder if there is an opportunity to consolidate? ;-)

Send a patch! I would be glad to see less functions and internal APIs in
GPIOLIB.

-- 
With Best Regards,
Andy Shevchenko



