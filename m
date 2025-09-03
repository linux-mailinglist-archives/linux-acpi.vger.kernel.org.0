Return-Path: <linux-acpi+bounces-16341-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162CBB42744
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 18:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7CF1BC292A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACE930EF77;
	Wed,  3 Sep 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQvCv3X2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7C2D47E5;
	Wed,  3 Sep 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918221; cv=none; b=kgcNyT0Sf8Qmet/dwTPczytMIYfCkZMUrIvmC7AvCeST53UVBwDl1eZ7QkjtPNH9LbCsAYCkJsi6gPeylSArDjNp7GgjHhhtzDEncrPETgrzF1npBfLaKeUgJpuNosqV/RWkXgfwfwmSx1uqQ1t/ELzxxR8Us9uqR1vc/zOFvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918221; c=relaxed/simple;
	bh=aAtQlMxFAc+ZiCQba2qoL0uFdUg9FUWu2RhL3FdJzaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EbaxsB8wbkHDFRXPjQXiEdWW1WoKzKrtWYMKGAiWML01PAFqEaqazzroXI9xamatQjNLmKIXd55g8lvZiNhggTrTe4jbdyHTNI0lcH3GZPiBIOlVJE1sk85G8xX05cX0dBJiAU32tAYhmy+x3q1PPp+HYpRaQYKQ8jMm7DaOJK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQvCv3X2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120BFC4CEE7;
	Wed,  3 Sep 2025 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756918221;
	bh=aAtQlMxFAc+ZiCQba2qoL0uFdUg9FUWu2RhL3FdJzaI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rQvCv3X2l/5gFRRZOXpBdF50tysL4K77p6N/XiSptxOzZX9RzJQKa6J4quNtiHsT9
	 U0iHw8PXQYDCYZ6/TzXXfsLA59RDan+iZB2Qcv2CvN9ZpwIWPjN/7E+VdRfgnK7X4E
	 b8eURtBxBJ7JgVSuB6xI7QApJ9OIVnSUdd82begAJHTpyiK7SVhgzhwooYDOIyMVYG
	 dCrqzPb/d0xxedN1SHXqebBL2I+Q/sYkAI+oslQ32krOaVETMx7HQGGgMSpFFEBUvU
	 rqMoKk5p8YP3nsnXDsWuuNTkG2wY6t9RCkkm2dAvLFxcJF3760riecs7Ju1eBHnrrD
	 I2iZoNCmdaRaA==
Message-ID: <06f0c531-2cb6-4a1a-a716-406b4f5f9676@kernel.org>
Date: Wed, 3 Sep 2025 11:50:20 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] MECHREVO Yilong15Pro GM5HG7A: lid switch causing unwanted
 s2idle wakeups
To: aprilgrimoire <aprilgrimoire@proton.me>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=@proton.me>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/25 11:23 AM, aprilgrimoire wrote:
> Hi!
> Opening or closing the lid causes my laptop Yilong15Pro GM5HG7A to wake up from s2idle, similar to the symptom described in
> 
> https://community.frame.work/t/tracking-waking-from-sleep-when-plugged-in-amd-k-ubuntu-22-04/44168
> 
> This issue for Framework 13 has been fixed in
> 
> https://lore.kernel.org/platform-driver-x86/20231212045006.97581-5-mario.limonciello@amd.com/
> 
> For me specifically, two interrupts appear on such unwanted wakeups: IRQ1 and IRQ7. IRQ1 is the lid switch, with DRIVER==button. IRQ7 has SUBSYSTEM==serio and DRIVER==amd_gpio. I tried some workarounds and got to disable IRQ1, but IRQ7 doesn't support disabling and the issue persists.
> 
> I did some modifications to the kernel code:
> 
> ----- drivers/platform/x86/amd/pmc/pmc.c
> 
> static int amd_pmc_wa_irq1(struct amd_pmc_dev *pdev)
> {
>          ...
>          if (device_may_wakeup(d)) {
>                  dev_info_once(d, "Disabling IRQ1 wakeup source to avoid platform firmware bug\n");
>                  disable_irq_wake(1);
>                  dev_warn(d, "Also disabling IRQ7!!! This is bad practice!!! Remove after testing IMMEDIATELY!!!");
>                  disable_irq_wake(7);
>                  device_set_wakeup_enable(d, false);
>          }
>          ...
> }
> 
> ----- drivers/platform/x86/amd/pmc/pmc-quirks.c
>          ...
>          {
>                  .ident = "MECHREVO Yilong15Pro Series GM5HG7A",
>                  .driver_data = &quirk_spurious_8042,
>                  .matches = {
>                          DMI_MATCH(DMI_SYS_VENDOR, "MECHREVO"),
>                          DMI_MATCH(DMI_PRODUCT_NAME, "Yilong15Pro Series GM5HG7A"),
>                          /* Not matching BIOS version: MECHREVO doesn't support Linux officially, so no expectation of them fixing the bios. */
>                  }
>          },
>          ...
> 
> But IRC7 cannot be disabled:
> 
> (base) ➜  ~ echo disabled | sudo tee /sys/kernel/irq/7/wakeup
> Password:
> tee: /sys/kernel/irq/7/wakeup: Permission denied
> 
> In dsdt.dsl, I also nuked some code about the lid state and changed all SharedAndWake to Shared, however it didn't work either.
> 
> Mechrevo officially only supports Windows, and this lid issue doesn't appear on Windows. Does this indicate this issue can be workaround in the driver level? What can be done next?
> 
> Thanks!

Hi,

Can you please reproduce the issue using 'amd-s2idle' from 
https://pypi.org/project/amd-debug-tools/ ?

Basically install the wheel, run 'amd-s2idle test'.  When prompted how 
long, set it for ~20 seconds.  Then wait for the LED to flash and close 
the lid and it should wake up and generate a report.

This will capture a lot of artifacts about the problem in the report and 
we can go from there on next steps.  Ideally if you can put the report 
on a new issue here and tag me (@superm1): 
https://gitlab.freedesktop.org/drm/amd/-/issues
We can iterate back and forth on it to come up with the best solution.

Thanks,

