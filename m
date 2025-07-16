Return-Path: <linux-acpi+bounces-15206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18198B07E77
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 22:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C63C5863DA
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 20:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CDA2C15A4;
	Wed, 16 Jul 2025 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1wLoGop"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475E2C08DC;
	Wed, 16 Jul 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695992; cv=none; b=spyyWViw85vfWtZ9DG1xk+y2gIwZ6Ok6SgjChbAGa0FQptFnbZTNPXLnC87tgJryluBOgFX7vyiTMWjjXhWELprajUPH3N9dnFdSW9nDdwMivz/Xdvr6roxuR/1+Odd4+QvEno1omBeUbRWVivlTZxnCe8IgoyZcefhXJ/brIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695992; c=relaxed/simple;
	bh=Ba0/4wUdmvPvCviBJEMcf2bCt1YkS4e1WEYt99/unjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TQ0vC1xAfJ7ccaOTSnOT9AaZ5zTxYNga1IuXBXXeg8XFTmMFsDwOEx0D+xUqxkZE5lal7T4iUK1alx6LmbFxSi0Ng3ZXmKqkhy8PErhHEGYRgX+42HC9a3oGCfWyR5PXsDug+khmyIenJatLXU+Y06+Hj/G98qHkbH0T7CjO7X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1wLoGop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE87EC4CEF4;
	Wed, 16 Jul 2025 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752695991;
	bh=Ba0/4wUdmvPvCviBJEMcf2bCt1YkS4e1WEYt99/unjk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u1wLoGopkpLIPzP3iXvGEZfATpbpuPYqmMlf1EQ3b/YBcKoXbeSnoZnbTpno37Toq
	 uT0K/GO4mSczBvCeCheS2ZMjdXY3ec+JRl6UH31bAEdi6idEdShQrfWDJJ0IOsv7iS
	 Et7p8MDbEunOS+FbR2Z2gTBM1sdBrHhpx66MrMP8wLime4p4cgqc62KmhRgdQd7IM/
	 W8QNLXV5xlc/atdnav+9XrJ1M4Lo+nW/QVarnoEtx31EEdJQeqAF22oSk4atzZ0T+p
	 gcPmcbTqhu2P55sAPh9PkMW5dC8QshbsZpm5nNdEaF4hltp2d0cXlJFytHfJ0Aigjf
	 ekpUutBZWUNEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E6C383BA3A;
	Wed, 16 Jul 2025 20:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ACPI: RISC-V: Remove unnecessary CPPC debug message
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175269601173.1308944.6913257148834233964.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 20:00:11 +0000
References: <20250711140013.3043463-1-sunilvl@ventanamicro.com>
In-Reply-To: <20250711140013.3043463-1-sunilvl@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, apatel@ventanamicro.com, alex@ghiti.fr,
 rafael@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 lenb@kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@dabbelt.com>:

On Fri, 11 Jul 2025 19:30:13 +0530 you wrote:
> The presence or absence of the CPPC SBI extension is currently logged
> on every boot. This message is not particularly useful and can clutter
> the boot log. Remove this debug message to reduce noise during boot.
> 
> This change has no functional impact.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> 
> [...]

Here is the summary with links:
  - ACPI: RISC-V: Remove unnecessary CPPC debug message
    https://git.kernel.org/riscv/c/16d743606dba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



