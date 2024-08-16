Return-Path: <linux-acpi+bounces-7634-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA728955115
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 20:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0FD1C2228A
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A741C3F2F;
	Fri, 16 Aug 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6sX9IOe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DCE1C3F25;
	Fri, 16 Aug 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723834399; cv=none; b=hnDN41eM6jxKyDc+Pq+/2n/zwImeFu0xPMwD0qA9d7qXkgPtBc4+qF1Q/FEiSQX4gvMuYYaKqyEI6jvQDP1HcGi5VgKv8YVZauSGMFzUM5z1R+O+6P8Ord2h9UhfYfgVsEZk9c00xjxsS/X0M13KOY70vqlz8X02aDcJKkcFjSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723834399; c=relaxed/simple;
	bh=7ZHxtq9LRbEHLeW2L1PlAFzjkOzeMkSahXKG9sHwY7U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KJsfAr7gyD8/PD2k2UWXE0LR8MFCXLvrr+Nb+jTEjsdgztXi6SeFHwst9HtTeLQgNkHmdE+Z04VV85GUcHyCWacKZSaxibWW+jc8ROz/CLFvnwBIBi7dYOhzSKoxYknYyaSJQtwp52WQhnPo4qZXhBU/HwGJjn5Byw7iJ6e4+zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6sX9IOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3B1C32782;
	Fri, 16 Aug 2024 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723834399;
	bh=7ZHxtq9LRbEHLeW2L1PlAFzjkOzeMkSahXKG9sHwY7U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t6sX9IOeYbkHOI/kuS28xyBTI36kVA6C7K54McBEBx4/wGNn87TM+FXtuK3hauCY4
	 2O62uGlATP1RCDKl6iMoyBFdAi21bnQF3+QDFDrfvaPtvxAF52OxkyhlYPqBHxz+ip
	 w1m0URk3YpYKzrzkl2lZzOjzp8uTWLNKo7IP/M2nRoDlm30p3N6qeirrVJ6S5QNdU5
	 VlnaSnts3kbFxTX6DacC/x06B3zH8cQX2F7LP0HXIeRiNWj0ruyAsaciP3lC2tizOM
	 Pn/hM2UGRtlSZ7KqHXebBw+WX0UZKnaTvBwTJsTjZt7Xz7S59Y+smudrLd6iOxHxbL
	 FtmxwE0m/eZRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE82638232A9;
	Fri, 16 Aug 2024 18:53:19 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.11-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g9-phbMjZmrY36p0joOFhJm9-op9uRs3pdE=cpO54cpw@mail.gmail.com>
References: <CAJZ5v0g9-phbMjZmrY36p0joOFhJm9-op9uRs3pdE=cpO54cpw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g9-phbMjZmrY36p0joOFhJm9-op9uRs3pdE=cpO54cpw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.11-rc4
X-PR-Tracked-Commit-Id: 71bf41b8e913ec9fc91f0d39ab8fb320229ec604
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64ab5e4039cd713afdb7c1b1d6a693efdd2050d8
Message-Id: <172383439820.3603929.7146026755245619568.pr-tracker-bot@kernel.org>
Date: Fri, 16 Aug 2024 18:53:18 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 Aug 2024 19:35:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64ab5e4039cd713afdb7c1b1d6a693efdd2050d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

