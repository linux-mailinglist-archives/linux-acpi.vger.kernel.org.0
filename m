Return-Path: <linux-acpi+bounces-14932-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FC7AF15A7
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 14:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB9D18883DB
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 12:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4767270EDD;
	Wed,  2 Jul 2025 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aimjaRiN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302BB26FDA5;
	Wed,  2 Jul 2025 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459338; cv=none; b=bUC0fIM66uSU45HgBnaUZQM401fgn9hIZlJkDck+4fcsg0vaE7gR6kXnaDWbuKkLil10X1NZUfEhintOHAMOZiPPr+T3FOaCKcHf94b7uR982yqtxqmtsGGraQhEkLAtW7ijiymof89302KB/OKHWdjqWLmjCA9o4vW38sBboVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459338; c=relaxed/simple;
	bh=zoqxa8Dth/WIL+RSmgjM63YP+N6qBvdpGWSiRdatsBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3GC0PCkc742SFReiOSnUXGtwI8Y8oPSp1bVzBNRnmrODK6UdulHV9oZVU3napdu04ACDmN2bdjEo4BGOerIUZBbUD64SiSA48b3UutQOjiVH0Ws6NoN6EMS1DgB/Pj2VrIEEcY3+n4m51UGUOk/Fr1FZeE8D5yCIyGlLk4ky30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aimjaRiN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751459338; x=1782995338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zoqxa8Dth/WIL+RSmgjM63YP+N6qBvdpGWSiRdatsBg=;
  b=aimjaRiNhIDq/ud/a1Ouq7G6B8K1Rjec3heqITU4bucRJOzy6IY3cWL1
   H7l1L81zaDSgFWQjCvN31AtBqhwW5fY2mMoGkBMYb42U11SrVnnlAMFi1
   GLIQUzvR3V2BwihCUaZXYotR44YMUl84LYgjogeuc1dAveqsLZtJFe4+S
   3fMwYvyh8MUy1rNdYTgeidK4Wwcd28+VmjFlb0HdTBmZ1ZPryqfnU+VMQ
   neeAuvUM9mEWqbkr07nKNjUNjKQx+m09y8YX8PhHi//Hw3+bJ/wWhFAHZ
   pFO1aRfl5OdHrQKH1kDnXU8vntw7XG9tAk5Asdz7gRmG3WS9+8K3D8UGv
   w==;
X-CSE-ConnectionGUID: OXtJ+nJQR5eWO8r3+dwVHA==
X-CSE-MsgGUID: tyc9leZBQJiLva+69552UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="57426623"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="57426623"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:28:57 -0700
X-CSE-ConnectionGUID: ZYzfy1TaTmSmBpS29OqyAg==
X-CSE-MsgGUID: c4FjoOfOQgG2bv26Z60xAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153839670"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:28:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWwZx-0000000Buum-1vQU;
	Wed, 02 Jul 2025 15:28:45 +0300
Date: Wed, 2 Jul 2025 15:28:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 21/24] mailbox/riscv-sbi-mpxy: Add ACPI support
Message-ID: <aGUl_S9irfhlHmy2@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-22-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702051345.1460497-22-apatel@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 10:43:42AM +0530, Anup Patel wrote:
> From: Sunil V L <sunilvl@ventanamicro.com>
> 
> Add ACPI support for the RISC-V SBI message proxy (MPXY) based
> mailbox driver.

...

> -		if (dev_of_node(dev))
> +		if (is_of_node(fwnode)) {
>  			of_msi_configure(dev, dev_of_node(dev));
> +		} else if (is_acpi_device_node(fwnode)) {
> +			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
> +							      DOMAIN_BUS_PLATFORM_MSI);
> +			dev_set_msi_domain(dev, msi_domain);
> +		}

Actually you don't need to have the if-else-if if I am not mistaken.
The OF does almost the same as it's done in the second branch for ACPI case.
How many MSI parents this may have?

-- 
With Best Regards,
Andy Shevchenko



