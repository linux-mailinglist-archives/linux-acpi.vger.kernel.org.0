Return-Path: <linux-acpi+bounces-7036-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAC393A0AB
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2024 14:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EE52837F7
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2024 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061BB15279E;
	Tue, 23 Jul 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7M2I86F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44F71514F3;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739516; cv=none; b=RaOmplm9zZxSr/SDvzmOjbRDPxp7X7dKzxRGrc85qKo3v9mSOflcFymQ3t3q3XsfDcSL8Fos2meIiWJKwAxk8aE3ItTT360+SeTJXkyzj8qnrEnPXF4RVAXH6t0qTT3RpDm3ajY1dAUD7THTu0eaxEIULv85fjQI/rU1OT0uILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739516; c=relaxed/simple;
	bh=fR1aySQ/+oVgf1My0oaj19WwBAMmOZvLsxd4wUUyhRM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NbZcJJ+7+WN2tnZwIiMF9u9vM7xTCou7knpYWxYP4t14mtpvvXTIYGk+okyKDdxrjD9Up7KG5R84jGvpk7Kl0LpC1fqhv8Jy5owYUgII6CIrFF/JkMHLGd2jaVaHVzmeIZWG0TmevN3n/oQUWmURT/03Zz382GQXNHUa5AVveNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7M2I86F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85835C4AF15;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721739516;
	bh=fR1aySQ/+oVgf1My0oaj19WwBAMmOZvLsxd4wUUyhRM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O7M2I86Fc86jPW9j7tzdrwXEwQ1iF9utnViosLowjTR6NAHGuVzXvhcsNIwvSNQwE
	 xpWqWGXPw58k1doZFZaEIFkqKKVrg6uN2E8N+NdAVfrNtvLuxz0Fw4vUnua3FnZ6ZT
	 lFgDbzM3H9a22SCXtN1vdvZk2Hf241vgjyQwLGtLTovpbOuHD3bkA81xWx9nmu1oBW
	 9nnNFBzUYWkL66Wfpqo2laPH7t9HKr/UHNX81RKI7qtZiYG6ZnkOMaXfP/YCZeZ1t2
	 88vtAEiFn1QEjQhl1gMs+CVOevmfAlNE562sJKjD9RzaZVx7moEmIpQy/5gF14DRXd
	 B84Yi/nS/ta7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7480DC4332D;
	Tue, 23 Jul 2024 12:58:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] Add ACPI NUMA support for RISC-V
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172173951647.10883.3771071105070465600.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jul 2024 12:58:36 +0000
References: <cover.1718268003.git.haibo1.xu@intel.com>
In-Reply-To: <cover.1718268003.git.haibo1.xu@intel.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: linux-riscv@lists.infradead.org, sunilvl@ventanamicro.com, arnd@arndb.de,
 xiaobo55x@gmail.com, ajones@ventanamicro.com, catalin.marinas@arm.com,
 will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
 conor.dooley@microchip.com, akpm@linux-foundation.org, charlie@rivosinc.com,
 bhe@redhat.com, evan@rivosinc.com, cleger@rivosinc.com, zong.li@sifive.com,
 samitolvanen@google.com, alexghiti@rivosinc.com, samuel.holland@sifive.com,
 chenjiahao16@huawei.com, rmk+kernel@armlinux.org.uk, jszhang@kernel.org,
 james.morse@arm.com, andy.chiu@sifive.com, maz@kernel.org,
 tglx@linutronix.de, tony.luck@intel.com, ardb@kernel.org,
 dan.j.williams@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, rrichter@amd.com, ytcoode@gmail.com,
 dave.jiang@intel.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 13 Jun 2024 16:54:32 +0800 you wrote:
> This patch series enable RISC-V ACPI NUMA support which was based on
> the recently approved ACPI ECR[1].
> 
> Patch 1/4 add RISC-V specific acpi_numa.c file to parse NUMA information
> from SRAT and SLIT ACPI tables.
> Patch 2/4 add the common SRAT RINTC affinity structure handler.
> Patch 3/4 change the ACPI_NUMA to a hidden option since it would be selected
> by default on all supported platform.
> Patch 4/4 replace pr_info with pr_debug in arch_acpi_numa_init() to avoid
> potential boot noise on ACPI platforms that are not NUMA.
> 
> [...]

Here is the summary with links:
  - [v4,1/4] ACPI: RISCV: Add NUMA support based on SRAT and SLIT
    https://git.kernel.org/riscv/c/eabd9db64ea8
  - [v4,2/4] ACPI: NUMA: Add handler for SRAT RINTC affinity structure
    https://git.kernel.org/riscv/c/39494aec8a04
  - [v4,3/4] ACPI: NUMA: change the ACPI_NUMA to a hidden option
    https://git.kernel.org/riscv/c/adc3e82d2537
  - [v4,4/4] ACPI: NUMA: replace pr_info with pr_debug in arch_acpi_numa_init
    https://git.kernel.org/riscv/c/5f76d4211ee4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



