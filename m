Return-Path: <linux-acpi+bounces-14926-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAA6AF141A
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 13:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4343718825EF
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 11:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095782676D1;
	Wed,  2 Jul 2025 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgQdgace"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B20D265630;
	Wed,  2 Jul 2025 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456290; cv=none; b=q0+mZU7+elkE+z4rlTj2lI9cYxGuA3YTILTm5J4n648in6pnakAcdXfBRHsNoXAQ3FdW0G5zjEZPhNVqkhNjrJHDfQOSEw32Qqnb/xlwdp+NkbV+JQwsbam8y+IjwPMeVigCTWlZSYEE9KB0V8Awl3yenAxcQJ6zlq7taHMYxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456290; c=relaxed/simple;
	bh=fJgjWVNnQ1JfN9I0fRmW4sxD0241ZFbaWN/2LUD+0dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX6GFn32UnM1FCkWKzC6jsZSHw8KQ/NCME9RAQvJ36pXbXkaOmZn/pZc4RS+v8ejNjc/NJyasvfTNtP3tmgk+pzXUKkKoJAZOiGebhja6LBZbTXOMDvQjFqQwwvytQ4Ckti2NP/cGprktbgHrptZAwwTfsaBUKRn6y+5pMFPU0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgQdgace; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751456289; x=1782992289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fJgjWVNnQ1JfN9I0fRmW4sxD0241ZFbaWN/2LUD+0dY=;
  b=BgQdgacecX/QeHNGO8dvHL+n2ymgJI7ExfTyqb+eWnIMd4eHC/XkRZgp
   Cx9GLVapwxus3/GEuge8N9elKMmNUl8mYkiXNrC3p1s0nwuAxAQKM7hmA
   rtMMIERd62q2nv7aWL1iKey0Rk+juHT16o5sCZ/gL5jDaVD9h+U2Wjfkm
   qnwJqrfOvG6RfaybKbaXqWjEIfD/PMwQV7VSU5IipDLBGgPt2ll5U6OKN
   3NHstW0F98CkAh6tursMgadFX5AdegsiADtlFixTtlZP/4f+0RJSYPbem
   JWRzBvdycl/Wf8GTev0rgqjlN2mYyTVmZl7Nr/l824D3hjhSgs7hWJGjy
   Q==;
X-CSE-ConnectionGUID: 85RRqUxJS1+mc3lfXjFYfQ==
X-CSE-MsgGUID: KV6nSlwoSsSnVVqsCCyCgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="79187056"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="79187056"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:38:08 -0700
X-CSE-ConnectionGUID: 13+ntn37QuGu/5SzJU2Mew==
X-CSE-MsgGUID: AkWC86+WQ3OMs/h2b6kHcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="159574298"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:38:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWvmo-0000000BuAB-07gn;
	Wed, 02 Jul 2025 14:37:58 +0300
Date: Wed, 2 Jul 2025 14:37:57 +0300
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
Message-ID: <aGUaFX9WgTW1I_ZO@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-16-apatel@ventanamicro.com>
 <CAJZ5v0iYYuK2GF2Pg3NiO4vLFzoYm6Q3Dnk5O2DkMJm1R3qSfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iYYuK2GF2Pg3NiO4vLFzoYm6Q3Dnk5O2DkMJm1R3qSfQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 12:20:55PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 2, 2025 at 7:16 AM Anup Patel <apatel@ventanamicro.com> wrote:

...

> >  static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
> >                                           const char *propname, const char *nargs_prop,
> >                                           unsigned int args_count, unsigned int index,

> >         const struct acpi_device_data *data;
> >         struct fwnode_handle *ref_fwnode;
> >         struct acpi_device *device;
> > +       unsigned int nargs_count;
> >         int ret, idx = 0;

> > +                       nargs_count = acpi_fwnode_get_args_count(device, nargs_prop);
> 
> I think it should work the same way as it used to for the callers that
> pass args_count, so maybe
> 
> if (!args_count)
>         args_count = acpi_fwnode_get_args_count(device, nargs_prop);

But this is different variable.

> >                         element++;
> > -
> >                         ret = acpi_get_ref_args(idx == index ? args : NULL,
> >                                                 acpi_fwnode_handle(device),
> > -                                               &element, end, args_count);
> > +                                               &element, end,
> > +                                               nargs_count ? nargs_count : args_count);
> 
> And this change would not be necessary?

This is not the same check as proposed above.
But this can be made shorter with Elvis in use:

						&element, end, nargs_count ?: args_count);

> And analogously below.

And below. And in case if there is a new proposal to have

	if (!nargs_count)
		args_count = acpi_fwnode_get_args_count(device, nargs_prop);

that is exactly what I asked to drop as it's included in the
acpi_fwnode_get_args_count() already, i.e. no need to check this in
the caller and in the callee.

> >                         if (ret < 0)
> >                                 return ret;

...

> >                         if (!ref_fwnode)
> >                                 return -EINVAL;
> >
> > +                       device = to_acpi_device_node(ref_fwnode);
> > +                       nargs_count = acpi_fwnode_get_args_count(device, nargs_prop);
> >                         element++;
> > -
> >                         ret = acpi_get_ref_args(idx == index ? args : NULL,
> >                                                 ref_fwnode, &element, end,
> > -                                               args_count);
> > +                                               nargs_count ? nargs_count : args_count);
> >                         if (ret < 0)
> >                                 return ret;

-- 
With Best Regards,
Andy Shevchenko



