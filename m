Return-Path: <linux-acpi+bounces-15219-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6493B08B3A
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 12:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2478517FB42
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jul 2025 10:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54BB2DCF77;
	Thu, 17 Jul 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFv82nLd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985582DCF73;
	Thu, 17 Jul 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749192; cv=none; b=jhoMb6xpvRDiFYs+3+ci7UZYLofpxwYTYNel0Y14baqGh++xfno6TPq9ljYw1TpOSMPsNs2TVsY9HFPMjaazMoUZXbLfFr+BBn+bLEE2rvNTdAiC+Act1FVGYhKwPSY2w8LRxFcbJExTWoQbXfej5bjpubj1g70bJmiRQGoZDn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749192; c=relaxed/simple;
	bh=0qgMdt/0EtzMZfFqcKJGGFv4x+9cNMvWf5W808j3enc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXJqYi3UG6sqNGHw0EoO2LWPiYu2BCSsKzVODSJK0CSBpg/j2V4JQaeeE3OMlKjhuBStuqqgMoBkBoKBahxyi23H6/EK9NmmLU8H7E+RAaDhkAir8M1CpHOdi9cx74jReLbAzZ/xskENtnEEI0oE1PibebuvNvZ9D2lHVII5Mtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFv82nLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A968C4CEED;
	Thu, 17 Jul 2025 10:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752749192;
	bh=0qgMdt/0EtzMZfFqcKJGGFv4x+9cNMvWf5W808j3enc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFv82nLdSEfLmuwrqHSkDWdQe2axVz877mdrMR1KigU7QY3lIVBPN/5mdqIfHaLqH
	 3ilBMk4VRGEBqjTfOBp8t1ywLpC0msDeH3AKVKhbDPx2vlg5Kw+tZY0JiO/N4EVTj4
	 7VkQ2OQfb0BacFJmehrD46qDqYjXrdc8kIt70BF7XO0vp04YayoHNIM1N5tbO85zUo
	 y93bOsm4zMvEuj5eN+CRpLwWFrWFettiK02Sk9hL7Hi9vg1t6KmEiUXWbeR+ZC8kwr
	 ldbdgu+0lIAAqNcR/to+L3qAL1UX9KtgphquVjQYwic/JHtbUX8KjCPaeWqCKohDi+
	 kBjzM6YrGNx8g==
From: Will Deacon <will@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Robert Moore <robert.moore@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH v2] arm64: Mark kernel as tainted on SAE and SError panic
Date: Thu, 17 Jul 2025 11:46:18 +0100
Message-Id: <175274683701.735514.4319542940682343455.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250716-vmcore_hw_error-v2-1-f187f7d62aba@debian.org>
References: <20250716-vmcore_hw_error-v2-1-f187f7d62aba@debian.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025 02:42:01 -0700, Breno Leitao wrote:
> Set TAINT_MACHINE_CHECK when SError or Synchronous External Abort (SEA)
> interrupts trigger a panic to flag potential hardware faults. This
> tainting mechanism aids in debugging and enables correlation of
> hardware-related crashes in large-scale deployments.
> 
> This change aligns with similar patches[1] that mark machine check
> events when the system crashes due to hardware errors.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Mark kernel as tainted on SAE and SError panic
      https://git.kernel.org/arm64/c/d7ce7e3a8464

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

