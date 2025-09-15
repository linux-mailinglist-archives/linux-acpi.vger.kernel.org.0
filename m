Return-Path: <linux-acpi+bounces-16889-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B9B5703A
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01BD3BB17E
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 06:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776C327A93A;
	Mon, 15 Sep 2025 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMGd1cWm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F05F17C21E;
	Mon, 15 Sep 2025 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917711; cv=none; b=gg2p8o0JHxQ95v/s4D+0qkDB5WJ45pa3sxdHbfrpxECzShG1I6NjJbB0CIqAfair4b2sYnMOBTtc//TGRO/iX7uVKJsD6NZlw7R26bFhZSyKCGNULRXqAbIybzhYrVzW3uJqVvHf7luYRLY7LH1is/bojUDSVmXfD/GWSdLq7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917711; c=relaxed/simple;
	bh=me76bROy2J9yGhs328zrnHssQDieNl60A2qZOA7dUCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp+/Ax5Oub0IRdxTNuRiDzIIWOreFam9faGEpSrQRrmihAy53dCGo+7w+RVaVE6j49NsFvg8guF7sQUcxiYB7Wic2DtF8reUbscc9Xoizt/NNhnCmY/3LbG3sJuEHIAj8EmSYDY9hqTbVnOzXmp8MG/v6OVRLcWsX8eBpHbaL00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMGd1cWm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757917709; x=1789453709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=me76bROy2J9yGhs328zrnHssQDieNl60A2qZOA7dUCM=;
  b=FMGd1cWmbgpdk0sAjKFbTs29/pRCyttBWr4kzazVpIOei+oOtE9GPSWL
   q7XVSggXQETkSxxidXSl2V35UAKTaG3gl4Ui1xdBYkTNhi/7QS+FU35Cd
   MUxnkgji7NDeY6neRoCXdedv/s+WX/pZLkm79rYwfda187lOIR1UVxh4L
   h8IukD6gusbMjay57xdUqAn15VUaTVfEfBjMuYtO6YpYGtcVtXZbltcK2
   7sFzoSmyuQVctUcNgMCfq0IYucCdTr6zDnv3TbrRzJaRkLm1XN5LMDZJA
   /AmSBjUCfIe/i3n5yKL8Bw5HmEjvUjq9VwTtwmui+9IaMrFk8JurZ/3KQ
   g==;
X-CSE-ConnectionGUID: LUllFqogR3CoiOW9d43SYA==
X-CSE-MsgGUID: NgK2qjIHTSeMqUvCcjY5GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="82750185"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="82750185"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:28:29 -0700
X-CSE-ConnectionGUID: OrN5CcvoRl6Y+/XRUR8kxA==
X-CSE-MsgGUID: x4oxwXoZR5ynmebY82APZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="173676514"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2025 23:28:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uy2hL-000000036hq-37Mf;
	Mon, 15 Sep 2025 09:28:23 +0300
Date: Mon, 15 Sep 2025 09:28:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	=?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [6.17 REGRESSION FIX] gpiolib: acpi: Fix using random stack
 memory during GPIO lookups
Message-ID: <aMeyB-mqyyCisejT@smile.fi.intel.com>
References: <20250912221859.368173-1-hansg@kernel.org>
 <CAHp75VeOAuhQC2xZxSJ_9hedNzGXdmmeAeoahnKBSR-K9UP3mQ@mail.gmail.com>
 <a73231f0-0636-45e5-a390-2fd74e192c83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a73231f0-0636-45e5-a390-2fd74e192c83@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 14, 2025 at 07:52:48PM +0200, Hans de Goede wrote:
> On 14-Sep-25 3:24 PM, Andy Shevchenko wrote:
> > On Sat, Sep 13, 2025 at 1:19 AM Hans de Goede <hansg@kernel.org> wrote:
> >>
> >> Before commit 8b4f52ef7a41 ("gpiolib: acpi: Deduplicate some code in
> >> __acpi_find_gpio()") and the follow-up fix commit 7c010d463372 ("gpiolib:
> >> acpi: Make sure we fill struct acpi_gpio_info"). The struct acpi_gpio_info
> >> used during lookups was part of struct acpi_gpio_lookup which gets
> >> memset() to 0 before use.
> >>
> >> And then after a successful lookup, acpi_gpio_resource_lookup() would
> >> copy the content of the zeroed acpi_gpio_lookup.info to the on
> >> stack struct acpi_gpio_info in __acpi_find_gpio(), overwriting any
> >> uninitialized memory contents there.
> >>
> >> But now instead a pointer to the on stack struct acpi_gpio_info in
> >> __acpi_find_gpio() is passed around, but that struct is never
> >> initialized.
> >>
> >> This passing around of the uninitialized struct breaks index based
> >> lookups of GpioInt GPIOs because info->quirks now contains some random
> >> on stack data which may contain ACPI_GPIO_QUIRK_ONLY_GPIOIO.
> >>
> >> Initialize the on stack struct acpi_gpio_info to 0 to fix this.
> > 
> > Ah, very good catch! I missed that field that can have garbage as we
> > don't file it. I'll take it on Monday and prepare a PR next week.
> 
> Thank you, but please take the more complete fix from Sébastien
> available here:
> 
> https://lore.kernel.org/linux-gpio/20250912-gpiolib-acpi-fix-v1-1-1a41acbffadf@armadeus.com/
> 
> That also initializes a second case of an uninitialized
> struct acpi_gpio_info on the stack.

Sure, thanks for the heads up!

-- 
With Best Regards,
Andy Shevchenko



