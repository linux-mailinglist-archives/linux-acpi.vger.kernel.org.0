Return-Path: <linux-acpi+bounces-14929-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD36AF1463
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 13:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1CF97B5EFB
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 11:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899E92609EC;
	Wed,  2 Jul 2025 11:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZh2rJDl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E411E520C;
	Wed,  2 Jul 2025 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456745; cv=none; b=hNDz22S3mxseBPN8mXI276NuV+bLgNsvsguoPQ5Rc1psg1gDAUqpTWIc5FqnCA4XZm+N8Hue9ot9WfBdD5Z9wozg4rIE/qppgNY09UuYKeU6uHY+pQVmcAiPONkQ1gmLFVLFF5a1BROnPSLczIewIBlCOZYUXzTlaA1qHovSap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456745; c=relaxed/simple;
	bh=dErZgu/HmVYj+emESiL6/oyn/LFKoTLtLdPT26fxZz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY5pe/cI7TeWWiqumHIpXe4MRpu0iv+t+kxIW67SIaqjQm46Fknk1rqQyvKBLt3EYtbkoepcjZ2jT2XctoXwqp5fx/1LxbUjsucP1oROK5vy3F3Bp/Q/FcQ/UkiGyjJ3MggY9aEIAvregkG3TCJToFrPznrrsVoDLh1WLoArahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZh2rJDl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751456744; x=1782992744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dErZgu/HmVYj+emESiL6/oyn/LFKoTLtLdPT26fxZz8=;
  b=ZZh2rJDldHva/3oVf5O9H5NIf/jGPwjWwP7ci3TW8VVFpNbcA1jqhW5Q
   hC6IMR8ofb+p/DgAVTG0TcMaTgzQuTv6F6Zm38dh/Bihl2s+fMML0F9PR
   2SqNsXDJ4CepdWkRNH8lpjYS+Q+2ZBLCv8HCkq7OokvWcqTY+CeLxajlo
   RgXVbhYMJqn4Dv8CESbihOJd5EmTv/fYfOwcixWZWhO+bIwNdKrbEDeAb
   9ojvtb7CsljQPs+MyiCXfHzQR10tm++oxteyIk17xJMgsfkRnsnCYpLjs
   XV7bA2rft0UEAYzpvJdcffSFO1kupSCstImCMNfizYoP2P0nhIfaJ3CPL
   A==;
X-CSE-ConnectionGUID: fRUfUPDZQvKgaIVHetTO6A==
X-CSE-MsgGUID: TYDQXipKTuK/6vhtBNlcSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="41374949"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="41374949"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:45:42 -0700
X-CSE-ConnectionGUID: Lp6tvve7RQCCemKpcNKtgQ==
X-CSE-MsgGUID: hw5JwzpsRDumshym1GmB5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154786702"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:45:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWvu7-0000000BuHj-416w;
	Wed, 02 Jul 2025 14:45:31 +0300
Date: Wed, 2 Jul 2025 14:45:31 +0300
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
Subject: Re: [PATCH v7 16/24] ACPI: scan: Update honor list for RPMI System
 MSI
Message-ID: <aGUb2yjvC3zhqKyk@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-17-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702051345.1460497-17-apatel@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 10:43:37AM +0530, Anup Patel wrote:
> 
> The RPMI System MSI interrupt controller (just like PLIC and APLIC)
> needs to probed prior to devices like GED which use interrupts provided
> by it. Also, it has dependency on the SBI MPXY mailbox device.
> 
> Add HIDs of RPMI System MSI and SBI MPXY mailbox devices to the honor
> list so that those dependencies are handled.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



