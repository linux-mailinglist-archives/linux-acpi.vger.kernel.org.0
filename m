Return-Path: <linux-acpi+bounces-18440-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFF8C2AE06
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 10:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B8C18925E8
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36412FAC18;
	Mon,  3 Nov 2025 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtMgeVdt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F32EF67F;
	Mon,  3 Nov 2025 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163700; cv=none; b=GJ98nIGemOouQMKpu/FAzOOc0BkaSNfdoNi2DDyUgpUkE3JFtYSpF51U7h6ydN3qEKIMTfE77wIIh/9eEMntF5u1iA9w/yy3b5h4zJfy5KAicbAHArLcwsnBK5sZvU9fW+rMZr6PD7zlbuCAuCP5MEhMSXfNJPNEqaCNQ9QiM70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163700; c=relaxed/simple;
	bh=yQa4fCCd+0RrzE8ETtLOE7Xo92os239xq4EPY1eQQzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kq543p/Ev+k0Dtpj96m4Dt9tdX1WeSX1GapT4SnwHXWRpC/mvxFoY2gu8ma/CgudKhB5gk2ebAWZnoCUL+quJFXDuykPfuKdc7m8PEtZV0qZbTQhG0Yz8c3h9vY/rIErjm9+RQRcF3b9LGenRokN5GEapoSnNwJBwGOk7BbJbL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtMgeVdt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762163700; x=1793699700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yQa4fCCd+0RrzE8ETtLOE7Xo92os239xq4EPY1eQQzU=;
  b=QtMgeVdtRcnvkDln2J4VGss4gKOga7HA28a15F8+qqAx3Ap0jDggPMYb
   gKbMYMqTsgl+QwvjvxnQsDZsIJCYR8FrT7axMb/xggm+SZ8Tl+IYfVfwX
   lioe/dMo4r+HUqrOWkrgoidL6EnjowIg7a3ULkEbXw4clN9NF3tXSDx2Z
   zQ6TF893OLDPfG3Z8t7NmleYI0VWgj+zSlsLRw7qbnWGQ6qKm+Gd3IZu5
   tpp+MsO28DZIx4JXGrGVH2y1y90SoGMxUlHyD38IfIZ2eS7Z/Ezl9tsdI
   3AmEc0Wmzd8ZXlcjBe1TusnOmEuyl/c/gIgrb/i2PNa27I7dFUY7JV14Y
   g==;
X-CSE-ConnectionGUID: WywI/TBjT/Kwjp3Di6MiZw==
X-CSE-MsgGUID: a2iDg9ghTQinKteSFd7Hgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="64385902"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="64385902"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:54:59 -0800
X-CSE-ConnectionGUID: M+65Q2l/RpGbrsL2/LCgYQ==
X-CSE-MsgGUID: j5iwjLUzTtG/F1ScxkviAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="217650118"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 01:54:55 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vFrH0-0000000571a-2G9K;
	Mon, 03 Nov 2025 11:54:50 +0200
Date: Mon, 3 Nov 2025 11:54:49 +0200
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
Subject: Re: [PATCH v4 05/10] gpio: swnode: allow referencing GPIO chips by
 firmware nodes
Message-ID: <aQh76Qo-PAunVLcr@smile.fi.intel.com>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-5-6461800b6775@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103-reset-gpios-swnodes-v4-5-6461800b6775@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 10:35:25AM +0100, Bartosz Golaszewski wrote:
> 
> When doing a software node lookup, we require both the fwnode that
> references a GPIO chip as well as the node associated with that chip to
> be software nodes. However, we now allow referencing generic firmware
> nodes from software nodes in driver core so we should allow the same in
> GPIO core. Make the software node name check optional and dependent on
> whether the referenced firmware node is a software node. If it's not,
> just continue with the lookup.

...

>  	gdev_node = to_software_node(fwnode);
> -	if (!gdev_node || !gdev_node->name)
> -		return ERR_PTR(-EINVAL);

The whole patch can be done in two lines (1 changed, 1 added):

		goto out_fwnode_lookup;

> -	/*
> -	 * Check for a special node that identifies undefined GPIOs, this is
> -	 * primarily used as a key for internal chip selects in SPI bindings.
> -	 */
> -	if (IS_ENABLED(CONFIG_GPIO_SWNODE_UNDEFINED) &&
> -	    !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
> -		return ERR_PTR(-ENOENT);
> +	if (gdev_node && gdev_node->name) {
> +		/*
> +		 * Check for a special node that identifies undefined GPIOs, this is
> +		 * primarily used as a key for internal chip selects in SPI bindings.
> +		 */
> +		if (IS_ENABLED(CONFIG_GPIO_SWNODE_UNDEFINED) &&
> +		    !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
> +			return ERR_PTR(-ENOENT);
> +	}

out_fwnode_lookup:

>  	gdev = gpio_device_find_by_fwnode(fwnode);
>  	return gdev ?: ERR_PTR(-EPROBE_DEFER);

-- 
With Best Regards,
Andy Shevchenko



