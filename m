Return-Path: <linux-acpi+bounces-306-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB107B4305
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Sep 2023 20:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 1830CB20A38
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Sep 2023 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA4118C04
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Sep 2023 18:31:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FF9C2CA
	for <linux-acpi@vger.kernel.org>; Sat, 30 Sep 2023 17:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57A45C433C9;
	Sat, 30 Sep 2023 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696093336;
	bh=5qGi2YCEHd6kQxR5v93za5a15O1F1SDz0D6DWAwbi70=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mzIetXB/LhtV2B545Q0w6LZC21WllNf7CgngTgJzEUAT/LZlVdeOrzavl7yPGKgFO
	 UrU/UvQPN/p7hN5a+m8vAfIr9F+fFZDQK+akVyvqw2lTJDGQ9MKiPGdX96cmF9JQMb
	 ClAc4c5DsrH/caSneOgcbHHUGtj9sMh5VFW+HAXq11hGVApIRcc/FxwHcFD1VY+Ld/
	 dIvBZCigbPiKWYCdimxXf/ojT9wcXasjA7BoM+T/7cT4s65xJz3NPjvJpNw9e/T9Lw
	 1+pM4azEyz80amHYSu9NSCgr32BPeURZCn7i2bH6NuRWRbuVk/p17RgWKbcK1wBwi8
	 BiDoJVxs7CVtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C78CC43170;
	Sat, 30 Sep 2023 17:02:16 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.6-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gaw_5VdZBL2ZbqMkAXyFTMEAcq_nO3FQaQc7qGBZJi6w@mail.gmail.com>
References: <CAJZ5v0gaw_5VdZBL2ZbqMkAXyFTMEAcq_nO3FQaQc7qGBZJi6w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gaw_5VdZBL2ZbqMkAXyFTMEAcq_nO3FQaQc7qGBZJi6w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc4
X-PR-Tracked-Commit-Id: f4dcf06bc6e0161920b700ba3966411d716a321b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 830380e3178a103d4401689021eadddadbb93d6d
Message-Id: <169609333624.18163.11828807637726153320.pr-tracker-bot@kernel.org>
Date: Sat, 30 Sep 2023 17:02:16 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Sep 2023 19:11:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/830380e3178a103d4401689021eadddadbb93d6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

