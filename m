Return-Path: <linux-acpi+bounces-14928-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2740AF1458
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 13:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C79DA7B51AB
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 11:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6EC266F1D;
	Wed,  2 Jul 2025 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANu+x2wh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6622225A2A2;
	Wed,  2 Jul 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456675; cv=none; b=RLOVSs297uHfbRxxGWpDOFjz6cLwF7r2vtO3VUj7Xfx4cb3geb14hoplXSmStgaxXbqHXMjLk+lKinlIOG6H0PghRSWgm9yWAPN46EBOLTYvZNhPOlQbxz72vOy6xd8rXraE9w4qigVDwn3zquJb8HvudqmAYmOa7Rde6FdplaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456675; c=relaxed/simple;
	bh=BpBCvq4RPD3JQB3NRc9+j8XkTmlFaTJQQCP78Asb59M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJ9CYlrze88h6vmNG5Y+vcylUqdX9jYf3i1n6FWtStIgDAysgr7QgFk642GbdWshglSp6pJ40iTQvr3kNH5jzUKqb8QtzxJasiyWC9RiFKxGWNtN770hfjauq/Rh4DiLd+qOJP4nATu27bXCQrUpiG/cgci7MV9TqMdNiS9WCrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANu+x2wh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751456673; x=1782992673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BpBCvq4RPD3JQB3NRc9+j8XkTmlFaTJQQCP78Asb59M=;
  b=ANu+x2whOGNRDhWJE5zkh3YPH1I4Z2Qo7+UxTqOnrVz2LIagbpglfuK5
   GdzkFJ2s9yHERm0upmk3/zYG0oh40hgz5ZfTLvpR8fp3NwTeeSxLbHgKb
   qfhltuZhRjnHv8zPTxLTJEtoMgVMTNeApmC/PzfbgGN/jxD5sIq4W312h
   dCBrHNmzZYbVSQfxmJFI/vLJboTT9bV2bfrRm3AzHiSlJCsQQB9401JY3
   Qp5rsMIHKiEllH5lyAyCaCR+vtxe+45Q4x9EzCWP/4JPlWE5thikbe2PS
   YxcUnr1F3YQGqI4gzoCdvFst7d8DuUJTweZfp+zfVm5hevBpn3RefY0LH
   Q==;
X-CSE-ConnectionGUID: Zpa4+7rOTPm4Q9Bgi+X1Lg==
X-CSE-MsgGUID: zcvOvrMRSjWGZhiBfte4NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57555489"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="57555489"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:44:32 -0700
X-CSE-ConnectionGUID: kvCPwjhTQvmObDaiwBgeGQ==
X-CSE-MsgGUID: oaJ5N5q4RoCq/O4ueG6nsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154393699"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:44:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWvsz-0000000BuFM-3tNf;
	Wed, 02 Jul 2025 14:44:21 +0300
Date: Wed, 2 Jul 2025 14:44:21 +0300
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
Subject: Re: [PATCH v7 15/24] ACPI: property: Add support for cells property
Message-ID: <aGUblcoNMCFiK3CL@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-16-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702051345.1460497-16-apatel@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 10:43:36AM +0530, Anup Patel wrote:
> From: Sunil V L <sunilvl@ventanamicro.com>
> 
> Currently, ACPI doesn't support cells property when
> fwnode_property_get_reference_args() is called. ACPI always expects
> the number of arguments to be passed. However, the above mentioned
> call being a common interface for OF and ACPI, it is better to have
> single calling convention which works for both. Hence, add support
> for cells property on the reference device to get the number of
> arguments dynamically.

You can use Elvis to shorten lines, but in my opinion this is okay change
overall. FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>



>  
> +			nargs_count = acpi_fwnode_get_args_count(device, nargs_prop);
>  			element++;
> -


u probably want to leave this blank line and rather move the new code here

			element++;

			nargs_count = acpi_fwnode_get_args_count(device, nargs_prop);

>  			ret = acpi_get_ref_args(idx == index ? args : NULL,
>  						acpi_fwnode_handle(device),
> -						&element, end, args_count);
> +						&element, end,
> +						nargs_count ? nargs_count : args_count);

						&element, end, nargs_count ?: args_count);

>  			if (ret < 0)
>  				return ret;

...

> +			device = to_acpi_device_node(ref_fwnode);
> +			nargs_count = acpi_fwnode_get_args_count(device, nargs_prop);
>  			element++;
> -
>  			ret = acpi_get_ref_args(idx == index ? args : NULL,
>  						ref_fwnode, &element, end,
> -						args_count);
> +						nargs_count ? nargs_count : args_count);
>  			if (ret < 0)
>  				return ret;

As per above.

-- 
With Best Regards,
Andy Shevchenko



