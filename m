Return-Path: <linux-acpi+bounces-17944-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A16C6BED344
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 18:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DAC18923A4
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9524337B;
	Sat, 18 Oct 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivk5aZFw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D8C23F417;
	Sat, 18 Oct 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760803307; cv=none; b=oE5+RGVpFoNDfpsM8aihP+NYiDuXOMtiioy/Bl2XmbZSoh53SUCaeBDBaTUM2YRXFfrjO789StIJsn2SaVJQGr/8IxwdCYhQN0b81/uvKDe2NkLqCNGmTeW80a1fQPye2OjtdsD1g/+yJbSFCQnDq7oX4lBR+EMeebe/m7+Og64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760803307; c=relaxed/simple;
	bh=xdGzVFaydhp9qU3Eq9iqFsHM3rixK5o6FO97hISarJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=StHdmBGk2IcDwo+N4nrn6X+2tdMm3gObyk2bZcfcryfjc2W7ZPrApLL5ztYU2JtAWlMgBE7unDsbYpeZWL826LfeUmTm+6UXzm3VwFpqxpONMvEbDqK04Bb8xo/acJ3bPq/HcoGS2hqpKrPqVv+lOIsml64nA/uSpUAmvx7yxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ivk5aZFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA949C4CEF8;
	Sat, 18 Oct 2025 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760803306;
	bh=xdGzVFaydhp9qU3Eq9iqFsHM3rixK5o6FO97hISarJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ivk5aZFwr1PqelJFYqIiLan7RNwSpRgCvimVwLWbZPPSsTaynAydgtRg34dHe4JoM
	 0OwpoyJB7yuUIYJLSmWXNSbyyOhMIMM+afBQjI9TNZ0Kel5Ib5t9m9Gi6yAUHVZtH/
	 ezkYhR4FTfzPvoS7yuW8naeqhECKHkctRYhNUnrmxGTTG8DzBhUgdq+aDW5yjs8C7F
	 dZvke3PXtXRdttUu8eP5CmfNmGrSOU+Mo/K43UQ6EyEcn/1U4zJXV7pQbNARwTuVF3
	 nr+8I/7k/xyHQj4W2ceUCFZuZZIylEYp+KtAa7xwF1aaFT+vAlwhS8HHptl7Z/iK5o
	 nY9GmDEUs1ZEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E1C39EFBB7;
	Sat, 18 Oct 2025 16:01:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ACPI: RIMT: Fix unused function warnings when
 CONFIG_IOMMU_API is disabled
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176080328974.3028979.2139175941358455786.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 16:01:29 +0000
References: <20251013181947.261759-1-sunilvl@ventanamicro.com>
In-Reply-To: <20251013181947.261759-1-sunilvl@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu, lkp@intel.com,
 alex@ghiti.fr, rafael@kernel.org, joerg.roedel@amd.com, palmer@dabbelt.com,
 anup@brainfault.org, pjw@kernel.org, lenb@kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Mon, 13 Oct 2025 23:49:47 +0530 you wrote:
> When CONFIG_IOMMU_API is disabled, some functions defined outside its
> conditional scope become unused, triggering compiler warnings reported
> by the kernel test robot.
> 
> Move these function definitions inside the #ifdef CONFIG_IOMMU_API block
> to prevent unused function warnings when the configuration is disabled.
> 
> [...]

Here is the summary with links:
  - ACPI: RIMT: Fix unused function warnings when CONFIG_IOMMU_API is disabled
    https://git.kernel.org/riscv/c/e7b969cbe302

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



