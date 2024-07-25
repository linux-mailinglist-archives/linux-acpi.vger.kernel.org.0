Return-Path: <linux-acpi+bounces-7053-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9B193C2CF
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2024 15:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA5C1C21B8D
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2024 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAD919B3E1;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LioHTqQy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53CB19B3C7;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913639; cv=none; b=W3WaPDx5+qS+1ibTjtTDCLfmEJCSCgD700DIgzSujNH0x3hRNm8QC3jlrmvh01B4JcRs+W+UJ5laHZpkKNPkihasR6fNken6EHHBjnzo4szfcMVyucLrPMjVChRQB2/7rk1Eb4r11ugyjwn4ApXQ8Ej1hPc46J0YsA7FsHTGvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913639; c=relaxed/simple;
	bh=vfzBgIcntLPqkhSJCyx0FFIQHgkyhzWKN7LqXMOkLP8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b1uBf23zN7L6IO2y5QNE3hueDU+sTxI1V1saV0fvo23GyaOmEXkn+QN461s71rNcItMYjt1czpwzaX/oJ7Rf7Juo4hDtfY4LC6AE00Z+pBOEqUESc1k6zgE2ulEaQfR81a/D7UyBwDdrP5FvMaUgkPwOEVvNDQQQr4w6gE5irvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LioHTqQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EAFCC4AF10;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721913639;
	bh=vfzBgIcntLPqkhSJCyx0FFIQHgkyhzWKN7LqXMOkLP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LioHTqQyAbtkWBjJn287USPv1Czr9b7xVzVhLXUWNZnRAEAFRu2t2zN4K4oBGGmZ0
	 evZnwPlXj2awXorBNpt/uJu+p2U6abJ3QbU+g9lzlxMApLstFezzGk7dvA+bbtHaJ6
	 2y8cMcDkuHQROLfBil+k3TNFKxIBy/AAyaipOGIRsgzKj60q0kB5r79cqaTx4d8nxO
	 bQcsvNwjvvRwru6ZkFdIJSiWImZJntUmIAWsCiLXMA3aTJo0TkoQSkqhw26IaGLwx4
	 J/c+btnP65W1qY9khcboBOiyahijXocjc58dAHoGgNKGF5M3RjCTEbTd/tKEJ4Audj
	 AK80C7Pe84MZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40240C8E8C6;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 1/3] riscv: cacheinfo: remove the useless input parameter
 (node) of ci_leaf_init()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172191363925.6240.13009091146291258074.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 13:20:39 +0000
References: <20240617131425.7526-1-cuiyunhui@bytedance.com>
In-Reply-To: <20240617131425.7526-1-cuiyunhui@bytedance.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: linux-riscv@lists.infradead.org, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, sunilvl@ventanamicro.com,
 aou@eecs.berkeley.edu, bhelgaas@google.com, james.morse@arm.com,
 jeremy.linton@arm.com, Jonathan.Cameron@huawei.com, pierre.gondois@arm.com,
 sudeep.holla@arm.com, tiantao6@huawei.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 17 Jun 2024 21:14:23 +0800 you wrote:
> ci_leaf_init() is a declared static function. The implementation of the
> function body and the caller do not use the parameter (struct device_node
> *node) input parameter, so remove it.
> 
> Fixes: 6a24915145c9 ("Revert "riscv: Set more data to cacheinfo"")
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> [...]

Here is the summary with links:
  - [v6,1/3] riscv: cacheinfo: remove the useless input parameter (node) of ci_leaf_init()
    https://git.kernel.org/riscv/c/0c8a84c2ab78
  - [v6,2/3] riscv: cacheinfo: initialize cacheinfo's level and type from ACPI PPTT
    https://git.kernel.org/riscv/c/604f32ea6909
  - [v6,3/3] RISC-V: Select ACPI PPTT drivers
    https://git.kernel.org/riscv/c/66381d36771e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



