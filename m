Return-Path: <linux-acpi+bounces-13730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB7EAB82AB
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 11:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6699C3AD72C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 09:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D17294A0E;
	Thu, 15 May 2025 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwczLDKf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935731DE3D6;
	Thu, 15 May 2025 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301491; cv=none; b=I0hvQGE+yJperAOkt5V0A466Iv11g0CZLp9gUodEqYeoqtKjgYrVM3npSHCM4JzS5nMpsRkQ0KIA9ApXlr/G10OjRLynqmnrOb4uFqGhZ/8+S5IZjvytPSzZ/CgcgsAu7KDa0kz8ShxN60oe1dgM4XrDdZG8PfbO+cgUivebSbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301491; c=relaxed/simple;
	bh=UFT4P0cp/ZjCmSXOpyEwfGN0zN+xz7+ZNg6QoBKfLvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUmjWA73Dufu3qfsxVAgFGxEawSlfh12GVaIrDRP0Jda66+HDsIWvhjVHaH+NW/W8n0Cq8KU2YzCsVvNEyIr4xo7BT2vngUNpECyfdFovUQ54p0mRX80y1Acb9JXR/+T8+NZXe+z/yajp6fdoEJRXCMQX+/ZwJv8kGsNe2r+9fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwczLDKf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747301490; x=1778837490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UFT4P0cp/ZjCmSXOpyEwfGN0zN+xz7+ZNg6QoBKfLvM=;
  b=GwczLDKfC2ElslEZ7l4nFPsEl6ad92po1TvxahDvHTQWr5GvjgGFE5FA
   wRn71EONbD2LG8Mey/7nmttyQHEjZXSB+IDSBuxARjCokhsZS9m236yFy
   51kRSa++C86mdBrSj0ip8Ox/yPXh2m2nA+gkfidmdUgDoXgI41MCqVbQ8
   SaPzwfTILOXpVLOWKsA+sCmMAc5esP8N9Zy8McqwmWDsG0Z5NCBhol+vg
   QMLEl+OmMEZ2Gf8CKxoMzszQpWDGpSw2XY3AeisLftss6so1QZPKkrh+6
   kHCBgx52Lpwg6yhEVWIR50fMjld5PwY1L4z73ID0/+/vuuqf9c/vVsJid
   Q==;
X-CSE-ConnectionGUID: ymMKqKXcS3uIxN8rmNiolw==
X-CSE-MsgGUID: xoDbyUt4Q8OskFk9Jm02hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="53030456"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="53030456"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 02:31:29 -0700
X-CSE-ConnectionGUID: d7me3l+tSr+6XOUx9LHvIQ==
X-CSE-MsgGUID: lE2z+msuTB+buviNfU9KIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="169248108"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 15 May 2025 02:31:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0921923F; Thu, 15 May 2025 12:31:24 +0300 (EEST)
Date: Thu, 15 May 2025 12:31:24 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 0/4] gpiolib: acpi: Split quirks to its own file
Message-ID: <20250515093124.GV88033@black.fi.intel.com>
References: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
 <20250514155955.GS88033@black.fi.intel.com>
 <aCWgBp4ZD5aesvRw@smile.fi.intel.com>
 <20250515083451.GT88033@black.fi.intel.com>
 <aCWo19FjcvZzP1H7@smile.fi.intel.com>
 <20250515084727.GU88033@black.fi.intel.com>
 <aCWsuRc5ggJJFc5u@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCWsuRc5ggJJFc5u@smile.fi.intel.com>

On Thu, May 15, 2025 at 11:58:33AM +0300, Andy Shevchenko wrote:
> On Thu, May 15, 2025 at 11:47:27AM +0300, Mika Westerberg wrote:
> > On Thu, May 15, 2025 at 11:41:59AM +0300, Andy Shevchenko wrote:
> > > On Thu, May 15, 2025 at 11:34:51AM +0300, Mika Westerberg wrote:
> > > > On Thu, May 15, 2025 at 11:04:22AM +0300, Andy Shevchenko wrote:
> > > > > On Wed, May 14, 2025 at 06:59:55PM +0300, Mika Westerberg wrote:
> 
> ...
> 
> > > > > That's might be the next step to have for all of them, but these are ACPI
> > > > > specific. In any case they can't be put to gpiolib-quirks.c due to module
> > > > > parameters. If we do that we will need a dirty hack to support old module
> > > > > parameters (see 8250 how it's done there, and even author of that didn't like
> > > > > the approach).
> > > > 
> > > > Hmm, how does it affect module paremeters? I thought they are
> > > > gpiolib.something as all these object files are linked to it?
> > > 
> > > gpiolib_acpi.FOO because the object file is gpiolib-acpi.o.
> > 
> > Ah okay.
> > 
> > > > At least can we drop the gpiolib-acpi-core.c rename?
> > > 
> > > Unfortunately no due to the above.
> > 
> > This does not work?
> > 
> > gpiolib-acpi-y                 := gpiolib-acpi.o gpiolib-acpi-quirks.o
> 
> No. You can't use the same name on left and right parts.

I see :( Okay then I guess there are no other options than name it like
this.

[ Ideally we would drop the while gpiolib- prefix from all these so you have
acpi.c, sysfs.c and so on without the redundancy but that's outside of
scope of this work anyways ;-) ]

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

