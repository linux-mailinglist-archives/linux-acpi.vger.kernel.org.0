Return-Path: <linux-acpi+bounces-19265-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC14C869D0
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 19:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AED43B37D3
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FEC32D443;
	Tue, 25 Nov 2025 18:29:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5932D439;
	Tue, 25 Nov 2025 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764095362; cv=none; b=ukNgaB3uQUbCt5q8p5RCWRTLAP0UzhHx7vJZBfBLr0ZDhqB7yO3wMRTnGT3TAgEHHMzOgUXDG7r3wIdlQNtUNZj81I7TSdCsGVRYXTCk7BW2VJJ8Zw78Sb/XLrh5NoOeuhdx0P/iQlwt8exn+P+el3SrcdKw9RCINkLzc2pdd5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764095362; c=relaxed/simple;
	bh=mTx8ezIQ3PvpoeYNj/iVQvYyJSYXvVmaaTe8wznBkYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUn1/4An3oFlJjPjuZx+XBlPYj+V3SEBYD5lVkR1KR4SpCSuGDdmjCEDD8PGXimy4B7KjrtXkCgXXVj5fPOn49OCDdbA+PMHLdNOsyj7dPHErCH6UYBfIB52mPT1oNmQlo3pgWYIUvX+JLGAI1XfNbWjP9kv9bMoHvR0ZyryrzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D07941570;
	Tue, 25 Nov 2025 10:29:10 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6D133F6A8;
	Tue, 25 Nov 2025 10:29:16 -0800 (PST)
Date: Tue, 25 Nov 2025 18:29:14 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ACPI: GTDT: Get rid of acpi_arch_timer_mem_init()
Message-ID: <176409533246.296080.6408688922668642971.b4-ty@arm.com>
References: <20251030110137.1843007-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030110137.1843007-1-maz@kernel.org>

On Thu, 30 Oct 2025 11:01:37 +0000, Marc Zyngier wrote:
> Since 0f67b56d84b4c ("clocksource/drivers/arm_arch_timer_mmio: Switch
> over to standalone driver"), acpi_arch_timer_mem_init() is unused.
> 
> Remove it.
> 
> 

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI: GTDT: Get rid of acpi_arch_timer_mem_init()
      https://git.kernel.org/arm64/c/155f8d4ef0b7

-- 
Catalin


-- 
Catalin

