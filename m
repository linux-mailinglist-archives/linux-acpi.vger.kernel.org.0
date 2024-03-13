Return-Path: <linux-acpi+bounces-4312-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8E587A704
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 12:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3178282F60
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 11:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFF43EA73;
	Wed, 13 Mar 2024 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOaMXbfm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D838DFC;
	Wed, 13 Mar 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328892; cv=none; b=QIu3nLS6dr9mTM6oYooqNOms9SaJiu7dC+WXeQoHBVHxLFsjQaiWTmZhjX8amK+SZ2XH6GuJ3f+QT8Ssz8zdnY17Fjh1QR/ov8FGPB6n6Jgeh5DMbN64KzClHvyNg2vG077KPKQGYufhwzuDv581NqM4x4jUhZHgEcuN32aV/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328892; c=relaxed/simple;
	bh=8ECqTcAirFKy8ujPXZnYM4q793Ex6GJL4Sb0p9+VxKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngX3J8bVpDeJICQ4lmgZObOrCAWtHIWgqIC+JM5bgv56uoosJSE5eKsRxXesa4TaVTQodNIg8ySePkmgIi77O01LJdDhRXcvWf6p4yudtu+oAWIvOF+esk3oBS1oQlUYWPfgYya8lpbHuIQ61gfL8Wty+nGj2iQbuW7I/bjo8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOaMXbfm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710328891; x=1741864891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ECqTcAirFKy8ujPXZnYM4q793Ex6GJL4Sb0p9+VxKM=;
  b=GOaMXbfmlTQyxfO9DoHJXGGL0ndeq7qnNfnb8XWx4JQ48GzV6Hh6tBNU
   qRnn0wKnxryILQJx1PeYpUJHy2LcBXId3od1NZJ4q4oKadWGIxurPTPoe
   mkej5UfY5eSjM+niA01ZbeKOGzYxIGGM6LMTUewg8UF8RtYGt5ixjSuIP
   TRh/rYEwzTLCqznNyHfO8oa9wEGvMO0C4BeFc5B5Lt3QDNbFYn2Xly7Ou
   fyaTPSgeAS2QE0ZzH5rdnanJ1FkpnAuGt3VZQouG/Te15nCvjfz56xSAr
   otDQbv8FsdpPNZww+ct8grNcOx9/0vAeCxDqBorAPDEdYhlHTjoStKMdf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8028603"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="8028603"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 04:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="914429334"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="914429334"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 04:21:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkMfl-0000000CCHm-3xA7;
	Wed, 13 Mar 2024 13:21:25 +0200
Date: Wed, 13 Mar 2024 13:21:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
	brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Move storage of acpi_gpio_chip
Message-ID: <ZfGMNWtFrgsuUdLz@smile.fi.intel.com>
References: <20240313030251.1049624-1-hamish.martin@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313030251.1049624-1-hamish.martin@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

+Cc: Rafael

On Wed, Mar 13, 2024 at 04:02:51PM +1300, Hamish Martin wrote:
> A memory leak occurs in a scenario where an ACPI SSDT overlay is removed
> and that is the trigger for the removal of the acpi_gpio_chip.
> This occurs because we use the ACPI_HANDLE of the chip->parent as a
> convenient location to tie the 'struct acpi_gpio_chip' to, using
> acpi_attach_data().
> This is fine in the usual case of removal of the 'struct acpi_gpio_chip'
> via a call to acpi_gpiochip_remove() because usually the ACPI data is
> still valid.
> But in the case of an SSDT overlay removal, the ACPI data has been
> marked as invalid before the removal code is triggered (see the setting
> of the acpi_device handle to INVALID_ACPI_HANDLE in
> acpi_scan_drop_device()). This means that by the time we execute
> acpi_gpiochip_remove(), the handles are invalid and we are unable to
> retrieve the 'struct acpi_gpio_chip' using acpi_get_data(). Unable to
> get our data, we hit the failure case and see the following warning
> logged:
>   Failed to retrieve ACPI GPIO chip
> This means we also fail to kfree() the struct at the end of
> acpi_gpiochip_remove().
> 
> The fix is to no longer tie the acpi_gpio_chip data to the ACPI data,
> but instead hang it directly from the 'struct gpio_chip' with a new
> field. This decouples the lifecycle of the acpi_gpio_chip from the ACPI
> data, and ties it to the gpio_chip. This seems a much better place since
> they share a common lifecycle.

Maybe in this case it's indeed better.

> The general concept of attaching data to the ACPI objects may also need
> revisiting in light of the issue this patch addresses. For instance
> i2c_acpi_remove_space_handler() is vulnerable to a similar leak due to
> using acpi_bus_get_private_data(), which just wraps acpi_attach_data().
> This may need a more widespread change than is addressed in this patch.

But with this it sounds to me that the root cause is like you said in ACPI
removal device code, i.e. acpi_scan_drop_device. Shouldn't that be fixed first
to be more clever?
Or are you stating that basically acpi_bus_get_private_data() and concept of
the private data is weak to the point that mostly become useless?

-- 
With Best Regards,
Andy Shevchenko



