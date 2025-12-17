Return-Path: <linux-acpi+bounces-19632-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3677CC8345
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 15:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEE89306D33F
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7382333F8DE;
	Wed, 17 Dec 2025 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9gPmFlq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B533B6F8;
	Wed, 17 Dec 2025 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981383; cv=none; b=tBA4Jl6SbQIZEsrNq/mezXm8bfISWy7vd+688wzIs2LrsGesyZNnRrT+xwZx5XA9kYwLSHLAqtBCMPlVWBFMzI1lIVdtkuE9ZdyQlE3YaW0RGP3teN6hCS6/8rL/MFZhjLEue175iIJRaNKQqzGkj9Wtg6Vk4siucyXMsScke3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981383; c=relaxed/simple;
	bh=SEcdHCQ4hyzEe6q3rbznOxDqeVfF4KdBSqC+7BJbnqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGIbownjnZt+HzC6nYzhiTeXIoUneu7QodZvLzdQqdZ/iW0u1NqSUpRBP27um/vSXtBhP6+zaOWUwsiVCUGdAfHaGtKe6+GAmKUuMbJumhe6QwDl5cx8Gzq2Kaijc/99OXnyVpcCY+yeC465oNWWu1UIuVYeegvnZ1sIcl+MX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9gPmFlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C4AC4CEF5;
	Wed, 17 Dec 2025 14:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765981381;
	bh=SEcdHCQ4hyzEe6q3rbznOxDqeVfF4KdBSqC+7BJbnqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R9gPmFlqb+KS5GweeIXUizpWihybg6WdSUGsBXJqze0npuf0c+7xP0z42rpkpkCyR
	 RFCJ71xX+MMVlMnhF2MzBqptmW5WKaBjKNPg+fQXjXjfS0eeRYKcyQmJzzExVJEALm
	 vvTXQZkn74Bcs5SQY7hoW/sqV2DslFF59lkPZIFwqRzRzz2UhxSA+HHLvJrfY9q+Yp
	 gmzvQ1UnzgRfI+wuR6OugjzA3ZjsDIjYLoFm0TqYjhfKXRESY0O1Zx0sUjnZl0rCLU
	 R3htBRoohyF2QDFowUGm0oj91Miw2t+/F67d17k34kjXB67AT6eEeLOAvvKoIzA02n
	 bcZgyQxeB/0+A==
Message-ID: <4402ed86-77f5-4a47-a9e1-8d57a709bb15@kernel.org>
Date: Wed, 17 Dec 2025 08:23:00 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 36-second boot delay due to by
 acpi_gpio_handle_deferred_request_irqs on ASUS ROG Strix G16 (2025)
To: Francesco Lauritano <francesco.lauritano1@protonmail.com>,
 Hans de Goede <hansg@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
References: <2kSCn4XaoXsXJ3EUR0syTdmip8Z1cBuUr0Br4sFVnwnsA8q4GlhiHOmsJkeBxvxYoLnetp4r44wIPXw42yTAFl-BtMROnIwR-NkckKgA5EY=@protonmail.com>
 <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <6iFCwGH2vssb7NRUTWGpkubGMNbgIlBHSz40z8ZsezjxngXpoiiRiJaijviNvhiDAGIr43bfUmdxLmxYoHDjyft4DgwFc3Pnu5hzPguTa0s=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

++linux-gpio, Hans

On 12/17/25 4:06 AM, Francesco Lauritano wrote:
> ASUS ROG Strix G16 G614PP (2025) experiences a 36-second kernel boot delay caused by `acpi_gpio_handle_deferred_request_irqs()` hanging during late_initcall_sync. The workaround is `gpiolib_acpi.run_edge_events_on_boot=0`.
> 
> System Information
> ------------------
> 
> -   Hardware: ASUS ROG Strix G16 G614PP_G614PP
> -   DMI Product: ROG Strix G16 G614PP_G614PP
> -   DMI Vendor: ASUSTeK COMPUTER INC.
> -   BIOS Version: G614PP.307 (08/14/2025)
> -   CPU: AMD Ryzen (Strix Point)
> -   GPU: NVIDIA (with nvidia-open 580.105.08)
> -   Distribution: EndeavourOS
> -   Kernel: 6.17.9 (also reproduced on zem)
> -   Bootloader: systemd-boot with dracut
> 
> Problem Description
> -------------------
> 
> The system takes approximately 56 seconds to boot, with 37.8 seconds spent in the kernel phase. Using `initcall_debug`, the culprit was identified as:
> 
>      [    1.739645] calling  acpi_gpio_handle_deferred_request_irqs+0x0/0x40 @ 1
>      [   38.077788] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0x40 returned 0 after 36338138 usecs
> 
> The kernel goes completely silent between ~2 seconds and ~38 seconds (no dmesg output during this period):
> 
>      [    2.607764] clocksource: Switched to clocksource tsc
>      [   37.828217] clk: Disabling unused clocks
> 
> Windows boots normally on the same hardware, indicating this is a Linux-specific ACPI handling issue.
> 
> systemd-analyze output
> ----------------------
> 
>      Startup finished in 8.593s (firmware) + 1.273s (loader) + 37.877s (kernel) + 4.645s (initrd) + 3.831s (userspace) = 56.221s
> 
> ACPI Errors During Boot
> -----------------------
> 
> The following ACPI errors appear in dmesg (though these complete quickly and are not the direct cause of the delay):
> 
>      ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GPP2], AE_NOT_FOUND (20250404/dswload2-162)
>      ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20250404/psobject-220)
>      ACPI: Skipping parse of AML opcode: Scope (0x0010)
>      ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - \_SB_.PCI0.GPP7.UP00.DP00.U4UP.U4P3.UHI0 (20250404/dspkginit-438)
>      ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> 
> GPIO-related dmesg output
> -------------------------
> 
>      [    0.257981] calling  pinctrl_init+0x0/0xc0 @ 1
>      [    0.257982] pinctrl core: initialized pinctrl subsystem
>      [    0.257994] initcall pinctrl_init+0x0/0xc0 returned 0 after 0 usecs
>      [    1.612848] calling  amd_gpio_driver_init+0x0/0x20 @ 1
>      [    1.613779] initcall amd_gpio_driver_init+0x0/0x20 returned 0 after 930 usecs
>      [    1.739645] calling  acpi_gpio_handle_deferred_request_irqs+0x0/0x40 @ 1
>      [   38.077788] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0x40 returned 0 after 36338138 usecs
> 
> Workaround
> ----------
> 
> Adding the following kernel parameter resolves the issue and reduces boot time to ~10 seconds:
> 
>      gpiolib_acpi.run_edge_events_on_boot=0
> 
> Impact of Workaround
> --------------------
> 
> Testing with the workaround applied, no obvious regressions have been observed:
> 
> -   Lid switch works
> -   Power button works
> -   Keyboard function keys work
> -   Sleep/wake works
> 
> Long-term, a DMI quirk entry for this device would be preferable.
> 
> Suggested Fix
> -------------
> 
> Add a DMI quirk entry to `drivers/gpio/gpiolib-acpi.c` for the ASUS ROG Strix G16 G614PP, though it may be needed on other ROG/Strix/Zephyrus models from 2021-2025.
> 
> Steps to Reproduce
> ------------------
> 
> 1.  Install Linux on ASUS ROG Strix G16 G614PP (2025)
> 2.  Boot without `gpiolib_acpi.run_edge_events_on_boot=0`
> 3.  Observe ~40 second boot time with `systemd-analyze time`
> 4.  Add `initcall_debug` to kernel parameters and observe the 36-second hang in `acpi_gpio_handle_deferred_request_ir`
> 
> 
> 

The behavior to run these interrupts at boot was introduced by:

https://git.kernel.org/torvalds/c/ca876c7483b6

Have you already analyzed the ACPI tables to understand where the large 
delay is coming from?  I think before jumping into the quirk like the 
LLM you used suggests we should understand which deferred interrupt 
handler is causing the issue to make sure we're not masking another issue.

Could you please attach the acpidump to a kernel Bugzilla to look over?

