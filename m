Return-Path: <linux-acpi+bounces-12430-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB23A70CE6
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Mar 2025 23:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909AE17C04B
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Mar 2025 22:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B6A26A09D;
	Tue, 25 Mar 2025 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFfe+gYh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C46C26A094;
	Tue, 25 Mar 2025 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941638; cv=none; b=ArfhGnQbCNEZteUba5CvBq0Gr2RCQ4qairkpLXGXEHlDJC0gtLUkwrzVON0CnN4hL/Vl9l0cYhYY4/tjucnm1/ybdrFDmZ0G3n0b9TnDGLftlCDPIXYVWYxpKN9Uz+MXb3hGL1AM6Im2T7W587yQMPcWtAZ/XnL45vpF4fJoEQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941638; c=relaxed/simple;
	bh=GuR4SJiDIPTjQE1OcmtgKIw4KlueTqFeDU2rpMXXAc8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OwC7pgLYqLCKc7cJ2v+cXrCRZn9+hs0LX1mhJkSDG2ZY5Lrd9ZA0rf5DTj4O2Ui2/x45VGNTTZrreFHE1LGVWrSSXUup8BE5yEcxxAAomeE0Wom6VMGwwZwY87LCTvS6bt8/3NKq1AE814LJc3y+9rgLHMleaRXRPf1uKAVWDJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFfe+gYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB06C4CEE9;
	Tue, 25 Mar 2025 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742941638;
	bh=GuR4SJiDIPTjQE1OcmtgKIw4KlueTqFeDU2rpMXXAc8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nFfe+gYhwvGzs7zBGgpSK5bfyr8yK0SwuMg4Casv8L6zHXfOEoy6wdqdolKvqPiXG
	 wAsgxjEjY8SzAK0/3LaVw5tZmNeU1NPvFvJyJAMDJGRPMNLY7T6VRW262Q2iO8pGOC
	 6La2BLv+Be2R6Rg4aGYoeFXfAIdznnZLHynNouMSgn0jHhjZLpKNIe92q7F5ltls41
	 ZFfI4e9Xlc+Tsejpy5TC+SKgNI4IbYI4qHQ74hcu/P2q9DdWvA41blKifcvjOB/u8n
	 vYVnYgeTMm98hcSGwYlBnP5Ejg9yof5lgeetkR3/QfQvREj4AQJtqmc6vNxS6xdAa8
	 IGwSkWQV2WTQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE98380DBFC;
	Tue, 25 Mar 2025 22:27:55 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hEX-1Yb_u3cjr8sVfX7jOk5puAY9iH-Qzto4UJHvXpfQ@mail.gmail.com>
References: <CAJZ5v0hEX-1Yb_u3cjr8sVfX7jOk5puAY9iH-Qzto4UJHvXpfQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hEX-1Yb_u3cjr8sVfX7jOk5puAY9iH-Qzto4UJHvXpfQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.15-rc1
X-PR-Tracked-Commit-Id: c5a55e427c947f013f08cbbf2be23bd4df2c9590
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d20aa5c32ac8bd272b5470ddbd7ac6e0cb35714
Message-Id: <174294167425.756596.3633818547680659078.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 22:27:54 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>, Shuah Khan <skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Mar 2025 17:32:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d20aa5c32ac8bd272b5470ddbd7ac6e0cb35714

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

