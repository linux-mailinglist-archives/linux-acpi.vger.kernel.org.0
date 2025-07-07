Return-Path: <linux-acpi+bounces-15050-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960FAFBCAF
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 22:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A7E16B0ED
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 20:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA79220F57;
	Mon,  7 Jul 2025 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeXjWCcK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7171FBE8B;
	Mon,  7 Jul 2025 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920898; cv=none; b=Vcx/rSma/Qra5dDBnIGsdAJ+P2snQ0bXrjvhIfosXiMvQgcmhGkNwsY1MsIIuPmqgO+5FcV5fr/2nGT4CSQ/h/JXK7sPUJWBoZZozjKnEYBYXAcLaYXRpmwYCyb2/Cl5jEtEeKK4XrIR30OrC7SdlFf6kK07BqFUqiq5JeHymkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920898; c=relaxed/simple;
	bh=ZGQ4IAp72CD0dvJdEiopEpJnXGG+TmleeD6jQxCqY6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdMFAWCi1uE4mcp+bemPS+6Zl3BL+cJNigA8krLLk73TPGiXtZFg0L19PwUQSuKDsLp2aCrXg98/h3UL79Ie2QFky2UJ4eBb1OX5QDXL2U+jwkRdCGj7Vlj5LjCCln+KRfiCuMfOJFjs8gsl3vfohDPmHtGxAaUhqhqPq0NNKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeXjWCcK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751920897; x=1783456897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZGQ4IAp72CD0dvJdEiopEpJnXGG+TmleeD6jQxCqY6s=;
  b=VeXjWCcKc82F7YtqXVKkjkpZb7zuBSwb2dDfpO3ykygCt2W2PxXe0tBi
   OJDXxQbYaYqpxH260ZlJ3HU2m2JgmfKk+WtQNI1s3aUlsnT2pEq+mjIlc
   RJ8EOH12IKnxbvwsPLKkHP3GNXSU9XDwKUyprpiMtHy/q81UASBJGzod7
   HZjbgqhHMc20wS87auVCqkB6rMMkFQYeH/+Gb2mIv3D3gGP0EvaN2yNVK
   yEvR+HE2dw5MwX/Ev1ALLalHUVKSeTJGlVxeWKlq3UANecQ6EWIAUGEiI
   l8iJLkClwbX2bgQRpdOhd+o6hZENuKfosxn7JNtQGb5Rnt9IytXJlJ+yk
   A==;
X-CSE-ConnectionGUID: pLhOTarRScGlKkEvcdTynw==
X-CSE-MsgGUID: S5A6f9z1T5OJXaIaatgzOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79582753"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="79582753"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:41:35 -0700
X-CSE-ConnectionGUID: 6ZV0IcV6Tc++xPaC45N/Cw==
X-CSE-MsgGUID: G755qW21QSO3Gx55MFvZOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="186342805"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:41:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uYseS-0000000DORp-3aM4;
	Mon, 07 Jul 2025 23:41:24 +0300
Date: Mon, 7 Jul 2025 23:41:24 +0300
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
Subject: Re: [PATCH v8 15/24] ACPI: Add support for nargs_prop in
 acpi_fwnode_get_reference_args()
Message-ID: <aGww9GWPdwTFw2kl@smile.fi.intel.com>
References: <20250704070356.1683992-1-apatel@ventanamicro.com>
 <20250704070356.1683992-16-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704070356.1683992-16-apatel@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 04, 2025 at 12:33:47PM +0530, Anup Patel wrote:
> 
> Currently, ACPI does not support the use of a nargs_prop (e.g.,
> associated with a reference in fwnode_property_get_reference_args().
> Instead, ACPI expects the number of arguments (nargs) to be explicitly
> passed or known.
> 
> This behavior diverges from Open Firmware (OF), which allows the use of
> a #*-cells property in the referenced node to determine the number of
> arguments. Since fwnode_property_get_reference_args() is a common
> interface used across both OF and ACPI firmware paradigms, it is
> desirable to have a unified calling convention that works seamlessly for
> both.
> 
> Add the support for ACPI to parse a nargs_prop from the referenced
> fwnode, aligning its behavior with the OF backend. This allows drivers
> and subsystems using fwnode_property_get_reference_args() to work in a
> firmware-agnostic way without having to hardcode or special-case
> argument counts for ACPI.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



