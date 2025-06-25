Return-Path: <linux-acpi+bounces-14600-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17789AE87BD
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 17:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27B75A523C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7CA269D18;
	Wed, 25 Jun 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVi3WHpC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4CB4C92;
	Wed, 25 Jun 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864658; cv=none; b=CQ0sQtxG2v/Kiu4sPO3zqaJ7pagYR4mTloU8DooanNwc/PCUI+TpKD09dCx6gIvHwscfIAAvCH3mQKG8KPhZjbhtukf+Bh49Ag9cssHaAr+d7F2EXyhzdete/4XhXlwzbpxh0DRurXSwqqC0uqvb8f0hd+BTV0kNhNZDIePPV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864658; c=relaxed/simple;
	bh=VAIMJsEXUJBRtuANssi1i4L6RoyEQfqrRrxpCMh/jXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YckCV6hcUjnwlbeGqJHQ3CAyMcvuDJ5Wdg/0KQMNVDbF585ucFcEbIo19fz0RAfWajPYyeHd9TuKBW9ysOLnXB9QqmDA+580dNeqKEckVtNl9+bWdbG4nk44bs316G1CLPy90kWjwY3djIy9xCpS46sOh4TXhxgZGmKopjlR1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVi3WHpC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750864657; x=1782400657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VAIMJsEXUJBRtuANssi1i4L6RoyEQfqrRrxpCMh/jXU=;
  b=KVi3WHpCodDmZxN/gy0ab6i7kPX2yKaox7pDVYdXDIRoMOxupJa74wka
   IicWmYTdY3UAR/E46CU2/EgEB7cRrUB0bZJ3v8ZgOM9FZCbBBx7rFfjXH
   GjOxSkRstTX15atVm9Fysb2t8LZ4hOWO33Ya4//ZRr7TrOAiBIJYBaL5D
   gqCsD/UzJxboCWTkxwNxcS+vpwQykofohTEgteWp7KSqPpG58n1jsrh5r
   OuZj3EiRB7aXwHpfZuqFRZ9QadIZCw4gSMDv0GXsSxz+DRxpPLXNZnp0b
   VvQaOEDwI4erXetHEOmHdiVHu5n3MZeIxm0kfEGu8SAQhFENbaC7dKVf8
   A==;
X-CSE-ConnectionGUID: 9Z0vX/8+Tt2sb2GggMjWNg==
X-CSE-MsgGUID: A79YH8HETgePQQvM5JZdag==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53279580"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="53279580"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 08:17:35 -0700
X-CSE-ConnectionGUID: DvVR5OVsTUiiXisDpTF6lg==
X-CSE-MsgGUID: l+R2EqbSQtaauRITvfxcjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="152538509"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 08:17:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uURsP-00000009oYL-3XHe;
	Wed, 25 Jun 2025 18:17:29 +0300
Date: Wed, 25 Jun 2025 18:17:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>
Subject: Re: [PATCH 2/2] Revert "Input: soc_button_array - debounce the
 buttons"
Message-ID: <aFwTCUXQydxRVEfk@smile.fi.intel.com>
References: <20250624202211.1088738-1-superm1@kernel.org>
 <20250624202211.1088738-3-superm1@kernel.org>
 <4a4d577b-a085-46e8-97b9-6df27461c870@kernel.org>
 <1f8c0262-b376-43cb-b2c5-5b60e8cbf678@kernel.org>
 <92ab85ff-6314-4db0-ae12-9803ddde5037@kernel.org>
 <625952d3-01e9-426e-9739-86fe5cdfeb35@kernel.org>
 <7b2f02ef-0274-480b-aecc-bc1165d15fd7@amd.com>
 <aFwRZO30wf8GxQea@smile.fi.intel.com>
 <be57dcd1-a9ba-44f6-af9e-9b40f2b5c870@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be57dcd1-a9ba-44f6-af9e-9b40f2b5c870@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 03:14:40PM +0000, Limonciello, Mario wrote:
> On 6/25/25 10:10 AM, Andy Shevchenko wrote:
> > On Wed, Jun 25, 2025 at 03:02:18PM +0000, Limonciello, Mario wrote:
> >> On 6/25/25 9:41 AM, Mario Limonciello wrote:
> >>> On 6/25/25 9:31 AM, Hans de Goede wrote:
> >>>> On 25-Jun-25 4:09 PM, Mario Limonciello wrote:
> >>>>> On 6/25/25 4:09 AM, Hans de Goede wrote:
> >>>>>> On 24-Jun-25 10:22 PM, Mario Limonciello wrote:

...

> >>>> Ok, so specifically the gpiod_set_debounce() call with 50 ms
> >>>> done by gpio_keys.c is the problem I guess?
> >>>
> >>> Yep.
> >>>
> >>>> So amd_gpio_set_debounce() does accept the 50 ms debounce
> >>>> passed to it by gpio_keys.c as a valid value and then setting
> >>>> that breaks the wake from suspend?
> >>>
> >>> That's right.
> > 
> >>>>> Also comparing the GPIO register in Windows (where things work)
> >>>>> Windows never programs a debounce.
> >>>>
> >>>> So maybe the windows ACPI0011 driver always uses a software-
> >>>> debounce for the buttons? Windows not debouncing the mechanical
> >>>> switches at all seems unlikely.
> >>>>
> >>>> I think the best way to fix this might be to add a no-hw-debounce
> >>>> flag to the data passed from soc_button_array.c to gpio_keys.c
> >>>> and have gpio_keys.c not call gpiod_set_debounce()  when the
> >>>> no-hw-debounce flag is set.
> >>>>
> >>>> I've checked and both on Bay Trail and Cherry Trail devices
> >>>> where soc_button_array is used a lot hw-debouncing is already
> >>>> unused. pinctrl-baytrail.c does not accept 50 ms as a valid
> >>>> value and pinctrl-cherryview.c does not support hw debounce
> >>>> at all.
> >>>
> >>> That sounds a like a generally good direction to me.
> > 
> > Thinking a bit more of this, perhaps the HW debounce support flag should be
> > per-GPIO-descriptor thingy. In such cases we don't need to distinguish the
> > platforms, the GPIO ACPI lib may simply set that flag based on 0 read from
> > the ACPI tables. It will also give a clue to any driver that uses GPIOs
> > (not only gpio-keys).
> 
> But 0 doesn't mean hardware debounce support is there, 0 means that 
> hardware debounce is not required to be programmed for this GPIO.
> 
> That is - if another system had a non-zero value in the GpioInt entry I 
> would expect this to be translated into the GPIO register.

Correct. The question is only about 0. So the flow will look like

1) if the GPIO is defined with 0 debounce, set the flag;
2) if the GPIO is defined with non-zero value, try to apply it;
3) if the step 2) fails, warn and set the flag.

Would it make sense?
Hans?

-- 
With Best Regards,
Andy Shevchenko



