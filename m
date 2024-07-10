Return-Path: <linux-acpi+bounces-6846-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC1992D60A
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 18:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAB61F2787B
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 16:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961EE19538A;
	Wed, 10 Jul 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZka0n7F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3F0194C88;
	Wed, 10 Jul 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628053; cv=none; b=Ovv296V89vAdDPojiqZAkate/BY+olc5YrNJ2g9GBSu4XjnEkSFMgM+sT8iVwwiLShPOsmWwWmkIl0t7tZA5djN/aPvcyrGocIwAVRtYDCsqwP5Tvq9ziqnODReh9Rd2og+lrh+31C8XSsgdlrtgA0r9JlNoQZ0vD8dvP6UPIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628053; c=relaxed/simple;
	bh=SjTjBdweheKicF/CDtZg1wfcwWGjPE1oFaNg8QtQhr4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=segmVFGU/uExs7XUEmHbzRAk5VtPHbg43rKlikma2f8jx8XvMPRrjwq3FM0aXqT/UaHayrONYMnimfOektdRuyWpLy8BJpTZQ/hsNOpjLoH2347DEph8/KyGgoGjPs+jOvukuf64UQubNujpzSlNoMqK+UoMbD5QfXcoJxaZeBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZka0n7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 434B6C4AF0B;
	Wed, 10 Jul 2024 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720628053;
	bh=SjTjBdweheKicF/CDtZg1wfcwWGjPE1oFaNg8QtQhr4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MZka0n7FygEJZkIvwPuD2q1wTw9xppuU54yheDyj+wZM+srSvyLxLkar3Z2R1p8xu
	 vhdhexRfgifUyRXSbva4EF9U5nEOLVZCY5BXrG3R47l/6HJUhA+gGjCRANBKKUOqs8
	 TGtyx/jaWDDq1ntPkrMqlIkhmcCMhKgWlzLFtoI0WtFjIygcoNwTDMzFyIVvlMzW17
	 S/TeHUjQVYsZOLEpvRmD+aOwIf+n8/WyFnIKAFIyLC1L274K7lMHi1nK8UdyX5yHn7
	 Cyj8FWulzV9SLM+YiplVCb3eAS1e+o5eKhXps4Mb8OoqtRfTalf9lnp9ICjMr03f4C
	 qoRWxvB2Xr70w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EA62C433E9;
	Wed, 10 Jul 2024 16:14:13 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.10-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iDKW7jLS=mD3dGqAdh8SuNsCe6Eq83DRoCEY5ATseG4A@mail.gmail.com>
References: <CAJZ5v0iDKW7jLS=mD3dGqAdh8SuNsCe6Eq83DRoCEY5ATseG4A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iDKW7jLS=mD3dGqAdh8SuNsCe6Eq83DRoCEY5ATseG4A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.10-rc8
X-PR-Tracked-Commit-Id: 233323f9b9f828cd7cd5145ad811c1990b692542
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97488b92e5172e7a1525cf04b6ed95c404add06f
Message-Id: <172062805318.17113.13134489864357773341.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jul 2024 16:14:13 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jul 2024 13:00:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.10-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97488b92e5172e7a1525cf04b6ed95c404add06f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

