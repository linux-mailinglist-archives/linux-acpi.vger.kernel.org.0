Return-Path: <linux-acpi+bounces-17054-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F7B7CC3D
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 14:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563BD1B26511
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 02:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA294236457;
	Wed, 17 Sep 2025 02:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV0gbRik"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF7D220F5C;
	Wed, 17 Sep 2025 02:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076811; cv=none; b=Ccx92eVN5upYDAb/LHKJlgROcu26yz3kgPF9mBnQS7SryJW3gk6xIJwAYcPTkoyzDoRH6pqcP3DM6Y50uFrouq5G35c8eaeMVXwcd+Sg6yzisAnc4lB6n4lNQjPgzexWdBUaK1yhTSG+3qbNMGwmxIEQ0akgmAAv499HH39gPW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076811; c=relaxed/simple;
	bh=w4wLr2yP8Lf0P8+wu6uiNnPTZbO4BPOT3E8l8dJYdWA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Crg8rzaPhLohPQ+MMbNsl70X0ZSeRKY1DKAbEFR2aSqtHGadGh32rVkfJAiSiAjsTiTQRm/oIOhQ7PL9+fQ+Z0xwQAr0EHwvK0pEY0eIG/ni2z/ykY/5LUKxjehHAIFQtc+i2o05RRi+Qyi7FnP8LcFI3cXC9x+xLpb0lUP0PQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV0gbRik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A29C4CEEB;
	Wed, 17 Sep 2025 02:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758076811;
	bh=w4wLr2yP8Lf0P8+wu6uiNnPTZbO4BPOT3E8l8dJYdWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pV0gbRikLFcdAi6S6oBasXHUmazo9Ijq3E1YrL4stpdS1JqA+JI66tleB1GCtaDRN
	 Y7R4ElrtL/gNYTxlyJN9cVKJnEkM1+xVxx28zI/LNqsrFpfx0H2gcaHtLX+uNl7GOZ
	 NpazGumn8ZKM9sKSlJ/5LVslpZvlO9y80i2vGK+26GnT1zKESblKd4RnxmmsonkPbI
	 CtzcJJw/zktmjeSUpXXFHdxkHjZYpDvLn1mSlzNENjCRBUQ300u8zEIByis5kavqlN
	 bYYJWVcUXMEYw2GFZX3nVg59xhelLfolp+sHHyiCWBmBuEqmVzJWQdb25PYaeuYoRh
	 Zj1/H65b9WFJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D3239D0C1A;
	Wed, 17 Sep 2025 02:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Common csr_read_num() and csr_write_num() for
 RISC-V
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175807681200.1444719.17820860384159771040.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 02:40:12 +0000
References: <20250818143600.894385-1-apatel@ventanamicro.com>
In-Reply-To: <20250818143600.894385-1-apatel@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, sunilvl@ventanamicro.com,
 rafael@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 alex@ghiti.fr, lenb@kernel.org, atish.patra@linux.dev,
 ajones@ventanamicro.com, anup@brainfault.org, will@kernel.org,
 mark.rutland@arm.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Paul Walmsley <pjw@kernel.org>:

On Mon, 18 Aug 2025 20:05:58 +0530 you wrote:
> Some of the RISC-V drivers (such as RISC-V PMU and ACPI CPPC) need to
> access CSR based on CSR number discovered from somewhere. Add common
> RISC-V csr_read_num() and csr_write_num() functions under arch/riscv
> for such drivers.
> 
> These patches can be found in the riscv_csr_read_num_v2 branch at:
> https://github.com/avpatel/linux.git
> 
> [...]

Here is the summary with links:
  - [v2,1/2] ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
    https://git.kernel.org/riscv/c/5b3706597b90
  - [v2,2/2] RISC-V: Add common csr_read_num() and csr_write_num() functions
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



