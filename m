Return-Path: <linux-acpi+bounces-15548-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A8FB1CA65
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 19:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6F83B2DB4
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 17:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0571E7C03;
	Wed,  6 Aug 2025 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ0K6HTZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAEC35898;
	Wed,  6 Aug 2025 17:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500523; cv=none; b=ZM0xHSKEV7QDixOSGeHXEEJFTF+blL+/T5r1csWHs1H9NauhiOlLw9Ne5KUd8UMKgLFuLfXVNIF63jC7ZRFpUNcJ9FBDu24U185fMBcFgpHw/NHUJCnQY2o/PfCCBjdZvZhlLmOVShKoeZIuS1R56k/8QBZWt9qi0KK1n2tDhZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500523; c=relaxed/simple;
	bh=I3R0ZZuPVZjnQiFgtmFRVCZ2r5++kREGhtzLYMxzees=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g4nFu53h8cAZrvQNv1tkBaJQZt7N4qAbCmKV4IUnJCGyQwpgorpyDvxBOIKJofnsbln+jzprLQbsQ/lqJ7XkoNkf+/knvpi82+SDwl4Kn6CzuxfXapXcO9rIQRftOrl8uSg3h/KXqkGn+vSF+16BSDYUg7wJn02Xy+L1JJEp9T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ0K6HTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CE8C4CEE7;
	Wed,  6 Aug 2025 17:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754500522;
	bh=I3R0ZZuPVZjnQiFgtmFRVCZ2r5++kREGhtzLYMxzees=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WJ0K6HTZEfT8BNH+os9kpt9pf57Ww0MKKW5Q7tRMASQtIpPlQvkgZtJGsw3KeEdBK
	 BaretPZGh8nFdv8U5zaWt1OzwhKxoJ/IkUeZPYDzwBy08EJGVTNbKkcbH2X8J81Bl+
	 21pdP1RoBJTIjViiGoDvOqsFOk0J250MYa855KdnLPkSAN5fW+l5PCNRAocBooOQJd
	 ijz9vEfwOt0CurH2++NyCsU+zuubaqSiZDz6GiTYBAV/K4DmuHSOdm9A0yC3KXDUwt
	 DdIvUQUmIwjvd/OCQc5uEfiC6otmfcVZXBuEDT9eCIYmSOCPwtX8P6YDl4Km+UYygT
	 xfKN+B9hO+jeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDD6383BF63;
	Wed,  6 Aug 2025 17:15:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/3] RISC-V: Add ACPI support for IOMMU
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175450053651.2863135.8588545093021909171.git-patchwork-notify@kernel.org>
Date: Wed, 06 Aug 2025 17:15:36 +0000
References: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
In-Reply-To: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev, apatel@ventanamicro.com,
 tjeznach@rivosinc.com, alex@ghiti.fr, rafael@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, atishp@rivosinc.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, ajones@ventanamicro.com,
 will@kernel.org, lenb@kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@dabbelt.com>:

On Wed, 16 Jul 2025 16:10:56 +0530 you wrote:
> This series adds support for RISC-V IOMMU on ACPI based platforms.
> RISC-V IO Mapping Table (RIMT) is a new static ACPI table [1] introduced
> to communicate IOMMU information to the OS.
> 
> [1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v1.0/rimt-spec.pdf
> 
> Changes since v4:
> 	1) Rebased to 6.16-rc6
> 	2) Addressed Anup's feedback on formatting.
> 	3) Added RB tag from Will and Anup.
> 
> [...]

Here is the summary with links:
  - [v5,1/3] ACPI: RISC-V: Add support for RIMT
    https://git.kernel.org/riscv/c/ea35561bc965
  - [v5,2/3] ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
    https://git.kernel.org/riscv/c/0d7c16d0df92
  - [v5,3/3] iommu/riscv: Add ACPI support
    https://git.kernel.org/riscv/c/368ed89f7ac9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



