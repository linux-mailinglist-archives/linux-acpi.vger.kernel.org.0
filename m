Return-Path: <linux-acpi+bounces-4356-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60E987E7B7
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Mar 2024 11:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F9D1F21AD9
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Mar 2024 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8921C2DF92;
	Mon, 18 Mar 2024 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/VPdU2w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCB364BA;
	Mon, 18 Mar 2024 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759158; cv=none; b=AjD4EUn7/d1gE/uKp9aULklf0USHBLECGG9/L/hMLBGuJJvfH2LYznKbEHebzboRgwJKPh781GeNECL0Mk8mC/wAoGWGKHvca3nySJyupdu7apubAGNS6Z9QV3uaNZRdIflfjj7LOiMLvn+1NX2f/EF5YQBM6t72bIeRxZEFIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759158; c=relaxed/simple;
	bh=OwxnuWoY3m48R2NAbq0b7xRY+NWRNbJKa92r+XdxlU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odiCnApYb1sO97rQTMYGKaRNfQaWMltK91eNcZ8N2SDZJb+F8SmnZT79mt+N7rVASQA90xGuTXGg7xP6YQKtMbj5s8C3zmdcYDBs9RjgRGQZioQOjyieTmMRJHPNiJxeLk0B51wJQ45J56/6ZDlVelB1sFLMJ7HppHEQodaverA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/VPdU2w; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710759157; x=1742295157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OwxnuWoY3m48R2NAbq0b7xRY+NWRNbJKa92r+XdxlU4=;
  b=T/VPdU2wAyrRrL7K6c3d8pL2ErxV66L+8CVUqr2ttlxOfHrkz4Ivtl1J
   2ybS0g4Kj2Gl51OjuUyWUebE7FaI2+qfx4SLaaTmqlDlcrGB5hewToeHT
   jAQpKbbonm9RCE67c/P4ieSUc1B6aoW1wZ7WByMFhIL8oWy3TsqPnjGlu
   +dfgUQLje/NvvGaM5KDfN7iZ5kbFh5m8FX+FNKTQ9dlSNqOAQCT1LmMj7
   lgCdIO70UWFmgXjI4odEhoro+tVkhB/1Nq1pes3JeZms04YaDa/OmLgaF
   omPqrgi16mFaA1bkNVlHYGG7i11FUEFQxFrVU/OGQXNBLv1muCw75rNw3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="16704747"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="16704747"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:52:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="914588377"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="914588377"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:52:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmAbW-0000000Dv2X-2mHi;
	Mon, 18 Mar 2024 12:52:30 +0200
Date: Mon, 18 Mar 2024 12:52:30 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>,
	Hans de Goede <hdegoede@redhat.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: acpi: Move storage of acpi_gpio_chip
Message-ID: <Zfgc7soiZyRAhUkp@smile.fi.intel.com>
References: <20240313030251.1049624-1-hamish.martin@alliedtelesis.co.nz>
 <ZfGMNWtFrgsuUdLz@smile.fi.intel.com>
 <ZfGNfucm2-izJBfd@smile.fi.intel.com>
 <f6833616b81e4e35f561dc0ea4dae8dcd0ac026b.camel@alliedtelesis.co.nz>
 <ZfL5CYMLY03i8q6u@smile.fi.intel.com>
 <a0c6898f94d5ca3132a132fc47e8d8e23c36eb4e.camel@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0c6898f94d5ca3132a132fc47e8d8e23c36eb4e.camel@alliedtelesis.co.nz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

Summon Hans and Sakari for the ideas and for heads up (MIPI case can be
affected as well).

On Fri, Mar 15, 2024 at 12:39:03AM +0000, Hamish Martin wrote:
> On Thu, 2024-03-14 at 15:18 +0200, andriy.shevchenko@linux.intel.com
> wrote:
> > On Thu, Mar 14, 2024 at 01:13:31AM +0000, Hamish Martin wrote:
> > > On Wed, 2024-03-13 at 13:26 +0200, Andy Shevchenko wrote:

...

> > > Removing the setting of the handle to invalid may be the right fix
> > > but
> > > I don't feel I know the code well enough to make a decision on
> > > that. It
> > > certainly doesn't resolve things immediately - I saw ref counting
> > > warnings output.
> > 
> > Not removing, but moving to the better place?
> > Can you share warnings, though?
> > 
> For context here is the current call chain that leads to
> acpi_gpiochip_remove():
> 
>  acpi_gpiochip_remove+0x32/0x1a0
>  gpiochip_remove+0x39/0x140
>  devres_release_group+0xe6/0x160
>  i2c_device_remove+0x2d/0x80
>  device_release_driver_internal+0x19a/0x200
>  bus_remove_device+0xbf/0x100
>  device_del+0x157/0x490
>  ? __pfx_device_match_fwnode+0x10/0x10
>  ? srso_return_thunk+0x5/0x5f
>  device_unregister+0xd/0x30
>  i2c_acpi_notify+0x10e/0x160
>  notifier_call_chain+0x58/0xd0
>  blocking_notifier_call_chain+0x3a/0x60
>  acpi_device_del_work_fn+0x85/0x1d0
>  process_one_work+0x134/0x2f0
>  worker_thread+0x2f0/0x410
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xe3/0x110
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2f/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30

Right, and with invalid handle it can't process further.
And note, that _pointer_ is valid, the content become
unavailable.

> I removed the setting of adev->handle = INVALID_ACPI_HANDLE from
> acpi_scan_drop_device() and shifted it to just after the call to
> blocking_notifier_call_chain() in acpi_device_del_work_fn().
> With that it seems things progress further with the call to
> acpi_get_data() in acpi_gpiochip_remove() succeeding now. However,
> later in acpi_gpiochip_free_regions() we hit this error:
> 
> pca953x i2c-PRP0001:03: Failed to remove GPIO OpRegion handler
> 
> We also get these errors:
> ACPI Warning: Obj 00000000ba6a9600, Reference Count is already zero,
> cannot decrement
>  (20230628/utdelete-422)

Right, because of ACPICA (not even ACPI glue layer!) the callbacks are called
when namespace node (which is acpi_handle) is being removed.

I spend a few hours to understand the history of the invalidation of the handle.
TBH, it looks like a hack to me, but its presence seems necessary to avoid racing
with the hotplug work. It's a lot of functions that run asynchronously there
and the validness of some objects is questionable.

Here are the commits in question:
d783156ea384 ("ACPI / scan: Define non-empty device removal handler")
c27b2c33b621 ("ACPI / hotplug: Introduce common hotplug function acpi_device_hotplug()")

(It doesn't mean they are bad, it means that this requires more investigation.)

That said, from my perspective what should be done/clarified

- the scope of ACPI data (Can we use it outside of ACPICA/ACPI glue layer or not?)

- clarify in the documentation the scope / life time of the ACPI objects from
  the ACPICA perspective (Is it already done? Where?)

- remove that invalidation hack and find better solution for the race avoidance

> > P.S.
> > I'm not an expert in ACPICA and low lever of ACPI glue layer in the Linux
> > kernel, perhaps Rafael can suggest something better.
> > 
> OK, thanks for your help. Hopefully Rafael can add something to the
> discssion.

Added more people to harvest the ideas.

-- 
With Best Regards,
Andy Shevchenko



