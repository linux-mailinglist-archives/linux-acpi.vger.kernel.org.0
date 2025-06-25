Return-Path: <linux-acpi+bounces-14615-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1F7AE8BD6
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 19:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E3D4A33D0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C262D5409;
	Wed, 25 Jun 2025 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLLjwv2V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40072C08A5;
	Wed, 25 Jun 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874166; cv=none; b=tcVVwtvtucfdjWoYmpap45Ul369l4c7fxU29OVUEH3ytQaxrtyakaL9M7TLd8IGMyg1E6ptPDLjX0KmCk7R+d5pNVkoz4Nl4fwkHRmWGfiwuVYXXi65PSiOqm0s140l41lJxToqf/M7RRLwxmDOQlyWhmAS0RBcgG/NILA+INTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874166; c=relaxed/simple;
	bh=bu5iQw1CLF7QIZG9KbNG3IwzNGML3JMs21WuLSzDcl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdo8+1TXoxpdM1875zOYHWPeEtE/WxQdvvz7ZTWfBqxcfqcLqjmaeJCXvqJHsc1WMrgxk7u56/f2YhOxegUmN0CvH11aH2IPnLvqASu6lgVXtXPACQ9d8QdSIMwb04JpZQZx/FbdhF1dmEX8C4+R6ih5AXUEPCwMLgGRG9acA3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLLjwv2V; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750874164; x=1782410164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bu5iQw1CLF7QIZG9KbNG3IwzNGML3JMs21WuLSzDcl4=;
  b=lLLjwv2V9xPdALogVSO5wosN4WhCYOSSS7FdxJALrCU+OEnIHmsJwq57
   B5rAKC+OeUHBE1wJ0h+4/h4Tf4ZtreF9XUGaTvIz4uWc//AahGf6j4GjD
   Bwy3kVI6/zFiQrpeiakTsxU0hVmWnwgy/Ck5+KqHPjt+T7HCpx8bgLeSU
   uVTyAnXMyXylX8R3tYzfVp0jEqNl1PBor1hZlHS3nO/pprNlgzHso7PYy
   qzsK+t8CFl3GKvtxc4G8I8/X0PLx2fQ4lANwoNRME+Yr/rNbYU565kOhJ
   OCV6Dr0kMg9+SrbaHMfzUoMyoFGComwNLeDizVJQpeJOUdLgVALB17Oa+
   A==;
X-CSE-ConnectionGUID: I/OkDkXNRm+CJXnhfJEZzw==
X-CSE-MsgGUID: bARxgZxGRAWx0Wt5XzISqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53221513"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="53221513"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 10:54:25 -0700
X-CSE-ConnectionGUID: 3eHJrar+STCeBVkm+snsYg==
X-CSE-MsgGUID: 6iXZVSoVRI2XMG/GMgKgNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="152774431"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 10:54:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uUUKB-00000009vzU-0jqb;
	Wed, 25 Jun 2025 20:54:19 +0300
Date: Wed, 25 Jun 2025 20:54:18 +0300
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
Message-ID: <aFw3yhVUkdtNnWXT@smile.fi.intel.com>
References: <20250624202211.1088738-3-superm1@kernel.org>
 <4a4d577b-a085-46e8-97b9-6df27461c870@kernel.org>
 <1f8c0262-b376-43cb-b2c5-5b60e8cbf678@kernel.org>
 <92ab85ff-6314-4db0-ae12-9803ddde5037@kernel.org>
 <625952d3-01e9-426e-9739-86fe5cdfeb35@kernel.org>
 <7b2f02ef-0274-480b-aecc-bc1165d15fd7@amd.com>
 <aFwRZO30wf8GxQea@smile.fi.intel.com>
 <be57dcd1-a9ba-44f6-af9e-9b40f2b5c870@amd.com>
 <aFwTCUXQydxRVEfk@smile.fi.intel.com>
 <6c0514e5-0ea6-4f66-9bc0-4230d7ef0d4b@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c0514e5-0ea6-4f66-9bc0-4230d7ef0d4b@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 03:34:55PM +0000, Limonciello, Mario wrote:
> On 6/25/25 10:17 AM, Andy Shevchenko wrote:
> > On Wed, Jun 25, 2025 at 03:14:40PM +0000, Limonciello, Mario wrote:
> >> On 6/25/25 10:10 AM, Andy Shevchenko wrote:
> >>> On Wed, Jun 25, 2025 at 03:02:18PM +0000, Limonciello, Mario wrote:
> >>>> On 6/25/25 9:41 AM, Mario Limonciello wrote:
> >>>>> On 6/25/25 9:31 AM, Hans de Goede wrote:
> >>>>>> On 25-Jun-25 4:09 PM, Mario Limonciello wrote:
> >>>>>>> On 6/25/25 4:09 AM, Hans de Goede wrote:
> >>>>>>>> On 24-Jun-25 10:22 PM, Mario Limonciello wrote:

...

> >>>>>> Ok, so specifically the gpiod_set_debounce() call with 50 ms
> >>>>>> done by gpio_keys.c is the problem I guess?
> >>>>>
> >>>>> Yep.
> >>>>>
> >>>>>> So amd_gpio_set_debounce() does accept the 50 ms debounce
> >>>>>> passed to it by gpio_keys.c as a valid value and then setting
> >>>>>> that breaks the wake from suspend?
> >>>>>
> >>>>> That's right.
> >>>
> >>>>>>> Also comparing the GPIO register in Windows (where things work)
> >>>>>>> Windows never programs a debounce.
> >>>>>>
> >>>>>> So maybe the windows ACPI0011 driver always uses a software-
> >>>>>> debounce for the buttons? Windows not debouncing the mechanical
> >>>>>> switches at all seems unlikely.
> >>>>>>
> >>>>>> I think the best way to fix this might be to add a no-hw-debounce
> >>>>>> flag to the data passed from soc_button_array.c to gpio_keys.c
> >>>>>> and have gpio_keys.c not call gpiod_set_debounce()  when the
> >>>>>> no-hw-debounce flag is set.
> >>>>>>
> >>>>>> I've checked and both on Bay Trail and Cherry Trail devices
> >>>>>> where soc_button_array is used a lot hw-debouncing is already
> >>>>>> unused. pinctrl-baytrail.c does not accept 50 ms as a valid
> >>>>>> value and pinctrl-cherryview.c does not support hw debounce
> >>>>>> at all.
> >>>>>
> >>>>> That sounds a like a generally good direction to me.
> >>>
> >>> Thinking a bit more of this, perhaps the HW debounce support flag should be
> >>> per-GPIO-descriptor thingy. In such cases we don't need to distinguish the
> >>> platforms, the GPIO ACPI lib may simply set that flag based on 0 read from
> >>> the ACPI tables. It will also give a clue to any driver that uses GPIOs
> >>> (not only gpio-keys).
> >>
> >> But 0 doesn't mean hardware debounce support is there, 0 means that
> >> hardware debounce is not required to be programmed for this GPIO.
> >>
> >> That is - if another system had a non-zero value in the GpioInt entry I
> >> would expect this to be translated into the GPIO register.
> > 
> > Correct. The question is only about 0. So the flow will look like
> > 
> > 1) if the GPIO is defined with 0 debounce, set the flag;
> > 2) if the GPIO is defined with non-zero value, try to apply it;
> > 3) if the step 2) fails, warn and set the flag.
> > 
> > Would it make sense?
> > Hans?
> 
> But so on these problematic BYT/CYT tablets which "layer" should be 
> setting the 50ms debounce?
> That should still be a quirk at the soc_button_array layer, right?
> 
> Because gpio_keys_setup_key() will already fallback to software 
> debounce, and the goal here is that both of those only use the 50ms 
> specifically with software debouncing.

Probably gpiod_set_debounce() should become a no-op in this case?

-- 
With Best Regards,
Andy Shevchenko



