Return-Path: <linux-acpi+bounces-5919-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE138CB3DF
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 20:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386BC1F2222C
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 18:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0CB148858;
	Tue, 21 May 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiJ6jo22"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B41442E3;
	Tue, 21 May 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317581; cv=none; b=UR9JVXfWzu9V7dQwkIt/WcDO0LNFrZKlHKoYeKVYD8ZZG2W4AAKtW46tRJ7wcxzOprqAiSn5RjszUddS0F+9y+koQbSKcDaQhit33y99Sm+sgm337JIJlS58+O1RKf/06IfMEdQmwRgUYEjbI5gdk90UL6x90XUxg/PXI2VKTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317581; c=relaxed/simple;
	bh=Y3dZuNN5JyJkgPvGR61kgXm8bYcgxSA3OcvYWH1+HMM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H3/uUW/DBZ6GXF1alwxYyiFicJhK3INq09bLtXjCea59E/7plUQMFPfmNu18rTno9kJ5qZX7QSf8zNJKW4g0G59nwMUlgeAs1LWO0jXE3A4gwuvaMoGQceUYzhHypW3RyeJNgJGLxjz9NCUSboAURH2SmAbECW8we4mEkFSbdxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiJ6jo22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2BC8C32789;
	Tue, 21 May 2024 18:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716317581;
	bh=Y3dZuNN5JyJkgPvGR61kgXm8bYcgxSA3OcvYWH1+HMM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DiJ6jo22BvXEttqWTaTmWjx1IyVQ5kYwT0TLw8OStD/MPHX8WINZVzaUenR1NOMpP
	 cChezj1IbV4VRDxDbJJHnYZCBE10RnLoxW/YLvwUEFkItMU3Y5TJcgBbja6Zk+H28h
	 8KQreNpmqP0YRYVj+luHrDSdjgS8J77HNvZFtZgPvICdvORB7ajSHHkkrEatX93vaP
	 KuZHpEavLOHmXeeC4pPzym35CSASaLlhpum2TxhaOfNnOTMfhrh7uXF0KOucCT8r1J
	 165chofRdhkUSZAQigDRwzi377edsKr0Pxa9H9QR+qPKwh/HDZEPNOTgG0DuIgFvIZ
	 bmfqUcbM47W+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90CA8C54BB2;
	Tue, 21 May 2024 18:53:01 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gPXNa+DjUbHpPYvBzt3Thdke9rvdbSXEcJ5qXPBQJtpQ@mail.gmail.com>
References: <CAJZ5v0gPXNa+DjUbHpPYvBzt3Thdke9rvdbSXEcJ5qXPBQJtpQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gPXNa+DjUbHpPYvBzt3Thdke9rvdbSXEcJ5qXPBQJtpQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.10-rc1-2
X-PR-Tracked-Commit-Id: 98a83da39b482c638954b111803906843a83a747
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62a12816cb2006776ac8ee9ef026fd99c3a47de6
Message-Id: <171631758158.16717.6415831548092022365.pr-tracker-bot@kernel.org>
Date: Tue, 21 May 2024 18:53:01 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 21 May 2024 11:35:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.10-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62a12816cb2006776ac8ee9ef026fd99c3a47de6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

