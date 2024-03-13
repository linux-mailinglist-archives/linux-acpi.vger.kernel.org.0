Return-Path: <linux-acpi+bounces-4313-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8749487A714
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 12:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66FD1C2313F
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 11:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5E63FB02;
	Wed, 13 Mar 2024 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AN5eS90K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067593F9CB;
	Wed, 13 Mar 2024 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329221; cv=none; b=t1zgwnAw1Y6ZtJu0EQZxGivA79Sg2Z6IfuIWAQex7QIdQrNWlY0ufmrlMEJkreXC74J4n7BtPCPbbUZBXVH9iOFz2G8+CE/sln/w+g+S2cScmrPZcG8/N1IYr+sdNSHDGSSoL2yFPGBQd/OxVJnpl8qy89Pm4tCuOYTZb6hrlyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329221; c=relaxed/simple;
	bh=XuGuW6XvhnOtp6HfIRnoPoGh3CLC2AY/FTeix59wTzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev09KNA16tTRG1FyWdRGxJNiKbGUdWoVoA/2l+aEbkbVm92qRQeiSxbO7I1uInS0nlGJ8vAISWmRE/9+5QxfPu+VkeAjVyxcbJ4jrTW2YK+MDNqa/+vTQ+lxLH2a9gmtYmSBsz2QbuYaIy4RgREm4jufgNY7cdnTI7XbUSHn6Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AN5eS90K; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710329220; x=1741865220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XuGuW6XvhnOtp6HfIRnoPoGh3CLC2AY/FTeix59wTzg=;
  b=AN5eS90KQ9ejKsb6NQQ/RoJkX531pgkAIrr1re1nleKfQcNIF+NBYyu/
   Gdetk/Xd0js0amFYlP1+N1cBuHIxIGlaY0H7BWA6/QfC4APR/TUupW9RZ
   bTtP9cKME1wNHkdRU1qGV5UfISSM72fYuutuYQq5UcRhWN39bsmaKIyJf
   rMB7Fu3X0F9peHjG6YJzf7qhV2EQzTjn5pAb+mxqfJq/BD/ruQoEAbsZ6
   OPWQ2EHuXODFIlC8zFL/2rSn6w2fB+VZmsJucuv4mafp4HcfFWHPusoDW
   4d520cpgPVQkRt6UWAtYcc0TERBEbAE+XGSs+cmSOB0L/NoLmUeYPBRno
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8028979"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="8028979"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 04:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="914429450"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="914429450"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 04:26:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkMl4-0000000CCMO-2E56;
	Wed, 13 Mar 2024 13:26:54 +0200
Date: Wed, 13 Mar 2024 13:26:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
	brgl@bgdev.pl, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Move storage of acpi_gpio_chip
Message-ID: <ZfGNfucm2-izJBfd@smile.fi.intel.com>
References: <20240313030251.1049624-1-hamish.martin@alliedtelesis.co.nz>
 <ZfGMNWtFrgsuUdLz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfGMNWtFrgsuUdLz@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 13, 2024 at 01:21:25PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 13, 2024 at 04:02:51PM +1300, Hamish Martin wrote:
> > A memory leak occurs in a scenario where an ACPI SSDT overlay is removed
> > and that is the trigger for the removal of the acpi_gpio_chip.
> > This occurs because we use the ACPI_HANDLE of the chip->parent as a
> > convenient location to tie the 'struct acpi_gpio_chip' to, using
> > acpi_attach_data().
> > This is fine in the usual case of removal of the 'struct acpi_gpio_chip'
> > via a call to acpi_gpiochip_remove() because usually the ACPI data is
> > still valid.
> > But in the case of an SSDT overlay removal, the ACPI data has been
> > marked as invalid before the removal code is triggered (see the setting
> > of the acpi_device handle to INVALID_ACPI_HANDLE in
> > acpi_scan_drop_device()). This means that by the time we execute
> > acpi_gpiochip_remove(), the handles are invalid and we are unable to
> > retrieve the 'struct acpi_gpio_chip' using acpi_get_data(). Unable to
> > get our data, we hit the failure case and see the following warning
> > logged:
> >   Failed to retrieve ACPI GPIO chip
> > This means we also fail to kfree() the struct at the end of
> > acpi_gpiochip_remove().
> > 
> > The fix is to no longer tie the acpi_gpio_chip data to the ACPI data,
> > but instead hang it directly from the 'struct gpio_chip' with a new
> > field. This decouples the lifecycle of the acpi_gpio_chip from the ACPI
> > data, and ties it to the gpio_chip. This seems a much better place since
> > they share a common lifecycle.
> 
> Maybe in this case it's indeed better.
> 
> > The general concept of attaching data to the ACPI objects may also need
> > revisiting in light of the issue this patch addresses. For instance
> > i2c_acpi_remove_space_handler() is vulnerable to a similar leak due to
> > using acpi_bus_get_private_data(), which just wraps acpi_attach_data().
> > This may need a more widespread change than is addressed in this patch.
> 
> But with this it sounds to me that the root cause is like you said in ACPI
> removal device code, i.e. acpi_scan_drop_device. Shouldn't that be fixed first
> to be more clever?
> Or are you stating that basically acpi_bus_get_private_data() and concept of
> the private data is weak to the point that mostly become useless?

Another Q is how does the OF case survive similar flow (DT overlay removal)?

-- 
With Best Regards,
Andy Shevchenko



