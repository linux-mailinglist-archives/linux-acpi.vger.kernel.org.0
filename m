Return-Path: <linux-acpi+bounces-15898-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CD5B306AB
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 22:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 924094E6825
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 20:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46C8352FFB;
	Thu, 21 Aug 2025 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtFFfiWF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B4352FF7;
	Thu, 21 Aug 2025 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807992; cv=none; b=iv0OfDpJgh3wHRvhv23xeObpSWkfgGQVaRbOiw9xhZsspQZeIjOtTeoMjRwcbNHmP696rAcxbPRod9NL+hkvtVajt2QuOzJ84SAxNCVJFAD9+H+VTbvkkyZYCqPB37n3arDJ1DyjikyUy8M7soCHGnBzZKToupHSK46Ns6YWQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807992; c=relaxed/simple;
	bh=7b4yk4K0Aw7dhO4KySnL0ggE5L3/I2MqXsSMrDX+zKA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=T5qMeJ+QyEHK/IFre9DQgVtCCr1zZrd59OOGLtgclAcYjgw17Lufco/dnBzQVhUxJw44ABiad77ohf/JAFaYMrDSz2cfUMcEV+i+xZdW8VZmniTPOnp4W3W6ZyfyvRWFuVfnP/XKksSjNQFIhAQcSmeYo4c5T6C+agphWY8fwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtFFfiWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D68C4CEEB;
	Thu, 21 Aug 2025 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755807992;
	bh=7b4yk4K0Aw7dhO4KySnL0ggE5L3/I2MqXsSMrDX+zKA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LtFFfiWF0DDOtj6yhsSPo3D2yPwaoSn/3qJfp5joN+oCG/jC59pORFcwJfsx/UlaU
	 aNhwzFqch3b8na2xGjNG0YOLAtgW2EApR5p0ugjdqHNLZ1svk+kMzCG6hb2vtAxSw3
	 o8n7uOlWIYixCArSafvxYKZekGxQZVIaiRZdypKRn/eflm58utzGRvuza2Z3NTqmbV
	 OtXXQfkQVKwQL1zaLd8duIURmlSMekOYElwi97J+1M6k7WkMI8JdsVFTsqYDkVX5pO
	 CPh/Gr3+V4eFNa8ES8RNjpy9S20lVJxfUpu7Ofgq9jzO5VtiJJKT4WeDOB8zDx/VY7
	 iaEMrxmrCXzyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB7383BF5B;
	Thu, 21 Aug 2025 20:26:42 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j4Df7055nA_niXzhonrE2QebyQFzEFY5FVYb=M5F1B2Q@mail.gmail.com>
References: <CAJZ5v0j4Df7055nA_niXzhonrE2QebyQFzEFY5FVYb=M5F1B2Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j4Df7055nA_niXzhonrE2QebyQFzEFY5FVYb=M5F1B2Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.17-rc3
X-PR-Tracked-Commit-Id: 670b51121ed09ff3a41539243407e4bd52eea9f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f70e1e7980f3611039d7b9a1b34beaaba1054af7
Message-Id: <175580800112.1187953.8578654001524806675.pr-tracker-bot@kernel.org>
Date: Thu, 21 Aug 2025 20:26:41 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Aug 2025 21:11:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f70e1e7980f3611039d7b9a1b34beaaba1054af7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

