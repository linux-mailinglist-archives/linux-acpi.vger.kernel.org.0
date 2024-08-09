Return-Path: <linux-acpi+bounces-7459-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4798194D037
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 14:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B6D1F209B4
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BC2194131;
	Fri,  9 Aug 2024 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVNHMXOX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58719308F;
	Fri,  9 Aug 2024 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206595; cv=none; b=M+0Q3GXi3gPoneu5cbkHO06W/0p5PnCkd9xHOX4FowPLFvcYSd0IGZ6nsI0SK43+rKR0w6EOlpnL0X1BFpPwibaY4+2Vb6j688kKaOoENB3aiCjJsFy3OmkmqUsnYnSl8M91BxEL/aRH4WSnG1XK3C5pdnteanM/pIbbcRmy4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206595; c=relaxed/simple;
	bh=/0i68SHChLXtas/gs2mFUTJN5ts/W+f0GMQgafSgfMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF/QjFQPF28ahsdfPEw/ZCbVq89At0SZHIrMi35ISSHQN330Yb0lJ4fDXwe325KdyIP2yozQjUP5CmXiAiwI+hbHXYXgI2eISiCg+cF47+k8xFBjLQTVBXXfahWfpm5kDZQGREi+T8PQGFhPfoVfJ3pyry+QjoUfjGM8Gby5NJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVNHMXOX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723206594; x=1754742594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/0i68SHChLXtas/gs2mFUTJN5ts/W+f0GMQgafSgfMc=;
  b=XVNHMXOX34crXtrjAmAl52Y4vBPfkJNpU35fwMwrHjp3gegSoQzI7gQ9
   CG2kOehZd0jOd0iw8YPn5TYkHmawH7gD350oTQaHZeDJsT/HufFqOVFRH
   yHLq+4xogUACfzEryacfNlIW/NVX33ARU0rAGGgXmSt4gQW9fvhLwQ/Cm
   fVTI69yRH99kcHlB3TAABJpwGcgC7+nykN6SUY1Hw9jJ61otjyNaD+B09
   PhHfa+O6cSH+1HbqPfJ5p/UZQN++vV+CXzcen9OXO8AyBFMVL80evehTN
   387UrmKBJgJ76wtWZBpVCb0kWiae//+m5BHtzZZAUe2EFItz6XdzrcDVg
   A==;
X-CSE-ConnectionGUID: 6B9q49g2QbyrxGboHnxEcA==
X-CSE-MsgGUID: 08/k9baLQcu2bRO9ec9cTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25247535"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="25247535"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:29:53 -0700
X-CSE-ConnectionGUID: hx0i8vIpS2WlDPjJkdNDgQ==
X-CSE-MsgGUID: YQBySL1QQeyMO87drTRkDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="58119753"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:29:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scOke-0000000DPme-3I03;
	Fri, 09 Aug 2024 15:29:48 +0300
Date: Fri, 9 Aug 2024 15:29:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: put gpio_suffixes in a single compilation unit
Message-ID: <ZrYLvCHcoNaZwPyj@smile.fi.intel.com>
References: <20240612184821.58053-1-brgl@bgdev.pl>
 <171834931757.6326.8605051498855992570.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171834931757.6326.8605051498855992570.b4-ty@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jun 14, 2024 at 09:15:31AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> 
> On Wed, 12 Jun 2024 20:48:21 +0200, Bartosz Golaszewski wrote:
> > The gpio_suffixes array is defined in the gpiolib.h header. This means
> > the array is stored in .rodata of every compilation unit that includes
> > it. Put the definition for the array in gpiolib.c and export just the
> > symbol in the header. We need the size of the array so expose it too.
> 
> Applied, thanks!
> 
> [1/1] gpiolib: put gpio_suffixes in a single compilation unit
>       commit: 7e92061f1e9d1f6d3bfa6113719534f2c773b041

Urgh... :-(

-- 
With Best Regards,
Andy Shevchenko



