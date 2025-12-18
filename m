Return-Path: <linux-acpi+bounces-19679-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD9DCCD9A6
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 21:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D648A30D64B4
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 20:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06837342C95;
	Thu, 18 Dec 2025 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFqQ6LTs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2587342538;
	Thu, 18 Dec 2025 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090591; cv=none; b=YyToetZ1kZRyBWpFZf2xM7KBipVQr94ERUmIwKfO08Nv2YtRFhtHNQxPopDNpqbgymvgu25mw00rie0wptR3PmNFJX2M8u5HSDT8kf2GTil8AWf4ancN1GykX8nvEx3Do21EiaRTA3quw760IZ7OlJmp5/lV2wRpuQq6WMSCNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090591; c=relaxed/simple;
	bh=VSTC3EDTtpWAsWi6AUq7/J2OoR8UKuNRsRuv4vC7RWM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rw88a/j5QS7vWTtFR3WuC+KcgUXBLiZBfai/o/l+1OEwLXDtR13wUj9MUkiaWL6WtMh1ThrLw4ISgN8HC0tDnvkj3kj22uhB9XJ6FTo8lAN1kMusXuuGMoN/k6GW1L23cW+bsGsURerkNwzZh/1qhZTWLUp5w+haefTp+7Tw7gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFqQ6LTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31FCC113D0;
	Thu, 18 Dec 2025 20:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090591;
	bh=VSTC3EDTtpWAsWi6AUq7/J2OoR8UKuNRsRuv4vC7RWM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lFqQ6LTs8oksJgYWx3dnuSPi9g3DxRlIdY2kEohLC5nlWAy7WA+Mmi2/Daixap/xR
	 BySDUvqBdBM+bMN67Ypz978FbbFNJOoqWY25/oONxJYni2bd0X944NQKU5OUm8HvK/
	 rEDurB8yjboCSGq8wZCjZtBH8IrlrXAt5/wGIPGW+Ub/5Is+eUIgt5CEgvMemTSIgS
	 oyKBIKv/iJNT4VY583Ffpqx+hACAP/NoExWQvDsnc02L6oTMye5UQ2FYoRnQPZgpxK
	 ynVj5Ou4LArKti1zvgipFnsARivLLV2RBfNDCWhopj/8cUAx+dLLzO+wWbZ2xdMQCv
	 EKPZrAI/N13Bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BB00380AA41;
	Thu, 18 Dec 2025 20:40:02 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.19-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hDvMiDFZ1B_bcn1+bHBma0qtjw11rYJycV0JevK9DkbA@mail.gmail.com>
References: <CAJZ5v0hDvMiDFZ1B_bcn1+bHBma0qtjw11rYJycV0JevK9DkbA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hDvMiDFZ1B_bcn1+bHBma0qtjw11rYJycV0JevK9DkbA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.19-rc2
X-PR-Tracked-Commit-Id: f103fa127c93016bcd89b05d8e11dc1a84f6990d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5caa3808bc29de989f46451124e109dd33e464c6
Message-Id: <176609040077.3123765.13332430992211691014.pr-tracker-bot@kernel.org>
Date: Thu, 18 Dec 2025 20:40:00 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 18 Dec 2025 21:04:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5caa3808bc29de989f46451124e109dd33e464c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

