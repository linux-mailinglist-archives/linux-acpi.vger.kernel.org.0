Return-Path: <linux-acpi+bounces-18382-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1484C213AF
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 17:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7014A189A060
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 16:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83702DF3EA;
	Thu, 30 Oct 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmBVhbsr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D57C133;
	Thu, 30 Oct 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842118; cv=none; b=Gqm6OqwR5q8xTd9eWHqxAkOYBiqQk2xNT4qermO7RaJMXQHg3RwLpL1FtaGmtGMaKrFuxFYjuWbhviXmj51JrsU9FIfuDVHkcKNuyo/n6qfpilekGsTOBn24N9jNvS4uOFdIjLxjGLZ6E9G7T6hx6FBSt58zLGkMlr/NjdORh9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842118; c=relaxed/simple;
	bh=hN0a1nBdKiMFiaSD/0G7lwpKVl2foow4E6pO4Pcw4F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8arAwF79b1uFMJMr/2OucwkM2PI0rVUjQD+OowoUox5u2w4/KlbcZd74DtpF0lp+QZpUY1XJYD4oatLNGSqNq9ieDEwGD2SJLf0LsLDFnSzGVkjMznESpInaOf8k0bsrN7RjoR41BDNBnSQsz7rsX7K3ZfHIpXS9ZMY8eoaEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmBVhbsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38906C4CEF1;
	Thu, 30 Oct 2025 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761842118;
	bh=hN0a1nBdKiMFiaSD/0G7lwpKVl2foow4E6pO4Pcw4F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UmBVhbsrQtd2KdUoHIzwQgLRpap1mnzaevw6pXbKZmMsNw4YgKVexPHNc+DCZY7rz
	 ELtQbSCDRehuO8RYNFosVNUPCBYaIU7Kfd9n4dxOTyTSs8BHnBv5my6P065L8BsEt4
	 DP+yxEOUtptvkZ5QS15jYpGGlNjqohyoPfI5I244Ur7FUZRrXWL332j/G568pykAXF
	 UKqH00JIBeGIN2C2A4CJSccwnDSoh9TCGnUvIiYeJbipWvnATN7/NkFzSosiKKPsmn
	 iF1Hsc6UmyIjWRbE6V0KclKFYW7SD35wb1hzt9rZ7wSKxzRmsCh9W9aWQqgfQl9iHM
	 vYREVSeY9+4CQ==
Date: Thu, 30 Oct 2025 17:35:11 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 3/4] clocksource/drivers/arm_arch_timer_mmio: Switch
 over to standalone driver
Message-ID: <aQOTv3VnOCTjSj46@lpieralisi>
References: <20250814154622.10193-1-maz@kernel.org>
 <20250814154622.10193-4-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814154622.10193-4-maz@kernel.org>

On Thu, Aug 14, 2025 at 04:46:21PM +0100, Marc Zyngier wrote:

[...]

> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c

[...]

>  #ifdef CONFIG_ACPI_GTDT
> -static int __init
> -arch_timer_mem_verify_cntfrq(struct arch_timer_mem *timer_mem)
> -{
> -	struct arch_timer_mem_frame *frame;
> -	u32 rate;
> -	int i;
> -
> -	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
> -		frame = &timer_mem->frame[i];
> -
> -		if (!frame->valid)
> -			continue;
> -
> -		rate = arch_timer_mem_frame_get_cntfrq(frame);
> -		if (rate == arch_timer_rate)
> -			continue;
> -
> -		pr_err(FW_BUG "CNTFRQ mismatch: frame @ %pa: (0x%08lx), CPU: (0x%08lx)\n",
> -			&frame->cntbase,
> -			(unsigned long)rate, (unsigned long)arch_timer_rate);
> -
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int __init arch_timer_mem_acpi_init(int platform_timer_count)
> -{
> -	struct arch_timer_mem *timers, *timer;
> -	struct arch_timer_mem_frame *frame, *best_frame = NULL;
> -	int timer_count, i, ret = 0;
> -
> -	timers = kcalloc(platform_timer_count, sizeof(*timers),
> -			    GFP_KERNEL);
> -	if (!timers)
> -		return -ENOMEM;
> -
> -	ret = acpi_arch_timer_mem_init(timers, &timer_count);

You probably already noticed (I was checking the initcall level in
drivers/acpi/arm64/gtdt.c to start sorting out GICv5 IWB dependencies),
AFAICS acpi_arch_timer_mem_init() is now unused so it can be removed.

Thanks,
Lorenzo

