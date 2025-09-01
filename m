Return-Path: <linux-acpi+bounces-16243-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BCEB3DD91
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 11:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094171A80849
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Sep 2025 09:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B87030276A;
	Mon,  1 Sep 2025 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1pb/YGX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34D30146E;
	Mon,  1 Sep 2025 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717457; cv=none; b=JdVBLiUcYgKvufiIYNXcT81lXhh30IgtrB3ZLms2XTy9pKSM0OC3VU4/6f5uJqV78JRhH/TRUMIy/sBNX59XmFPaWKjF1nbgS4sw1BGlANeSsNKcX5HGqlPnc4tCXqLynlnL6ukU1lg8nQ0cczBO1U4N7QkqwiMd8E+wV7ePg0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717457; c=relaxed/simple;
	bh=hoPwDEUVNjFvKPgr4nDs6U8M+KKVFQQSzWDP+GtJxMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjHk29sDQms3QlHk/MzGDCewJLcFdb7L3u02dHLdFZgqCcqCozgPbbFfSdTZRbUizMxUqp71e/SwlULQ0uMBSMkYX/6h1/9m5bpaw1T8Q0kFkJ5fLval61B+dlR58aZnFrJaK8+MtzXJXhMtitlQSbw7xlSzPHFUOUAjeCcerQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1pb/YGX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756717456; x=1788253456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hoPwDEUVNjFvKPgr4nDs6U8M+KKVFQQSzWDP+GtJxMQ=;
  b=H1pb/YGXjS4J4eBB4xioD8BY70DusvMBLm4R2b3NRxq4eYNaJeohll2H
   KqHd6ew+KzJ1ge7bRhoo6ajFnZu6SfDILY0/OGL/2q/t1d4HM7JUQsHHS
   IgbZdpGhfongvBzplh2EjUYx6kCJmy7eXxFJLqy2LbEfAwsEEVA2ihVJA
   Jo05To6gegddJxvFd8QCNGml/r+lEzODMYO/BzhgIsyiJaFbtqX05js67
   LRIwcJDc/jaE0e0oAolhiwmNlrsH+sbDInzowgm6g0+YdcxEZu0JNzyVY
   TKxuebGWaxflpFvtp72ZgVABUUl+OKJpn4qufwt6uIx9ekmfD2/Q1tyBh
   g==;
X-CSE-ConnectionGUID: dm6NPY8cR5aflnYMIEG86g==
X-CSE-MsgGUID: 9idTNztJR3ayuajP2B+kwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="62613046"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="62613046"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 02:04:15 -0700
X-CSE-ConnectionGUID: i7u0poHqRTKPrl9hIWrF2w==
X-CSE-MsgGUID: aEMnrN8xRqyolytZZUIu9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="201897708"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 02:04:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ut0SQ-0000000AMqp-1kPB;
	Mon, 01 Sep 2025 12:04:10 +0300
Date: Mon, 1 Sep 2025 12:04:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-05
Message-ID: <aLVhijm0pXWItwAt@smile.fi.intel.com>
References: <20250827175842.3697418-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827175842.3697418-1-lkml@antheas.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 27, 2025 at 07:58:42PM +0200, Antheas Kapenekakis wrote:
> Same issue as G1619-04 in commit 805c74eac8cb ("gpiolib: acpi: Ignore
> touchpad wakeup on GPD G1619-04"), Strix Point lineup uses 05.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



