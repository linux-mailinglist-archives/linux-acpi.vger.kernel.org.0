Return-Path: <linux-acpi+bounces-19875-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC0CCE5708
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Dec 2025 21:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21B94300B28B
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Dec 2025 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E365F23B61E;
	Sun, 28 Dec 2025 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiu4+dpf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A27083C;
	Sun, 28 Dec 2025 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766952912; cv=none; b=HF57KXciVsmAm9jRhjwAGBd0wMfBTtIdJ6cKBmpFXIoaIjYoFg9cRDVr8sxMePkbpTDhALuU8ijVB7v7yUs4pAnkzaOlpWJtSCPYpJqK2cD7vNQLgrc8cwNvCFkTgTHsCFuGPcUWDg9vZfMRHGc2CHZFZ8MFXsmtQnPxOoQSndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766952912; c=relaxed/simple;
	bh=+9l7RPUslIPHW/THX1/QNwzs4MImlyHOusYT9W1RtJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/l5GNZMHrjFAGTEwrFYDfJqqlN+TqonQ2LLDsvhg42KBAUZC/0rKFn/2VHz5nwPezeV/ozXEInFP8Kt8LNdyn1qe6kmcaFY3CAb+lByG+EcR9nt0Tx0iW4Ou7RL2GWKQh1LWwXrNt98H/N900KMvFQdDcrAfjz7IlRGB5KVLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fiu4+dpf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766952911; x=1798488911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+9l7RPUslIPHW/THX1/QNwzs4MImlyHOusYT9W1RtJQ=;
  b=fiu4+dpfxkdm5Ie8lGxziPnKDHKKoLKTx73+cD8U8n++oIisP8bbbQxr
   AmT6PrNFxnCEA8JcnPaSp+0P0XSDN+K2GMeAo0OlODCwaob10GLCKe3Ne
   YhWGKVff0pFz8g25jTpXyh46HKsxv20KBgK45LuevJFoZLEDPyY52gT/4
   cqHOvYEQQnRppUxwRXdvyvHWsgZW6n/w74sH786ik0aQZMS+TnmTvaU6T
   SRc0ZbAKhNRJVaCPLQkfv2qTJ82pbbbgMZGsi8yCfK9MC96aQb3J3v19D
   EEEeedZdcuWulwTdeHQOwrIpd8iv/YO1HNppPkAQGS5T3tKevq7wTcF2c
   w==;
X-CSE-ConnectionGUID: kXK5UXhUTNyOthi4cv9ANA==
X-CSE-MsgGUID: SBGWaZP3S5CeCVz6VWZTMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11655"; a="72207920"
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="72207920"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 12:15:11 -0800
X-CSE-ConnectionGUID: epHtT5m7QhmfH4MW7GFt9A==
X-CSE-MsgGUID: wlkIvAvsRGa32e6TnuU7wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,184,1763452800"; 
   d="scan'208";a="201693922"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2025 12:15:08 -0800
Date: Sun, 28 Dec 2025 22:15:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Francesco Lauritano <francesco.lauritano1@protonmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Disable edge events on boot on ASUS ROG
 Strix G16 G614PP
Message-ID: <aVGPysQghxHGaJ2r@smile.fi.intel.com>
References: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com>
 <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com>
 <20251217120146.51321-1-francesco.lauritano1@protonmail.com>
 <20251217130822.GS2275908@black.igk.intel.com>
 <X9fJuqzxIBzuhcbjDFYBPSScoKnUpKLe13znKYaJkJpgmjcbfF6_RN2_24ksQq0Hwyvy9pVrnL7_vHEarnQyUBC0zBLmhlvp75nNhgmq7OI=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9fJuqzxIBzuhcbjDFYBPSScoKnUpKLe13znKYaJkJpgmjcbfF6_RN2_24ksQq0Hwyvy9pVrnL7_vHEarnQyUBC0zBLmhlvp75nNhgmq7OI=@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 17, 2025 at 02:01:51PM +0000, Francesco Lauritano wrote:
> 
> Thanks for looking into this. Happy to dig deeper.
> 
> Here are the requested dumps (boot with initcall_debug, no workaround):

(Usually we also use `ignore_loglevel`, but I think dmesg should have it anyway.)

> dmesg: https://gist.github.com/kylan11/63ec3ec319cd6bcaa043fa0b1366965a
> 
> acpidump: https://gist.githubusercontent.com/kylan11/7956bbf75714265107f0886f6ed2a381/raw/1614845eb1dc6ab7e2effb6fe56b585a746abe4f/gistfile1.txt

> Some quick notes:
> - The AMD GPIO controller probes successfully (LINE 2077)
> 
> - The hang occurs in the deferred IRQ handler (line 2960)
> 
> - There are some ACPI errors around 0.285373 to 0.289806, though they complete quickly

This looks like related to USB4 (thubderbolt) dock? Mika, does it look familiar?

> - After the 36-second hang, everything else initializes normally.
> touchpad, audio, wifi, nvidia GPU all work fine.
> 
> The ACPI tables show there's a _AEI method under \_SB_GPIO. Not sure if those
> unresolved GPP2/GPP7 references are related to what's blocking the deferred
> IRQ handler, or if it's something else entirely.
> 
> Let me know if you need anything else or want me to test something specific.
> 
> On Wednesday, December 17th, 2025 at 2:08 PM, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> > On Wed, Dec 17, 2025 at 12:01:52PM +0000, francesco.lauritano1@protonmail.com wrote:
> > 
> > > On the ASUS ROG Strix G16 G614PP (2025), the kernel can stall for ~36
> > > seconds during late init in acpi_gpio_handle_deferred_request_irqs().
> > > 
> > > Booting with gpiolib_acpi.run_edge_events_on_boot=0 avoids the stall and
> > > restores normal boot times.
> > 
> > Okay but it might just accidentally "work" and hides the real issue. Doing
> > things like this blindly might end up breaking something that relies on
> > that _AEI.
> > 
> > Can you post full dmesg and acpipdump somewhere so we can try to figure out
> > what is going on?

> > > Link: https://lore.kernel.org/platform-driver-x86/6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com/

Not sure what this means. Maybe better tag like Closes should be used?

> > > Tested-by: Francesco Lauritano francesco.lauritano1@protonmail.com

This is implied that the author of the patch tested it before sending.

> > > Signed-off-by: Francesco Lauritano francesco.lauritano1@protonmail.com

-- 
With Best Regards,
Andy Shevchenko



