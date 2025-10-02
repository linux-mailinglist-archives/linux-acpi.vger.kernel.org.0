Return-Path: <linux-acpi+bounces-17492-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B50BB23B0
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 03:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA0219C6B67
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 01:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283821A2C0B;
	Thu,  2 Oct 2025 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z03fUPoy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13CE1A2387;
	Thu,  2 Oct 2025 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367455; cv=none; b=pxuVBaXw0JNpl97zmg5PNL9MQI7D8xiyhK1eBS3S2FkYR6lGHgpcmS2T3+FNU0skFyExepmFho5As9jm/mozNRPI7dc7utVXMdvtJLtD2ym03Rs91HpUuzxM17Xqa2MV/HEtadXaX9zKb0sFRF9MwMGvyMTRCq77h8wutvwaax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367455; c=relaxed/simple;
	bh=lIGvoiVxBwkDxXaHS/29NEo3JJhimHcaJfV2c81L+JQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pzu97d9myCfYsg6W8KJBBp3Qn737wAVCBhsbFbGpsaBksh3s/3JgTCx5OCDeGjVyqJwFLmBsk2rHuAgSTFrPEa9TWuDE32Lo0nWN/MedOOBFdfUxM5nfV5SOoT42mF2Vt22GRtik3pOdVbehSE1aJ59XKL0jt2zkDBshaujds/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z03fUPoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A9EC4CEFB;
	Thu,  2 Oct 2025 01:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759367454;
	bh=lIGvoiVxBwkDxXaHS/29NEo3JJhimHcaJfV2c81L+JQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Z03fUPoynRSivgvjscyCpOXWPGPjxL7NPdxaxcZCtRsIZG75Cvpu51mPHM/hMALPO
	 mNyJ/NFd72oFiEsiFbarDQnPxrlcCXO1YTCaq/ELsLoOxjp/H+jGnncJQ0Hh1gEyz/
	 lhYnZmsU/APA7M7uNbuqVRs+ZgpagTbFCApoo6fgcMpo64Yapl6POPUfPu5LKPglWg
	 nSryb/F0PxPAsHMBlE4ptx2HOxA1iWiu+FonPRkknOWsUGDae0BfrG9FtHnS5VXQ7v
	 5bQMf2yI7uLOh0BxrJ0eaeyzU6ShnIiKHuES6c/wshmOXTI54lX2pz4sYLHtT9HWGU
	 v77ajFGgaRtSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6526339EF947;
	Thu,  2 Oct 2025 01:10:48 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0joS1VAnZ=hKtf2cx51XGNeMkqnJwq1GX-W58k_FQy39A@mail.gmail.com>
References: <CAJZ5v0joS1VAnZ=hKtf2cx51XGNeMkqnJwq1GX-W58k_FQy39A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0joS1VAnZ=hKtf2cx51XGNeMkqnJwq1GX-W58k_FQy39A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.18-rc1
X-PR-Tracked-Commit-Id: 2085f0f4697234a0f59ed718d0e72f38688210e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f13ee7cc2dca5ebbd7f01e14d6c8db1caabd863b
Message-Id: <175936744729.2689671.13062074823349530815.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 01:10:47 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 16:57:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f13ee7cc2dca5ebbd7f01e14d6c8db1caabd863b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

