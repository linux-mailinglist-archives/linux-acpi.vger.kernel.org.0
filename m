Return-Path: <linux-acpi+bounces-14693-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041CDAEA095
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 16:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4344E4E39AF
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52428C039;
	Thu, 26 Jun 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6zCviau"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143C313B58B;
	Thu, 26 Jun 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948182; cv=none; b=oFfOMP4sxn90QvOfvpw46O5S1hvT6JOqka5Kunq85e6jxSSYwt77FWIDTW3sYPF8gxzh/8ZcT8LOEoP7zAxIWOKOsCR53PJgaFH53VEuzrbLAB3/CwLvd3PKBvwDUdPP1MkrUpigIV4VJVf8CTSEUKAMR1xcZCmZX0pllCULIwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948182; c=relaxed/simple;
	bh=UIAz9RAwELfU0OEgEwo3hJoP9RNGZV0++tXX3piu9KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do/VNUa8g17nS68qaRYY7ByOwN+XkjbHBzDLyNhKb5+XHu+XffiKml5t53W/krwgtlyrRCowAQkf0SDPGr5UaozNY4RiBI64G1itO1Y+Fljx8jYVaY+XSm2NMbb0GQTJb+pSXjwz7fM8BIIS/BJvSX4C9GBBqBPhOjKHqd+y19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6zCviau; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750948181; x=1782484181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UIAz9RAwELfU0OEgEwo3hJoP9RNGZV0++tXX3piu9KM=;
  b=C6zCviauGF0mkpYVk6CALEzmTN5pVCnk6aIYGIjJvuRyuW1IGNiXAGoV
   G5I8Q59PH6qpj+jOZJiafC1FETxW6HjlyomR8QBsFd07WMwQ4iER6i2Tj
   K0mPbiUixpkMAo5qcdlnjtUzHA2MWk6mOEizf5tLv0bZl+YWHRC7yRhCo
   ofNu+mnIcWlmYqNQVaiV/6yGkP46tfTlxVIX6joQIxzYWH27ZVAKGzmXL
   c5DFmSSGchJMSpauAZVkRnwhP/2om/dP/N6PGZzNhPcBg6PuBaRGx1IT1
   0rbx4I1PuwTyqLcRbBzn5dAfW10ovdqkbMCgYhgXMkbBiONOKJbez0LJ8
   Q==;
X-CSE-ConnectionGUID: XU3lZyZyTj6jt+hnW14lxw==
X-CSE-MsgGUID: kWcPPXO1SqSsIJAb7T+JVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70675651"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="70675651"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:29:40 -0700
X-CSE-ConnectionGUID: 07gvzv9nRaW8MU8M0IRrVg==
X-CSE-MsgGUID: tnTiW4raT3iFHNA/xssLsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="152829607"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:29:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uUnba-0000000ACTu-3tWu;
	Thu, 26 Jun 2025 17:29:34 +0300
Date: Thu, 26 Jun 2025 17:29:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 1/4] gpiolib: acpi: Add a helper for programming
 debounce
Message-ID: <aF1ZTrq4FLnpSz0q@smile.fi.intel.com>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625215813.3477840-2-superm1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 04:58:10PM -0500, Mario Limonciello wrote:
> 
> Debounce is programmed in two places and considered non-fatal in one of
> them. Introduce a helper for programming debounce and show a warning
> when failing to program.

> This is a difference in behavior for the call
> in acpi_dev_gpio_irq_wake_get_by().

When I meant "both", I was thinking of the _single_ existing case and new one
which you are about to add. In principle, I think changing behaviour here is
undesired. We provoke BIOS writers to make mistakes with debounce settings in
GpioInt() resources.

I agree on the patch...

> -			/* ACPI uses hundredths of milliseconds units */
> -			ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
> -			if (ret)
> -				return ret;
> +			acpi_set_debounce_timeout(desc, info.debounce);

...except this hunk.

-- 
With Best Regards,
Andy Shevchenko



