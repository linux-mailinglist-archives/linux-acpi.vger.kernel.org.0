Return-Path: <linux-acpi+bounces-8311-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743C6979AF1
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Sep 2024 08:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5E32840DE
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Sep 2024 06:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9C57F7CA;
	Mon, 16 Sep 2024 06:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wc888R+W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A6D84D3E;
	Mon, 16 Sep 2024 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726467133; cv=none; b=epo4tKheknR8HpO8+yklIQviun1avJ5jDhQHjmYhkzyp4CNxBEsSa0VZP2shlzhjsHzJCfLO9/XDiI8Q0puArmWxW3+gj6tA5tUV0lbSb71jwShpYPpu9We7S8mbkGE/0or7PTT7XFga3R+jISXoZDcsYXsYlr7bEesqmlGVkLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726467133; c=relaxed/simple;
	bh=6U+O42GXl95GoPSdDNWlQYYiNIJFoebMg67ndyAaDt8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lx902C9ShBsuBAjYakJB/tOFLopyy9lu2n0198Pa2rsTTmrVNiMcJqHLpmEMaPm1j4IIZd67KKIkYldfSLmnOMa4B1FWJ6MoV6t/8lSvKR6XlwiaMpEJJ/fy5HHicdAw5R0JT3GHD3NhurMsgbAKR5d42byJ2gX4b4bd9f7/7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc888R+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5BDC4CEC4;
	Mon, 16 Sep 2024 06:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726467132;
	bh=6U+O42GXl95GoPSdDNWlQYYiNIJFoebMg67ndyAaDt8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Wc888R+WdyKpa2WONwJFAXFkOiOw0FdBZD1LkZ7mZOGEY9OK31sH5xvMqVdt5FGCk
	 HOhsx7lgMRkWnfHCG4RkGTZFQCCn2vx7YeXxwVtP/F+pKX3cGpcTer5Zvxk7FqaP5P
	 yhOERh/wq7ldEr6VW7gmwYqLGyxAU7IRiAds6Sb/V2BHiz1g7/BqCzg5kqKLsnhMS8
	 nBJT9EpYGW3tsQYKzWGXTCiiIlm1dX7RML8s7oj0QvFCqajzCybFHbc2g4RtfufMLL
	 rbfsBWOUTaTEIt/oM6a8aJ1op+n9r2rYWlzUUwEOA1SzDdLMRcJ0Rh1GxSPpfkutJs
	 d2ipY9eu6jPiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710383809A80;
	Mon, 16 Sep 2024 06:12:15 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gJXBx0jM4n8eO3-_bh1xcCaZVCHRA2K+Y468dFSJf4yg@mail.gmail.com>
References: <CAJZ5v0gJXBx0jM4n8eO3-_bh1xcCaZVCHRA2K+Y468dFSJf4yg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gJXBx0jM4n8eO3-_bh1xcCaZVCHRA2K+Y468dFSJf4yg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc1
X-PR-Tracked-Commit-Id: 0a06811d664b8695a7612d3e59c1defb4382f4e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02824a5fd11f99b4637668926a59aab3698b46a9
Message-Id: <172646713395.3261404.4212782517264770390.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 06:12:13 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 20:08:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02824a5fd11f99b4637668926a59aab3698b46a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

