Return-Path: <linux-acpi+bounces-12729-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7807A7B6F6
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 06:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2064F7A5AA0
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 04:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF4B2629D;
	Fri,  4 Apr 2025 04:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUwl9Mhd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A471448D5;
	Fri,  4 Apr 2025 04:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743741808; cv=none; b=um9LeikhahAFPFZ/SQAW1j1nayK+4pV0IGLQCdeLej9kkiyopvhA1Zn9KbUrpPqP24NUYZTp5nwIkEeRGvszxxwLdoLqUqrzK1aMtiLmNji2mxL/HFJ9e5UQoZXhMMqtXTiUH6JwYwL00ukHhkt/8Ye1RpHEpsXsOrc8sKlvIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743741808; c=relaxed/simple;
	bh=yOFP6WyBvsmJomlapRb3VVI2bxBHvehWdst6fSGFPYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvGVFfLl2UuP+aWoCWLemMUbcGUShiBwfkByd9QdExt1cnOVOHPqPlgGjb5nmYsPcSMqidjE6g4AyyZAPb3ZalysLpsmellzjIJwJ+BBN1Ixclph6wUl8xeVGo33YH4BXojuUO/atv+yMacH95VfqkRtvvIJLod73GaR7rqEfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUwl9Mhd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743741807; x=1775277807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yOFP6WyBvsmJomlapRb3VVI2bxBHvehWdst6fSGFPYQ=;
  b=ZUwl9MhdaCuNyxH1DyhYtsrNOt4AntXvxBJoUZCTVSwV+YBQAuu4GvBa
   X/GXnnnDTIy3ydtAv90oRiv9FMU1sOcBbGYHQ2m7hkNmwj5RkpBjMO7wQ
   Y7rlvMZ85Xj2fmd/H0zLiU29YG2lRZeYfhk4pPcFHLl+IRldRYxC0IPVn
   9gCm0VtheX4fkMZbMADqxmIlPcdGZI7fnusvRgSqeSDtrHGU9F8jEHoSO
   6azxuuEoE/YIqk7sPM4wZSUQenE7vW2rHbSo8rzR60STLHgI7eTduclq5
   mm0RIcvCpaTHu+FKljiyoXzU7NIwsEyUJ57sGifCvSPGClPKQcmS29oni
   g==;
X-CSE-ConnectionGUID: aakOP+3BQHuJF453rDv7/w==
X-CSE-MsgGUID: 1UuHOrvESW29k17M8iEN0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="45348980"
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="45348980"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 21:43:22 -0700
X-CSE-ConnectionGUID: o2F2cX8WSia7cBJ2AnsCHg==
X-CSE-MsgGUID: +1RCCa9DRZuGs3fmv8VukQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,187,1739865600"; 
   d="scan'208";a="126985059"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 03 Apr 2025 21:43:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 5A50F141; Fri, 04 Apr 2025 07:43:18 +0300 (EEST)
Date: Fri, 4 Apr 2025 07:43:18 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 0/6] gpiolib: acpi: Refactor to shrink the code by ~8%
Message-ID: <20250404044318.GL3152277@black.fi.intel.com>
References: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>

On Thu, Apr 03, 2025 at 06:59:11PM +0300, Andy Shevchenko wrote:
> A simple refactoring of the GPIO ACPI library parts to get an impressive
> ~8% code shrink on x86_64 and ~2% on x86_32. Also reduces a C code a bit.
> 
> add/remove: 0/2 grow/shrink: 0/5 up/down: 0/-1221 (-1221)
> Function                                     old     new   delta
> acpi_gpio_property_lookup                    425     414     -11
> acpi_find_gpio.__UNIQUE_ID_ddebug478          56       -     -56
> acpi_dev_gpio_irq_wake_get_by.__UNIQUE_ID_ddebug480      56       -     -56
> acpi_find_gpio                               354     216    -138
> acpi_get_gpiod_by_index                      462     307    -155
> __acpi_find_gpio                             877     638    -239
> acpi_dev_gpio_irq_wake_get_by                695     129    -566
> Total: Before=15375, After=14154, chg -7.94%
> 
> In v2:
> - renamed par to params (Mika, Bart)
> 
> Andy Shevchenko (6):
>   gpiolib: acpi: Improve struct acpi_gpio_info memory footprint
>   gpiolib: acpi: Remove index parameter from acpi_gpio_property_lookup()
>   gpiolib: acpi: Reduce memory footprint for struct acpi_gpio_params
>   gpiolib: acpi: Rename par to params for better readability
>   gpiolib: acpi: Reuse struct acpi_gpio_params in struct
>     acpi_gpio_lookup
>   gpiolib: acpi: Deduplicate some code in __acpi_find_gpio()

Looks good now,

Acked-by: Mika Westerberg <westeri@kernel.org>

