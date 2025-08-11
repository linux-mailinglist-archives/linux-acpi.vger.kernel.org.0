Return-Path: <linux-acpi+bounces-15593-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BAAB216A4
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 22:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C5B2A5C9F
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 20:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0E22D9EEC;
	Mon, 11 Aug 2025 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxZ9e6By"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA2F2D839E;
	Mon, 11 Aug 2025 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944971; cv=none; b=LfLCBE4vgpjunZOqse9DX4CMr+/CnkTbITs6jdSXinzfCGZBuMyCeqrDY4d1U+SJ5dzisrkP8obBWTllSCKaCmHA6psqoYHK68NatMlehwHUxxxu3nmnZ03N+LmwJiQIeJae39OGKNRJteryuBUwraK/cz0qX6jiqnDGkhXHzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944971; c=relaxed/simple;
	bh=GmWZ6Ev9oejXz4iHB+udPAzmMmbPgwnAHOjMlFR6wws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxkHK8jerzsZMYiLdiSpZwd4Vnz2t58jecWfYMx6vF5W8Srt2zQx4nt9z89fYmgqCsFa/qwbc7tdmOlcMPDHQiKvDLzgBsCzIxuxM+6t9euNs0M2vrToeyPr6mocP8R6hT6S2vGILRiNu7sj5UGSngsj6JyAT9gCcwidwbHLMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxZ9e6By; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754944970; x=1786480970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GmWZ6Ev9oejXz4iHB+udPAzmMmbPgwnAHOjMlFR6wws=;
  b=JxZ9e6ByekV2oBkGVMf5Z64FpWLIEd8JASLN7YzuFxAPhtOQrVlqBrPJ
   yUKwIC/0PhW40EmvQ4Sifru+X6ZrQL2gK/mnZaVNrS2v+5sZ4GgsxSWV5
   aq09KnpC/YWvbPuEtrQXXbbUp8oxLGBpL4xP8MqtvxtnZKwEIYYJ1Df5D
   pHiWufmQeelajtqLd6qdGPPPD4MCeqKoc3geC/irMmNsLCxjLFzjCsyQt
   Sy8cVHNH+4d0GPLL6aOlrFjO/ZAb441CLHxMnxGvPx5PWFDhiWJYCLCvc
   nwCQcl0aR7j8YgOiilVUbgcS1RYlgvCHFZekrW/NgibFvZlK0MQifdJCi
   w==;
X-CSE-ConnectionGUID: DsT5niLaSpG7I7FYypmWkw==
X-CSE-MsgGUID: 5h49Pr1qST+1l0/q/Ek5IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57163959"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57163959"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 13:42:50 -0700
X-CSE-ConnectionGUID: 9v1frkdgRXCboi8GEOba8A==
X-CSE-MsgGUID: jl8PsxXVQ7KIaEi+TwFcfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170149383"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 13:42:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ulZLw-000000056ns-0QAp;
	Mon, 11 Aug 2025 23:42:44 +0300
Date: Mon, 11 Aug 2025 23:42:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>
Subject: Re: [PATCH v3] gpiolib: acpi: Program debounce when finding GPIO
Message-ID: <aJpVw39tBNkEtkgZ@smile.fi.intel.com>
References: <20250811164356.613840-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811164356.613840-1-superm1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 11, 2025 at 11:43:56AM -0500, Mario Limonciello (AMD) wrote:
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
> 
> As this is considered non fatal if it fails, introduce a helper for
> programming debounce and show a warning when failing to program.

I think I already commented on this previously. Let me do that below anyway.

...


> +static void acpi_set_debounce_timeout(struct gpio_desc *desc, unsigned int timeout)
> +{
> +	int ret;
> +
> +	/* ACPI uses hundredths of milliseconds units */
> +	ret = gpio_set_debounce_timeout(desc, timeout * 10);
> +	if (ret)
> +		dev_warn(&desc->gdev->dev,
> +			 "Failed to set debounce-timeout: %d\n", ret);
> +}

I would make it still return the code to the caller. See below why.


...

> -			/* ACPI uses hundredths of milliseconds units */
> -			ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
> -			if (ret)
> -				return ret;
> +			acpi_set_debounce_timeout(desc, info.debounce);

The commit message fails to explain why we do relax the condition here. This is
about GpioInt() resource and so far I haven't heard about misused debounce
values there. If we drop the fatality, it has to be a separate patch explaining
why. But only if we have practical use cases. AS long as there no failed
platforms, I can't agree on this piece of change.

-- 
With Best Regards,
Andy Shevchenko



