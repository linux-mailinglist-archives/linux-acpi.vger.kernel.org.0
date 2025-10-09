Return-Path: <linux-acpi+bounces-17662-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43967BC70FA
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 03:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4673E4F23
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 01:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABE41A0711;
	Thu,  9 Oct 2025 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyZOPJwH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803BC19F11E;
	Thu,  9 Oct 2025 01:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972030; cv=none; b=N9PvGcYhqTe+JPgrl0PrwmEbt8rdmttcSorT35ifIgjm0kU3RkAK6eYVq5X4TeAf8rXr/8kb7pZ2sAw7OOiwLf3Z2Wa5ZmORjP7RlUm/CYzl09GSCsArKjhFoSVB7FdyFjRYpJIiSGXpXb3RT0/K6aR0wbFEOgnV5F6z8lh1vrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972030; c=relaxed/simple;
	bh=8lLvrSOJdnG2+/1GjnzlTqFjSAwkMIFcfM7bGqMBkdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=STQHDGH6zfo17YNVNPCMwk6WlUqCP9JQAW6+9b8D4A0o715m5LTVw5pytHRshFvhIUrCqcJhMhmb13p8wULJXLYeIDZE9Is0qOVEOKq7qhLZWkpVRulvXW56vp1HXZ1YKj945vY4ctXzfjKgU63I/EGxXIuZDkLU0MxWzQCXH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyZOPJwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07299C4CEF5;
	Thu,  9 Oct 2025 01:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759972030;
	bh=8lLvrSOJdnG2+/1GjnzlTqFjSAwkMIFcfM7bGqMBkdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UyZOPJwH3RjkXnLVgTJzxH5oVJpDqfmqP7LzmM+awC+tUq7Rt5vCg0abl7bSheIUJ
	 Oq1je4fQcNzSpt7ogh4/UqwBvheY2RcpMkgO+tIhJ2H3sOlB+v56G5JgMYVcGJkKIb
	 jWP0yl9+MPdvQ7wK8Ek9FeXfhsp8HFKey+1Y5A9Oq5oXtrQwJ07kavbrAJuiqy2NDN
	 V9EY8zlrTmFiMOQCcyrtJqPDmaPyL1MzSqLxx0EDpCJP3TauSYXm6GAeYAeA1GqAtk
	 66wb2AuVs5HwMXTXRApex6ApzJ7y7vHjVXrDQR0K9OzFQ1VFDQVCnYPlu7UxL5gJLV
	 Q7r5J4Bfkkqdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEE23A41017;
	Thu,  9 Oct 2025 01:06:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/3] RISC-V: Add ACPI support for IOMMU
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175997201849.3661959.13962135221127346845.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 01:06:58 +0000
References: <20250818045807.763922-1-sunilvl@ventanamicro.com>
In-Reply-To: <20250818045807.763922-1-sunilvl@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev, aou@eecs.berkeley.edu,
 tjeznach@rivosinc.com, alex@ghiti.fr, rafael@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, will@kernel.org, lenb@kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Joerg Roedel <joerg.roedel@amd.com>:

On Mon, 18 Aug 2025 10:28:04 +0530 you wrote:
> This series adds support for RISC-V IOMMU on ACPI based platforms.
> RISC-V IO Mapping Table (RIMT) is a new static ACPI table [1] introduced
> to communicate IOMMU information to the OS.
> 
> [1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v1.0/rimt-spec.pdf
> 
> Changes since v5:
> 	1) Rebased to 6.17-rc2
> 	2) Fixed incorrect id_out assignment (Reported by Xianliang)
> 
> [...]

Here is the summary with links:
  - [v6,1/3] ACPI: RISC-V: Add support for RIMT
    https://git.kernel.org/riscv/c/8f7729552582
  - [v6,2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
    https://git.kernel.org/riscv/c/cbf4fbc484e1
  - [v6,3/3] iommu/riscv: Add ACPI support
    https://git.kernel.org/riscv/c/4f901b3dce57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



