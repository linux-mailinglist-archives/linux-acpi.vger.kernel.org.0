Return-Path: <linux-acpi+bounces-1060-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE7B7D9B7E
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFAE1C208E5
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01477374C2
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJsomzOA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81451EB28
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DE13C433CC;
	Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698412829;
	bh=uaH9oSE8hSkKDrtZ+0k6LRDnVc9OxcoK0ehE0l5U8ek=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZJsomzOASmPMdOTc2TIYX2q1MNQgkY7nBHCDWAyDyDl+kFMaSfgJitYqGJaUfRqsx
	 bqE8LgStwd4vG1/+rAL1v+Q5Jnq97fW0qQTHKu0oqJdmdbLj7XgNCgzGmtNpyrY9p8
	 SHZ3A5T/mpRZZe88g3U681OnxeXidQ5nZULw3jLTsd3J31dGGUzcvfrGV6L4bQxIbR
	 WvgAItRJ1abxHPUKPt/YQ4lIVHMiJLwbSLBieDE6ogNmZJRoXZxsEfWfaaeVNlSTYO
	 ghQKqF+5BXl9XUQSytlDYhkm/ex0PaOdyOa19ht6ZpT47bk+xCmZ7uFCAODUYq/4G8
	 i92lIqCuQhTww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D0FDC41620;
	Fri, 27 Oct 2023 13:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 -next 0/4] RISC-V: ACPI improvements
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <169841282911.15670.16781297228669817220.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 13:20:29 +0000
References: <20231018124007.1306159-1-sunilvl@ventanamicro.com>
In-Reply-To: <20231018124007.1306159-1-sunilvl@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, apatel@ventanamicro.com, aou@eecs.berkeley.edu,
 rafael@kernel.org, conor.dooley@microchip.com, palmer@dabbelt.com,
 paul.walmsley@sifive.com, ajones@ventanamicro.com, lenb@kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 18 Oct 2023 18:10:03 +0530 you wrote:
> This series is a set of patches which were originally part of RFC v1 series
> [1] to add ACPI support in RISC-V interrupt controllers. Since these
> patches are independent of the interrupt controllers, creating this new
> series which helps to merge instead of waiting for big series.
> 
> This set of patches primarily adds support below ECR [2] which is approved
> by the ASWG and adds below features.
> 
> [...]

Here is the summary with links:
  - [v4,-next,1/4] RISC-V: ACPI: Enhance acpi_os_ioremap with MMIO remapping
    https://git.kernel.org/riscv/c/e8065df5b0c4
  - [v4,-next,2/4] RISC-V: ACPI: Update the return value of acpi_get_rhct()
    https://git.kernel.org/riscv/c/a06835227280
  - [v4,-next,3/4] RISC-V: ACPI: RHCT: Add function to get CBO block sizes
    https://git.kernel.org/riscv/c/9ca87564190c
  - [v4,-next,4/4] RISC-V: cacheflush: Initialize CBO variables on ACPI systems
    https://git.kernel.org/riscv/c/2960f371f165

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



