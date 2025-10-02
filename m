Return-Path: <linux-acpi+bounces-17490-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC2EBB2398
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 03:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19D3C7A40E5
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 01:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CF318DB26;
	Thu,  2 Oct 2025 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxbaEXUH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0667E0FF;
	Thu,  2 Oct 2025 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367452; cv=none; b=MMGAZ4XECDU1qca9133X5TwMHI9Z/W5TJ14ewV+T2XgFKzFSqzf0Opts1Pfy2W6AuqzSL5L0sUuxtMJ6BPDNBeFhEWm51jJFLsqzRMQYeh7YFMBW2Dca9RqCqUWnnROo9u5/uKv/vIQzzrUu6OuEFuPXEfNM6xIeB4zUJUqCU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367452; c=relaxed/simple;
	bh=O5GPSnP1HpgUunC+avKoGToaQp1PC2H0lMxEdeMkwqA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=m5fnqM6CegwkNqs1FrsWc8EK6E6tqt+Zocr0a/EQ1O/lkeX3thARFrZJKtzjWolCN/sHCmTlpMJQDMkf3lBR7ewNmf7OoDGDMUbf5b5vAMCDafPZmuceGJ2XXyCEc77gKL/XMV5X1YyTtpRUpARMGODbdR4NJU9HS7qwvMFPmqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxbaEXUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54A6C4CEF5;
	Thu,  2 Oct 2025 01:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759367451;
	bh=O5GPSnP1HpgUunC+avKoGToaQp1PC2H0lMxEdeMkwqA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HxbaEXUHxJZeeChlJfq9HLox84OdjS2XePvUkzVI+5VexQAtYD4/DMh3rcIuKfBpg
	 1EiiPUfJuvh2Pks58yVZFFvXfbg0lW7o+yBjpt58krnZVFA9Lo8efnhYHSC0pEHQ9R
	 EhSU7v8LjwBzGF/xnmftsZn1Dpados/CtR7EWGqCVtagbM/zEIXu3GSGPyx9fnRlCL
	 S9NsGW+T9iR2Uek22K4lpj7o5Sz0yUCGNlZKUqJHx0C5VDnRlFtD0/UW1wThc2yrFQ
	 euryKSBsdDiNU6oiVyDVipZLqMUq5hSbOVALNfw2IvUH0eqcVJp6HaskACGSse1q9z
	 IVNmeMGBFPtaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED939EE03D;
	Thu,  2 Oct 2025 01:10:45 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jNZxcQ26TAPSGX43Psh0P8udTQmkOk+BrKdkS4RhUKmg@mail.gmail.com>
References: <CAJZ5v0jNZxcQ26TAPSGX43Psh0P8udTQmkOk+BrKdkS4RhUKmg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jNZxcQ26TAPSGX43Psh0P8udTQmkOk+BrKdkS4RhUKmg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.18-rc1
X-PR-Tracked-Commit-Id: 40d2cf9c3c1a5a1a9a443389d6b57a87362e4237
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 991053178e08fb4d1f80398367db05c2cc4f20b4
Message-Id: <175936744417.2689671.16906328962189795133.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 01:10:44 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, Shuah Khan <skhan@linuxfoundation.org>, Len Brown <lenb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 16:52:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/991053178e08fb4d1f80398367db05c2cc4f20b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

