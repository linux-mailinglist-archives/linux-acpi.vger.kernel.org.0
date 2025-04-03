Return-Path: <linux-acpi+bounces-12673-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2556A7A120
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 12:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7AC175135
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE15B24A054;
	Thu,  3 Apr 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEGHM2gP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85D52417D7;
	Thu,  3 Apr 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676512; cv=none; b=pMzpokjbbpw5tQh1HBGIgVtpcS53iZB40bDx1ix3p0frHQHpDvtE3ulqZZcl+NDfGhaSWfyAjPwh1U/c7qY7rjEQPgvt+0FHOCkyRdMNlv0Ir7DlzZMp1a1g9C4I4Ecl+4r0nsgQYTfPvAjA7Iw5LbDbTNt2PtjIRnNlG6QSzpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676512; c=relaxed/simple;
	bh=GD8GtdqYWV9GQMQcIMlkLPP31qBj8F+7qvyBxc/kjXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuRY9kjxBQdNFiIIlx4dn1NORoaqhdBaGZqpSDO3UOAVN+kHkJlEC4mJi6AprxEqhWHO+fi5UM6nQ1xbNUsc/53dzPgt7ORkzin6pLA6eDiT8m0eWxa1MArIfVFYIyXGQlptDzw+fHwZsk0sp9ujLcSr7ZnAN3kx8Q/hKMhwrZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEGHM2gP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743676511; x=1775212511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GD8GtdqYWV9GQMQcIMlkLPP31qBj8F+7qvyBxc/kjXY=;
  b=LEGHM2gPOv2D4AxvwmODVuZCmSZQetQkTnaFJEb9vgAT2frCspXXj3Ik
   ccFDJ+uBKxINfgA5E628RGyp1zGcO+AeU61x9eOjcrGVXUDHz2SVb5ZNI
   lElmECOxTCPF4CJHOgk/MHSnfTADWrQPlghNUa0GA8YGZSwBRmfhJUTmH
   1rmgtjS4c9tKOLzk5Z2E1SHFNtIbp2IburfxGsOK0Bj4ZBl1K8CE9VTjF
   69qN0bVGd5gzEU9wGR3LRCj0txkTOV1im23cnb68f0Nw/pEaftqklO/Y6
   aduH7tThVDkb7nFMbyLM0/tq4AolV2jdoRHfPqqEOzcHuYaN/aGg6GB2H
   w==;
X-CSE-ConnectionGUID: IzfXKdOeSGCmr8dfcNXgiw==
X-CSE-MsgGUID: qlMWPMqDREyfUQ9Vu5VkBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44227536"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="44227536"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 03:35:09 -0700
X-CSE-ConnectionGUID: Fs2oP0QHTh+jV+HiJSaPDg==
X-CSE-MsgGUID: V5NhXtbBR7mKH2yr3Zp2wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="157960777"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 03 Apr 2025 03:35:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id A5ED8E2; Thu, 03 Apr 2025 13:35:06 +0300 (EEST)
Date: Thu, 3 Apr 2025 13:35:06 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 4/5] gpiolib: acpi: Reuse struct acpi_gpio_params in
 struct acpi_gpio_lookup
Message-ID: <20250403103506.GJ3152277@black.fi.intel.com>
References: <20250402122301.1517463-1-andriy.shevchenko@linux.intel.com>
 <20250402122301.1517463-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402122301.1517463-5-andriy.shevchenko@linux.intel.com>

On Wed, Apr 02, 2025 at 03:21:19PM +0300, Andy Shevchenko wrote:
> Some of the contents of struct acpi_gpio_lookup repeats what we have
> in the struct acpi_gpio_params. Reuse the latter in the former.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index afeb8d1c7102..750724601106 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -744,9 +744,7 @@ static int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
>  
>  struct acpi_gpio_lookup {
>  	struct acpi_gpio_info info;
> -	int index;
> -	u16 pin_index;
> -	bool active_low;
> +	struct acpi_gpio_params par;

params is better name

>  	struct gpio_desc *desc;
>  	int n;
>  };
> @@ -754,6 +752,7 @@ struct acpi_gpio_lookup {
>  static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
>  {
>  	struct acpi_gpio_lookup *lookup = data;
> +	struct acpi_gpio_params *par = &lookup->par;

These are not changed I guess so can this be const?

Ditto everywhere.

>  
>  	if (ares->type != ACPI_RESOURCE_TYPE_GPIO)
>  		return 1;
> @@ -765,12 +764,12 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
>  		u16 pin_index;
>  
>  		if (lookup->info.quirks & ACPI_GPIO_QUIRK_ONLY_GPIOIO && gpioint)
> -			lookup->index++;
> +			par->crs_entry_index++;
>  
> -		if (lookup->n++ != lookup->index)
> +		if (lookup->n++ != par->crs_entry_index)
>  			return 1;
>  
> -		pin_index = lookup->pin_index;
> +		pin_index = par->line_index;
>  		if (pin_index >= agpio->pin_table_length)
>  			return 1;
>  
> @@ -796,7 +795,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
>  			lookup->info.polarity = agpio->polarity;
>  			lookup->info.triggering = agpio->triggering;
>  		} else {
> -			lookup->info.polarity = lookup->active_low;
> +			lookup->info.polarity = par->active_low;
>  		}
>  
>  		lookup->info.flags = acpi_gpio_to_gpiod_flags(agpio, lookup->info.polarity);
> @@ -834,7 +833,8 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *p
>  				     struct acpi_gpio_lookup *lookup)
>  {
>  	struct fwnode_reference_args args;
> -	unsigned int index = lookup->index;
> +	struct acpi_gpio_params *par = &lookup->par;
> +	unsigned int index = par->crs_entry_index;
>  	unsigned int quirks = 0;
>  	int ret;
>  
> @@ -857,9 +857,9 @@ static int acpi_gpio_property_lookup(struct fwnode_handle *fwnode, const char *p
>  	if (args.nargs != 3)
>  		return -EPROTO;
>  
> -	lookup->index = args.args[0];
> -	lookup->pin_index = args.args[1];
> -	lookup->active_low = !!args.args[2];
> +	par->crs_entry_index = args.args[0];
> +	par->line_index = args.args[1];
> +	par->active_low = !!args.args[2];
>  
>  	lookup->info.adev = to_acpi_device_node(args.fwnode);
>  	lookup->info.quirks = quirks;
> @@ -897,10 +897,11 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
>  						 struct acpi_gpio_info *info)
>  {
>  	struct acpi_gpio_lookup lookup;
> +	struct acpi_gpio_params *par = &lookup.par;
>  	int ret;
>  
>  	memset(&lookup, 0, sizeof(lookup));
> -	lookup.index = index;
> +	par->crs_entry_index = index;
>  
>  	if (propname) {
>  		dev_dbg(&adev->dev, "GPIO: looking up %s\n", propname);
> @@ -909,9 +910,9 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
>  		if (ret)
>  			return ERR_PTR(ret);
>  
> -		dev_dbg(&adev->dev, "GPIO: _DSD returned %s %d %u %u\n",
> -			dev_name(&lookup.info.adev->dev), lookup.index,
> -			lookup.pin_index, lookup.active_low);
> +		dev_dbg(&adev->dev, "GPIO: _DSD returned %s %u %u %u\n",
> +			dev_name(&lookup.info.adev->dev),
> +			par->crs_entry_index, par->line_index, par->active_low);
>  	} else {
>  		dev_dbg(&adev->dev, "GPIO: looking up %d in _CRS\n", index);
>  		lookup.info.adev = adev;
> @@ -943,6 +944,7 @@ static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
>  						  struct acpi_gpio_info *info)
>  {
>  	struct acpi_gpio_lookup lookup;
> +	struct acpi_gpio_params *par = &lookup.par;
>  	int ret;
>  
>  	if (!is_acpi_data_node(fwnode))
> @@ -952,7 +954,7 @@ static struct gpio_desc *acpi_get_gpiod_from_data(struct fwnode_handle *fwnode,
>  		return ERR_PTR(-EINVAL);
>  
>  	memset(&lookup, 0, sizeof(lookup));
> -	lookup.index = index;
> +	par->crs_entry_index = index;
>  
>  	ret = acpi_gpio_property_lookup(fwnode, propname, &lookup);
>  	if (ret)
> -- 
> 2.47.2

