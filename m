Return-Path: <linux-acpi+bounces-11770-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B9DA4DF69
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D6F17858B
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12182040A7;
	Tue,  4 Mar 2025 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1jV40Hy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0912202F88;
	Tue,  4 Mar 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095499; cv=none; b=SEVMoVY7cqfS74rnztdmxQDnStTOhSB+JJvRFIgG2NpM+FSTh81hyTqoTIrS4yWLK22JiqT4A86NSvobkjTqGXq9058NZRqM+2+ZLWmVf6FbZ5A77FRY/7lAcu/fFvtaecmMtlzYvoy2WPiivE09cVkm+0WoycfK8taMCLewkwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095499; c=relaxed/simple;
	bh=+DTY6DJPeBY2cYYm2BcQt9dHF5t6h2jZTPAP1p+s0Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCz7A4/GmBSiu7SkuyW3Vu2g+DAfiQODZl+ABavAzeINM3PDKxiTMHY6UVlTDwWwFKnDByVJx1yRsRk/iSrY1k8lEIRU+PuR5lId7H97Wios4R8rhK0oSdB/ajIOxeqv0BU1Dq6uGht0PUahf7cBx1TSTm2fCwHJyK0i+HmiIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1jV40Hy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741095498; x=1772631498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+DTY6DJPeBY2cYYm2BcQt9dHF5t6h2jZTPAP1p+s0Bc=;
  b=S1jV40HyNj22u6JtutLqv8lPKsCxZ9u0TePu5E80E3eefEgw57Hl+DHK
   pFnVzCZPEFT1rxI2TwZH5DJkSpHUTrCfYUbD/7bXqiC3bINxlfm76+d+5
   TwhYuVCH2Fs+hMpJ3M/bg4/ZL5g8QtSNUmE44Jx07HsHp3Fp3WhbwdNp1
   sjM3kco2W1IOOu+pDkB5WaCJikUXylRLbzGz/CcTx/9eQ/QtvlDHo37v/
   45To/6OH6VulIKFjC7/5/Ts7j2KI4QyE036T0PBnEGSR372hLzgZj2wCf
   MiaVYICZR+/cUMqCjUD6uOsgfcmBcVUnm5jey5jXCVrJ8cqZeay8l3A94
   w==;
X-CSE-ConnectionGUID: 8D362pveSFmB44ZAcJ3epQ==
X-CSE-MsgGUID: bCSvsf50QQGcyuPuk8N6hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59561438"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="59561438"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:38:14 -0800
X-CSE-ConnectionGUID: +0tDC8ZmS7m9gn+FHVrUVg==
X-CSE-MsgGUID: tarYCqqGRMW47O6wShOFdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="155565630"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 05:38:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpSTJ-0000000H8VU-0sXs;
	Tue, 04 Mar 2025 15:38:09 +0200
Date: Tue, 4 Mar 2025 15:38:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v1 2/3] gpiolib: Rename gpio_set_debounce_timeout() to
 gpiod_do_set_debounce()
Message-ID: <Z8cCQPWBmJXFgKAe@smile.fi.intel.com>
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
 <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
 <20250304091804.GG3713119@black.fi.intel.com>
 <Z8bdDQGg_xcamZv2@smile.fi.intel.com>
 <20250304111157.GJ3713119@black.fi.intel.com>
 <Z8bhJq3kn_uw3iYE@smile.fi.intel.com>
 <20250304113135.GK3713119@black.fi.intel.com>
 <Z8brYjfL1yj_BvpN@smile.fi.intel.com>
 <CAMRc=MfsKc+r=uhDZVbd_BW=Gs1BpaidPC1tfF6TGqcq9bgP6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfsKc+r=uhDZVbd_BW=Gs1BpaidPC1tfF6TGqcq9bgP6Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 04, 2025 at 01:15:02PM +0100, Bartosz Golaszewski wrote:
> On Tue, Mar 4, 2025 at 1:00 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Mar 04, 2025 at 01:31:35PM +0200, Mika Westerberg wrote:
> > > On Tue, Mar 04, 2025 at 01:16:54PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Mar 04, 2025 at 01:11:57PM +0200, Mika Westerberg wrote:
> > > > > On Tue, Mar 04, 2025 at 12:59:25PM +0200, Andy Shevchenko wrote:
> > > > > > On Tue, Mar 04, 2025 at 11:18:04AM +0200, Mika Westerberg wrote:
> > > > > > > On Mon, Mar 03, 2025 at 06:00:33PM +0200, Andy Shevchenko wrote:
> > > > > > > > In order to reduce the 'gpio' namespace when operate over GPIO descriptor
> > > > > > > > rename gpio_set_debounce_timeout() to gpiod_do_set_debounce().
> > > > > > >
> > > > > > > To me anything that has '_do_' in their name sounds like an internal static
> > > > > > > function that gets wrapped by the actual API function(s).
> > > > > > >
> > > > > > > For instance it could be
> > > > > > >
> > > > > > >   int gpio_set_debounce_timeout()
> > > > > > >   {
> > > > > > >       ...
> > > > > > >       gpiod_do_set_debounce()
> > > > > > >       ...
> > > > > > >
> > > > > > > However, gpiod_set_debounce_timeout() or gpiod_set_debounce() sounds good
> > > > > > > to me.
> > > > > >
> > > > > > Then please propose the second name for gpiod_set_config_XXX to follow
> > > > > > the same pattern. The series unifies naming and reduces the current
> > > > > > inconsistency.
> > > >
> > > > > gpiod_set_config()?
> > > >
> > > > The problem is that
> > > >
> > > > gpiod_set_debounce() and gpiod_set_config() are _existing_ public APIs.
> > > > That's why I considered "_do_" fitting the purpose.
> > >
> > > I see.
> > >
> > > Hmm, we have:
> > >
> > > int gpiod_set_debounce(struct gpio_desc *desc, unsigned int debounce)
> > > {
> > >         unsigned long config;
> > >
> > >         config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
> > >         return gpiod_set_config(desc, config);
> > > }
> > >
> > > and
> > >
> > > int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
> > > {
> > >       int ret;
> > >
> > >       ret = gpio_set_config_with_argument_optional(desc,
> > >                                                    PIN_CONFIG_INPUT_DEBOUNCE,
> > >                                                    debounce);
> > >       if (!ret)
> > >               gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
> > >
> > >       return ret;
> > > }
> > >
> > > I wonder if there is an opportunity to consolidate? ;-)
> >
> > Send a patch! I would be glad to see less functions and internal APIs in
> > GPIOLIB.
> >
> 
> I'm definitely in favor of consolidation instead of renaming to
> gpiod_go_set_debounce(). If anything a better name would be:
> gpiod_set_debounce_nocheck() to indicate the actual functionality.
> 
> How about first extending gpio_set_config_with_argument() to take a
> boolean "optional" argument and removing
> gpio_set_config_with_argument_optional() altogether? Both are internal
> to drivers/gpio/ so it would have no effect on consumers.

Consider this series as a report then, I am not going to spend time on it.
Thank you for the review.

-- 
With Best Regards,
Andy Shevchenko



