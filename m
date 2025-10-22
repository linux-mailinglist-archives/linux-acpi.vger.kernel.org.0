Return-Path: <linux-acpi+bounces-18114-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19437BFDDF8
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 20:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A0A34FCFA7
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 18:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D212534D4E1;
	Wed, 22 Oct 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBq8bRXv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C764C272E51;
	Wed, 22 Oct 2025 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158292; cv=none; b=fecj/r5d0W6q0mxazJuWE+XtCma0xe8J1nPaOpcBfuIQCVHtpMhrb3qdIYgF60CeBvsHMa8YokNnJ9Z+3vzjralu7ajWBk4m8C6fLcVchcjM6bZcR4/k4yrw/asuZenyi1RGWk8crRiKPqptSWMPxIcMDoWtMdjAmBXc2418JcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158292; c=relaxed/simple;
	bh=w2dSx6r+qMl9C3M0KrUR4k84EpNHWAxVhPzJNvx00UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB2IkW8kViFYoEP7C+D/BaoYx1S9B1gAH2W8ofHdQN6xQgeeQJlAX4APugnIf/s0DFxnJg8mn8fRMQbT/SF7eBXY9M8yeEl03I+95uOU0+PCUK1yombJc7didzOrFjpkOrYV7vvfY87fHhXeoa0qjZyvKvbdOvwZyew1fiy0oUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBq8bRXv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761158291; x=1792694291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w2dSx6r+qMl9C3M0KrUR4k84EpNHWAxVhPzJNvx00UQ=;
  b=GBq8bRXvaZO09wjrN8QsUyVZPsUrP5jYD1XUCspDdXDhHbGMxlXQDP2V
   S8pPMYHrcf1kiJrPi9rChsPlOkwkHbAPQlq7TF3+yspdBBo2HRgsVNrL8
   FYbPUQVqfRVV1iXfxXBs9+ft0LU9Xm2ztGZWalmJPC2IEySwhOVf/OZU9
   CHtva4l4I7H1rACP1AhpTgBEKhyVP8h3lsvThBbuK99EGTl8CfWBvMulH
   xrlXE8Zz/+VJYQlAATY6vGZHJwLXoM/qKkQHGx36bS/6UtZ6jiE5vYrhA
   i7OIRafqgmYRLA3n8qrG1UIlwTpEruNg5QIuyF4UkFnu7r0ZxZy9RccCI
   w==;
X-CSE-ConnectionGUID: sWKUPTspThOKTX5+MljlUg==
X-CSE-MsgGUID: FNuAOUoQQneYqwewTQkAXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74435732"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="74435732"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 11:38:10 -0700
X-CSE-ConnectionGUID: G+1ZlxXbRvOCdw5OqQaIzg==
X-CSE-MsgGUID: YGVNBTVkQ9Who4zzjcGIZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="183652058"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.83])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 11:38:07 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBdim-00000001ldm-1xFU;
	Wed, 22 Oct 2025 21:38:04 +0300
Date: Wed, 22 Oct 2025 21:38:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 8/9] reset: gpio: convert the driver to using the
 auxiliary bus
Message-ID: <aPkkjBa5B84N2Xz9@smile.fi.intel.com>
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
 <20251022-reset-gpios-swnodes-v2-8-69088530291b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-reset-gpios-swnodes-v2-8-69088530291b@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 22, 2025 at 03:41:07PM +0200, Bartosz Golaszewski wrote:
> 
> As the reset-gpio devices are purely virtual and never instantiated from
> real firmware nodes, let's convert the driver to using the - more
> fitting - auxiliary bus.

...

> -static const struct platform_device_id reset_gpio_ids[] = {
> -	{ .name = "reset-gpio", },
> +static const struct auxiliary_device_id reset_gpio_ids[] = {
> +	{ .name = "reset.gpio", },

While at it, the inner comma may be dropped for good.

>  	{}
>  };

-- 
With Best Regards,
Andy Shevchenko



