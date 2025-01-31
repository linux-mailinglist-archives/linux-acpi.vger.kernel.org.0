Return-Path: <linux-acpi+bounces-10870-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2A1A238BC
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jan 2025 03:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 100A17A37B0
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jan 2025 02:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871FD1BDCF;
	Fri, 31 Jan 2025 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIkk5HdL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31A2563;
	Fri, 31 Jan 2025 02:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738288819; cv=none; b=czPdZl7u3DMsTUlgclM1VUfhxDw7TY0tdiNFnyDiz7kS8fWErwpo0CBaSEcWLVBtlXJXkOxXPEPN9pT+2XBuUvJgfgLmRHlXkVpBZ2w5DorxRcyUT0cXK6bv3isWSAFVuaDaCmh2MG7uJgJvW1T87kbsw7rsCYfaBgO+v5sqA2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738288819; c=relaxed/simple;
	bh=nqxkUKHNaSy7bysESjGps8wbfbs7FfkqJT/U3S5klTA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QKDY2jNRLFpWD4iZ8L5jPjR/3YVZHeWa1dSbnrMNir7zuYu4QYOdIcJTg8SxhWZ3B+8DLiCaVBm/e7KkucV/F8xy1sojBfcPPJrHMsqf1pHlA7iKV4Y6xF+ZEGDM/5k9zDq/+UXWa3EusSp/HL7SKZMMhEZvxeqwXXEZUmK+dmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIkk5HdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87C5C4CED2;
	Fri, 31 Jan 2025 02:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738288818;
	bh=nqxkUKHNaSy7bysESjGps8wbfbs7FfkqJT/U3S5klTA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vIkk5HdL/vZf63l2geDCB+vY5miDesDquipZjWjf0YdPyjJt75AvKzZc4eGtzpU24
	 nyDK+6ivpABhCYvBCT8KcuaK5HPDkkF7TJ5DMwZeSg4jiziPBx2usSjcmylSiWPEYI
	 Yj/BbUgLieJGIbpQRTFmh1wNdLWGizY4dN4uRCmDV3iWapGMcK2JsFp7OS6Kx5rAE0
	 40Axt9f+4vM9pC6K7ml5nWMoTyjywV+C+hvljpRmsDlu3R01RJ6JtG2bv8M7AnmyM9
	 R/OJGUDipy6YSIdAoP25KundcXJAGIJHe4GYT81NiDu0nORXT+cOJfIU1sdfYA2STS
	 lZ3gWJv+pOROQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7191D380AA66;
	Fri, 31 Jan 2025 02:00:46 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0htsHzumnajMzcndHi1C1SjxQXXZp6Sg4qo6mnkftHUng@mail.gmail.com>
References: <CAJZ5v0htsHzumnajMzcndHi1C1SjxQXXZp6Sg4qo6mnkftHUng@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0htsHzumnajMzcndHi1C1SjxQXXZp6Sg4qo6mnkftHUng@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.14-rc1-2
X-PR-Tracked-Commit-Id: 0141978ae75bd48bac13fca6de131a5071c32011
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47cbb41a2e22554ab63ad2d6f36e9cdacd8cdc11
Message-Id: <173828884501.1145982.5409773937003674525.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jan 2025 02:00:45 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Jan 2025 22:06:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.14-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47cbb41a2e22554ab63ad2d6f36e9cdacd8cdc11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

