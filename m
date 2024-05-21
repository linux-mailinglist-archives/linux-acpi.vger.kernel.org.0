Return-Path: <linux-acpi+bounces-5914-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD908CB1A1
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 17:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC27E2815BD
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7FF1CD2A;
	Tue, 21 May 2024 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anlTrY+9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E71FBB;
	Tue, 21 May 2024 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306451; cv=none; b=IWgKmIdm+DymfdjxoMHcrrYBzUzjNn0F3wLDZ5thERiw5zOS/F4QbLWm/MzkRcsnDqZTQNMGjXG/Mq+8QrHVc38tvNZjEqMwHhCQzIrD/oPQ+4c897Qe4ehkpK7LjmqWGw6TkOymvrI4gQqIRiBrxSgOSDCfETyVjvkKj3CYB1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306451; c=relaxed/simple;
	bh=muREvFmTCCrQm9KGsdQInt2Uyefx2O/x1zLCjJT+RiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6dgX32wWkEUHHo6hNB+RD7oEAYysKCIt+Y63CdlEj6Yfi1xEajXUCOlQYs6RihajOtbmXgPp/cw5eOwrdVpkn1AUpavtVD0NYxU3PGTZ4qUcbjc8eu/nmfSoNpoaXWxvIBYh3LBVhpUxYicf1t1CH/qRzNZ2iSQW+84aY3Cog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anlTrY+9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716306449; x=1747842449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=muREvFmTCCrQm9KGsdQInt2Uyefx2O/x1zLCjJT+RiQ=;
  b=anlTrY+9BnDBsKISlPz6cSHr8txl5W4jx9oc0m2kkiecWpbtSErvLoqz
   gU5+3S3O9QHB1OKhKHxTytQ00WCq+rlzpNJbpkh6ma4KDnz/6+l7f+roE
   53UVXsklIaIEr4MBOdFOS1szagfSIjoI/xMviyTJE4NiBhUnhS32LFSrB
   AcN8YLRMOdG6tRZWQS1WVPpe6SonJOKE6Kq9Lkc8nEw4Y7SuJ3sX6l6je
   3HlLS41iFAoxHx+ZUZlhov+OPw8XF4dbIVCMoD8XEzvsNq+EYTjZF84nj
   bZ/xKDNGV57jRjsFoAZM3dTuSMDaVV2cJZZ77lFT8m94To5/Yaz98lBVw
   A==;
X-CSE-ConnectionGUID: JqSdfCEiSlGUxa6z8yaMBg==
X-CSE-MsgGUID: omWfhK5iQq2blW/8qs3NMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12301913"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12301913"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 08:47:28 -0700
X-CSE-ConnectionGUID: A54Wee5oT5KWhdWOJyYzjA==
X-CSE-MsgGUID: T52cE34wS0qBbaLkM5ODzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="56191217"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 08:47:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s9Rhy-00000009hWz-3UE8;
	Tue, 21 May 2024 18:47:22 +0300
Date: Tue, 21 May 2024 18:47:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Devyn Liu <liudingyuan@huawei.com>, linus.walleij@linaro.org,
	brgl@bgdev.pl, f.fangjian@huawei.com, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	jonathan.cameron@huawei.com, yangyicong@huawei.com,
	yisen.zhuang@huawei.com, kong.kongxinwei@hisilicon.com
Subject: Re: [PATCH] gpiolib: acpi: Fix failed in acpi_gpiochip_find() by
 adding parent node match
Message-ID: <ZkzCCkOx8AtjPWSE@smile.fi.intel.com>
References: <20240513075901.2030293-1-liudingyuan@huawei.com>
 <20240520043749.GH1421138@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520043749.GH1421138@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 20, 2024 at 07:37:49AM +0300, Mika Westerberg wrote:
> On Mon, May 13, 2024 at 03:59:01PM +0800, Devyn Liu wrote:
> > Previous patch modified the standard used by acpi_gpiochip_find()
> > to match device nodes. Using the device node set in gc->gpiodev->d-
> > ev instead of gc->parent.
> > 
> > However, there is a situation in gpio-dwapb where the GPIO device
> > driver will set gc->fwnode for each port corresponding to a child
> > node under a GPIO device, so gc->gpiodev->dev will be assigned the
> > value of each child node in gpiochip_add_data().
> > 
> > gpio-dwapb.c:
> > 128,31 static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
> > 			       struct dwapb_port_property *pp,
> > 			       unsigned int offs);
> > port->gc.fwnode = pp->fwnode;
> > 
> > 693,39 static int dwapb_gpio_probe;
> > err = dwapb_gpio_add_port(gpio, &pdata->properties[i], i);
> > 
> > When other drivers request GPIO pin resources through the GPIO device
> > node provided by ACPI (corresponding to the parent node), the change
> > of the matching object to gc->gpiodev->dev in acpi_gpiochip_find()
> > only allows finding the value of each port (child node), resulting
> > in a failed request.
> > 
> > Reapply the condition of using gc->parent for match in acpi_gpio-
> > chip_find() in the code can compatible with the problem of gpio-dwapb,
> > and will not affect the two cases mentioned in the patch:
> > 1. There is no setting for gc->fwnode.
> > 2. The case that depends on using gc->fwnode for match.
> > 
> > Fixes: 5062e4c14b75 ("gpiolib: acpi: use the fwnode in acpi_gpiochip_find()")
> > Fixes: 067dbc1ea5ce ("gpiolib: acpi: Don't use GPIO chip fwnode in acpi_gpiochip_find()")
> > Signed-off-by: Devyn Liu <liudingyuan@huawei.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



