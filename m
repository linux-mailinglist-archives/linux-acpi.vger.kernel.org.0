Return-Path: <linux-acpi+bounces-8490-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FC698A0A6
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 13:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4951C2691D
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 11:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B021118E354;
	Mon, 30 Sep 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkXsh5/m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBBD18E34A;
	Mon, 30 Sep 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695357; cv=none; b=jWVI6oRXclSa71JUjKocM+Rwq1lTvlCNL+2spIEOlHV1W4+FNJdmGWXVbgv09tK/fsvYdLbIxELGDuAoCPqPvacavYACjgmQI+5KEpH6yX9ALqm4tchgsnmAyd2AwxqZ1BuVmQL+8BdepYXbezR34PA3ACypH3/m8lCB77v5UtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695357; c=relaxed/simple;
	bh=tvb6ri3Nja796exCyfmuCOvDiq1nQKOLbn41ZnZS74Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnViJEZdmlQSS/sQTON3lBb/HOcoOvO8XplBZziQqrEQq21mwzArrYC9jj3kAiJvCr+nrTMtSVhiDZWXFhB4Vatoj34Xb8k4f3yAK4vkYYE3OLCVcsaP7zLFTNE6AkMqwbmoSF4cB+onNddo89wc4nyN6grnj+sTJCtzksDSOVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkXsh5/m; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727695356; x=1759231356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tvb6ri3Nja796exCyfmuCOvDiq1nQKOLbn41ZnZS74Q=;
  b=RkXsh5/mbDCDc/lbnGR4wMMCSR4ce+5dkSBCmFhVycPYJoXPhWZOl/gO
   yVI++7fwHUmdkcsurtz4JeM0Uq4YuDUIrOK7kzxiUlMkNiTCDp87jChrT
   M1c8ENbUi6BjzuIcDYcKzLAFDEPzHJ+Jx4Xs584ueNyLBIhZ3SJUNw5VJ
   +zhppwKO9eDRDIu8TlJ38EwL12gKsjY3AiHC119QstGd1OhFVv6Jkyich
   Q63O2zTDHJB+vBdXa7bJeT1/rkEWYJtrelxQcFHZmvmks+I/a22Qcv5CD
   eCm6IVBiUZjKm99qJK9E/nUcOb2MPgCRONssdDaRSKNlNziHxOHnKIt2E
   A==;
X-CSE-ConnectionGUID: TyIQlE3CS9qKHIv5gmUV7g==
X-CSE-MsgGUID: G32gimmgTHG4KqU1dsiCDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26874639"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26874639"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 04:22:35 -0700
X-CSE-ConnectionGUID: MOm71n1SQV2VNv7p0sKOYQ==
X-CSE-MsgGUID: m49Qbj5DSgSTrctPjP8Dmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="104074033"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 04:22:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1svEU2-0000000Edaa-0ETj;
	Mon, 30 Sep 2024 14:22:30 +0300
Date: Mon, 30 Sep 2024 14:22:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Hoan Tran <hoan@os.amperecomputing.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/3] gpio: dwapb: switch to
 device_for_each_child_node_scoped()
Message-ID: <ZvqJ9ddw9uAVSqk1@smile.fi.intel.com>
References: <20240928-gpio_device_for_each_child_node_scoped-v1-0-c20eff315f4f@gmail.com>
 <20240928-gpio_device_for_each_child_node_scoped-v1-1-c20eff315f4f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928-gpio_device_for_each_child_node_scoped-v1-1-c20eff315f4f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Sep 28, 2024 at 09:47:35PM +0200, Javier Carrasco wrote:
> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for a  call to fwnode_handle_put() in the error path.
> 
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



