Return-Path: <linux-acpi+bounces-2243-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C8480AE02
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 21:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F994280F88
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 20:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D6D57889
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxJ35/V0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D5F51C27
	for <linux-acpi@vger.kernel.org>; Fri,  8 Dec 2023 20:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C886C433B9;
	Fri,  8 Dec 2023 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702065615;
	bh=+mg2Ycx/25evKO4XjrlZ0RIrM2NqEraXGcSh2peU0Z8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cxJ35/V0N8+cuXfI4TuSp6fjXDF0ZY0EotqsdwJ0Dn4TPumlFhhDrlaGIcmzp0wQc
	 yAknZ0yTD8yqFXzckSmd8eqExOJF/TULw9e5Zp9dj26+HMw+3Fq3Tqk1OaCNSfrrmP
	 x9DPgWB4PZ1LCVHwCxMK0UyCWFbcFRa/Hja28xzauYZ0kRkF5JOuFGixEl7Kn5R5Ic
	 RL+X4zZtGRDh99dK+KLHWvbDeVsTrLdm9FDs313wJucI0PMxdjUqY1L+WIncrF6I4S
	 pK+k9Po+S3E/MR2fFrqwpxXaDxPG/Jeiyf8It/DuHeO6psKgsItyTqUAbL41ad4Acy
	 mV+SDos8A/NWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 390F2C04E24;
	Fri,  8 Dec 2023 20:00:15 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.7-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ja548sr4QjzTgpNHZLMsNC_r8GY6Jys3sH1Y3jsXqK3w@mail.gmail.com>
References: <CAJZ5v0ja548sr4QjzTgpNHZLMsNC_r8GY6Jys3sH1Y3jsXqK3w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ja548sr4QjzTgpNHZLMsNC_r8GY6Jys3sH1Y3jsXqK3w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc5
X-PR-Tracked-Commit-Id: 8f0b960a42badda7a2781e8a33564624200debc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3e2f9bda2ffa2dd7dcaf2b45604db08c6ab0579
Message-Id: <170206561522.12654.8671400626734986914.pr-tracker-bot@kernel.org>
Date: Fri, 08 Dec 2023 20:00:15 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Dec 2023 18:55:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3e2f9bda2ffa2dd7dcaf2b45604db08c6ab0579

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

