Return-Path: <linux-acpi+bounces-15049-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20528AFBCA6
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 22:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C961892938
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6416421E082;
	Mon,  7 Jul 2025 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWrYm+hV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0AB1FBE8B;
	Mon,  7 Jul 2025 20:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920758; cv=none; b=iWK7qD9zEYR8nMVaALdkh6rEaPzByh3R3AiJ2zr3pHQ8w842J9ic+20oyvTOVzhfB2Hxyyx33d+hJjEKnwb9WJpXbbDkrSvaBQmP2G8+xMRT3r2mBpaPzDOVXcUs7BiSD1HaOvyveeycTe5p8pyVK1gOvLxq2HvAK1/Jh7rJ3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920758; c=relaxed/simple;
	bh=kcrB6F2mxoqFMPRnDijT6o6h3KVvHamrCsmEhzHfJiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojZCsbENrfrohihtcqIR3QZ7Py5fctMO+0nrkDTAlfsovrC1JeBAb88jnwxzASgz4JGQuDkGdg0c+Ar9FpakvMuqoC7nawqx21Mx5zXsfm9WbuzvBptkMdQ52wNVzwPQWlZ0Gv6pNYb68AarYdtJiPMiN5jYwsEuI9BSejWglz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWrYm+hV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751920757; x=1783456757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kcrB6F2mxoqFMPRnDijT6o6h3KVvHamrCsmEhzHfJiQ=;
  b=QWrYm+hVoOBvaM1dosFsuV3oloBBzgvWx/+Nzt06LYELr2u/hBitTrAu
   vKUXPQi94q0i49hMvSRPNYx8yzZQuptMo/JIIPwvUR0sGemReV193bMcH
   b0UJ+JAfWs6DT5kw/7vNlGeyQy05SW/dPUDZYuugdKAec7+F3MNJyL1zS
   nlExRR7vvi7u02pLP0WZEtSyASWx5ijtjAl7OjydSygTQOT9e2x/xhw0D
   PGnUk7eu4kyCydWVDRey9P9pcZCXT1+F2FKVZi4Pk1fgp/GOdrPV3xMOD
   +WIvyQ6Zk/2+dxy6IP5ZEan5N/yHnGVcA9V5g448KYE2spKdF+cZ6+WLu
   A==;
X-CSE-ConnectionGUID: XZKvKVPcRwCC4J5Kor88kw==
X-CSE-MsgGUID: im2bvxoLR7u+lY64K5yNkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64397516"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="64397516"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:39:16 -0700
X-CSE-ConnectionGUID: vD4xfab6Q4iMgufgeuM4pw==
X-CSE-MsgGUID: i1AYe1TLR5CbsO1FTsLDjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="192494134"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:39:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uYscD-0000000DOQV-12J7;
	Mon, 07 Jul 2025 23:39:05 +0300
Date: Mon, 7 Jul 2025 23:39:04 +0300
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
Subject: Re: [PATCH v8 14/24] ACPI: property: Refactor
 acpi_fwnode_get_reference_args() to support nargs_prop
Message-ID: <aGwwaGmiIxdElk1Y@smile.fi.intel.com>
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
 <20250704070356.1683992-15-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704070356.1683992-15-apatel@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 04, 2025 at 12:33:46PM +0530, Anup Patel wrote:
> 
> Currently, acpi_fwnode_get_reference_args() delegates to the internal
> function __acpi_node_get_property_reference() to retrieve property
> references. However, this function does not handle the nargs_prop (cells
> property) parameter, and instead expects the number of arguments (nargs)
> to be known or hardcoded.
> 
> As a result, when fwnode_property_get_reference_args() is used with a
> valid nargs_prop, the ACPI backend ignores it, whereas the Device Tree
> (DT) backend uses the #*-cells property from the reference node to
> determine the number of arguments dynamically.
> 
> To support the nargs_prop in ACPI, refactor the code as follows:
> 
> - Move the implementation from __acpi_node_get_property_reference()
>   into acpi_fwnode_get_reference_args().
> 
> - Update __acpi_node_get_property_reference() to call the (now updated)
>   acpi_fwnode_get_reference_args() passing NULL as nargs_prop to keep
>   the behavior of __acpi_node_get_property_reference() intact.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



