Return-Path: <linux-acpi+bounces-11737-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BB9A4C6DD
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 17:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA5B7A9AB7
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C274227EBF;
	Mon,  3 Mar 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjX/z3rw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F55241139;
	Mon,  3 Mar 2025 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018264; cv=none; b=tiHV3Q45421VOmBDIhM2oADENQxty9FDbBqUJyavMjU3tsgDAfvN0dt+xznhnt+1wCLW8Or4eNDCTllT4ouvO+8wMXaysxwcW2SQBzqjn5Ifj/Rva7wjtwpER2r7o7kD06CIkvibiHFmCjv6KBmOC18A3ZY2YdbsqUtOjXX8otg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018264; c=relaxed/simple;
	bh=QQIDOhSvxTEQ/p8Q5kXn2VFgSumYab+p4JRolyOFisI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMI6ga/SlW2NG+GW0a1EMquXQJXGa1u1DxpuljQclZkO2+8D3IGM+wHNDu1hr7uK7JHvcMS7DoW70rJ4IXCAmLoupG1sTKl4EzJhe+nDZiwL4gcsLkQPMk5XoEPhwgn5q5oHtklqGxL+zv5cp5D0xCtERRvLmHfiZVkoujpm1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjX/z3rw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741018261; x=1772554261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QQIDOhSvxTEQ/p8Q5kXn2VFgSumYab+p4JRolyOFisI=;
  b=TjX/z3rwNX48xzxYXGTRmY/CwjV+iW8YDd8BkRqzQax/7wdhha2z7pIL
   n9cvLgWCBcO+OtMy6pvlTqS6kz/AWrusqhTHPiZIl4EJxAvZXn3CRC+6H
   B904yAzcDpiZDTUv0wyrqkMycGBWnqN41yyoKBJCMzIy9rGJAZTOMf7NJ
   wEcU1swgYCyNHMgYpbxcZWuGn0O5i872S8Ot5JZkSksJ4YRd1laMh6JOz
   loZ/sIIDW2Lyok9KvtYRdc8Inzx95hQ44YdJLU7jEKFzyfuC2PJWjpztj
   F1bivxHF1lWAzs10eMs+Aa+pJd5hy3AUZfreMSqUOkOtnBi7PsG77OoBu
   A==;
X-CSE-ConnectionGUID: 9cDxg380RFaBASzmQQp+bQ==
X-CSE-MsgGUID: 1d16Fpb9Rm2wapjG9QsahQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="59311535"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="59311535"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:11:00 -0800
X-CSE-ConnectionGUID: dcpOc7HHQcWTgk9t7GZlqQ==
X-CSE-MsgGUID: N2y0weZaRY+g7jVOS8lpgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="118765326"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:10:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp8Nb-0000000GrLO-1dkQ;
	Mon, 03 Mar 2025 18:10:55 +0200
Date: Mon, 3 Mar 2025 18:10:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v1 3/3] gpiolib: Rename gpio_do_set_config() -->
 gpiod_do_set_config()
Message-ID: <Z8XUjwZ6SWrHkTYx@smile.fi.intel.com>
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com>
 <20250303160341.1322640-4-andriy.shevchenko@linux.intel.com>
 <Z8XUMRAlR3H13zha@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8XUMRAlR3H13zha@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 03, 2025 at 06:09:21PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 03, 2025 at 06:00:34PM +0200, Andy Shevchenko wrote:
> > In order to reduce the 'gpio' namespace when operate over GPIO descriptor
> > rename gpio_do_set_config() to gpiod_do_set_config().
> 
> This change was made against my custom tree and I forgot about that.
> I will wait for the overall response to this series and if okay I
> may issue the correct patch.

Or I can send that custom change separately as a prerequisite...
Tell me what you prefer.

-- 
With Best Regards,
Andy Shevchenko



