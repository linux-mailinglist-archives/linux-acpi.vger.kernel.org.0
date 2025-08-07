Return-Path: <linux-acpi+bounces-15571-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D72B1DBF3
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 18:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5201649DE
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE4826B777;
	Thu,  7 Aug 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIaF/mDM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC81186A;
	Thu,  7 Aug 2025 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585427; cv=none; b=DRYTww9Z1S4MxIX5jkiaqp/m/e55ptS+sCWyS1f8iTEDezaoY4sfmnopwf7Dpf5YN2/PA0VMpRFSdBoA40Ae9AVgkL86Qw97dLe7eS6bJYVBFYFOhg/qBtjMNoWZut69JCPW1V/2rCSFXazw39sZvDsZ+sCkIMaijwvW7whTJEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585427; c=relaxed/simple;
	bh=RiEGjWMeRpLrAhRA2swG+3oVM1h20C6FfR6nWAJKqaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tY0xO6/21wskAN9A2bby3Yg+MR+KhYOSZ3aPg/JiU0enyomqS2HXoRaNwMuJcjTMJiK1H9xPAqkUS8p61ugqetYjMG9ElVecCagz+C7DK3layX/VI4j9SfRuLCwUN24IxMTifbcrxbxTIFHfYq5vCzaEMGXxze2XIB7hKu+0W1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIaF/mDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9E1C4CEEB;
	Thu,  7 Aug 2025 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754585427;
	bh=RiEGjWMeRpLrAhRA2swG+3oVM1h20C6FfR6nWAJKqaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lIaF/mDMS2H/wVMeSCtD+CrDT2B1XWtYl7DiXKzODzhFTHINWINdeSq3R+Gou8rB3
	 sGR2UuGotuFFTWNqLK/Tvl30SDaTrFuK70Ik2dQ5wBWjcme6Lk8bGAUwwTpO6wca/3
	 B5Y2zSl/OUueVdJjGqn+/ag14joR2DkJqkeebVrFXM63Q2C2+G05xb3oXgzTXeOgzA
	 ZYUY3f2lnOvMMMeVkweGZRNYJh9B9aC5hc5ccW7Lg8u1HvXL2/BmBo/BeZl2SrAp7A
	 oP19YQbreNH7MelXP2v3XzcBCsJESBYXpkSLdMlUodcjbzG32qSB4ch8zG2LWcfz+I
	 /4RriIm62d3rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB24A383BF4E;
	Thu,  7 Aug 2025 16:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 00/24] Linux SBI MPXY and RPMI drivers
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175458544049.3624981.13613580736849122114.git-patchwork-notify@kernel.org>
Date: Thu, 07 Aug 2025 16:50:40 +0000
References: <20250728094032.63545-1-apatel@ventanamicro.com>
In-Reply-To: <20250728094032.63545-1-apatel@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jassisinghbrar@gmail.com, tglx@linutronix.de, rafael@kernel.org,
 mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
 linus.walleij@linaro.org, brgl@bgdev.pl, ukleinek@kernel.org,
 devicetree@vger.kernel.org, ajones@ventanamicro.com, alex@ghiti.fr,
 atish.patra@linux.dev, leyfoon.tan@starfivetech.com, anup@brainfault.org,
 linux-kernel@vger.kernel.org, samuel.holland@sifive.com,
 linux-acpi@vger.kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 lenb@kernel.org, linux-clk@vger.kernel.org, rpathak@ventanamicro.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@dabbelt.com>:

On Mon, 28 Jul 2025 15:10:08 +0530 you wrote:
> The SBI v3.0 (MPXY extension) [1] and RPMI v1.0 [2] specifications
> are ratified by the RISC-V International.
> 
> Currently, most of the RPMI and MPXY drivers are in OpenSBI whereas
> Linux only has SBI MPXY mailbox controller driver, RPMI clock driver
> and RPMI system MSI driver This series also includes ACPI support
> for SBI MPXY mailbox controller and RPMI system MSI drivers.
> 
> [...]

Here is the summary with links:
  - [v9,01/24] dt-bindings: mailbox: Add bindings for RPMI shared memory transport
    https://git.kernel.org/riscv/c/e6ef156cbf20
  - [v9,02/24] dt-bindings: mailbox: Add bindings for RISC-V SBI MPXY extension
    https://git.kernel.org/riscv/c/f24d93a2a11b
  - [v9,03/24] RISC-V: Add defines for the SBI message proxy extension
    https://git.kernel.org/riscv/c/0f2705c52e4a
  - [v9,04/24] mailbox: Add common header for RPMI messages sent via mailbox
    https://git.kernel.org/riscv/c/c949af8fce93
  - [v9,05/24] mailbox: Allow controller specific mapping using fwnode
    https://git.kernel.org/riscv/c/bbc108db8712
  - [v9,06/24] byteorder: Add memcpy_to_le32() and memcpy_from_le32()
    https://git.kernel.org/riscv/c/1419b7bcaff5
  - [v9,07/24] mailbox: Add RISC-V SBI message proxy (MPXY) based mailbox driver
    https://git.kernel.org/riscv/c/81db83e750ca
  - [v9,08/24] dt-bindings: clock: Add RPMI clock service message proxy bindings
    https://git.kernel.org/riscv/c/3d8d1343d4b3
  - [v9,09/24] dt-bindings: clock: Add RPMI clock service controller bindings
    https://git.kernel.org/riscv/c/9231349d789f
  - [v9,10/24] clk: Add clock driver for the RISC-V RPMI clock service group
    https://git.kernel.org/riscv/c/f10b3b886a26
  - [v9,11/24] dt-bindings: Add RPMI system MSI message proxy bindings
    https://git.kernel.org/riscv/c/f421f9dadf4b
  - [v9,12/24] dt-bindings: Add RPMI system MSI interrupt controller bindings
    https://git.kernel.org/riscv/c/dad7051158aa
  - [v9,13/24] irqchip: Add driver for the RPMI system MSI service group
    https://git.kernel.org/riscv/c/087f01ae8138
  - [v9,14/24] ACPI: property: Refactor acpi_fwnode_get_reference_args() to support nargs_prop
    https://git.kernel.org/riscv/c/dfb5dd686542
  - [v9,15/24] ACPI: Add support for nargs_prop in acpi_fwnode_get_reference_args()
    https://git.kernel.org/riscv/c/b39b9be6cf10
  - [v9,16/24] ACPI: scan: Update honor list for RPMI System MSI
    https://git.kernel.org/riscv/c/3061eca5a86f
  - [v9,17/24] ACPI: RISC-V: Create interrupt controller list in sorted order
    https://git.kernel.org/riscv/c/cc57a1b47003
  - [v9,18/24] ACPI: RISC-V: Add support to update gsi range
    https://git.kernel.org/riscv/c/5515df185704
  - [v9,19/24] ACPI: RISC-V: Add RPMI System MSI to GSI mapping
    https://git.kernel.org/riscv/c/a7339aedb006
  - [v9,20/24] irqchip/irq-riscv-imsic-early: Export imsic_acpi_get_fwnode()
    https://git.kernel.org/riscv/c/eeaac5b3a430
  - [v9,21/24] mailbox/riscv-sbi-mpxy: Add ACPI support
    https://git.kernel.org/riscv/c/79ccd8be2527
  - [v9,22/24] irqchip/riscv-rpmi-sysmsi: Add ACPI support
    https://git.kernel.org/riscv/c/515799045fca
  - [v9,23/24] RISC-V: Enable GPIO keyboard and event device in RV64 defconfig
    https://git.kernel.org/riscv/c/b84b1867766c
  - [v9,24/24] MAINTAINERS: Add entry for RISC-V RPMI and MPXY drivers
    https://git.kernel.org/riscv/c/a10b9984fdfc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



