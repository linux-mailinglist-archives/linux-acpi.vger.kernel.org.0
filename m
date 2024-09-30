Return-Path: <linux-acpi+bounces-8492-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6656498A0AF
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 13:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C081F26F4D
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 11:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8D18FC6B;
	Mon, 30 Sep 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQyGDLFS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C6018A6C6;
	Mon, 30 Sep 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695397; cv=none; b=tKihzO+rqV681rMSrNfeMALU0srLqqkmlQ1qIPaOVeFWL69N2wc0QNhziVWYiHaqgV9TKFIybh6z2kRAShjRn5sDNAP5h+2mwl8omstxioICW/phDNMdpacgnCse/anv3OexCtm5iu6uITFUfwcvBSdCLcARKZoQIc2v/mbI/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695397; c=relaxed/simple;
	bh=UcxX2EbKxzeP73iWfO/ySnrabb7OCG9HXv8UuO2S6qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz6l7b8uJ994BqIXXxy5IZKG0fTxkik5vOusgtCBO51+YPRlbxSO7z4m0Vn2DegMLJYINQp4T/v7c39RNF1mKJrqImdQ3g4A9pxRvO+vZ9n93cR2YOsBdzN9ZvcHEXnGFAYVlxwgSZLjH0zPw/Jzj58zC7ljiIeOLePhntGbxfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQyGDLFS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727695397; x=1759231397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UcxX2EbKxzeP73iWfO/ySnrabb7OCG9HXv8UuO2S6qw=;
  b=SQyGDLFS5vYWTgf1EF71CtfsNdRbqVFesUvGfX1DwBg+dH7v27GXfcf0
   X4NNeL1rsrPkk3ELWcqI8lrLEh36hkWEj40B+iPaeSgzlh9oVaFqriAa/
   G/Z4wRuidg/TEYzbPSaaL1F3XURrt6Bdl9FYav6UCSJQ8F2IRcr7cQQKL
   eqAFAsKcmf454k6L8PdTYo284KwoCp3gbTK1X/HLdAEnfwC0h19IEqMnS
   k8k7y3CyYNi6vrckjfVJDOvnc2SkJequWkFVl7oFCTc1S5pzgkPmkeTsd
   dl0OVr2jrIS1EOyPCnYu5u82op4xbtLLjV5uaZcH4XEKpqTbKtbEq6Iip
   w==;
X-CSE-ConnectionGUID: Rec4yyEXQ4OwU+k80AuBDA==
X-CSE-MsgGUID: t5NhqXZtQAm/w24vxbuocg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="44240056"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="44240056"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 04:23:16 -0700
X-CSE-ConnectionGUID: 9qZY/RhISTydtQyrNkQzNA==
X-CSE-MsgGUID: IpPpP0K8TdudyLWvMEDpiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="72943098"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 04:23:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1svEUg-0000000EdbM-3yvL;
	Mon, 30 Sep 2024 14:23:10 +0300
Date: Mon, 30 Sep 2024 14:23:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Hoan Tran <hoan@os.amperecomputing.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 3/3] gpio: acpi: switch to
 device_for_each_child_node_scoped()
Message-ID: <ZvqKHqBAvimceWzo@smile.fi.intel.com>
References: <20240928-gpio_device_for_each_child_node_scoped-v1-0-c20eff315f4f@gmail.com>
 <20240928-gpio_device_for_each_child_node_scoped-v1-3-c20eff315f4f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928-gpio_device_for_each_child_node_scoped-v1-3-c20eff315f4f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Sep 28, 2024 at 09:47:37PM +0200, Javier Carrasco wrote:
> Switch to device_for_each_child_node_scoped() to simplify the code by
> removing the need for a call to fwnode_handle_put() in the error path.
> 
> This also prevents possible memory leaks if new error paths are added
> without the required call to fwnode_handle_put().

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



