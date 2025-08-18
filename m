Return-Path: <linux-acpi+bounces-15784-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B3BB298AA
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DDC3BC690
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5523267F57;
	Mon, 18 Aug 2025 04:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIG1ajvA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34C25F784;
	Mon, 18 Aug 2025 04:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492969; cv=none; b=rw3wyJ+uKCuc7xk22isiBx5cPr/elZVCmeFpqh3eGN2mjIsXZLhScR4lkQP5NV90IZu6pxiU/XO2szeSybASkCu+urtcKTtj2f/y70r0bpJ61yYoQ6WyVE18SIcJYDu/03+0O66SLa1ta5obe8Ftpzkhjxo4HTyWN2vLHBjpGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492969; c=relaxed/simple;
	bh=phOrr6AqxsUcKASEeGxGc0+GlsCJEktRHW1Fov+4S6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/erPNYJ1ReiHeiANmulM04aC8n1/6UcHfa9pVjyfcPQHT9KOGYBK0GCI33C/Ve9aGUqtf4C+UD2rjhPRdHjl/xMU4zZjqxoXum3VWZKYT52ODu3vgCQQ5zxmdd1R5O1ZA3My1umlkVZtHXbA2UcQd0DSdZMnc6g061J6Ju/kRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NIG1ajvA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755492968; x=1787028968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=phOrr6AqxsUcKASEeGxGc0+GlsCJEktRHW1Fov+4S6c=;
  b=NIG1ajvAqwjHUBrXgYw7PyG9CSiTuQABtuKAvrq6wfRfGC8B6LuxZIK/
   1pQSrwyvME3Y4BDAjoNsHC6vbDzfSsq2SFq5KH3aUw6ztCTBh5e9HtCaf
   2540Au3YLO1+nAmH4bODA+jJ+fxvaSEW00uKziMXQVJarh+vUhMhNNKis
   Ck6zMacgB/S1ElPrSk6HxEzDw8GLACkPwKmOkf7HfyDsXdiAyfG91W7Ox
   cTRLe1IFKXm7VUsIVftRptvGxxwmzAncfGgJabNchDhmWUZECKohidacU
   ySOQ1rvHvWJfTebJQHb1VrTevf5Y7OrrysPCzfarQYBFrgZmWGlDTvldB
   g==;
X-CSE-ConnectionGUID: ekWd7ywcRQiwcTnfRAdg8A==
X-CSE-MsgGUID: gQsZkwGmR4ekvmY5ykMoOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="56916345"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="56916345"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 21:55:42 -0700
X-CSE-ConnectionGUID: 3msc1eCBRNSNvTHIaaOjNw==
X-CSE-MsgGUID: mOp1VBBoStO6fVBf06otDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167724025"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 17 Aug 2025 21:55:40 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id C04DC93; Mon, 18 Aug 2025 06:55:38 +0200 (CEST)
Date: Mon, 18 Aug 2025 06:55:38 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, westeri@kernel.org,
	andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
	brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Program debounce when finding GPIO
Message-ID: <20250818045538.GH476609@black.igk.intel.com>
References: <20250818015219.3604648-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818015219.3604648-1-superm1@kernel.org>

Hi,

On Sun, Aug 17, 2025 at 08:52:07PM -0500, Mario Limonciello (AMD) wrote:
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

The spec says for GpioInt():

  DebounceTimeout is an optional argument specifying the debounce wait
  time, in hundredths of milliseconds. The bit field name _DBT is
  automatically created to refer to this portion of the resource
  descriptor.

I was not sure but wanted to check that if it is left out, does ACPICA fill
it with 0? If yes (I would expect so) then this is fine.

> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v4:

You missed "v4" in the $subject.

>  * Just add a direct call instead
>  * drop tag
>  * update commit message
> ---
>  drivers/gpio/gpiolib-acpi-core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
> index 12b24a717e43f..6388e8e363dee 100644
> --- a/drivers/gpio/gpiolib-acpi-core.c
> +++ b/drivers/gpio/gpiolib-acpi-core.c
> @@ -944,6 +944,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
>  	bool can_fallback = acpi_can_fallback_to_crs(adev, con_id);
>  	struct acpi_gpio_info info;
>  	struct gpio_desc *desc;
> +	int ret;
>  
>  	desc = __acpi_find_gpio(fwnode, con_id, idx, can_fallback, &info);
>  	if (IS_ERR(desc))
> @@ -957,6 +958,11 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
>  
>  	acpi_gpio_update_gpiod_flags(dflags, &info);
>  	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);
> +	/* ACPI uses hundredths of milliseconds units */
> +	ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	return desc;
>  }
>  
> -- 
> 2.43.0

