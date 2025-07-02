Return-Path: <linux-acpi+bounces-14930-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36F7AF14E8
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 14:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084FC5201CD
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB2726D4E7;
	Wed,  2 Jul 2025 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNHwal9f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B26C1E1DE0;
	Wed,  2 Jul 2025 12:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457815; cv=none; b=T1QX+hyzZ43oJ/cEE/j1liEbYa3nNTJOsb9iMYvricJzqYF4Hx7Q9aA5wlHv99mINGNnbYzzFL0/26oRY/M1mykfgjWT/0EVzQkHO/XU0QK/O5KJfsnb9GWixkI/XBqirGOjwYXwxMeHsyi1qENdhmjO5dYGDXs6VPipUKpfplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457815; c=relaxed/simple;
	bh=ejD2BbOWhhH2C3aYM/UenuDYs6xR5HBlVSofSY5zouA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1/p/N24kKOfn4XlB5m94OQBzYyPvsbGP6ZibzvcttW59d/FdOw0tUCXEct3nSUjOvhbQyNTmZbjC8qOwD7Nx3HgxSdz8xxBXabEDfoyns+JAHOa5E0BhUx8/cUnp8uC3SwqLw2YSkFg4WcJzW6sw/URYrRNHxy/4ai9gJjb1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNHwal9f; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751457814; x=1782993814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ejD2BbOWhhH2C3aYM/UenuDYs6xR5HBlVSofSY5zouA=;
  b=JNHwal9f2KB7zlNMY6Me6280RZL1B09WCY3bJSYEtSyaYg9zm1I6KrD1
   Kx/QnH9VZOJ42EFSSRhl4TE7/l5ZtLY8SOam3SeKuX6BGI2I1YgT1jLqL
   7//YPVBFHsRjdR9bJH3N35cOYe5IgEgbJh2ez027CuvprzQrr7LOSSTcP
   I8QqmgKKvTNrT3KbSUB1DdjL5xVep696X56M7x+q0WofGTWIPSmFVZdfJ
   8FRQHteFL8A9lI7riIZbAtyeU1I2USsNjU0nm1Azdyf24MLMalGgP/Boo
   SHsS9pY8Zmslvn/vPhv5GLwPf1lUqwqkkvQvscnI+yuH0uYUW5j1U6UYn
   Q==;
X-CSE-ConnectionGUID: VdSNpAm2Sq2KvvL5a1IqiQ==
X-CSE-MsgGUID: /JfRz4d4RUi4mK/OeOy94g==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="41376325"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="41376325"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:03:33 -0700
X-CSE-ConnectionGUID: y/UVNBj2THGcJc/iCveI0A==
X-CSE-MsgGUID: TLSUro/aQVGE2wGprEhSKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154536438"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:03:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWwBN-0000000BuWY-1IDx;
	Wed, 02 Jul 2025 15:03:21 +0300
Date: Wed, 2 Jul 2025 15:03:21 +0300
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
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v7 03/24] RISC-V: Add defines for the SBI message proxy
 extension
Message-ID: <aGUgCeDvNv4RxCwv@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-4-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702051345.1460497-4-apatel@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 10:43:24AM +0530, Anup Patel wrote:
> Add defines for the new SBI message proxy extension which is part
> of the SBI v3.0 specification.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



