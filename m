Return-Path: <linux-acpi+bounces-19664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CC4CCB708
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 11:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D059F3016933
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCAA333439;
	Thu, 18 Dec 2025 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SG51jI6L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC30231845;
	Thu, 18 Dec 2025 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054318; cv=none; b=m8B+ilUU3FSrTl/vYtSYOxKMz5bHcFHLHekCursEhiaRl6SnNiqc9FF0dNfmEd+wglO+a64+nN/gWM2NQZtbEUr6wHa/09Uh3OMfa64p891JlZAWsdl1NR1Ev/AbWtI2c/Q/Jdyhh7K4NA5jmQJ4XPI0c4dcqW6s8KT6m8/nHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054318; c=relaxed/simple;
	bh=vwm6N2bnPoCTLf/4/1IVflErHqE9gQ9WzAyaoiVQXGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSL0zIbbotE1Vasa0JmSLe/GpP2XRgrUvSVFIJhvd3yUuxjthU85TPHkEtK5D3hd3adl3nJ/sOjTMFbnXrRwxCuevCAn8oMgG8uKRWqM9VJnU6VFeWJes5YejLbk02fXZ3vlNoWIM4ORKt921pgno6SC1mIQpo+6RrUmJV8TtB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SG51jI6L; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766054316; x=1797590316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vwm6N2bnPoCTLf/4/1IVflErHqE9gQ9WzAyaoiVQXGo=;
  b=SG51jI6LONVR92A0C0uPzS5jcGhArupPMuUL4IAMNE9f8HEe+yjLObJA
   ZhCktIl8FaNTG+IHCuPyiCP7bdRUcvUnX6bO0N1ujFj8QlRMP5RDLS25S
   ZfKFp7kDIWuxYu3c5xXqdcuAHcP9Bgnn3Aq+FmwThvDPS47K15FbRSjfN
   8d3lppJ/+AXGuv8xj9BCsKpN+ylVJv8bgDjo8mQKnk5tN14A99Tsv79f+
   joAyWEbeXLvpq5xJQlgf8lV70BC9ujZz/HgPZtVD8z037/qNhJQdjh3HF
   J+Il5HDbfvntGGJltMqxXn6bkkin/n6Omf6fb7IjcJc7zI7vrHlPNq9Jo
   w==;
X-CSE-ConnectionGUID: QI/dixY4QiWHr5fbuG7Fqg==
X-CSE-MsgGUID: PZ6+ZDLPS4m2lFXijyTxXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67200067"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="67200067"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 02:38:34 -0800
X-CSE-ConnectionGUID: whSMGVHoQiKbMHHNV5gp4A==
X-CSE-MsgGUID: gO9goX9ESPi1DZLCT7n8eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; 
   d="scan'208";a="229614852"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 18 Dec 2025 02:38:32 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 9B67B8E; Thu, 18 Dec 2025 11:38:31 +0100 (CET)
Date: Thu, 18 Dec 2025 11:38:31 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Francesco Lauritano <francesco.lauritano1@protonmail.com>,
	Mario Limonciello <superm1@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"westeri@kernel.org" <westeri@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [BUG] 36-second boot delay due to by
 acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
Message-ID: <20251218103831.GW2275908@black.igk.intel.com>
References: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com>
 <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com>
 <4402ed86-77f5-4a47-a9e1-8d57a709bb15@kernel.org>
 <woxnPhTYiKi2aLzBK8GnO8DpvdgYjQc-P42uhJOzyrcYC3Gdstht27hML8yNHgOklhm2MgGA7wt9gGZ17BHoWlG0vqJuVVJDgCSev8udfds=@protonmail.com>
 <NIIS8XD_nSRvp36X39GxcDRAWsaScQIFx6o9JsFCbyBZk5PqznRdxg9EDDb_9tzWd5TcjzxrRtFx5_uLCVa5wJAYykW2k0Ue_XPMPtWCQiY=@protonmail.com>
 <e8ed4d4e-37e1-4577-bf80-62fcefbef7dc@kernel.org>
 <ReQS8sQSGy3UTuG6tyPvoOb8_037sC6A2yXsSFNuXY1PlTFtCcDHnjf8vufEsk8avBSIL46U0qE-ZjTJD1xsbVYZ6_d2-wlTOZ2NJ2coTsc=@protonmail.com>
 <20251218063954.GT2275908@black.igk.intel.com>
 <b57b44c3-ea96-4189-8b70-71bf4a80d29b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b57b44c3-ea96-4189-8b70-71bf4a80d29b@kernel.org>

On Thu, Dec 18, 2025 at 11:33:14AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 18-Dec-25 07:39, Mika Westerberg wrote:
> > On Wed, Dec 17, 2025 at 07:19:56PM +0000, Francesco Lauritano wrote:
> >> On Wednesday, December 17th, 2025 at 7:01 PM, Mario Limonciello <superm1@kernel.org> wrote:
> >>
> >>> On 12/17/25 10:57 AM, Francesco Lauritano wrote:
> >>>
> >>>> On Wednesday, December 17th, 2025 at 4:12 PM, Francesco Lauritano francesco.lauritano1@protonmail.com wrote:
> >>>>
> >>>>> The _AEI defines 5 GPIO interrupts. Narrowed it down to two:
> >>>>>
> >>>>> gpiolib_acpi.ignore_interrupt=AMDI0030:00@21,AMDI0030:00@24
> >>>>>
> >>>>> This fixes the delay. Pins 0x15 and 0x18 both call: \_SB.PCI0.SBRG.HNC0()
> >>>>
> >>>> Traced it further. HNC0(pin, 0) takes the Else branch and calls:
> >>>> ATKM(0xC0)
> >>>> ADTM(Zero)
> >>>>
> >>>> ADTM calls NOD2(), which is the actual culprit:
> >>>>
> >>>> While ((Arg0 != RDNT))
> >>>> {
> >>>> If ((Local0 >= 0x0F)) { Break }
> >>>> Notify (^^GPP0.PEGP, Arg0)
> >>>> Local0++
> >>>> Sleep (Local0 * 0x64)
> >>>> }
> >>>>
> >>>> It notifies the dGPU and polls RDNT, sleeping 100, 200, ... 1500ms per iteration.
> >>>> Max 15 loops = ~12s per pin. GPU doesn't respond at boot so it maxes out.
> >>>>
> >>>> Two pins, ~12s each, ~24-36s total.
> >>>>
> >>>> Francesco
> >>>
> >>>
> >>> Any idea why isn't the dGPU responding? I would have expected
> >>> https://git.kernel.org/torvalds/c/4d4c10f763d78 sets up policy that it's
> >>> in D0.
> >>>
> >>> Is the dGPU turned off in BIOS or through some reverse engineered
> >>> tool/API or something?
> >>
> >> dmesg without the workaround:
> >> [    1.005184] pci 0000:01:00.0: PME# supported from D0 D3hot
> >> [    1.288811] pci 0000:01:00.0: vgaarb: VGA device added
> >> [   38.250139] nvidia: loading out-of-tree module taints kernel.
> >> [   38.369358] nvidia 0000:01:00.0: enabling device (0000 -> 0003)
> >> [   39.744421] NVRM: GPS ACPI DSM called before _acpiDsmSupportedFuncCacheInit
> >>
> >> GPU is in D0 from 1.0s. nvidia loads at 38.2s after the GPIO hang completes.
> >>
> >> No weird tools/APIs besides userspace utils (asusctl/supergfxctl). 
> >>
> >> No changes to BIOS factory defaults other than disabling Fast Boot.
> >> dGPU is active, Display Mode is Dynamic (hybrid).
> >>
> >> Traced RDNT - it's set by GPS function 19 in the ACPI tables:
> >> Case (0x13)
> >> {
> >>     Debug = "GPS fun 19"
> >>     \_SB.PCI0.SBRG.RDNT = (Local1 + 0xD1)
> >> }
> >>
> >> As far as I can understand GPIO initcall blocks at late_initcall_sync, preventing nvidia 
> >> from loading in time to respond. Based on the timing, GPU is awake but nothing can 
> >> register a handler while kernel is stuck at NOD2 polling loop.
> > 
> > I wonder if you could try with the nouveau driver so that it's built-in to
> > the kernel proper? Then it should be ready at the time these events
> > trigger.
> 
> That is not really a workable solution though.

Yeah, I did not meant it to be the "solution" rather just to check whether
it is related if the GPU driver is there or not. You cannot build the
proprietary driver into the kernel so that's why I suggested the
open-source one.

