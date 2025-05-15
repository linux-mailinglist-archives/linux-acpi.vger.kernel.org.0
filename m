Return-Path: <linux-acpi+bounces-13725-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7DDAB8015
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 10:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BA217F14C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 08:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091AA21D3CD;
	Thu, 15 May 2025 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dh08Z4iF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7F19CC3D;
	Thu, 15 May 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297025; cv=none; b=UbhOf7t9TxmDJSMFBf+fawOEh1vL1fjrmRjMCnML1lYNx+flRvYQUCwByI5z3cbg28hvjsCRTUeluX2EnNEYXu6n8UGHPl780rATC1hPoc7Mjf/wPPuyCATq87m0q9AwIlVTeo3yUMT+hJsjjklrFmplmIZczv/mbG6hNlK4SNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297025; c=relaxed/simple;
	bh=jeEOhZKOTAjkhdwPFYNHsRf8Tq3rBS2geVYhdvnggwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0l+zQwSf0C0qoHLdA0KXhI7sie2BZPZZ/7lSnALVhScDNZOCbxGszAieL4R9ZKBvso8dTKSfjhA0kuSc3rc5k0G9M5LaMZ+EXgiTYAatsFI/zQXjY11ZIQAlxPlXnCi4N9EboPWvMRrEqTjSarle2Ne6KAyxC0fx2vzx5jOnAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dh08Z4iF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747297025; x=1778833025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jeEOhZKOTAjkhdwPFYNHsRf8Tq3rBS2geVYhdvnggwU=;
  b=Dh08Z4iF3F/BAJGTXAZ51G8GYXJJH4xY/5MWWWn7LlvKD7iXT7hh+8XG
   5vIT7iyw+y2vJkxER67AcL4ToN96mah6kJ8ZP/liVVEwiPcRhXK7WYSBH
   kXAkrZTJFas9tzbTiza9SA2uUvWhuc8B3fWo5hN5/gdzi+BG3pnFBlzym
   +BNtuwe2E4y2d5eH5LWMGw2038NAmSXZao+0Wis9CZel7BsdAbNg2wfFw
   OTdy/slWbhzQSknuCNLGg4xIynLProzDaJykC8S6GrjDdPgU5iZTO8Ti9
   0jgPX0W17XFWpU2pFR81lbunkkUDhse13D9CvZaczgvJ8gL0XWSRBmC8d
   A==;
X-CSE-ConnectionGUID: YXInKZt8RVq3ODNO0Ayn7g==
X-CSE-MsgGUID: A+keISg8SGKnC4zPFFgv7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="60559058"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="60559058"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:17:04 -0700
X-CSE-ConnectionGUID: IGj+2oH3TUCYIKHgL0A8uQ==
X-CSE-MsgGUID: tM7oZ2QpT1uNtBRbqMFzJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="143256362"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:17:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uFTly-00000001mwN-16vI;
	Thu, 15 May 2025 11:16:58 +0300
Date: Thu, 15 May 2025 11:16:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 0/4] gpiolib: acpi: Split quirks to its own file
Message-ID: <aCWi-oUsCrbS0AiI@smile.fi.intel.com>
References: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
 <20250514155955.GS88033@black.fi.intel.com>
 <CACRpkdbhnoffwtwVTMRaUAGVEpLfAESQNOb1PvYOer=V+og97Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbhnoffwtwVTMRaUAGVEpLfAESQNOb1PvYOer=V+og97Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 15, 2025 at 09:21:10AM +0200, Linus Walleij wrote:
> On Wed, May 14, 2025 at 6:00 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> 
> > >  drivers/gpio/Makefile                         |   1 +
> > >  .../{gpiolib-acpi.c => gpiolib-acpi-core.c}   | 344 +----------------
> > >  drivers/gpio/gpiolib-acpi-quirks.c            | 363 ++++++++++++++++++
> > >  drivers/gpio/gpiolib-acpi.h                   |  15 +
> >
> > All this -foo-core things look redundant to me. Why not just split it out
> > and call it gpiolib-quirks.c and put there all the quirks not just ACPI? I
> > Don't think we want to have gpiolib-of-quirks.c and gpiolog-swnode-quirks.c
> > and so on.
> 
> For OF/device tree the quirks are in gpiolib-of.c and we probably do
> not want to put these into a shared file with ACPI (and swnode?)
> quirks as systems with OF compile objects (Makefile entries)
> and ACPI compile objects are not always included in the same build,
> so having them per-hw-config-principle cuts down compiletime
> overhead. Also it's pretty clear separation of concerns I think.

Yes, gpiolib-quirks.c would make sense for the shared code, but I don't
expect we will have any reasonable amount of those that are shared between
ACPI, DT, swnode cases.

But main problem here is the module parameters that are already exist,
there is no clean way in Linux kernel to provide an aliases table when
renaming files (AFAIK, otherwise tell me how to achieve that).

-- 
With Best Regards,
Andy Shevchenko



