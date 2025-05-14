Return-Path: <linux-acpi+bounces-13719-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1429AB70AC
	for <lists+linux-acpi@lfdr.de>; Wed, 14 May 2025 18:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9FA18936C3
	for <lists+linux-acpi@lfdr.de>; Wed, 14 May 2025 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14FB27990E;
	Wed, 14 May 2025 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huqqQjJg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0648F221721;
	Wed, 14 May 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747238401; cv=none; b=oOeAdymFCWKHXJRMd0V+ET5pqnN5STY2xbr7GBwlQOWn1zqkrO82jpLwWE2LkaxmJizU34cQvUoAOwtN30XEIHZMI7ZZyOeCHC1VGNPgDt7BaBQ2f5Cp+sd5XzU0isNWZsbKBdH/R6zP8O8+qQyx2qJfx5OaXvsnwpu13rGfWbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747238401; c=relaxed/simple;
	bh=vOv8RJRqrwu3FrT4+wzYt6FEwAwGIL55uoT9EYvT5XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjspbBIbaZ9vMC9D4BCZ8ejajy2jpJA7yTQU2uza4tkgDqNDXzMq/0w4hwOJOVoIgFPigSNt3XuNrQ4rlDIWDFYSi8yFNWWGWmnUAEfE2JBON+H/CAOk2JTdpgD7nSw4CnK4DCvDp9b770OI4rJ66rVm2eclM0u4sL5ddisC46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huqqQjJg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747238400; x=1778774400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vOv8RJRqrwu3FrT4+wzYt6FEwAwGIL55uoT9EYvT5XU=;
  b=huqqQjJgeHP3BvY8vfOj+6LrydldgypZ75VmvClWOH1HA/f/tKsyTqff
   mjIeUQ64p4o/qiOs4X4jaXpE0nFrI9BIvj4wbjNnb13QDjrUXMOJ2Rkou
   emAHBgxWCymM2reD0UuyhQFIp0hx+1+PsfEleGhvlRslTEjmWETSj1Z7v
   nBn7eX9x72YHJc2z6xJcBYCRwAVsT5ZDmca4ldetaoWKWvLLdVwo2aXMG
   SCa0W8a3P0vg04R17Cxzr4/50ZwZddjHj6mO6voSnf/BUmRO0alXkCU7Q
   EeLsTD6Vys4h7cjto5mlUguOkdHtUcEJkl3MufR3tisvxcuFzHixcX7BK
   g==;
X-CSE-ConnectionGUID: 5/ClVFJrQpWBecTskKK0Yg==
X-CSE-MsgGUID: 9xvPn6+2QXiQ9k9nYwmwnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49125248"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49125248"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:59:59 -0700
X-CSE-ConnectionGUID: LyMBQ3pyT9KaZwQ2LPyk6Q==
X-CSE-MsgGUID: MGhEcIDLQ8iw5M4Wfn6M7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142964104"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:59:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 75BB823F; Wed, 14 May 2025 18:59:55 +0300 (EEST)
Date: Wed, 14 May 2025 18:59:55 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 0/4] gpiolib: acpi: Split quirks to its own file
Message-ID: <20250514155955.GS88033@black.fi.intel.com>
References: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>

On Tue, May 13, 2025 at 01:00:30PM +0300, Andy Shevchenko wrote:
> The GPIO ACPI helpers use a few quirks which consumes approximately 20%
> of the file. Besides that the necessary bits are sparse and being directly
> referred. Split them to a separate file. There is no functional change.
> 
> For the new file I used the Hans' authorship of Hans as he the author of
> all those bits (expect very tiny changes made by this series).
> 
> Hans, please check if it's okay and confirm, or suggest better alternative.
> 
> Andy Shevchenko (4):
>   gpiolib: acpi: Switch to use enum in acpi_gpio_in_ignore_list()
>   gpiolib: acpi: Handle deferred list via new API
>   gpiolib: acpi: Add acpi_gpio_need_run_edge_events_on_boot() getter
>   gpiolib: acpi: Move quirks to a separate file
> 
>  drivers/gpio/Makefile                         |   1 +
>  .../{gpiolib-acpi.c => gpiolib-acpi-core.c}   | 344 +----------------
>  drivers/gpio/gpiolib-acpi-quirks.c            | 363 ++++++++++++++++++
>  drivers/gpio/gpiolib-acpi.h                   |  15 +

All this -foo-core things look redundant to me. Why not just split it out
and call it gpiolib-quirks.c and put there all the quirks not just ACPI? I
Don't think we want to have gpiolib-of-quirks.c and gpiolog-swnode-quirks.c
and so on.

>  4 files changed, 392 insertions(+), 331 deletions(-)
>  rename drivers/gpio/{gpiolib-acpi.c => gpiolib-acpi-core.c} (79%)
>  create mode 100644 drivers/gpio/gpiolib-acpi-quirks.c
> 
> -- 
> 2.47.2

