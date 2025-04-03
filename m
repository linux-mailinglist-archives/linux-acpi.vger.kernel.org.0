Return-Path: <linux-acpi+bounces-12665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD9A79951
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 02:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9222189425C
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 00:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630F413AA3C;
	Thu,  3 Apr 2025 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxN1VK98"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9B4136672;
	Thu,  3 Apr 2025 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743639071; cv=none; b=P/6q7CBgCEFRMB17mbU0YTTnAWGb0sq+qumxIOwHH5axKnzKFOFMODhoYiEdU/YZUbkJHY7nudiJrdtkfXl5LsrsZzjxMzpKdp1Nv+lJ1pZwnZcRhMv7aAtOmCUQaT/LVJCNUnAI1C3xC2e9Q5mMxBfpcXB1mgHwPPElmJxThiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743639071; c=relaxed/simple;
	bh=nbcEmSSCK6ihTq+DYdCMXcWHleu5c3ROWS/hG/hEOqY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IZ8/jOxuoxGPLuyK81l9/QEbhM1QSN9fBJthRkh1F/CNwWAQtsJeTn97sTheb+oR3pBpiGy/FajeeVU1WKJhwyIHJ0bGVaGBgCpU8fN4EoH5Ac6vN/OE8m2/z0DB98HxVdZkvSYmdJYQDCZSnCX3qaIpNc4MsH9m6DNsuzapJ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxN1VK98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC06C4CEDD;
	Thu,  3 Apr 2025 00:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743639071;
	bh=nbcEmSSCK6ihTq+DYdCMXcWHleu5c3ROWS/hG/hEOqY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DxN1VK98QD1fLQMDx8lv9QCi+x5DNNEhbqN/aegqsoeQL+CW10/xPbsJhPl4VcJSC
	 5+tM2aNpyHdLG9Ogm3Uzl7Tpi61V5v+kh+9dFbdirisQqFRMEtHronsT0oYFEKtpHL
	 mKU/3yBLjn5B0efvx4KICVcfbwuOl5VrzCTC6BYLjIJtw31TM1jg2CAOeyPYILIkz2
	 0fJRUCBg2NpKHijUxjVqvqDSAms48GvAef0EVWHjcMbbqyE+xp2z/nPI6XOuj1KPuj
	 NyLTfG34pHTPasdjsCkPuv8NbhpuZRrzbilVTnh2lLx6cgKhrdCiOkGETPz1cedJ8B
	 PEEjrFwyQ0s6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34359380CEE3;
	Thu,  3 Apr 2025 00:11:49 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gtr2acS0ZNux5TzHrawoxC6jD474H1s-_MHBQPAe3fkA@mail.gmail.com>
References: <CAJZ5v0gtr2acS0ZNux5TzHrawoxC6jD474H1s-_MHBQPAe3fkA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gtr2acS0ZNux5TzHrawoxC6jD474H1s-_MHBQPAe3fkA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.15-rc1-2
X-PR-Tracked-Commit-Id: 5bf46fe2b84cda662062f7aca73e15602c76a844
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e69e6e468a5c273132e9f87094fea1c62e347899
Message-Id: <174363910787.1725867.5473692597871114960.pr-tracker-bot@kernel.org>
Date: Thu, 03 Apr 2025 00:11:47 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 2 Apr 2025 16:59:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.15-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e69e6e468a5c273132e9f87094fea1c62e347899

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

