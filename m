Return-Path: <linux-acpi+bounces-13729-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6E5AB81DB
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 11:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936309E60AD
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 09:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6F02957C3;
	Thu, 15 May 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEgR28s3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37C28935D;
	Thu, 15 May 2025 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299524; cv=none; b=BJkMugXrwy8Y9jK3W22Joq4BQLcWBwW0noAUYXRyoY+tgjJigH32qwQqohW3w9Rfa9MdD98n7xoKIDZ0SijywciNhUhh+s6EIhhulAPUDNFk6YTLqoOJYsnZ+Xg73vc9cH8HU5Su4Yy0KbFIch1nRZvHk0cUHLRCp93xM1lHg/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299524; c=relaxed/simple;
	bh=fQT9k3Da6Wvq0TYDDTvmlNbPMwESEq76o0FhaDKPx84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0ruvsfHSg6zsuTDPyZBQHdD7eMNqz+z8yBd+RJcYNxFEItMzFGcUw5TxvO1J3UPf5wRy0j7dEosKxKcCNfh4vK/PXniziZPH6A2xKf2m2Ktup4gwP0URsUsR994vWNIVEpdAmeoAOjDUV8zzy8NuqHmL54yzNjazcM+GEabQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEgR28s3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747299523; x=1778835523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fQT9k3Da6Wvq0TYDDTvmlNbPMwESEq76o0FhaDKPx84=;
  b=SEgR28s3BUJd2Ap0Z7O9hnQ7VBpZcK9Sl7mXzDTzEHzOkHi4dbDQj3S+
   lfIkxGM0qApn7yQGwEW2S1SfnyScIkZ6C0aA6xcXC0ZnUXGUtGmwd494M
   wMQQXvxa/TN+hzChbwPd3U+rlSatu4omTTZn1AJlHUNe2+wfi0RQYPr9J
   qd/hfIPemioF9lkKdPtfAgm+CZZAZbSF+3WBxdEH+ZooKWHcRw+CyEc9m
   bTXeKynvFSUTp0NGGIaBj2zjnzzLD7ZYOhcB5LYQk55JuPUrUREVQh9ry
   YTF15OmxOpp4JNya/1zAmdC9Tvl2Mr7H1ocV05KpB9cqjWcWJ7YaGbBan
   Q==;
X-CSE-ConnectionGUID: 4E/mgJunStCK5r584E9nDQ==
X-CSE-MsgGUID: H0SXvrBjQ8O9QHBLiaq4Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66776490"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="66776490"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:58:42 -0700
X-CSE-ConnectionGUID: fmompXI5SUO4bQqfMyjuig==
X-CSE-MsgGUID: jh2Nv7BFQI2pjUFKDv76eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="139206406"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:58:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uFUQD-00000001nTF-477r;
	Thu, 15 May 2025 11:58:33 +0300
Date: Thu, 15 May 2025 11:58:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 0/4] gpiolib: acpi: Split quirks to its own file
Message-ID: <aCWsuRc5ggJJFc5u@smile.fi.intel.com>
References: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
 <20250514155955.GS88033@black.fi.intel.com>
 <aCWgBp4ZD5aesvRw@smile.fi.intel.com>
 <20250515083451.GT88033@black.fi.intel.com>
 <aCWo19FjcvZzP1H7@smile.fi.intel.com>
 <20250515084727.GU88033@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515084727.GU88033@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 15, 2025 at 11:47:27AM +0300, Mika Westerberg wrote:
> On Thu, May 15, 2025 at 11:41:59AM +0300, Andy Shevchenko wrote:
> > On Thu, May 15, 2025 at 11:34:51AM +0300, Mika Westerberg wrote:
> > > On Thu, May 15, 2025 at 11:04:22AM +0300, Andy Shevchenko wrote:
> > > > On Wed, May 14, 2025 at 06:59:55PM +0300, Mika Westerberg wrote:

...

> > > > That's might be the next step to have for all of them, but these are ACPI
> > > > specific. In any case they can't be put to gpiolib-quirks.c due to module
> > > > parameters. If we do that we will need a dirty hack to support old module
> > > > parameters (see 8250 how it's done there, and even author of that didn't like
> > > > the approach).
> > > 
> > > Hmm, how does it affect module paremeters? I thought they are
> > > gpiolib.something as all these object files are linked to it?
> > 
> > gpiolib_acpi.FOO because the object file is gpiolib-acpi.o.
> 
> Ah okay.
> 
> > > At least can we drop the gpiolib-acpi-core.c rename?
> > 
> > Unfortunately no due to the above.
> 
> This does not work?
> 
> gpiolib-acpi-y                 := gpiolib-acpi.o gpiolib-acpi-quirks.o

No. You can't use the same name on left and right parts.


-- 
With Best Regards,
Andy Shevchenko



