Return-Path: <linux-acpi+bounces-19629-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C6ACC7C73
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E208E300B6A3
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 13:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE1735CB62;
	Wed, 17 Dec 2025 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wb0NE0Zr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405035C1AA;
	Wed, 17 Dec 2025 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976909; cv=none; b=jskQpK8/9hQUsSjPpcAlOSDE6oo57Wf/eLsP+8Py5SaBM0mRQY4T9vXKaw21EZjH3BdGZJ6CWzWKlaItB3fTg5yHW7M1iPXsXL1X+18NXZFIkcrknsh2MYPj4gsBWu6Ma6rV5qg2mBKzJaCQ2RM7ubOkzNpzFvBG5NRWdYiRZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976909; c=relaxed/simple;
	bh=fU2P2RiQOqkjlomWYIMOL4OZUkrRrtwuBHMbQB3THKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBDuwEroMFFJ69pKOb2BgVmvTzcFGsZit/mYf7n9hMgyo6sf6SNWeB1RdC6LIAMlo13ABHG78YnMEDAVllhUC2XfIClxGEC2mqNH4J/kH+k90I6qbBvIhmebUBTWOirzS25pBypmc6CWrMsXCwWIta69c6AEh4aQvrdTAb2vPe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wb0NE0Zr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765976907; x=1797512907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fU2P2RiQOqkjlomWYIMOL4OZUkrRrtwuBHMbQB3THKE=;
  b=Wb0NE0ZrMCY+LMP0voKqa3oESZq0Is91QXSdUUTCXL1pcjQFju1pA4oU
   AxrVyVtcxp3rby6BLmuHTr22RTpsBbBnX4CBnLJdFvWoWMVKTT5u6gBME
   WpbujDCtUPG6sBXJKw2CuRlE62B0Exp0ecAfpShy4qYiInnuiucewoA8T
   4TXNYmQnCSvGwTRqgB8P4+DneS+BVeMa1Kg4qhJOhBDOCDTlogFgIMoTP
   HjKt9CW1ToiAX4JBsg9TVpgh3/FQyFQkydpLRM3iIEi2rocQ6P6RZg5uU
   yiNewQ6zy7PU2qv2P/qRwjjgxNw0aenZ4IYdz04qTz8//0uYdCIczwhCa
   g==;
X-CSE-ConnectionGUID: SXdbVMhoRKOR220bgcE02w==
X-CSE-MsgGUID: N1wm6rM4QKm16+0BXWiZxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="79283144"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="79283144"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 05:08:26 -0800
X-CSE-ConnectionGUID: nekhdJu5SsiXvfxk2t8DFA==
X-CSE-MsgGUID: QSwEuS9hQZqesjjypmmRCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="228984034"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 17 Dec 2025 05:08:24 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id D049598; Wed, 17 Dec 2025 14:08:22 +0100 (CET)
Date: Wed, 17 Dec 2025 14:08:22 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: francesco.lauritano1@protonmail.com
Cc: Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Disable edge events on boot on ASUS ROG
 Strix G16 G614PP
Message-ID: <20251217130822.GS2275908@black.igk.intel.com>
References: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com>
 <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com>
 <20251217120146.51321-1-francesco.lauritano1@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251217120146.51321-1-francesco.lauritano1@protonmail.com>

Hi,

On Wed, Dec 17, 2025 at 12:01:52PM +0000, francesco.lauritano1@protonmail.com wrote:
> From: Francesco Lauritano <francesco.lauritano1@protonmail.com>
> 
> On the ASUS ROG Strix G16 G614PP (2025), the kernel can stall for ~36
> seconds during late init in acpi_gpio_handle_deferred_request_irqs().
> 
> Booting with gpiolib_acpi.run_edge_events_on_boot=0 avoids the stall and
> restores normal boot times.

Okay but it might just accidentally "work" and hides the real issue. Doing
things like this blindly might end up breaking something that relies on
that _AEI.

Can you post full dmesg and acpipdump somewhere so we can try to figure out
what is going on?

> Add a DMI quirk to disable edge events on boot by default on this model.
> 
> Link: https://lore.kernel.org/platform-driver-x86/6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com/
> 
> Tested-by: Francesco Lauritano <francesco.lauritano1@protonmail.com>
> Signed-off-by: Francesco Lauritano <francesco.lauritano1@protonmail.com>
> ---
>  drivers/gpio/gpiolib-acpi-quirks.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
> index a0116f004..763dd3cbd 100644
> --- a/drivers/gpio/gpiolib-acpi-quirks.c
> +++ b/drivers/gpio/gpiolib-acpi-quirks.c
> @@ -370,6 +370,22 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
>  			.ignore_wake = "ASCP1A00:00@8",
>  		},
>  	},
> +	{
> +		/*
> +		 * The ASUS ROG Strix G16 (2025) has a buggy ACPI GPIO configuration
> +		 * causing acpi_gpio_handle_deferred_request_irqs() to stall for
> +		 * ~36 seconds during boot.
> +		 *
> +		 * Found in BIOS G614PP.307.
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Strix G16 G614PP_G614PP"),
> +		},
> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
> +			.no_edge_events_on_boot = true,
> +		},
> +	},
>  	{
>  		/*
>  		 * Spurious wakeups, likely from touchpad controller
> -- 
> 2.52.0
> 

