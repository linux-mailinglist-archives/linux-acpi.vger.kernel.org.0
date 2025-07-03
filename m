Return-Path: <linux-acpi+bounces-14977-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171F0AF7639
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 15:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C571C84DDA
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 13:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62FC2E7F13;
	Thu,  3 Jul 2025 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iuo4jH+Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FEB2E7BD9;
	Thu,  3 Jul 2025 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550869; cv=none; b=OKUMMuhBtyouErkGNfKlrPWCg4KteOzPxtPoYasV4wYyFFnjAA6KdJF3IUnmEV1ArS3dsWi0LAQaY/CAO0iUlBvd4JD2L8lqv4ql6J+S9m0tLWwP1MmT3wg+poq4bNqmJWZ+o5RzRlihpbygMmzqrq1r8H9d6lsPY+zP9CCUoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550869; c=relaxed/simple;
	bh=hkynFXqBgMDhBIacDm9GkRDPLniP47vYUeHzZhSjqPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eddCL/2WAqbhIxeoZTgXOOl8fIXVfLrTyiudTVnbBsQD5HtjZ42vGxRcZ13DLMz02BPaLrbh4vVX1LoPWFfrgEh3KqK2SpsJdGCKUf0UgFSRKkxmhTGtAVH/WXorWJTK09jGVvWoQtVi6aMc+S/Z6WVIJk5GaEIAqbKJaqJbFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iuo4jH+Y; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751550868; x=1783086868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hkynFXqBgMDhBIacDm9GkRDPLniP47vYUeHzZhSjqPE=;
  b=Iuo4jH+YLzq6DVWUeAq2jZK5USPTOhYisKgOROVHg/s55NC2xcZdIgf0
   PzjpnFL2MftsrgmnEDMTFfbtf3muJR/QAxJ02GQrOaKkMuTRJsQQhovfV
   v35Mv2WwQ6nAERKeS+eRBoBvmOegCfkEZF5gkJ9INxf2mNArOtNgYn7Cm
   yTBH7KMdEVwPnDYSu4pVeupIQ49IRuUpSB8h9l64Nc9ClYc3zPLWrChwh
   Y3DQbyt6jLzAgHCXfz6SQOaaJoqJyqCPZrG+n90AnPye/txXQsSBlzw1Y
   KUglGPg+/BhwkjfKc7xbopkhawHf0uEC7nd0lq1aJPpIxy6mWCVowht+j
   w==;
X-CSE-ConnectionGUID: AAjKmMZ4TRutFgd4UTxzpQ==
X-CSE-MsgGUID: B3OULOP1Qom2ex9Jj1K0Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57686384"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="57686384"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 06:54:27 -0700
X-CSE-ConnectionGUID: Sz8pfLTHRumN6SVidx2zkw==
X-CSE-MsgGUID: LlSnEty4TaS4oZ+RxqLYkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="153790365"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 06:54:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uXKOG-0000000CDjq-1Yoc;
	Thu, 03 Jul 2025 16:54:16 +0300
Date: Thu, 3 Jul 2025 16:54:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Anup Patel <apatel@ventanamicro.com>,
	Michael Turquette <mturquette@baylibre.com>,
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
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 21/24] mailbox/riscv-sbi-mpxy: Add ACPI support
Message-ID: <aGaLiK0eW8Mc1YC3@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-22-apatel@ventanamicro.com>
 <aGUl_S9irfhlHmy2@smile.fi.intel.com>
 <aGZhWlxxQG0Z8awP@sunil-laptop>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGZhWlxxQG0Z8awP@sunil-laptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 03, 2025 at 04:24:18PM +0530, Sunil V L wrote:
> On Wed, Jul 02, 2025 at 03:28:45PM +0300, Andy Shevchenko wrote:
> > On Wed, Jul 02, 2025 at 10:43:42AM +0530, Anup Patel wrote:

...

> > > -		if (dev_of_node(dev))
> > > +		if (is_of_node(fwnode)) {
> > >  			of_msi_configure(dev, dev_of_node(dev));
> > > +		} else if (is_acpi_device_node(fwnode)) {
> > > +			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
> > > +							      DOMAIN_BUS_PLATFORM_MSI);
> > > +			dev_set_msi_domain(dev, msi_domain);
> > > +		}
> > 
> > Actually you don't need to have the if-else-if if I am not mistaken.
> > The OF does almost the same as it's done in the second branch for ACPI case.
> > How many MSI parents this may have?
> > 
> OF already has a well defined interface to configure the MSI domain. The
> mechanisms existing today are different for DT vs ACPI to find out the
> fwnode of the MSI controller. So, it is done differently.

I don't see how. The only difference I see is that OF iterates over all listed
parents, if any, ACPI tries only one.

So, perhaps it's a time to have a common API somewhere for this to be agnostic?
Something like fwnode_msi_configure() in somewhere of IRQ MSI core?

> In RISC-V case at least, there will be only one MSI parent.

-- 
With Best Regards,
Andy Shevchenko



