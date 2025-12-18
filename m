Return-Path: <linux-acpi+bounces-19646-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F8CCA7FD
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 07:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E26C4302D59C
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 06:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4FD329C4D;
	Thu, 18 Dec 2025 06:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmt6SgFT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3332A3C8;
	Thu, 18 Dec 2025 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040000; cv=none; b=Ud8zM7wFzv4cXsNa6yCt3rP2OTlDpWnabuNxVqOHdRyPt49tNMF2hbpX7tfwi5Q+/nZVU1FlXxpUA+Ga8jPK1glifgp04MIxPadLp7UxOGjocmEk+iAMhKN2Y/6U89pHOtjoZcqO0i8rmfqz0gYlpxq8xJlrANUhE1QO/tYoIRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040000; c=relaxed/simple;
	bh=uoPF7WSfeTcDhwLGWPpS+bzYgMaUKE7QOPRMvdBh5fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMJW19rmnBmP4h0RpWXFrDIH7YGr5kFmUx4ruYH2lHlQ0aSZ2+k9ZA0zdAn3bSksvGFIprHT53PWNfpFxDIUTcZ6FoClGzqMBJk6qrbbAtPZD7uTCYQ7Xdrrt7JNOf/WBSRDznEu9Fr3IpmoNSVPS9ek51j9mPJBWdRz63qmEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmt6SgFT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766039999; x=1797575999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uoPF7WSfeTcDhwLGWPpS+bzYgMaUKE7QOPRMvdBh5fk=;
  b=cmt6SgFTBSpj4tQm7jx8mKwVAz3n1FZVljEGOsfWgH5e8Dd5YR5bpAbL
   MH0RgdFxtGkOneZ99gXCJGWg0ff//dwv/3k6hgw5GFu2jFg+HQZRVtVVN
   Ft4Cr9/qNTi1nGkJ5bIzlpUUehcEDK5bXZFZP5WBH2d5T62wtiT1PUj1P
   eCRIQ8iAMFijAYQ8Zzoliz9KJDRIhS0vdmrqZ//0cP9hABqlncPaZAxrT
   RpI6knRqeQ+Qmc7imZ3Plk5vIOs/QV7jo3V3hHHHle+6WPhvLafgmQUHf
   /dHGVJxqAUWqvHZ+S6yY/Y+0Jb/jB7ImnVIsLefJT2lkRJsbq6RyHiEiZ
   w==;
X-CSE-ConnectionGUID: 1lAosaWKQE2I9gCwacNiJw==
X-CSE-MsgGUID: lPEAKc4CSy2g6V4GzF4mpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67925116"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67925116"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 22:39:58 -0800
X-CSE-ConnectionGUID: 6u2/uD1OTKqAHi3XxhFwMg==
X-CSE-MsgGUID: fcOSVWwKQXOYgq5/esolTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="229565235"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 17 Dec 2025 22:39:55 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id AB1258E; Thu, 18 Dec 2025 07:39:54 +0100 (CET)
Date: Thu, 18 Dec 2025 07:39:54 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Francesco Lauritano <francesco.lauritano1@protonmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"westeri@kernel.org" <westeri@kernel.org>
Subject: Re: [BUG] 36-second boot delay due to by
 acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
Message-ID: <20251218063954.GT2275908@black.igk.intel.com>
References: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com>
 <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com>
 <4402ed86-77f5-4a47-a9e1-8d57a709bb15@kernel.org>
 <woxnPhTYiKi2aLzBK8GnO8DpvdgYjQc-P42uhJOzyrcYC3Gdstht27hML8yNHgOklhm2MgGA7wt9gGZ17BHoWlG0vqJuVVJDgCSev8udfds=@protonmail.com>
 <NIIS8XD_nSRvp36X39GxcDRAWsaScQIFx6o9JsFCbyBZk5PqznRdxg9EDDb_9tzWd5TcjzxrRtFx5_uLCVa5wJAYykW2k0Ue_XPMPtWCQiY=@protonmail.com>
 <e8ed4d4e-37e1-4577-bf80-62fcefbef7dc@kernel.org>
 <ReQS8sQSGy3UTuG6tyPvoOb8_037sC6A2yXsSFNuXY1PlTFtCcDHnjf8vufEsk8avBSIL46U0qE-ZjTJD1xsbVYZ6_d2-wlTOZ2NJ2coTsc=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ReQS8sQSGy3UTuG6tyPvoOb8_037sC6A2yXsSFNuXY1PlTFtCcDHnjf8vufEsk8avBSIL46U0qE-ZjTJD1xsbVYZ6_d2-wlTOZ2NJ2coTsc=@protonmail.com>

On Wed, Dec 17, 2025 at 07:19:56PM +0000, Francesco Lauritano wrote:
> On Wednesday, December 17th, 2025 at 7:01 PM, Mario Limonciello <superm1@kernel.org> wrote:
> 
> > On 12/17/25 10:57 AM, Francesco Lauritano wrote:
> > 
> > > On Wednesday, December 17th, 2025 at 4:12 PM, Francesco Lauritano francesco.lauritano1@protonmail.com wrote:
> > > 
> > > > The _AEI defines 5 GPIO interrupts. Narrowed it down to two:
> > > > 
> > > > gpiolib_acpi.ignore_interrupt=AMDI0030:00@21,AMDI0030:00@24
> > > > 
> > > > This fixes the delay. Pins 0x15 and 0x18 both call: \_SB.PCI0.SBRG.HNC0()
> > > 
> > > Traced it further. HNC0(pin, 0) takes the Else branch and calls:
> > > ATKM(0xC0)
> > > ADTM(Zero)
> > > 
> > > ADTM calls NOD2(), which is the actual culprit:
> > > 
> > > While ((Arg0 != RDNT))
> > > {
> > > If ((Local0 >= 0x0F)) { Break }
> > > Notify (^^GPP0.PEGP, Arg0)
> > > Local0++
> > > Sleep (Local0 * 0x64)
> > > }
> > > 
> > > It notifies the dGPU and polls RDNT, sleeping 100, 200, ... 1500ms per iteration.
> > > Max 15 loops = ~12s per pin. GPU doesn't respond at boot so it maxes out.
> > > 
> > > Two pins, ~12s each, ~24-36s total.
> > > 
> > > Francesco
> > 
> > 
> > Any idea why isn't the dGPU responding? I would have expected
> > https://git.kernel.org/torvalds/c/4d4c10f763d78 sets up policy that it's
> > in D0.
> > 
> > Is the dGPU turned off in BIOS or through some reverse engineered
> > tool/API or something?
> 
> dmesg without the workaround:
> [    1.005184] pci 0000:01:00.0: PME# supported from D0 D3hot
> [    1.288811] pci 0000:01:00.0: vgaarb: VGA device added
> [   38.250139] nvidia: loading out-of-tree module taints kernel.
> [   38.369358] nvidia 0000:01:00.0: enabling device (0000 -> 0003)
> [   39.744421] NVRM: GPS ACPI DSM called before _acpiDsmSupportedFuncCacheInit
> 
> GPU is in D0 from 1.0s. nvidia loads at 38.2s after the GPIO hang completes.
> 
> No weird tools/APIs besides userspace utils (asusctl/supergfxctl). 
> 
> No changes to BIOS factory defaults other than disabling Fast Boot.
> dGPU is active, Display Mode is Dynamic (hybrid).
> 
> Traced RDNT - it's set by GPS function 19 in the ACPI tables:
> Case (0x13)
> {
>     Debug = "GPS fun 19"
>     \_SB.PCI0.SBRG.RDNT = (Local1 + 0xD1)
> }
> 
> As far as I can understand GPIO initcall blocks at late_initcall_sync, preventing nvidia 
> from loading in time to respond. Based on the timing, GPU is awake but nothing can 
> register a handler while kernel is stuck at NOD2 polling loop.

I wonder if you could try with the nouveau driver so that it's built-in to
the kernel proper? Then it should be ready at the time these events
trigger.

