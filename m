Return-Path: <linux-acpi+bounces-20410-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 129FED3878E
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 21:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B53031960C2
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 20:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB163A4AA7;
	Fri, 16 Jan 2026 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTLA0dQi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942E2C032C;
	Fri, 16 Jan 2026 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595113; cv=none; b=BJFpoP+LC/qXC6q80XocVavWfTOWQLiAtm1q6TbgucgYUpa/EcI+zRO5Ql+fztQXNEe4VkWHElviw+1y9Zhsudk84XtfowIrXKdNKlz13ppUbhdsZNqxAI5GZwobpPpwJFeehlY1eV8B0dzOIp6DGKGYmec5UB7Ij5Gu9kym4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595113; c=relaxed/simple;
	bh=lOZHtENYBRIh6BxeQvA+IYoSKwHpi2R9GGoJS2Pw0WQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QO064C2ymGKmVAWY4VkjVFsK6k1CI1BCN+lCh2DnZmvjiRgsPnnF/ju866nrNYK6bKYWFH0Dx8EtFJGsTUx3/lZuH8zxe/soE0MLWk94WQyPa1XkXtk/BCO2nB0omVtTRyDBuzliM7t8c1GZIzJgLdcZU1XcSMb7ggp1Rp+UslA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTLA0dQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F070C116C6;
	Fri, 16 Jan 2026 20:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768595113;
	bh=lOZHtENYBRIh6BxeQvA+IYoSKwHpi2R9GGoJS2Pw0WQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WTLA0dQiP4TZQ47O4ah1Q3D4ql9v7FPenrn+yPeu0l793uB9ESzWmuoM8MdPAMfAk
	 P6ze6RDEKOlQVhm6YkKNY1mxXnjyxMhv9L1CEeTZSYF/rv2kOwt/ox6adQ13wfuWdq
	 9vpn4K3d1l29gbkMG4B1Gy4RDSZ0KkIT3ErGodgRJ428EjnII8Je9lQntwQ9fGSlQl
	 FVCWHsGNBiNdSDLSCJoCOrNqcoSkiKeCPG3XnzKG9JWWUPWkIercwMCpfaF/WdY0gR
	 Fm+I3wG1xFBgWfMbXQWGCZgy2zbX5A0gJmIUBJduyBNTyArVFeR+eWF0it83UP7snH
	 7yYi6YNxNnRjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7C9380CED1;
	Fri, 16 Jan 2026 20:21:46 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes for v6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jppKw_SCf+wia8HKwc0YkxHewfZXSjqiQf-C5AFozR3w@mail.gmail.com>
References: <CAJZ5v0jppKw_SCf+wia8HKwc0YkxHewfZXSjqiQf-C5AFozR3w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jppKw_SCf+wia8HKwc0YkxHewfZXSjqiQf-C5AFozR3w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.19-rc6
X-PR-Tracked-Commit-Id: 7edf6f7ef5345e1b4202912ca98aaa7c73e1e82c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e547d4f733f04ac540099b09358e6dc8c8977113
Message-Id: <176859490473.789588.16443680999899438378.pr-tracker-bot@kernel.org>
Date: Fri, 16 Jan 2026 20:21:44 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Jan 2026 16:39:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e547d4f733f04ac540099b09358e6dc8c8977113

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

