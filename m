Return-Path: <linux-acpi+bounces-1234-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDF17E10EA
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 21:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BF0280DC3
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F4E24A04
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vwi7KEfH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36F421A14
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 19:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36B34C433C9;
	Sat,  4 Nov 2023 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699124494;
	bh=jqoqRBrahXgFt8CKrWMUpi3C4qdw4tFMaKV5AHi98ws=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Vwi7KEfH0fmfcFtWYEjP9yJCYVW0u1Q76+E4qcA7Hkf8YUg6VgPxZLfPedfQQgc0H
	 MSMbUkMy97t0czqLjCKid8b0jeMYP1SWpRafnvwQLk30Q5pukx7cL+iUP3HCXBSRKz
	 B1uznOOArnfh4PRbDn/dYA2l+jxqeheYcl+ZE6+DK0Rl9kVrCUn8XtSQWSiAl0n4Iu
	 qr3Y712ovdiuSzosTMluNF8wifZvYq7vtNSeKb1FJX64hRbcrnd/qW+BSGtGrcB7tI
	 VEys5vxfqaBwFfRMrs43pSmdkSIVo04TJHiPed20MNoQD1eaIq7/3t1Gdr+XFaqCgQ
	 5m3JKSJdTMPlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D296EAB08A;
	Sat,  4 Nov 2023 19:01:34 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gazz3JxSHwgDFFhXjHVEzwjpteXzAc6uPwz=FFdWs_cg@mail.gmail.com>
References: <CAJZ5v0gazz3JxSHwgDFFhXjHVEzwjpteXzAc6uPwz=FFdWs_cg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gazz3JxSHwgDFFhXjHVEzwjpteXzAc6uPwz=FFdWs_cg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc1-2
X-PR-Tracked-Commit-Id: 4b27d5c420335dad7aea1aa6e799fe1d05c63b7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3062a9879afbca810d9f1613698963ecfcb35701
Message-Id: <169912449411.2096.15814675613023825068.pr-tracker-bot@kernel.org>
Date: Sat, 04 Nov 2023 19:01:34 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Nov 2023 15:45:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3062a9879afbca810d9f1613698963ecfcb35701

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

