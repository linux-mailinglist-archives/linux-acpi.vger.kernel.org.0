Return-Path: <linux-acpi+bounces-12995-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C9A87819
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 08:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA123AE7BC
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 06:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08E21B0F2C;
	Mon, 14 Apr 2025 06:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ywr+g372"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52174C74;
	Mon, 14 Apr 2025 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613182; cv=none; b=M2r+MjET3QXgT6gMh1QfWuBcC0dBwDW1xaOtcCIt04QTDdE6XRvLbCOFHRyUW/nyhg2CQ/V9Hp22KeHLz9aXwY6SV0G48tUfShgl28QWK8pHYhJ1qCkzsV9bhwfNqU/Yz7hCwSkC5TomS3De2m/GN9yzXPazplhGtkCv13ps1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613182; c=relaxed/simple;
	bh=mBGJRsQ+WsyRiRJLgjtqA2RyqOVpidlbh2FVErfwimQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=safsHTo2FX+nn9hr5/pNwPbD18PgD8Z/xYjc/LjMv39zW3im4g5Tbwps9FYniPT78Unm/D7VuYgax07OwW5If72rmlIys6jN/H/N0+jtbcix2kCnwn4xXBvOOEPW8K52Q5h4Ye7IOW7MjbU/kb+OIwTR7YiAEgK2zFQiEG0VXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ywr+g372; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744613181; x=1776149181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mBGJRsQ+WsyRiRJLgjtqA2RyqOVpidlbh2FVErfwimQ=;
  b=Ywr+g3726I8KCYzZ/ax5BtP/YAUzzNSuo05XQomwkIcVkZjo4Be8dx+L
   xcHaxJFH82tBUM6s2QkqZlUWMmUYGjKHTT3WAobSTNApVdNtR7oLwrKiJ
   UQ6bpm+AmxrAL0T1zsC5XyehPFxz9jhhb7Z3QWyQ2HTgFoKHLpSdUz6Ui
   I+mqAVC44gxoue6OCp59U4CN5NtZ7DgVksSLOa2Wt5pXlkv8PNdU9Q9k0
   y7mVm5EGEwczF6f60Mbfov1/BqcASNECQhkl0na7GzcdkQbhUZwp/EQ21
   0JPs5qrg2kBEwGd+t9pFtejpWY+n6rMGhEuTPirNdL/KWB3spNMEuoVNU
   g==;
X-CSE-ConnectionGUID: Cxnff0i8QpuQMQcHnbbl1A==
X-CSE-MsgGUID: 7Fpv0l6XTfG2HtjYlkHsfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="57453560"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="57453560"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 23:46:20 -0700
X-CSE-ConnectionGUID: IwlqUOhdRd6jYKD1Qo2myw==
X-CSE-MsgGUID: ltiacmHxRYSzFTp0okwUig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="152918174"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 23:46:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4DaA-0000000C9dy-35pF;
	Mon, 14 Apr 2025 09:46:14 +0300
Date: Mon, 14 Apr 2025 09:46:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] property: Use tidy for_each_named_* macros
Message-ID: <Z_yvNl23GcEpOkK1@smile.fi.intel.com>
References: <Z_ew4DN0z71nCX3C@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_ew4DN0z71nCX3C@mva-rohm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 10, 2025 at 02:52:00PM +0300, Matti Vaittinen wrote:
> Implementing if-conditions inside for_each_x() macros requires some
> thinking to avoid side effects in the calling code. Resulting code
> may look somewhat awkward, and there are couple of different ways it is
> usually done.
> 
> Standardizing this to one way can help making it more obvious for a code
> reader and writer. The newly added for_each_if() is a way to achieve this.
> 
> Use for_each_if() to make these macros look like many others which
> should in the long run help reading the code.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks for cleaning these up!

> ---
> The patch was crafted against the IIO/testing branch, and it depends on
> the 76125d7801e5 ("property: Add functions to iterate named child").
> Hence I'd suggest taking this via IIO tree (if this gets accepted).

I'm not sure why. The for_each_if() is part of v6.15-rc1.

-- 
With Best Regards,
Andy Shevchenko



