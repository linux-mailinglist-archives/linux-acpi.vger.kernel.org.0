Return-Path: <linux-acpi+bounces-19249-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 312D8C8450F
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 10:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9683B1297
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 09:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCAC2ED872;
	Tue, 25 Nov 2025 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LR19ivzD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F5C2EDD64;
	Tue, 25 Nov 2025 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064557; cv=none; b=tDoJI+Y7pu4jTrzAhareK48hhoZR78C9sbQZfvJb4U6O69u19NPdByEkQEdFpZXlN/emy4WYRmAFkpH13gE7gNZ72ufpwoXN2IOTY4imfZj3D0ePcmoD8TLYZLk+FLQrvQDJpg+JacS5Y+8uaJIXUpd5+5CtI291CqkV/MFplo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064557; c=relaxed/simple;
	bh=ft7ew2qfT7nP6Gbr86qhmeR9WG9LHorsMZfdwQHWsgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIe0x9Zc/DMUDAW328WOeUHK3UOTf458LPq9Zdd5Xj3aofTDwhL70Fhf7FRe5gnVhq79KITC1aGnY6i+HuD+dJzkkDGTbOYB4RcaCgjMW4kIgUc+4C73FxQBl1jwS80XA87ha7fKA/owebRjGGH+eXQGTNPDiCfUxRT0IaMdXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LR19ivzD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764064556; x=1795600556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ft7ew2qfT7nP6Gbr86qhmeR9WG9LHorsMZfdwQHWsgg=;
  b=LR19ivzDVTdTtaZcM08btU42T0UoyfdggF92Ih48U8KLsXbBu8nAbJnp
   VhRdjz3Dd2JidynL/WKsM4TPfrC19ATyZZfLFz3WDh7LejNy0hCpTKv4w
   JBL6IQbIFC8yBanrZhhyr32S8c4ZQNqcjECxLTEihfZHcld4REgqGGQh0
   FfkVUIKIHvhSG2WMVA2WoV16N8fDW65mqfpZP8O16Uhh88K08waFrIi85
   gC7W+wCyoRhC6urxEjPN76cFk6LznCIg4mctsxe6mWdU7wy7JDnxGa91C
   2nQj4QZ05aY1JqjPDGWKULvFWiDDM6y2gvll/CtXdlZgIws8DWBedDvrU
   Q==;
X-CSE-ConnectionGUID: xCoYQwtJRN+Jj6/m42TtZw==
X-CSE-MsgGUID: CCIePTtzS+ebUc5tCdRGxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="53645455"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="53645455"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 01:55:55 -0800
X-CSE-ConnectionGUID: I18gb42OTXyeGIVWQPk54g==
X-CSE-MsgGUID: DK4TSHc7Twim3IO4GIMRJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="192833855"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.152])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 01:55:53 -0800
Date: Tue, 25 Nov 2025 11:55:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <westeri@kernel.org>
Subject: Re: [PATCH 18/44] drivers/gpio: use min() instead of min_t()
Message-ID: <aSV9JxrZdJZNhSL4@smile.fi.intel.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-19-david.laight.linux@gmail.com>
 <aR7K2bWKiaXrwWIr@smile.fi.intel.com>
 <20251120093743.1cf9bb8f@pumpkin>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120093743.1cf9bb8f@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 20, 2025 at 09:37:43AM +0000, David Laight wrote:
> On Thu, 20 Nov 2025 10:01:29 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Nov 19, 2025 at 10:41:14PM +0000, david.laight.linux@gmail.com wrote:
> > > 
> > > min_t(u16, a, b) casts an 'unsigned long' to 'u16'.
> > > Use min(a, b) instead as it promotes the both values to int
> > > and so cannot discard significant bits.
> > > 
> > > In this case the values should be ok.
> > > 
> > > Detected by an extra check added to min_t().  

...

> > > acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,  
> > 
> > > -	length = min_t(u16, agpio->pin_table_length, pin_index + bits);
> > > +	length = min(agpio->pin_table_length, pin_index + bits);  
> > 
> > Now, if you look closer at the code, the pin_index alone has the problem you
> > are targeting here.
> 
> The compiler warning happens because 'pin_index + bits' is 'int' and the compiler
> doesn't know the value fits in 16 bits.
> It should fit, but only if the caller passes in valid data.

I meant that assignment to pin_index already cuts the higher bits
from the input.

> > On top of that the iterator and 'length' are signed, while
> > the result of min_t(u16) is unsigned (however it has no difference in this case).
> 
> Actually the result type of min_t(u16) is 'int' (:? promotes char/short to int).
> So the u16 cast does '(pin_index + bits) & 0xffff', everything is then promoted
> to 'int' for all the comparisons (etc).

Sure, but the value is positive even if int is signed. That's why I put
a remark in the parentheses that it has no difference in this case.

...

> > TL;DR: I apply this patch with subject changed, but I think more work needs to
> > be done if you want to fix it fully.

-- 
With Best Regards,
Andy Shevchenko



