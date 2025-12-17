Return-Path: <linux-acpi+bounces-19635-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C80CCC863E
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 16:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14F37303270C
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 15:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204A92459D4;
	Wed, 17 Dec 2025 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Y7b659Kh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714AA3A1E6F;
	Wed, 17 Dec 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984360; cv=none; b=rNW1JsCW7Np8k1A1Mv5z+FGwD/PwEP8wUIRhUta6EYI1Brc/OgD5+v/l9aUdOeJC+W6PE4xORdaHZXo/0GXWkXCmfF1tU+lCnh0AcGaMb++d0FPTu+HGp8i47cVUrX43Q5ACtT+lSZUn7utLbxAE7cY2WBEtmcbx8vw+i+1AAx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984360; c=relaxed/simple;
	bh=kAkTPuxAPRaLZC3z8AnNk53JT3zWUlJ5FKb8MymCJSQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/AsX8t2HftLJtm7i/Ls4PULGFIW3L8p3G3E3/pUlXIskyzT/TWt58ZNPknQFJGEwOeWpmBuVBdEu/+j6snL7oHk7FgmJDLNA56kcTepKVhGmYwq95xvMrj6vvkb1eNndsClfSrh89YJlQaE+6HRswy6pb8G8UwfVEyhZeYMWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Y7b659Kh; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1765984349; x=1766243549;
	bh=kAkTPuxAPRaLZC3z8AnNk53JT3zWUlJ5FKb8MymCJSQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Y7b659KhdBnBosslUoZETCoe44mrE9LfbDxRXeJvaYewQ/5aApGPSFgc2nAPuEDYP
	 fNsmMsuVVdTP8uEuZGFQ5fOiw3Ryt7ftVuF+AI6X4MEsKFYG2ARTwuC0S9ythxQG2y
	 XOMYcTPszdhIH4ziyGnzEF6Of9uHXIG5ou/PFKOATbHU5ne8XwFHvFpNSGTy1Cxwqc
	 AXFOadR3BtJM+8uO2b39pF7NzGl1vdnbv/GaOBaphoVcphe65/f4SisfddUcLC8peA
	 tQsrLDQsCdwqw2jRYaHg/oD8z3NoGPar2TCeMzFGL3UttbyAaOD1JdUBO7lrtqvQe+
	 Do/gLr937+jjg==
Date: Wed, 17 Dec 2025 15:12:25 +0000
To: Mario Limonciello <superm1@kernel.org>
From: Francesco Lauritano <francesco.lauritano1@protonmail.com>
Cc: Hans de Goede <hansg@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, "westeri@kernel.org" <westeri@kernel.org>
Subject: Re: [BUG] 36-second boot delay due to by acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
Message-ID: <woxnPhTYiKi2aLzBK8GnO8DpvdgYjQc-P42uhJOzyrcYC3Gdstht27hML8yNHgOklhm2MgGA7wt9gGZ17BHoWlG0vqJuVVJDgCSev8udfds=@protonmail.com>
In-Reply-To: <4402ed86-77f5-4a47-a9e1-8d57a709bb15@kernel.org>
References: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com> <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com> <4402ed86-77f5-4a47-a9e1-8d57a709bb15@kernel.org>
Feedback-ID: 66654272:user:proton
X-Pm-Message-ID: f8c4b38d580819dae605cd7bb0f4493480d0bc74
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Mario,

+Mika (sent him the dumps earlier)

dmesg: https://gist.github.com/kylan11/63ec3ec319cd6bcaa043fa0b1366965a

acpidump: https://gist.githubusercontent.com/kylan11/7956bbf75714265107f088=
6f6ed2a381/raw/1614845eb1dc6ab7e2effb6fe56b585a746abe4f/gistfile1.txt

Agreed, got way too excited, still learning. Did some more digging.

The _AEI defines 5 GPIO interrupts. Narrowed it down to two:

gpiolib_acpi.ignore_interrupt=3DAMDI0030:00@21,AMDI0030:00@24

This fixes the delay. Pins 0x15 and 0x18 both call: \_SB.PCI0.SBRG.HNC0()=
=20
that method stalls around 18s per pin. Ignoring just one cuts the delay in =
half (32s vs 56s boot), so both are hitting the same broken path.

Also found another similar report on a G614PR (same chassis, different GPU)=
: https://rog-forum.asus.com/t5/rog-strix-series/rog-strix-g614pr-long-boot=
-time-on-linux/m-p/1112775

Happy to test patches.

(Re: LLM - used it to format the report, debugging was done the old fashion=
ed way :) )

Francesco



On Wednesday, December 17th, 2025 at 3:23 PM, Mario Limonciello <superm1@ke=
rnel.org> wrote:

> ++linux-gpio, Hans
>
> On 12/17/25 4:06 AM, Francesco Lauritano wrote:
>
> > ASUS ROG Strix G16 G614PP (2025) experiences a 36-second kernel boot de=
lay caused by `acpi_gpio_handle_deferred_request_irqs()` hanging during lat=
e_initcall_sync. The workaround is `gpiolib_acpi.run_edge_events_on_boot=3D=
0`.
> >
> > System Information
> > ------------------
> >
> > - Hardware: ASUS ROG Strix G16 G614PP_G614PP
> > - DMI Product: ROG Strix G16 G614PP_G614PP
> > - DMI Vendor: ASUSTeK COMPUTER INC.
> > - BIOS Version: G614PP.307 (08/14/2025)
> > - CPU: AMD Ryzen (Strix Point)
> > - GPU: NVIDIA (with nvidia-open 580.105.08)
> > - Distribution: EndeavourOS
> > - Kernel: 6.17.9 (also reproduced on zem)
> > - Bootloader: systemd-boot with dracut
> >
> > Problem Description
> > -------------------
> >
> > The system takes approximately 56 seconds to boot, with 37.8 seconds sp=
ent in the kernel phase. Using `initcall_debug`, the culprit was identified=
 as:
> >
> > [ 1.739645] calling acpi_gpio_handle_deferred_request_irqs+0x0/0x40 @ 1
> > [ 38.077788] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0x40 r=
eturned 0 after 36338138 usecs
> >
> > The kernel goes completely silent between ~2 seconds and ~38 seconds (n=
o dmesg output during this period):
> >
> > [ 2.607764] clocksource: Switched to clocksource tsc
> > [ 37.828217] clk: Disabling unused clocks
> >
> > Windows boots normally on the same hardware, indicating this is a Linux=
-specific ACPI handling issue.
> >
> > systemd-analyze output
> > ----------------------
> >
> > Startup finished in 8.593s (firmware) + 1.273s (loader) + 37.877s (kern=
el) + 4.645s (initrd) + 3.831s (userspace) =3D 56.221s
> >
> > ACPI Errors During Boot
> > -----------------------
> >
> > The following ACPI errors appear in dmesg (though these complete quickl=
y and are not the direct cause of the delay):
> >
> > ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GPP2], AE_NO=
T_FOUND (20250404/dswload2-162)
> > ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20250404/psobject=
-220)
> > ACPI: Skipping parse of AML opcode: Scope (0x0010)
> > ACPI Error: AE_NOT_FOUND, While resolving a named reference package ele=
ment - \SB.PCI0.GPP7.UP00.DP00.U4UP.U4P3.UHI0 (20250404/dspkginit-438)
> > ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> >
> > GPIO-related dmesg output
> > -------------------------
> >
> > [ 0.257981] calling pinctrl_init+0x0/0xc0 @ 1
> > [ 0.257982] pinctrl core: initialized pinctrl subsystem
> > [ 0.257994] initcall pinctrl_init+0x0/0xc0 returned 0 after 0 usecs
> > [ 1.612848] calling amd_gpio_driver_init+0x0/0x20 @ 1
> > [ 1.613779] initcall amd_gpio_driver_init+0x0/0x20 returned 0 after 930=
 usecs
> > [ 1.739645] calling acpi_gpio_handle_deferred_request_irqs+0x0/0x40 @ 1
> > [ 38.077788] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0x40 r=
eturned 0 after 36338138 usecs
> >
> > Workaround
> > ----------
> >
> > Adding the following kernel parameter resolves the issue and reduces bo=
ot time to ~10 seconds:
> >
> > gpiolib_acpi.run_edge_events_on_boot=3D0
> >
> > Impact of Workaround
> > --------------------
> >
> > Testing with the workaround applied, no obvious regressions have been o=
bserved:
> >
> > - Lid switch works
> > - Power button works
> > - Keyboard function keys work
> > - Sleep/wake works
> >
> > Long-term, a DMI quirk entry for this device would be preferable.
> >
> > Suggested Fix
> > -------------
> >
> > Add a DMI quirk entry to `drivers/gpio/gpiolib-acpi.c` for the ASUS ROG=
 Strix G16 G614PP, though it may be needed on other ROG/Strix/Zephyrus mode=
ls from 2021-2025.
> >
> > Steps to Reproduce
> > ------------------
> >
> > 1. Install Linux on ASUS ROG Strix G16 G614PP (2025)
> > 2. Boot without `gpiolib_acpi.run_edge_events_on_boot=3D0`
> > 3. Observe ~40 second boot time with `systemd-analyze time`
> > 4. Add `initcall_debug` to kernel parameters and observe the 36-second =
hang in `acpi_gpio_handle_deferred_request_ir`
>
>
> The behavior to run these interrupts at boot was introduced by:
>
> https://git.kernel.org/torvalds/c/ca876c7483b6
>
> Have you already analyzed the ACPI tables to understand where the large
> delay is coming from? I think before jumping into the quirk like the
> LLM you used suggests we should understand which deferred interrupt
> handler is causing the issue to make sure we're not masking another issue=
.
>
> Could you please attach the acpidump to a kernel Bugzilla to look over?

