Return-Path: <linux-acpi+bounces-10114-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8019E9EDA2A
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 23:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D3F28326C
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 22:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F5920DD5C;
	Wed, 11 Dec 2024 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4HKpHYz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A14209F32
	for <linux-acpi@vger.kernel.org>; Wed, 11 Dec 2024 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956387; cv=none; b=qhByB2oVNGLJA/7dBVhe2fJIos1FMHmk7iykaf+cqUsUnXB477Hw7msNvQ8PGMQMcey/6bCW0N9TKdszdycG7nnQbJjB7oBNlAed0GVLtsohRDXv1X+izd8u8S10sEmYLyUQpio0XeS2Pyg9EBVIs3JR0aBYsSwarD2Rm2XdsfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956387; c=relaxed/simple;
	bh=6vzy9W7MutUOZNBEPu/ZaeFKt+pCcG6i2Mi81FMo/zo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EnBM1xwiider8xlJzzXHEh+X7k/+iSDh9Xz3DasYjJ7IcYyB5xviwG8p/tN7Tthnh90WBNpae8pvHpSCUhUDDEpQVT5AxZj2MFfIJ4/PSdBxPNp4S2LHiuNSZD4vnf22QMjV6FTmcPhfmOvzL0+oCMjCyrZDIcvlcD/v0eYY7Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4HKpHYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03B1C4CED2;
	Wed, 11 Dec 2024 22:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956386;
	bh=6vzy9W7MutUOZNBEPu/ZaeFKt+pCcG6i2Mi81FMo/zo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o4HKpHYz5SmpQqTC9GZTYYy4yG9JFVIeM+ayvy/+YFWquF15hl5vh5/qKEH5pK49v
	 Sieu7dXVq6LpyNvgG6Ftq2AxnjNx7Shc2dADxtWMJv98WMfPVAN0CyRGwOlPl4UzRK
	 DQ+aSQcSiq26XFF3vdiXybukEqBL+ue+nAhU9FcxjLus6W+b0DurNnzqZ38s90Y5Qp
	 U4WwSSY6uJeUD4uqItXPW5GVeHBrx905oU0uOJ1f2/PIK78s84wyvLbykSNqaAi/hD
	 9BS/2U3/CPf8fi0fQKyMn81FhMNGoFgySNjam1t4JouI8BmJqaQUyPj5B3C+ALubUm
	 30gtmj941aCyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3458B380A965;
	Wed, 11 Dec 2024 22:33:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] ACPI: introduce acpi_arch_init
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395640299.1729195.506901103763287454.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:33:22 +0000
References: <20241121-intro-acpi-arch-init-v4-1-b1fb517e7d8b@gmail.com>
In-Reply-To: <20241121-intro-acpi-arch-init-v4-1-b1fb517e7d8b@gmail.com>
To: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Cc: linux-riscv@lists.infradead.org, guohanjun@huawei.com, rafael@kernel.org,
 lenb@kernel.org, sunilvl@ventanamicro.com, sudeep.holla@arm.com,
 lpieralisi@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, shankerwangmiao@gmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Rafael J. Wysocki <rafael.j.wysocki@intel.com>:

On Thu, 21 Nov 2024 22:25:21 +0800 you wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> To avoid arch-specific code in general ACPI initialization flow,
> we introduce a weak symbol acpi_arch_init. Currently, arm64 and
> riscv can utillize this to insert their arch-specific flow. In
> the future, other architectures can also have chance to define
> their own arch-specific acpi initialization process if necessary.
> 
> [...]

Here is the summary with links:
  - [v4] ACPI: introduce acpi_arch_init
    https://git.kernel.org/riscv/c/9d8a2b033db1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



