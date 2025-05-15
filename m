Return-Path: <linux-acpi+bounces-13726-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB19AB80E1
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 10:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771F07A42D2
	for <lists+linux-acpi@lfdr.de>; Thu, 15 May 2025 08:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D5028B4FE;
	Thu, 15 May 2025 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8vduhZX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA91E3DF2;
	Thu, 15 May 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298106; cv=none; b=mPauFHpMTtU+3IdaXiwzcTP42sYI4J/JhU1Zvjuw7Ltm61goMDqlf0FO38hQh0PIhwJD3n/u0hmMumottkUbDQkMNoOEg6ccIhovdRgobDmLnYvvH3GK1Sobuy5RVUFEm1U10GQni/f1ckgd8Nh+9zAevF5hnIIdGH95i7PDj60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298106; c=relaxed/simple;
	bh=FK3yPomqB3AyvPfrkHg1IFjEg251mn7RzPP8c3HpRfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltEQYIF9xENFWmJmFHPYKDPbr4TTzlzoIebw+oT3KeI7kbI+pCdtDQjkYVIApYmpLnwGiJwalAtt2rRJIiUO29/DxnlI4qcNjLzEfCkwut31i/l+384m2fIYPHgrZ1WdgvX3jt0AKb8LoZZtjl/hD3J1BBNL89V0FyVWARqCMDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8vduhZX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747298105; x=1778834105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FK3yPomqB3AyvPfrkHg1IFjEg251mn7RzPP8c3HpRfo=;
  b=P8vduhZX+11gIsAeiYQ5OQOKBEXmxXT6SGza62e5nHYZPp9fnN815DY9
   JE5VCRIWBgf1wqwcgGRp3IyEZDSRSMbj9x//9GgTuLV7fIfNzow4hRTus
   E3oTZgGqet4wga0l2dVr+pJpVIxp6eG1F/Lt0F/Y3/BbRMURmBz18qT1P
   ve4H4qSOPS4rq8FzlvWwYM1HQmMnp8Q3GHukZFF00S4Zx6L0LrWtiWINR
   H9O8NwJU8EWFMVfdm+SY/k1KC24NBOdrdRBZOnBz3UJRDsXyjDV9vwu3r
   JsvhasCgRseKLywhDLa1cWBPfFdu4VvNi+nx/J1X4TdXUd9SdtTU6y+ZM
   A==;
X-CSE-ConnectionGUID: ehf+1qvYS7ut2i9FgT3ePg==
X-CSE-MsgGUID: sxOwZAzNSfCaimo3Z1GM1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59876277"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="59876277"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 01:34:55 -0700
X-CSE-ConnectionGUID: fc7RY3fkSfCRqe1D51bxkQ==
X-CSE-MsgGUID: WikHw8PaRLGewwVY4zXkVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="161591005"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 15 May 2025 01:34:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id B2C7B23F; Thu, 15 May 2025 11:34:51 +0300 (EEST)
Date: Thu, 15 May 2025 11:34:51 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Mika Westerberg <westeri@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 0/4] gpiolib: acpi: Split quirks to its own file
Message-ID: <20250515083451.GT88033@black.fi.intel.com>
References: <20250513100514.2492545-1-andriy.shevchenko@linux.intel.com>
 <20250514155955.GS88033@black.fi.intel.com>
 <aCWgBp4ZD5aesvRw@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCWgBp4ZD5aesvRw@smile.fi.intel.com>

On Thu, May 15, 2025 at 11:04:22AM +0300, Andy Shevchenko wrote:
> On Wed, May 14, 2025 at 06:59:55PM +0300, Mika Westerberg wrote:
> > On Tue, May 13, 2025 at 01:00:30PM +0300, Andy Shevchenko wrote:
> > > The GPIO ACPI helpers use a few quirks which consumes approximately 20%
> > > of the file. Besides that the necessary bits are sparse and being directly
> > > referred. Split them to a separate file. There is no functional change.
> > > 
> > > For the new file I used the Hans' authorship of Hans as he the author of
> > > all those bits (expect very tiny changes made by this series).
> > > 
> > > Hans, please check if it's okay and confirm, or suggest better alternative.
> > > 
> > > Andy Shevchenko (4):
> > >   gpiolib: acpi: Switch to use enum in acpi_gpio_in_ignore_list()
> > >   gpiolib: acpi: Handle deferred list via new API
> > >   gpiolib: acpi: Add acpi_gpio_need_run_edge_events_on_boot() getter
> > >   gpiolib: acpi: Move quirks to a separate file
> > > 
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
> That's might be the next step to have for all of them, but these are ACPI
> specific. In any case they can't be put to gpiolib-quirks.c due to module
> parameters. If we do that we will need a dirty hack to support old module
> parameters (see 8250 how it's done there, and even author of that didn't like
> the approach).

Hmm, how does it affect module paremeters? I thought they are
gpiolib.something as all these object files are linked to it?

At least can we drop the gpiolib-acpi-core.c rename?

