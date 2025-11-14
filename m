Return-Path: <linux-acpi+bounces-18884-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB988C5AD45
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 01:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57B40354499
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 00:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E629285C96;
	Fri, 14 Nov 2025 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in67E4pv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477BB284B4F;
	Fri, 14 Nov 2025 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080895; cv=none; b=KlOw6SnmavilpJLNb7yg7Y4hBdjo3qYIAsTjQo2iMQnpcbMmpDn3ffD0b+7tCh3mn5Dwhe5B+JvwJcafZhB/QpqLLFggQ8SuMz57EP6ebiibms4Y128W3GfKCcgqFnbYU+8RCsjKGKpO5EYQ2DJibw/1a/Xvc1ttN015Dvxg1wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080895; c=relaxed/simple;
	bh=YbzOy5m1shRybSun40tlFQm6ibPLM7ott95yaV8f1HM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QVSy7AOgBXg7ezdSaLJbKP2tz3m3+4v/NoX005et8ogvbmdU9vhQ9SD2hAJziI0ZuPTGYRnoQCJCnuRQ27r1fQvxZy2HbUD7V3K41i0Dq+NRxfvGkZR3YpX7LZiH+EkXW1TCQimyJofncfndB7oYmXIP3GaeAlsLKWI0C6Wo4yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in67E4pv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D6AC4CEFB;
	Fri, 14 Nov 2025 00:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763080894;
	bh=YbzOy5m1shRybSun40tlFQm6ibPLM7ott95yaV8f1HM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=in67E4pvmbKYhBbiwY4vP6eaWshOSuglqqbmj3sK3F2A+2JgQ4exYYl9nICjUS50/
	 oSH9FWzHtOq4wI73kXIW1fuJoW/WpciR6AoFbtGtbIoBZnEyzr4whFeHrWpPBCwveD
	 9MWZi8DB+zpSuFW+6x3EKE3wN8wKzmjYO5qbpYfN6onwJ4kBZC1X2Zep9/jrLld6km
	 PpYSfgfdrWjAYV3S/lNoQw5CMUQd+0KIuuYB0IpcC0yl7y6oTYPqMMySZYS0ynYWYD
	 DYcoVYGtFk3uFOEZphN+VNkp23eEb9v10w5tXub02pCeNEFQkPBsDH/lf+D6vidXLm
	 yF+ScV49zN2Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4733A55EFF;
	Fri, 14 Nov 2025 00:41:04 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes for v6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gTrsccUOjqAM4tRoYiFdpemWzsZ6kY=P+r+yDJ38Hw1g@mail.gmail.com>
References: <CAJZ5v0gTrsccUOjqAM4tRoYiFdpemWzsZ6kY=P+r+yDJ38Hw1g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gTrsccUOjqAM4tRoYiFdpemWzsZ6kY=P+r+yDJ38Hw1g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc6
X-PR-Tracked-Commit-Id: 7564f3543cf19b1232553ab10399c9fbf514b5f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a3cc1b749c0808011424c80a0ba5497fdcd5f9c
Message-Id: <176308086358.1063025.5806539171683050554.pr-tracker-bot@kernel.org>
Date: Fri, 14 Nov 2025 00:41:03 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Nov 2025 21:14:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a3cc1b749c0808011424c80a0ba5497fdcd5f9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

