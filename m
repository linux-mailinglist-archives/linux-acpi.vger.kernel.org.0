Return-Path: <linux-acpi+bounces-10792-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F150FA1993F
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 20:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442D9167A71
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 19:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A455215F78;
	Wed, 22 Jan 2025 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asJuEvkl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A40215F45;
	Wed, 22 Jan 2025 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737574852; cv=none; b=n/1dU41EAaFJCRxlV70ZSAv/SQvRWVPuEa8/5OfFHonhVJNC8z/E6WMR+NtZmGEIxLnQouw37IFjeRDRtuDkEwpylx+/aPeN8Yr/02UX5MuLYhFwMbP8Wo9/9sOwbty/II8amBS+jURhxF803pgZQV/4+RBYNWm5rMTFyFMR79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737574852; c=relaxed/simple;
	bh=i/voMi74ofaKZizAPw0w7OwobyyBw2h0Js+CnE/Br04=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VZP9V9bfez4uE7vHKitowzyjZSPqBfAqa/fWF7Mi1Zz/1Cp+Uo5N3ePI+1G91he+zoSLmG41Aw618c6Hjj/oC39AmQGSiv3DFLoBC3KBpYvE77SCd7FPqNqwJZriCtZO8WtVSddrP/ppwMzMdAFgNYAV6V1zxHkj1BDqiDjOQaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asJuEvkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7B7C4CEE2;
	Wed, 22 Jan 2025 19:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737574851;
	bh=i/voMi74ofaKZizAPw0w7OwobyyBw2h0Js+CnE/Br04=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=asJuEvklfdBKkXtlrYZDA0mrCGMAeONJ8XThD5VwxYkjiCMzaJ3crNGl4+t4YhT9R
	 /D0g2XRKA3OSlN0yHaRKbDFKuTvKq2GAKo/F1LQKb2K4cCSvlTLVLObcsZhuAzOuqE
	 IGrQjJEUJwxIyrccT8SV4+TNP7U7pcTNaCHWpxm6cwiFYPQ35mJX0Gd6b7CPIdBsk+
	 2yWVQs1qvISiNVBwMvOW9oyRUHQsBxnCoRPiigwMPvtsmJBSC0GTRGXN5fI89M4HdG
	 Elp07MQN+T0x5ocDjH96Kf8D4aavuHKEJhK3jjA+J8qnagc0Y3IiVPtRjkTqkU0LJi
	 OxRcTjZ1Z1Izw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 65FB8380AA6B;
	Wed, 22 Jan 2025 19:41:17 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i4eh2z_8vDf6U+Ro0V+221wA8BL656kpREgvMWYR83SA@mail.gmail.com>
References: <CAJZ5v0i4eh2z_8vDf6U+Ro0V+221wA8BL656kpREgvMWYR83SA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i4eh2z_8vDf6U+Ro0V+221wA8BL656kpREgvMWYR83SA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.14-rc1
X-PR-Tracked-Commit-Id: 1c91c99075db4e31fb5cf0838ce59e80ecd51eab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4b9d3bf44d59ca4489bd8c489539c27c02e5c6a
Message-Id: <173757487618.794141.2159577501865242466.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 19:41:16 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>, Shuah Khan <skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 22:04:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4b9d3bf44d59ca4489bd8c489539c27c02e5c6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

