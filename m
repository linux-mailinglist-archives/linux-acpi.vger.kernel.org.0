Return-Path: <linux-acpi+bounces-9248-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AC49B9810
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 20:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640522828C8
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 19:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3E41CEE8C;
	Fri,  1 Nov 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omMVK4QP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018B14B955;
	Fri,  1 Nov 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487976; cv=none; b=YGWC9EKyJ8J1jT8tF+A50AS9u1EEWSXROI1s575xEFHH9INIoudgLlAkXZ+gCk6MEx9snCwPgG3Yyo92TjCVLnImgBLEMJa+EsbjWhjRyl6n4EEl/cBNXfJQ31wxAxHxObvLP7LwMsiOkcUm9alP8sA5CLRPJ2STVpfeZTjE2Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487976; c=relaxed/simple;
	bh=PPQS4AxEegfCusCyi3JHOpXilm+ZIMNfhZK5KI/EZNI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NU4l+gTwcA9QMew/ve0QV/RpP8Fl2taPgNX2zUYqiIPtxWHrKxDWHthHdIk5+TWwm4MsCXzLwX0YBdsLsdfQDAun/JTxjW3rT0w3+/ujaXwpTQbfkemecUkv2K/38w+/U5EIj5KTjkkamelMeCxvhSBM37f900D5LpbM3gQFuCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omMVK4QP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8CFC4CECD;
	Fri,  1 Nov 2024 19:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730487976;
	bh=PPQS4AxEegfCusCyi3JHOpXilm+ZIMNfhZK5KI/EZNI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=omMVK4QPl/3LjQ9kqLRbM+xnCBp/0W/uFSxegf6+ahld6N+DUqPmso+kdrcHTPYTG
	 QluCk9nM7c+/AkYrWD3SmsCt8PhhrCW8moti3/HzvW2wX9ZGeaW5Ccvh0QDu1jH6Rf
	 xEUMPGz8tnacFvDgGM2znp845aoY0U949V5VQSPPxzHBC6hb0/LQuw/PVFkdSb9OE6
	 SCnbZJ3Rbs+rHvXnthVb8sRuEyQ7931eHfaX2Ng7MYRBy5fDlFEgeJdOzNOTDi/94U
	 GSki4VXnJa2TzhHUY+kTvg0j8k13SPsQYa8+23yg23bzuyUvN/necIdtf1W8AcVgxY
	 rEksnzFRvVvWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB08D3AB8A94;
	Fri,  1 Nov 2024 19:06:25 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jFxoRAoUkEGmUCg3-H4qhhNd1g4-w05bPnpgJndfDDWA@mail.gmail.com>
References: <CAJZ5v0jFxoRAoUkEGmUCg3-H4qhhNd1g4-w05bPnpgJndfDDWA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jFxoRAoUkEGmUCg3-H4qhhNd1g4-w05bPnpgJndfDDWA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.12-rc6
X-PR-Tracked-Commit-Id: 1c10941e34c5fdc0357e46a25bd130d9cf40b925
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c426456857fa0957d4ef62cb1410b5e91a08aca4
Message-Id: <173048798449.2811397.14821509686581811287.pr-tracker-bot@kernel.org>
Date: Fri, 01 Nov 2024 19:06:24 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Nov 2024 19:35:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c426456857fa0957d4ef62cb1410b5e91a08aca4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

