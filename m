Return-Path: <linux-acpi+bounces-8321-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A597B447
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Sep 2024 21:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7811F23C0D
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Sep 2024 19:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2481B189B8A;
	Tue, 17 Sep 2024 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7eXMVgO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003EF839F7
	for <linux-acpi@vger.kernel.org>; Tue, 17 Sep 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726600232; cv=none; b=Q59U2w6aDjz7p1lPyNHxZJ6cBMxDm6p6vtgq8yMdB1JLCIALkoD3lLaBJpLlN/jRdYX4qF2nwA77SINVn27wn0nZUG92vabBkjL15lG4veNzhEroEgyQ8lnMcGhbW9s/YgTtSp33cOZUhZqO0K//EtAPkdR1tHlVNLIPXgd8Zuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726600232; c=relaxed/simple;
	bh=LN4sSdQbVNRyuftdRjJJuLlsJTP2gVDvHPaxKdycA+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iAlyhh5pTtSJM1lm2CT7Nhu/G0/HaqfzUu5PlBYPIg06uclbcetOdc5CYD3vTfY/WamrKwg4wbEonIIX3GCX9vvJEl0C87awVdkCeGKmWvG6QeNQP6EB5yOHzJlTsCmrNzxdMO65fqdKYQiGC1Zvyz4KoE8NjMd4d2K/Ysb045s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7eXMVgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68419C4CEC6;
	Tue, 17 Sep 2024 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726600230;
	bh=LN4sSdQbVNRyuftdRjJJuLlsJTP2gVDvHPaxKdycA+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g7eXMVgOamIn36vMbI7OuOfwa16ZYj540udwW+aw0LC5jk77499xdtMqu4+A781a4
	 JXFWE02bYY8cKiHwool1FkHqHPB1Bm/5V+oGpDvsMsFpqI+fHW3Z6r/pdJHOtuJmv0
	 l67yZnK/BHXhciEeDPl3Vy5NheFPkSEtJkKZ6F2+leJCcyABGU8BsbRC6Su8ORzjo3
	 7G6EoxkrMNGCzprGCbrI9TVknmWwsuvRZOy/udc5Y7J/+J6jt9EZwL7M+bj+Thquk0
	 annP5eezlsUrx6ni73ycjRDliNFIarC2RpjqjzqKWXnuoZ44UsoUK8WTvz3/8Bv+8U
	 i1nr7135Ut1AA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34FE73809A81;
	Tue, 17 Sep 2024 19:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ACPI: RISCV: Make acpi_numa_get_nid() to be static
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172660023203.247451.10308153847159173227.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 19:10:32 +0000
References: <20240811031804.3347298-1-guohanjun@huawei.com>
In-Reply-To: <20240811031804.3347298-1-guohanjun@huawei.com>
To: Hanjun Guo <guohanjun@huawei.com>
Cc: linux-riscv@lists.infradead.org, sunilvl@ventanamicro.com,
 haibo1.xu@intel.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, sudeep.holla@arm.com, lpieralisi@kernel.org,
 rafael@kernel.org, linux-acpi@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 11 Aug 2024 11:18:04 +0800 you wrote:
> acpi_numa_get_nid() is only called in acpi_numa.c for riscv,
> no need to add it in head file, so make it static and remove
> related functions in the asm/acpi.h.
> 
> Spotted by doing some cleanup for arm64 ACPI.
> 
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> 
> [...]

Here is the summary with links:
  - ACPI: RISCV: Make acpi_numa_get_nid() to be static
    https://git.kernel.org/riscv/c/21d98d658f9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



