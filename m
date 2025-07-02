Return-Path: <linux-acpi+bounces-14927-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43D3AF143A
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 13:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 335C97B2CAA
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 11:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9523B266594;
	Wed,  2 Jul 2025 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i12nkX6K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA2265CD0;
	Wed,  2 Jul 2025 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456374; cv=none; b=Iu3KZUergqVp9kbPutZIxdKgjYnxnEafpgAl1gySfgk0JPQs6tG/mWY6pJNasaRrFwT8TVluUq3jZq3LlYMx8OTeUDS+BqS+dDt6Q7Z02A14jVCNx6Xp+SxXbYc5wczH6fO5utFxuA5+KwZn4VLvXvHP0FMTT7i8ZFwcUto8Lx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456374; c=relaxed/simple;
	bh=v6saksW8Caqa3y5KRNV+vSZS7ie/jhuoui51AlwXf7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrcIm5KSPQR+KynNgeKGYDPTcZ+XH6eZBbNjVL7TfxR9vxy9sjUsv7ndpoKz7JBvlo9+UyXq9ixycAj08NV35YbHI4nZxmwD/vkj0kLcdgww/R9+sqvsyUkFZGCoJ/Ba+zHV7a1v4wCB4Etd6Y4yPVY50ZIrIPYW4NkvksujVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i12nkX6K; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751456372; x=1782992372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=v6saksW8Caqa3y5KRNV+vSZS7ie/jhuoui51AlwXf7k=;
  b=i12nkX6KePKsTzSyCbJg7mcAKzn4I7HwVXH1Q+pX2ZLor97N2rDK1JlI
   625fUfGZt5BeSReeNCoL8z3MxGb5deHdDUwtYRvJDBoBYTfrBcZIvEjtx
   cjxlQMPHDBTZHuEHmFPQMSh86SfcdWNRgwy5oxeens3O11QS5/OlSzYwL
   Aum2x7D9LPHaES6PEWKuRCtEZWx9VlpplJWlVNpCCywC6oW0llFj5ybpI
   pT5vfwp8RBGDkpqOQD4s05+yD/21+uJmCaHSRivHW/rD2oEcVLxlYh99H
   GzipJxDo9CSSe9tk60Ugt4caTj0/KiI0iDb5rYkU5F8tT45XXQs8kRVEh
   w==;
X-CSE-ConnectionGUID: lJMvkXwYQ4O29/jIE43FXw==
X-CSE-MsgGUID: AOIUzDZBSlado5EPrEXHeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53839539"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53839539"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:39:30 -0700
X-CSE-ConnectionGUID: mlpi9m3FSByAEgGF4mUwsw==
X-CSE-MsgGUID: kJgdkV2/ROyIIrCgnKDzDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="184998772"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:39:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWvo8-0000000BuBI-3Jry;
	Wed, 02 Jul 2025 14:39:20 +0300
Date: Wed, 2 Jul 2025 14:39:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <aGUaaOQaya-SaasR@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-16-apatel@ventanamicro.com>
 <CAJZ5v0iYYuK2GF2Pg3NiO4vLFzoYm6Q3Dnk5O2DkMJm1R3qSfQ@mail.gmail.com>
 <aGUaFX9WgTW1I_ZO@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGUaFX9WgTW1I_ZO@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 02:37:58PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 02, 2025 at 12:20:55PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 2, 2025 at 7:16 AM Anup Patel <apatel@ventanamicro.com> wrote:

...

> > >  static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
> > >                                           const char *propname, const char *nargs_prop,
> > >                                           unsigned int args_count, unsigned int index,
> 
> > >         const struct acpi_device_data *data;
> > >         struct fwnode_handle *ref_fwnode;
> > >         struct acpi_device *device;
> > > +       unsigned int nargs_count;
> > >         int ret, idx = 0;
> 
> > > +                       nargs_count = acpi_fwnode_get_args_count(device, nargs_prop);
> > 
> > I think it should work the same way as it used to for the callers that
> > pass args_count, so maybe
> > 
> > if (!args_count)
> >         args_count = acpi_fwnode_get_args_count(device, nargs_prop);
> 
> But this is different variable.
> 
> > >                         element++;
> > > -
> > >                         ret = acpi_get_ref_args(idx == index ? args : NULL,
> > >                                                 acpi_fwnode_handle(device),
> > > -                                               &element, end, args_count);
> > > +                                               &element, end,
> > > +                                               nargs_count ? nargs_count : args_count);
> > 
> > And this change would not be necessary?
> 
> This is not the same check as proposed above.
> But this can be made shorter with Elvis in use:
> 
> 						&element, end, nargs_count ?: args_count);
> 
> > And analogously below.
> 
> And below. And in case if there is a new proposal to have
> 
> 	if (!nargs_count)

I meant

	if (!nargs_prop)

here of course.

> 		args_count = acpi_fwnode_get_args_count(device, nargs_prop);
> 
> that is exactly what I asked to drop as it's included in the
> acpi_fwnode_get_args_count() already, i.e. no need to check this in
> the caller and in the callee.
> 
> > >                         if (ret < 0)
> > >                                 return ret;

-- 
With Best Regards,
Andy Shevchenko



