Return-Path: <linux-acpi+bounces-14936-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EEDAF1635
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 14:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CAF1C2838E
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4E275106;
	Wed,  2 Jul 2025 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7MSSLLj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A42750F2;
	Wed,  2 Jul 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461018; cv=none; b=POeOYOAVSCXhfBzAZBcT6bwBoAEtCj2Z+NvO8Bail43kN5c1MmVSr1WcQANoIPzCwLmbPoINgmkOPQM31nqwOVT9URXTzYmjgOL+9ufkYequsfc1jA7p7ZgdouOw//8IkLvNNKRTUoUr6wLwLQSDk6mfytt252DfVu9Z4RW0g4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461018; c=relaxed/simple;
	bh=87AuNJuW+2yV1B9Zb2+kKYqb3dCQ3S9+ENTr/v9ygw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoG8qMVN4WPFh3B7mTyCZde3awc1Vl9lMXCLfN+EBYM5nYIDNOD/ZTeq9T7JPV130OQ90rLJDokUKWa+E/+jGfI8MfPlcV5xg2dUJfV4mytrvky3RZHrzdEGfZG40sVNil2+J4At71+hHqT2VKoL6UA/6g+pT9uLO5l0lou0wB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7MSSLLj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751461017; x=1782997017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=87AuNJuW+2yV1B9Zb2+kKYqb3dCQ3S9+ENTr/v9ygw8=;
  b=A7MSSLLjgmgy1cI4PG+rH5xJN3O9HtYltk0DJ9+Cn4E1Z4afNNH7NZtZ
   +hpvmsQCIaLuCIakotv07WQVRIgRdH30mprFQl0UNZ+YF+Io4N8EdvRh7
   sWU8rk0Y1eN45idjFU6JbYhW4RLhBZbzjF+q5ymeEgFbbZq0Rfx7pGsSU
   SYhQv44cEDiOD6wf527r0vnZe2TU379hAnZD+VwydipiPvRouAcH1+wbT
   5lSPZ8r5ydrC2h6czEOJ0Cs7KwjXeGGCeYBRB4jz33F7n186CNu9o+e+i
   Ig8cUnTcWlvN0XqecDIRQ1eD4wIUeBLSrPLSrexy4w1iBR9rqg51/VPZd
   Q==;
X-CSE-ConnectionGUID: xVFwBIAiRP6ETwkCqRFZHA==
X-CSE-MsgGUID: WdS/eiK6QIW9xIn/er9tiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="79193524"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="79193524"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:56:46 -0700
X-CSE-ConnectionGUID: k5aMYtXJR2qEFNakZQpjgw==
X-CSE-MsgGUID: aq3oM6NuTeeQ7eQWflv3ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="158331640"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:56:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWx0t-0000000BvFQ-3atU;
	Wed, 02 Jul 2025 15:56:35 +0300
Date: Wed, 2 Jul 2025 15:56:35 +0300
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
Message-ID: <aGUsg121lenWHL-w@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-16-apatel@ventanamicro.com>
 <CAJZ5v0iYYuK2GF2Pg3NiO4vLFzoYm6Q3Dnk5O2DkMJm1R3qSfQ@mail.gmail.com>
 <aGUaFX9WgTW1I_ZO@smile.fi.intel.com>
 <CAJZ5v0h=qzS67Xu6NUfN_LmQUmKF9=AtkaRrTx81td0m-mRNNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h=qzS67Xu6NUfN_LmQUmKF9=AtkaRrTx81td0m-mRNNg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 02:39:30PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jul 2, 2025 at 1:38 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Jul 02, 2025 at 12:20:55PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jul 2, 2025 at 7:16 AM Anup Patel <apatel@ventanamicro.com> wrote:

...

> > > >  static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
> > > >                                           const char *propname, const char *nargs_prop,
> > > >                                           unsigned int args_count, unsigned int index,
> >
> > > >         const struct acpi_device_data *data;
> > > >         struct fwnode_handle *ref_fwnode;
> > > >         struct acpi_device *device;
> > > > +       unsigned int nargs_count;
> > > >         int ret, idx = 0;
> >
> > > > +                       nargs_count = acpi_fwnode_get_args_count(device, nargs_prop);
> > >
> > > I think it should work the same way as it used to for the callers that
> > > pass args_count, so maybe
> > >
> > > if (!args_count)
> > >         args_count = acpi_fwnode_get_args_count(device, nargs_prop);
> >
> > But this is different variable.
> 
> Of course it is different.  It is an acpi_fwnode_get_reference_args() parameter.
> 
> > > >                         element++;
> > > > -
> > > >                         ret = acpi_get_ref_args(idx == index ? args : NULL,
> > > >                                                 acpi_fwnode_handle(device),
> > > > -                                               &element, end, args_count);
> > > > +                                               &element, end,
> > > > +                                               nargs_count ? nargs_count : args_count);
> > >
> > > And this change would not be necessary?
> >
> > This is not the same check as proposed above.
> 
> No, it is not.
> 
> It just makes the function work the same way it did before the change
> for the callers who passed nozero args_count and so they might be
> forgiven expecting that it would be taken into account.

I see your point now. But do we have such a user? I dunno.

-- 
With Best Regards,
Andy Shevchenko



