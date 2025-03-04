Return-Path: <linux-acpi+bounces-11758-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5B9A4DC29
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 12:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 715CB7A1F85
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 11:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FE81FF614;
	Tue,  4 Mar 2025 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uv151Xuj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D51FF601;
	Tue,  4 Mar 2025 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086723; cv=none; b=oHe4a8D35j9ozUS16uk7d1iQmh5RVIHSZNVQTuhif1tHMl/3hZu522BFauFwZxd87WCP0UKy8LSnq2f5PYrZu4GPIRCQfTFOY/IAC4D93n2t5uaC/79H4nGJIpBp+AlxRn9GLTOVyFDoU16MGuDmcnLytoVsrKg1ZmtRSuKyDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086723; c=relaxed/simple;
	bh=Ug6TRu/EYll01ZOlYl+lLhX3+EIE4rZNyV0DQX6FArI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRXTTMgm6s3BB5c5ir263DmqlRKUyCb7Cft3gpiJJxAblVQD+OkDjSfw+q4aBqWsdXmAWNFvkdrVLT3pjCERT8k68y2KPGVBO8EJQdMTOcN4VWTe5HPBv3Xx3bIBwJhxBLUmx2PLh/5IQKYdg7KBSVFMVNLowTWV92fEltGtQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uv151Xuj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741086722; x=1772622722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ug6TRu/EYll01ZOlYl+lLhX3+EIE4rZNyV0DQX6FArI=;
  b=Uv151XujUkxVOALsIhHRoK22xmyBpQfx9/W+KsHrjemun9zPZ+J36ei+
   Ca7ouOJSqmo7bTracXP87n/zS4NiLPPmmvomXcqzDnxDOnpEdLOugSO7J
   ql/RMV3LTUOv3jA9XGPRsIyZUb6HLMrMjf2WNq4xvf4LEARqK0kS9W22P
   E7pW7SCxD3UBZOJOSC/3wAkiJLEA44osf/KIK9SBotAAW+Mmae9+0FeFQ
   IJrRrEFMLc1xZjc/bjWyvcEkW8iarkDih8ZHCV6IWsGjKXmRH0BJL+/g/
   b9OTC/fghKdouvfcXPBChMEwr2Vk032JDsBBFE+6760SzXkvTKQboF7Ys
   Q==;
X-CSE-ConnectionGUID: wB0nRVmRQkCCPm7fIz3Ndg==
X-CSE-MsgGUID: 55mwXH7IRDGSceZOYDOjtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41711358"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41711358"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:12:01 -0800
X-CSE-ConnectionGUID: dwJ3T5pfRmu3C2PK3OMYhw==
X-CSE-MsgGUID: 5U36dYxdSsWPT+kP4Mk8BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123356280"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 04 Mar 2025 03:11:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id A9F0A1A5; Tue, 04 Mar 2025 13:11:57 +0200 (EET)
Date: Tue, 4 Mar 2025 13:11:57 +0200
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
Message-ID: <20250304111157.GJ3713119@black.fi.intel.com>
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
 <20250303160341.1322640-3-andriy.shevchenko@linux.intel.com>
 <20250304091804.GG3713119@black.fi.intel.com>
 <Z8bdDQGg_xcamZv2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8bdDQGg_xcamZv2@smile.fi.intel.com>

On Tue, Mar 04, 2025 at 12:59:25PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 04, 2025 at 11:18:04AM +0200, Mika Westerberg wrote:
> > On Mon, Mar 03, 2025 at 06:00:33PM +0200, Andy Shevchenko wrote:
> > > In order to reduce the 'gpio' namespace when operate over GPIO descriptor
> > > rename gpio_set_debounce_timeout() to gpiod_do_set_debounce().
> > 
> > To me anything that has '_do_' in their name sounds like an internal static
> > function that gets wrapped by the actual API function(s).
> > 
> > For instance it could be 
> > 
> >   int gpio_set_debounce_timeout()
> >   {
> >   	...
> > 	gpiod_do_set_debounce()
> > 	...
> > 
> > However, gpiod_set_debounce_timeout() or gpiod_set_debounce() sounds good
> > to me.
> 
> Then please propose the second name for gpiod_set_config_XXX to follow
> the same pattern. The series unifies naming and reduces the current
> inconsistency.

gpiod_set_config()?

