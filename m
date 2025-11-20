Return-Path: <linux-acpi+bounces-19136-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BABB9C72B21
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 09:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C6444E2A9F
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 08:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7A26ED53;
	Thu, 20 Nov 2025 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiCQh3tu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A4221271;
	Thu, 20 Nov 2025 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625696; cv=none; b=ODGM0K3pKg+Qe5DabEThy2Y9ATVsODiybmxUr4OUqzqVt8AZvDmhbkn83p/4jFphmE+x7u43x23xhvPMAYhG8pc3JlImIb0exAf3U82ebsjSBRp2clxYk139dCFH1cSj7i57jCuG8+uL10ymRC/XZ7p0ZN/USXr+YXf5NAppqcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625696; c=relaxed/simple;
	bh=SSZA69vSnHTsTGmpz+7Z4/vliAw53CA2Oum9gWN3dxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgOnVwnSmH4WFsiz6V6c4RAUQXuwfpiBxrxV1gw0memVsmDy4ucLRb2IW+TPFbgAEw7MbCeg34hDS5pKDWRBM6Fx6ORklJKUqa2xeEsgRAmvcRAzG+wkyfDp3RFkg0j3YO94xl2T7XccCn+X6fiLUaGAG486h1Zb96UDjkUHYYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiCQh3tu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763625694; x=1795161694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SSZA69vSnHTsTGmpz+7Z4/vliAw53CA2Oum9gWN3dxM=;
  b=WiCQh3tu6uzYRW0AAt5U4olf0nB3/shsahPy4iEYZxul1kcIX1mH21NP
   la+oGbM4Z2lgu9u91C76rJDurWVl3Ta6gHJJjK63nC902pIViAqvqDniN
   f+0hjjWhjRRwLiUijKJ9hi3hBJlCIwqU6UNhmjdrxR9xs+NJCsRL7cqo3
   Iz/j3VtJ5tC9zgVOiKOY0PJQtAYzXvGWJVstlUAGAwbcMzCAorkJ9nAUQ
   tJDRQbrSMmKoodbgHXW6K+BF/Rql7rqifbOu7qqiApjXKEu5LDyOmwd5h
   30KFqZwovh+1ZMRdDs8o8BELTb+SdK5KE3TnmMt3uNn5L27xIyWc63Qa+
   w==;
X-CSE-ConnectionGUID: 5Mb4scYSTuCcUGzLQlUkQg==
X-CSE-MsgGUID: 9ay5Wd10SWasvha5yqsQdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65846193"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65846193"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:01:33 -0800
X-CSE-ConnectionGUID: cvvDmAEWTwe8GdGy2Ex7cQ==
X-CSE-MsgGUID: 4WOVAidyTqKpFXp70t3A1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="195426582"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.97])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 00:01:31 -0800
Date: Thu, 20 Nov 2025 10:01:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: david.laight.linux@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <westeri@kernel.org>
Subject: Re: [PATCH 18/44] drivers/gpio: use min() instead of min_t()
Message-ID: <aR7K2bWKiaXrwWIr@smile.fi.intel.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-19-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119224140.8616-19-david.laight.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 10:41:14PM +0000, david.laight.linux@gmail.com wrote:
> 
> min_t(u16, a, b) casts an 'unsigned long' to 'u16'.
> Use min(a, b) instead as it promotes the both values to int
> and so cannot discard significant bits.
> 
> In this case the values should be ok.
> 
> Detected by an extra check added to min_t().

In most of the patches you need to follow the commonly used Subject prefix.
This can be done by doing

	git log --oneline --no-merges -- $FILE(S)_OF_INTEREST

For example,

$ git log --no-decorate --oneline --no-merges -- drivers/gpio/gpiolib-acpi*
b1055678a016 gpiolib: acpi: Use %pe when passing an error pointer to dev_err()
e4a77f9c85a5 gpiolib: acpi: Make set debounce errors non fatal
19c839a98c73 gpiolib: acpi: initialize acpi_gpio_info struct
3712ce9fa501 gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-05
16c07342b542 gpiolib: acpi: Program debounce when finding GPIO
23800ad1265f gpiolib: acpi: Add quirk for ASUS ProArt PX13
...


> acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,

> -	length = min_t(u16, agpio->pin_table_length, pin_index + bits);
> +	length = min(agpio->pin_table_length, pin_index + bits);

Now, if you look closer at the code, the pin_index alone has the problem you
are targeting here. On top of that the iterator and 'length' are signed, while
the result of min_t(u16) is unsigned (however it has no difference in this case).

...

TL;DR: I apply this patch with subject changed, but I think more work needs to
be done if you want to fix it fully.

-- 
With Best Regards,
Andy Shevchenko



