Return-Path: <linux-acpi+bounces-14598-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0392AE8782
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F613A4FFB
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 15:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44473269B08;
	Wed, 25 Jun 2025 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBWyN1jp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCAA263F40;
	Wed, 25 Jun 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864238; cv=none; b=m+Z+LHRCEujUvk2PCom3RKY1hXfmfsrpekxrC7poogxySgldSlhAmElFfCOTTpTn5iEirY+G11U5q3mgubrBWoBxnGQ1H6Dwx5nJL/kTi1crLzZi2/3RDMDAhWQQuO3kt8+8GZuS9AO4TGCiReK4LaU/cXLQuyXKqtxe1J0iZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864238; c=relaxed/simple;
	bh=2vYg8CGu9BAqmlZuYpCFtNSeJb0sljjiAyb9B6pMNPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlBSWxChr1SsvQgp4gGawLuL2HVhh+xnOaQvvjALBhkreCMGMHI/hadMLZlM6CPfYvXjMVSD0KLnUYc1lc/6nLruAEO8lVoxUqVYqA0K2RZjU14zzSWQr3JLHTKinnapsyzKoWRA44JFWQFKfDTU+ylKLs6aZ4uMRMgwXq/yFjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBWyN1jp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750864236; x=1782400236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2vYg8CGu9BAqmlZuYpCFtNSeJb0sljjiAyb9B6pMNPM=;
  b=IBWyN1jpG5aGB1YxaC/45ayPe3CDHzlZTT/1KaGXisAknt+JQU0T4UZm
   L9bdHIrNWEDjgFDOCROsDPBE1+lpKR1CYzo4mfJF8tK6808XHRQut8tUz
   KLAOXRAkNqBmfx0KHtvTughjeZ1LAvctq6527bSSiGKaaccvPXfHVxSyb
   doHSw6DmVMooRsCs8NM/HiEqchexlVtte9TU/RRDv9diJC8uFJ0UIuIo3
   AafyeI5XbhgfqwQfwJXdFpzhVllNBjB9/m47BSDPeKuSpK8dLCkP/5Hbu
   xATq+PO9nBaPHpdl3U9ZnJ/t8RirXYhhpsKqXjoIOwxcobgZr3CwLll1V
   w==;
X-CSE-ConnectionGUID: 8ZIgltamR1Cc/0jLIBe7CQ==
X-CSE-MsgGUID: WDK5Z55NTLieJrA1NLn+0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53074329"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="53074329"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 08:10:35 -0700
X-CSE-ConnectionGUID: vz/s4aTuQoaXCf0RhIfy1Q==
X-CSE-MsgGUID: hnpThCZdRQKZftIn4Ys6Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="152014619"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 08:10:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uURld-00000009oSY-08xw;
	Wed, 25 Jun 2025 18:10:29 +0300
Date: Wed, 25 Jun 2025 18:10:28 +0300
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
Message-ID: <aFwRZO30wf8GxQea@smile.fi.intel.com>
References: <20250624202211.1088738-1-superm1@kernel.org>
 <20250624202211.1088738-3-superm1@kernel.org>
 <4a4d577b-a085-46e8-97b9-6df27461c870@kernel.org>
 <1f8c0262-b376-43cb-b2c5-5b60e8cbf678@kernel.org>
 <92ab85ff-6314-4db0-ae12-9803ddde5037@kernel.org>
 <625952d3-01e9-426e-9739-86fe5cdfeb35@kernel.org>
 <7b2f02ef-0274-480b-aecc-bc1165d15fd7@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b2f02ef-0274-480b-aecc-bc1165d15fd7@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 25, 2025 at 03:02:18PM +0000, Limonciello, Mario wrote:
> On 6/25/25 9:41 AM, Mario Limonciello wrote:
> > On 6/25/25 9:31 AM, Hans de Goede wrote:
> >> On 25-Jun-25 4:09 PM, Mario Limonciello wrote:
> >>> On 6/25/25 4:09 AM, Hans de Goede wrote:
> >>>> On 24-Jun-25 10:22 PM, Mario Limonciello wrote:

...

> >> Ok, so specifically the gpiod_set_debounce() call with 50 ms
> >> done by gpio_keys.c is the problem I guess?
> > 
> > Yep.
> > 
> >> So amd_gpio_set_debounce() does accept the 50 ms debounce
> >> passed to it by gpio_keys.c as a valid value and then setting
> >> that breaks the wake from suspend?
> > 
> > That's right.

> >>> Also comparing the GPIO register in Windows (where things work) 
> >>> Windows never programs a debounce.
> >>
> >> So maybe the windows ACPI0011 driver always uses a software-
> >> debounce for the buttons? Windows not debouncing the mechanical
> >> switches at all seems unlikely.
> >>
> >> I think the best way to fix this might be to add a no-hw-debounce
> >> flag to the data passed from soc_button_array.c to gpio_keys.c
> >> and have gpio_keys.c not call gpiod_set_debounce()  when the
> >> no-hw-debounce flag is set.
> >>
> >> I've checked and both on Bay Trail and Cherry Trail devices
> >> where soc_button_array is used a lot hw-debouncing is already
> >> unused. pinctrl-baytrail.c does not accept 50 ms as a valid
> >> value and pinctrl-cherryview.c does not support hw debounce
> >> at all.
> > 
> > That sounds a like a generally good direction to me.

Thinking a bit more of this, perhaps the HW debounce support flag should be
per-GPIO-descriptor thingy. In such cases we don't need to distinguish the
platforms, the GPIO ACPI lib may simply set that flag based on 0 read from
the ACPI tables. It will also give a clue to any driver that uses GPIOs
(not only gpio-keys).

-- 
With Best Regards,
Andy Shevchenko



