Return-Path: <linux-acpi+bounces-14979-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 016F8AF77AB
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 16:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34DE37B15AB
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6F92ECEBB;
	Thu,  3 Jul 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDtlaxpl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771582EBDF7;
	Thu,  3 Jul 2025 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553191; cv=none; b=foke369Bft+FS0/brO+f8uyU95SRwUOAJApKUkGIx6B+IQjIabrLUmEAQMA0ucmPcimpuMn8N70K2rEf2eVRlzbgYjwzHtqgjqBqnCK8xjA70c/McplWd0klC8HYcyeG3zYeRnNttFZHTAVUF7Q/S9jnkZRcWeSNiYjfEtkkKqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553191; c=relaxed/simple;
	bh=QDQcYemNumpJkyuG0e7AEPmXkZuj/5OH8ZkCvxJeii4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBVjFNcI0hTUrJaSU3UN95xMwh0sWrOLLp8F5Rk7aJ8hN9fTzriwSUN3zOTcnfLrjK+Mpyh/mQZFFk1B2x/5QTUORHU6Z36Aieo9qqN5RRIP19YwRsYxJXXzyAD5jUpb7LvqnttQpZYETTIqmpirwpnmGbGvXlcXIhuVavFprt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDtlaxpl; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751553189; x=1783089189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QDQcYemNumpJkyuG0e7AEPmXkZuj/5OH8ZkCvxJeii4=;
  b=NDtlaxpljzu1q+u9ZZTCzLoMZQVHU5ODq01/+90drdWnR77uWUca4Qht
   wPp5x+/BmEnMVTZ7Ti3F3YZNbotehziQxWi/QX0eAWGxpuI91K9YbLmXg
   /+ozDatAqC21XErULw8qcRh3PeUdTCMdHChyxfiDhk0nOBG+7bg8ImcX9
   Dz95/WnffRqq3aNK3nHr8jLN0tXYZG4LnyUM3gzdJXmCJb+eojsgnRkfo
   WVmjNXM+cW8rpfPUdmVcux/wVzWq2r9ZqCzYz9VvuRdnxbKIoqJ2von1q
   EiCkzFb2g2J25Z4yaaguJLDNefrndojXzKfMSLBGC+nqPDA+wSbL10uEE
   Q==;
X-CSE-ConnectionGUID: 6BE6dySyRfmprrD7756arw==
X-CSE-MsgGUID: sXsWJYgLRHq2HfDSxK4Uww==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57691494"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="57691494"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:33:08 -0700
X-CSE-ConnectionGUID: rD2M51rKSdi1x5PzUhceIw==
X-CSE-MsgGUID: UEtkloWDSZmDsJUfFaYINA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154958463"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:33:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uXKzi-0000000CED8-1unY;
	Thu, 03 Jul 2025 17:32:58 +0300
Date: Thu, 3 Jul 2025 17:32:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>,
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
Message-ID: <aGaUmpw1pVWNAmpb@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-22-apatel@ventanamicro.com>
 <aGUl_S9irfhlHmy2@smile.fi.intel.com>
 <aGZhWlxxQG0Z8awP@sunil-laptop>
 <aGaLiK0eW8Mc1YC3@smile.fi.intel.com>
 <CAK9=C2VjrOvcu=hEfxqw8R6Bwc1W5n9m_ksQ8vx02Lo8232wqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9=C2VjrOvcu=hEfxqw8R6Bwc1W5n9m_ksQ8vx02Lo8232wqQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 03, 2025 at 07:56:52PM +0530, Anup Patel wrote:
> On Thu, Jul 3, 2025 at 7:24 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Jul 03, 2025 at 04:24:18PM +0530, Sunil V L wrote:
> > > On Wed, Jul 02, 2025 at 03:28:45PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Jul 02, 2025 at 10:43:42AM +0530, Anup Patel wrote:

...

> > > > > -         if (dev_of_node(dev))
> > > > > +         if (is_of_node(fwnode)) {
> > > > >                   of_msi_configure(dev, dev_of_node(dev));
> > > > > +         } else if (is_acpi_device_node(fwnode)) {
> > > > > +                 msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
> > > > > +                                                       DOMAIN_BUS_PLATFORM_MSI);
> > > > > +                 dev_set_msi_domain(dev, msi_domain);
> > > > > +         }
> > > >
> > > > Actually you don't need to have the if-else-if if I am not mistaken.
> > > > The OF does almost the same as it's done in the second branch for ACPI case.
> > > > How many MSI parents this may have?
> > > >
> > > OF already has a well defined interface to configure the MSI domain. The
> > > mechanisms existing today are different for DT vs ACPI to find out the
> > > fwnode of the MSI controller. So, it is done differently.
> >
> > I don't see how. The only difference I see is that OF iterates over all listed
> > parents, if any, ACPI tries only one.
> >
> > So, perhaps it's a time to have a common API somewhere for this to be agnostic?
> > Something like fwnode_msi_configure() in somewhere of IRQ MSI core?
> 
> There is an issue/gap in the DD framework which is being work-around
> here. This issue manifest mostly in RISC-V land because in RISC-V both
> MSI controller driver and drivers using MSI are regular platform drivers
> while the probe ordering is ensured by dev_link support of DD framework
> or the frameworks (like ACPI) creating the device.
> 
> As-per this issue, when platform devices (DT or ACPI) are created the
> MSI domain instance is not available and hence set to NULL. The MSI
> domain instance is only available after MSI controller driver is probed
> so currently we explicitly do of_msi_configure() or dev_set_msi_domain()
> in the driver using MSI as a work-around. Adding a common
> fwnode_msi_configure() is only going to be an improvement to the
> existing work-around which we should not have in the first place
> hence not the right approach IMO.
> 
> In the long run, we need a clean fix for the above issue in the DD
> framework such that platform drivers using MSI don't have to explicitly
> do of_msi_configure() or dev_set_msi_domain().

I see, thanks a lot for this explanation. Can you add a summary as a comment on
top of the if-else-if in case it's not there already?

-- 
With Best Regards,
Andy Shevchenko



