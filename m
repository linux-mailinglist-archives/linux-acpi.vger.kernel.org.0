Return-Path: <linux-acpi+bounces-5892-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B8F8C98A7
	for <lists+linux-acpi@lfdr.de>; Mon, 20 May 2024 06:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913171F21AB3
	for <lists+linux-acpi@lfdr.de>; Mon, 20 May 2024 04:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C70011184;
	Mon, 20 May 2024 04:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="haioVuSD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D950468E;
	Mon, 20 May 2024 04:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716179876; cv=none; b=UrkrMVkN1qo/K8dSIqo+1l8MBZueGlv0oEeMo0RiDFxAhlzkjIcQXU0kwqBYUsHIjCp+ng6xkh1am7/Ipf2A7phierv9VP2qsb6e4cMUNgI/0oD2hsIK1vVoHblgz9XmLFHSSCURUy17IXZhKu8QiMx28fDE1Y8uX8GRriynbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716179876; c=relaxed/simple;
	bh=2YAnCqrREP/hJDbqr7chrj4LIgZjefs5gj8e5cVBzIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0RcQewxWKgvPyg4MrxuNhJrdnWvE0cRQQ5ABXj8mvbNye3h2xFhQtbLwBsWlh8Zzp0FHec860UNXa+Njf/360PDgvcqyMHFIyFKa9nVN5qyEmFXVSyK5Cv3GjDLQVLY0E9hjw4lqhU2LqA/tCDIxgHEuSBcOumIdfxDoo3lUMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=haioVuSD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716179875; x=1747715875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2YAnCqrREP/hJDbqr7chrj4LIgZjefs5gj8e5cVBzIQ=;
  b=haioVuSDGKTr4cf24fmI7M2y5ljVi6siZX7365F+PoMNB9///osAk1i+
   Z0l2hgswYqu+eVeHojqBXe9WLurtjdtn5SONBnxUa+FB8LXNLzhY4P6xp
   ZipWEZolzeMwcA398VdG6YAZuBgAhxfkUObyGIvSq2YlUz6eUhlPt5bAm
   Jtwl8bZY+7qHZYCTJ4tGC8U4lfcJAjnshIcPJePGkBpMEn24Nrv9llyrm
   J//oX0eTq9Oc2leoYXAOq4cI7sPrTI0pLBy54cNSAnvSGDYwQk15b/XTo
   GIRIbYZbrB2hlDqcpgH/xwBL2PF80mtp5KkUCXyLBfEZZUewlvb4OtPF/
   w==;
X-CSE-ConnectionGUID: D/bIB6QuSHO6VQ4TijWdGg==
X-CSE-MsgGUID: WICmLBEYTIyrnvBaVxv2Xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="16116490"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="16116490"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 21:37:55 -0700
X-CSE-ConnectionGUID: oMFfpQaRSVOQnyfAVkcMwA==
X-CSE-MsgGUID: aCR+5qLdTjawS+XI7LU1/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="33009876"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 19 May 2024 21:37:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id B0519193; Mon, 20 May 2024 07:37:49 +0300 (EEST)
Date: Mon, 20 May 2024 07:37:49 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Devyn Liu <liudingyuan@huawei.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, f.fangjian@huawei.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
	jonathan.cameron@huawei.com, yangyicong@huawei.com,
	yisen.zhuang@huawei.com, kong.kongxinwei@hisilicon.com
Subject: Re: [PATCH] gpiolib: acpi: Fix failed in acpi_gpiochip_find() by
 adding parent node match
Message-ID: <20240520043749.GH1421138@black.fi.intel.com>
References: <20240513075901.2030293-1-liudingyuan@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240513075901.2030293-1-liudingyuan@huawei.com>

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
> 
> Fixes: 5062e4c14b75 ("gpiolib: acpi: use the fwnode in acpi_gpiochip_find()")
> Fixes: 067dbc1ea5ce ("gpiolib: acpi: Don't use GPIO chip fwnode in acpi_gpiochip_find()")
> Signed-off-by: Devyn Liu <liudingyuan@huawei.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

