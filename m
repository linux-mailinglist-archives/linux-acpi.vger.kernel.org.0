Return-Path: <linux-acpi+bounces-19169-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A2AC75FC4
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 20:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9CE84E14F6
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 19:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9102D35B132;
	Thu, 20 Nov 2025 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPN3Xm11"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650883587C6;
	Thu, 20 Nov 2025 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665254; cv=none; b=Mc7pqiqq7RFMLaevLQyBW48GCmdDrCWeb9rVG5Z2pM0kUYLGTh62S0pcx6bhEJSqxO9peYsZWHroi0jawfc55A4MHtnPtLsCwMH8vsJVqXqn2g4n2e/WLrUYTs5Po6kmL0K5hgg1H/LRM1TbJVC6wGXtTqzteCzMZc5aryDWWZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665254; c=relaxed/simple;
	bh=/YuINHLWPv6/KAd3ycGxChlCb8WJFwEngIRVBo94uvk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HJctxXAvNF66s8LQ9Q+4vYsELEZLZjL8Nq9vU0THkOEws7m6oV/IYDb8j6K8HdkN8BhgOHJGywe1qG3K+MKGMY7FSO+13VeoGksnRvgQF1LgR+SA/CqB5eg3UKUOsAOMEpjBr0vXlq6DpRnhPLobZ3gkreAjFt6XrTUXzSQKo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPN3Xm11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D18C4CEF1;
	Thu, 20 Nov 2025 19:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763665254;
	bh=/YuINHLWPv6/KAd3ycGxChlCb8WJFwEngIRVBo94uvk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VPN3Xm11tb8/oyp/FmBgAiHtaANZd6xvU0GHdgxZhwRe98wqsgQMkv6KiJmQtEE/L
	 wSAwCD2aGMfoe21GcM11OuJ/ag3htSAIRe3I4vyHYZfH9KhOD1WVDWoL1V/x0Vbbi1
	 mWMk/6fiUPoQ7jV8nCNvNrC1cOA5o/2qbqFXo5xwaGapOM2nJPt9d8I0whtc7tBYGP
	 5I7C0B1NSqGm0Qi2p/xXB500kM/8FxMT/61zHdzlORRmLMvu0f0MTmKGmYpaAEMnfv
	 pNH9y1/z9moP38XX1xhjZ0Yhh6BhUgRvEQ6A48SvtUiSoxtLCZl1L8rw5y0Jf4Od1K
	 vJrBFxIeJw4Xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713BF3A40FE6;
	Thu, 20 Nov 2025 19:00:20 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fix for v6.18-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iVYQ43L_bvnzyZyO+ArhO9ePT91GetFfFfwDKguxVMSQ@mail.gmail.com>
References: <CAJZ5v0iVYQ43L_bvnzyZyO+ArhO9ePT91GetFfFfwDKguxVMSQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iVYQ43L_bvnzyZyO+ArhO9ePT91GetFfFfwDKguxVMSQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc7
X-PR-Tracked-Commit-Id: d2932a59c2d4fb364396f21df58431c44918dd47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1753d40dce2023405cafd9e3bec169674ed99e2d
Message-Id: <176366521940.1750999.17528207855796577302.pr-tracker-bot@kernel.org>
Date: Thu, 20 Nov 2025 19:00:19 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Nov 2025 18:25:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1753d40dce2023405cafd9e3bec169674ed99e2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

