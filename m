Return-Path: <linux-acpi+bounces-6922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2172393348A
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jul 2024 01:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA510286EB9
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2024 23:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0A5143C6A;
	Tue, 16 Jul 2024 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJwNBjM9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43921411EB;
	Tue, 16 Jul 2024 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721172486; cv=none; b=bhhMqjwtV6OdRPrewu8xGwdOq7bpJxi4gG++e9Q21i2DvzhoorZstsWZktRU9ULEOuMVfiUeg+kz23aOi6YbaEayRM5Z/XFXBhBDJjFr0NvxdDba8yRT8kyNAnY2EM810GIxWxe/F7Skjw6cW7ANuz6KvYW/i0kFjh6E1fu8l5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721172486; c=relaxed/simple;
	bh=3PhUjAInXpInyfpl2Ij75Wq/BbxX3W4g1uMMuAYTKnY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t3H10tfB5UT7stGLxVRtcuRXzIU4aCZDo9m6RPrQqF3SrQeRHInBnOaeysuHz46eANQ2OU2iLRLWdwPNvlYwS6EeFghCsttnxYX2lbEjZZJwTTkcTWnK/U36ukBmf2uNzXAFXCOKa1CkqEIedG123rm/lHyFqZ0i1axR9dKJf9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJwNBjM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97827C116B1;
	Tue, 16 Jul 2024 23:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721172486;
	bh=3PhUjAInXpInyfpl2Ij75Wq/BbxX3W4g1uMMuAYTKnY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vJwNBjM9o5JkVb1ydzfqcI4ooiUwFUocbxdIbh2D+65eq/cCVKTl/6EV16Hs6mmEL
	 m7mYRFERnTg/7rLbX4YVrC8N5fl46ij/fkW8MZoDoTHdm/6LK/bMH4dc45zYU5aehN
	 csin2NnIUmqlljy5Cl3UricjQGiu77UTVUBpcI+tSJLAPhmHqYdtGH01NWuk6sYacH
	 rv5F1D4wTl5VAo31XZn2GuJh47TQg3CL3zQtn6H8+a7z08DMnLIva6WwctJAUAn8X4
	 JiE580uEwJlQ4Ippjt5AJweyfbZlxuB6xbjPjdpg/Gx7lP/5R1LgfSGTU9fwctDEZK
	 6bhaDiaRPnUpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A1A0C43443;
	Tue, 16 Jul 2024 23:28:06 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0guQr816kzz88G8XUjC7fnV9psTVdR_HWyt9D7evA27LA@mail.gmail.com>
References: <CAJZ5v0guQr816kzz88G8XUjC7fnV9psTVdR_HWyt9D7evA27LA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0guQr816kzz88G8XUjC7fnV9psTVdR_HWyt9D7evA27LA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.11-rc1
X-PR-Tracked-Commit-Id: 281cfec53b4484ce2092c89b6909f5573cb23443
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15114e8fb58ffd574da83951e89cb5ab0055cc1e
Message-Id: <172117248655.20323.1630230704673031815.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 23:28:06 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 21:41:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15114e8fb58ffd574da83951e89cb5ab0055cc1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

