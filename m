Return-Path: <linux-acpi+bounces-5788-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3818C3E15
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 11:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3611C21295
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 09:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2FD1487E3;
	Mon, 13 May 2024 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyLKE9Hu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0711474B1;
	Mon, 13 May 2024 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592359; cv=none; b=pF+gnR++bhiVpxKhmZxPqptx1QJjw3eaEifKzKwiTFmOq+PN+ddu5kLCxuoOSjmDkqX3bpGw3bQDOpmlImI2Fs3ZsrGhYpVBKHhLKFPCWP6S1Zz/U1hnuFOSmnSrS8bhIKuDyxBxG18wR2lVvFOPjXF99BJMt+XeEtuRqEdHRoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592359; c=relaxed/simple;
	bh=eUxyCthTkzLGiOzZpbcweFxKVgJqygyWBG1GroNMWH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ER+R9c9NnHgvcTI+JEIGCde1wL+REdkLGH7X4aKDIeSLCI2pFEvSlO8Zt3BdlI9evUCQo5WnUAx7OU/VLtY8SdsOp+F+ET8gyEA1x9kknWsDPzN0KlZUXcGT+dUTL36dAKe+7DzS9fX3PFynrnd8OgmGp7KDENEdrFPeZPm3KT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyLKE9Hu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715592357; x=1747128357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eUxyCthTkzLGiOzZpbcweFxKVgJqygyWBG1GroNMWH0=;
  b=XyLKE9Huhp9GWGUGAKjxkd/p2SFzytfdfXTdCyp/SFs4RqoAk/Ekz3tm
   yUOVY9/lyUUdVUVXpgmy6yibKJwMqY2qEy/yIu4hTEMxlgAesYNpy9ZZ0
   ADNAPwYlTfrFuUKMkRE7JlYVGRl0Lbya7J+G1i3RcepPxdb3G3YjpGq+D
   VbhY9esCJknJbXKWqrI/rNrmXVZClKenLrbXRjz1NmCpzvJPsPIIVq8G/
   5cewN3wPsszqQhH8EEtB7AXRkBbPi1Uq4y8rityLxmqmWQPdcaU3tJ8qI
   M08RFN8TiRWoI9YQub2v1C/1jG4aKgRjH2ehW24UpVoAxZEV0C28Ih8hK
   g==;
X-CSE-ConnectionGUID: 4PY4uzQ4QAeBYwVlJNWctA==
X-CSE-MsgGUID: vqBS76DHSJuAfkHDAHnlJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="14464576"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="14464576"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 02:25:56 -0700
X-CSE-ConnectionGUID: ODn1dWKRQK6QsacEKrGs1A==
X-CSE-MsgGUID: F15USjABTZuZ9imEr2i1dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30266327"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 02:25:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s6RwM-000000074IG-1vyI;
	Mon, 13 May 2024 12:25:50 +0300
Date: Mon, 13 May 2024 12:25:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Devyn Liu <liudingyuan@huawei.com>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, f.fangjian@huawei.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org,
	jonathan.cameron@huawei.com, yangyicong@huawei.com,
	yisen.zhuang@huawei.com, kong.kongxinwei@hisilicon.com
Subject: Re: [PATCH] gpiolib: acpi: Fix failed in acpi_gpiochip_find() by
 adding parent node match
Message-ID: <ZkHcniqCiLPEPN9o@smile.fi.intel.com>
References: <20240513075901.2030293-1-liudingyuan@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513075901.2030293-1-liudingyuan@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 13, 2024 at 03:59:01PM +0800, Devyn Liu wrote:
> Previous patch modified the standard used by acpi_gpiochip_find()
> to match device nodes. Using the device node set in gc->gpiodev->d-
> ev instead of gc->parent.
> 
> However, there is a situation in gpio-dwapb where the GPIO device
> driver will set gc->fwnode for each port corresponding to a child
> node under a GPIO device, so gc->gpiodev->dev will be assigned the
> value of each child node in gpiochip_add_data().
> 
> gpio-dwapb.c:
> 128,31 static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
> 			       struct dwapb_port_property *pp,
> 			       unsigned int offs);
> port->gc.fwnode = pp->fwnode;
> 
> 693,39 static int dwapb_gpio_probe;
> err = dwapb_gpio_add_port(gpio, &pdata->properties[i], i);
> 
> When other drivers request GPIO pin resources through the GPIO device
> node provided by ACPI (corresponding to the parent node), the change
> of the matching object to gc->gpiodev->dev in acpi_gpiochip_find()
> only allows finding the value of each port (child node), resulting
> in a failed request.
> 
> Reapply the condition of using gc->parent for match in acpi_gpio-
> chip_find() in the code can compatible with the problem of gpio-dwapb,
> and will not affect the two cases mentioned in the patch:
> 1. There is no setting for gc->fwnode.
> 2. The case that depends on using gc->fwnode for match.

Thanks for the report, analysis, and patch.

...

>  static int acpi_gpiochip_find(struct gpio_chip *gc, const void *data)
>  {
> -	return device_match_acpi_handle(&gc->gpiodev->dev, data);
> +	return device_match_acpi_handle(&gc->gpiodev->dev, data) ||
> +		(gc->parent && device_match_acpi_handle(gc->parent, data));
>  }

I'm wondering if the below approach will work for all:

static int acpi_gpiochip_find(struct gpio_chip *gc, const void *data)
{
	struct device *dev = acpi_get_first_physical_node(ACPI_COMPANION(&gc->gpiodev->dev));

	return device_match_acpi_handle(dev, data);
}

Cc'ing to Benjamin for testing and commenting.

-- 
With Best Regards,
Andy Shevchenko



