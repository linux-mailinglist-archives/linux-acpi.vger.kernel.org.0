Return-Path: <linux-acpi+bounces-15693-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E836FB26B96
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494C21CE4CD2
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B1523AB8F;
	Thu, 14 Aug 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwup5duM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8CEEAC7;
	Thu, 14 Aug 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186530; cv=none; b=em5q+wWTWmKxnMu+3jUkVbo7xtMmwktSB9aiPDFkO+Mh0Pgtww6+/iSuyMysHI/HlEieqm/gRm31Hfm+ZQ6Yf4ON4qpG4NcgaSF8JTeB6TsFOKIRKWXzoL9dMS8cy2XkAc0BdE4lu2cKUo92grwUNXtBuh9ji8kd2s47Q/OjJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186530; c=relaxed/simple;
	bh=NvhhLUBU9wcMg+SxKY0s8NNDzWIP5qjfKIG6KfEhlfM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RKKM6LKUwaOctR/D3hrY4diH0JNiFG7AmwcHIqGzX/YgE4VFJU6yGILIaJLUyIEefVqb1Up1SQiRwVE5QENVsgjJGzVpG0uQDId/dwSg9W/AvXfxz6p5SIMVUztkdy+6xVuvbGJZIbMdb7EEY0YtaSDCDsCnqJ0MT3VcAJzEhk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwup5duM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D347C4CEED;
	Thu, 14 Aug 2025 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755186530;
	bh=NvhhLUBU9wcMg+SxKY0s8NNDzWIP5qjfKIG6KfEhlfM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Iwup5duMl3GTq0bdpKdFiisYLA5gpooGy+7MDBduir/I0KVhucGBCcQ6XkdFhMy6T
	 xVJUWx1gZ8WyAFPV5ggmY/RXhiRI1KLVCq7TqOdS09nV+uEh9hj6X7E2JD9vjIYssS
	 9q8eKc6Yg4xEGF9qhzRTEM0W4D8LfjJneaoL09fT/1+o4fXiMRboFzSiMcJL9C1I+P
	 9C828/Ue9Wp/rHlnisbfqdkPNbOqP3UwJfU21S67+FBHU5wdw3CxWr07lgrNJMh93o
	 +PYxlG/iptoU2zle1NuHgSFavG35Sy8fMXyVc44mT+twsYacEm+HrYdT4h6i409hjc
	 5xmO4NriQiNHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3477D39D0C3B;
	Thu, 14 Aug 2025 15:49:03 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0joXWwzmEXh9EUgMERgdbCD32m2M8VMoFVrqVEGKmLXLg@mail.gmail.com>
References: <CAJZ5v0joXWwzmEXh9EUgMERgdbCD32m2M8VMoFVrqVEGKmLXLg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0joXWwzmEXh9EUgMERgdbCD32m2M8VMoFVrqVEGKmLXLg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.17-rc2
X-PR-Tracked-Commit-Id: 5302e2a3886c830b803ae3390b9d41d35832f315
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c28d28a7b005dd6459a6059dc7eff684bf0b7464
Message-Id: <175518654167.350189.266785873397390633.pr-tracker-bot@kernel.org>
Date: Thu, 14 Aug 2025 15:49:01 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Aug 2025 13:32:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c28d28a7b005dd6459a6059dc7eff684bf0b7464

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

