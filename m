Return-Path: <linux-acpi+bounces-19209-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7821DC81145
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 15:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5399C3A7365
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF5C283FF8;
	Mon, 24 Nov 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qjhc5WAW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FAF283FDD;
	Mon, 24 Nov 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995274; cv=none; b=lUkJq95t0Xww4hisG0X6P0NF+kZOURhSDhbpTXY8RIbTi5oHfYFNRNuealDo3UrQIROiJvId7UYLHOYEL6ClDrUOi6WyDgtzUxEBJh4q/LwTHynaeNLGn26KV+Ii25sH9KdGeUrgtpmmwbrduORt04XdYfXDPPF7AGbWqaxrTgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995274; c=relaxed/simple;
	bh=lT7qGlbAr3MwLkOA70sTgna2dfB0sri60SmsTiNFPGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttyiqa/izCZ7FiQgpK7cLwCqB9rp87n2jfVGwccR9BiWIXgLijVLd1NDrl2MpIsifgI+k34DIXo+ngBmjjxbdmDXpD+pihxODPV6/f1Q/uxnR4Jn7Acfq/FffmX8fXg8EsYxXSDh6OSjDd0/uyBTwIg/digz5quBPSv8hPqIack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qjhc5WAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F93AC4CEF1;
	Mon, 24 Nov 2025 14:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763995273;
	bh=lT7qGlbAr3MwLkOA70sTgna2dfB0sri60SmsTiNFPGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qjhc5WAWAhQOgtVSUgkXumrod8ozEddwI1bEPZVpyQmoPlDgcsHNBVW+nFVGivswH
	 MbagNwqbqH/yfrMoWtgH+PvIHPrPSvC1bSUM4tpb6cu8Ol7BLiDpLqC2bMQ6wLCEsp
	 bXEqngsnQ2N/Xti2C1MHP03ctvr06rVz7ltAKAmAUB9xSJcdv76EWhMPWgEEIVnbIw
	 DpUFR3ctwp/oMiMs4HfvtIjKN9Vea7gMTx7RMEbFmXgRuvHG1ysgtGEKHQ92NFuQjN
	 0ksH+Kc1QdJTKuymEIXm9zwL2E7S5BCeQte3Z+KNoTwuNyFPxjZhQyU4aGfPGo84h2
	 MKdgmvj3bwF+g==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ACPI: GTDT: Correctly number platform devices for MMIO timers
Date: Mon, 24 Nov 2025 14:41:03 +0000
Message-Id: <176399026678.3269829.16087692619591928105.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251030110115.1842961-1-maz@kernel.org>
References: <20251030110115.1842961-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 30 Oct 2025 11:01:15 +0000, Marc Zyngier wrote:
> Use the actual timer counter instead of the watchdog counter.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] ACPI: GTDT: Correctly number platform devices for MMIO timers
      https://git.kernel.org/arm64/c/7c16c02e8608

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

