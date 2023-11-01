Return-Path: <linux-acpi+bounces-1124-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C47DDAFE
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 03:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3821C20CCE
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 02:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A314184F
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 02:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lljfK6Et"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761A1390
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 01:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C6A8C433C8;
	Wed,  1 Nov 2023 01:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698803060;
	bh=ykrvRfuuuojPTwHZrO0/0npa0Uw8hmBeyHA5txm1BJs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lljfK6EteIHJpDK3eH2LEz2PaJJtZ7oYQWez9z7rCTklyJ5wOgcsCuV2Q4keUnqwo
	 +izY0WdjVtUfEODnz1wcrdwU2w2CvJvrO3iyToiDYd34DhKb2wjNmj3SFn2gDPbfzY
	 BhNeNAw2ngZVaNg6tLso0EijH6IFwyvNC2JSXlq4MDRqbV1IomlVbjvLR6f+Rb/TuZ
	 IpmWPL5xFqeOukTZ09t8cU3sYNm2N6uQAnS4oH54fZ/GQe5ZltO7oCNk2Vr0nxGP0v
	 0W7ZeOVgPFy2kOP/fWP9m8nAZ2cr3mHSctmeZMiXfKMnXCZNKOoRNCj2ZiC0oBZvxo
	 qxlzx3l0Yy0tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 726F7C3959F;
	Wed,  1 Nov 2023 01:44:20 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jT7CKsUtTY3FN=GKBZkCm5naHVEH43vS+jonTrvy4gCg@mail.gmail.com>
References: <CAJZ5v0jT7CKsUtTY3FN=GKBZkCm5naHVEH43vS+jonTrvy4gCg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jT7CKsUtTY3FN=GKBZkCm5naHVEH43vS+jonTrvy4gCg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc1
X-PR-Tracked-Commit-Id: f4cb34a75e4a4aee09ff832ea2147cf8322a6a7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4b671d4c66cd57ccebeae659d9b18e28a4fc9e8
Message-Id: <169880306046.15034.15335431795917861803.pr-tracker-bot@kernel.org>
Date: Wed, 01 Nov 2023 01:44:20 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Oct 2023 15:50:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4b671d4c66cd57ccebeae659d9b18e28a4fc9e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

