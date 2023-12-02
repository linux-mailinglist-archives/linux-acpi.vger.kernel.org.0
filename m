Return-Path: <linux-acpi+bounces-2086-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698218018FD
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 01:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E5DB20D53
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 00:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2231FA2
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Dec 2023 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOuATeh2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A3800;
	Sat,  2 Dec 2023 00:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03D6AC433C9;
	Sat,  2 Dec 2023 00:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701475551;
	bh=TgggRG1TMqZFiFbd5FDYfIrnrqqA9H1+qPcZXxXiPGk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mOuATeh2Kp+uOiJdekFKZ7l9n7EZ+b5ZzeVg+5GfKkr1l+sHdWDPILwLNdISdhSv3
	 /YpAb+u8NVVEH0wgytt6NQ/ihsJIljm7Pda7ku2LjEpabb10enmmkBIedUm5uu3Q8C
	 IU/K1bfXNkWh+FipHVv0pZ+ORAGY2KY788zFa4EUehT/aF0XoiODpUGu4O/9EsLHDQ
	 r+h6iV+0+1sG1PomhwJsWRFlPwT6RjOhS5ZnUNU+oQ0yZNCT0C8iqRHjCotmjz4Q8X
	 Ltxe92CWvwhLN8hiEfPLGboxalS9hkJvVLdhsQA4mfOttykh/ZkmdG0HBbetmj/DIi
	 zwcGQVPtEG8QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D74B2C73FE4;
	Sat,  2 Dec 2023 00:05:50 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.7-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gCXED78oLB7wPJ+bn0keQvYzZhyk-XsQVUJrP2i+c-xQ@mail.gmail.com>
References: <CAJZ5v0gCXED78oLB7wPJ+bn0keQvYzZhyk-XsQVUJrP2i+c-xQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gCXED78oLB7wPJ+bn0keQvYzZhyk-XsQVUJrP2i+c-xQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc4
X-PR-Tracked-Commit-Id: 7d4c44a53dade7103c3a9a928705db2326efba6f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce474ae7d006e4d451d8b9e23ee8110499edb62a
Message-Id: <170147555085.9445.6777555479344897778.pr-tracker-bot@kernel.org>
Date: Sat, 02 Dec 2023 00:05:50 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Dec 2023 22:19:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce474ae7d006e4d451d8b9e23ee8110499edb62a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

