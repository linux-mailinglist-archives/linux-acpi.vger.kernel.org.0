Return-Path: <linux-acpi+bounces-9765-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EBB9D6773
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Nov 2024 05:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAF9281E42
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Nov 2024 04:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58734178383;
	Sat, 23 Nov 2024 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsBfMaC0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24254175D4F;
	Sat, 23 Nov 2024 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732335032; cv=none; b=lX8K2amMXvD1Z/gGLUsZsH/rz92KQrJFH9PkuNWcdxcISqt02BhMWFMBYI2pquy8FhUuWNQCzpcK4nRpfCr/D57jl48CkgjiqJ8YnkaoExlaxI2lriYea5e9fzU4ictPXklTiSsMGWb3xuz1Q1RHOUUXIAL/pTWhaI9I1DF5Kpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732335032; c=relaxed/simple;
	bh=J+qI8O4vMngVfSfA+n7ElaLg/q3yIfjNY151GO/kOCg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YdvUn4vF3N567v85Hjo34ORmW2q4BaEqjGsA3mGqtob5m/SmYIZ5BJlg7+Kn5kwY6eiesDzehbpoIdOSwNzDLTFMFpzKPDv5Hu7mQYXlN3rRuIs15VLQGfH7ZuxOUyzjXL2a3CxFLXR/NM1CXjmS1ZM2RtsIh/61RKW4ygUfv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsBfMaC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008C2C4CECD;
	Sat, 23 Nov 2024 04:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732335032;
	bh=J+qI8O4vMngVfSfA+n7ElaLg/q3yIfjNY151GO/kOCg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OsBfMaC0YSUGbLO/ywhExvii48WmVtRr1s037wnSbksHxQwEubw3wdOgAXjQ7frpx
	 X2rd/MNk3TLFLUeiKenTjA1led4FdXJlmoVkCNsEDew/Z1lidei8mCw7mXtuLGMCab
	 j1ts4Dq0OUZwjFFZ3KzAI/2Td0Altf3eqdNAIVMWiB8Gkv+QysoziW7Zt1mQShmNgF
	 DoTt3vBu1PLMR9mK0nAlP76R6yNslt75Xn9FhwmWUZR/1HnCRI4q+zNGImrzqcoVxC
	 OhF+lh3pSWERwPZPw0NDnAxzzWZc9wDCxpjEOw5bndSsw/reWCs3WDwsiD5/vx5ZLC
	 u1Phb8anrHWDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715943809A01;
	Sat, 23 Nov 2024 04:10:45 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hD-P3fK4qiZeu3xqnV120UtBiiH6UN4PE5xBqQfOZQmw@mail.gmail.com>
References: <CAJZ5v0hD-P3fK4qiZeu3xqnV120UtBiiH6UN4PE5xBqQfOZQmw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hD-P3fK4qiZeu3xqnV120UtBiiH6UN4PE5xBqQfOZQmw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.13-rc1-2
X-PR-Tracked-Commit-Id: f3e66e78f2ecb18a55374f7d58030556b751dd79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f9baa9b92c2e4e28e385fa581f0511621db3f9a
Message-Id: <173233504427.2897203.14549171937432815255.pr-tracker-bot@kernel.org>
Date: Sat, 23 Nov 2024 04:10:44 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Nov 2024 21:26:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.13-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f9baa9b92c2e4e28e385fa581f0511621db3f9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

