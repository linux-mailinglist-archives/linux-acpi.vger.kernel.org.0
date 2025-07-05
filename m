Return-Path: <linux-acpi+bounces-15033-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79068AF9CEF
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jul 2025 02:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7CE4A5F14
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jul 2025 00:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79381BF58;
	Sat,  5 Jul 2025 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGMSPb9r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A75383;
	Sat,  5 Jul 2025 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751675632; cv=none; b=aJwJ5vTZPG3MvdgjjpOVoy0V2QwDE6J/Xj3HCwv9MWqJInS8J3FLXs36AWr+ERCqoP6bht3x7oSUPyaIOMxg2BUZqNfMy/NcMlGWb8+nBe5orpJX8JOC8l6mfIkrj6gbHc+SLYbRE6gEwpnnpVqXikdwsXeB51thxPhzcS+woTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751675632; c=relaxed/simple;
	bh=fRjeJIWAa/F9KyIs6QeQtVIl4Qi9wTg+6lbQBrmkPWU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ldEhMb3EggB1XXahh+aixqprEvuWFRrIbku7DT9dpA4k0xxBj2HrcfyNVRdU2ILoFGNAaS60GNiXTEq60O11S6TF43MUQeX8b+YksR73cHnEKXkOaMzm/SYGwTWbRer+VB2iX73mFLdgl1E0LmpmafJ24Ui2XC9EjdYNylNJ3mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGMSPb9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B915C4CEE3;
	Sat,  5 Jul 2025 00:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751675632;
	bh=fRjeJIWAa/F9KyIs6QeQtVIl4Qi9wTg+6lbQBrmkPWU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fGMSPb9rQMvkKQgJlTpUv10ouN4pi3NK6NHTeLEfCfa34cHMQArYsYGZ2O5IkSU0b
	 3Woo9NxfqxoZ5HNPZEbhMGGKcJJucafGO/SWj5QjZbHmebH/cUlU6Fs1zwnPq4BrCE
	 EiPc4ByPpB5Op+ZdwNX1qfqEgNHl8menZfY0AYkdB9mLK95dPp0uqldOg56lzxIrpi
	 MfQ87VRInZZwlCcNqfHlsKZZa45yunRK+IsZvKxGfWY2Ev6yqXu9Dw7Le9RlzpPBTF
	 Lko7ulMKCuHVFnvUwkaL8k2+1vkJ2PBYfXg3A6DThdOnLIr88KlvnaG8G4irDf0saN
	 b3AySLHt6tVtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE164383BA01;
	Sat,  5 Jul 2025 00:34:17 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.16-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jSU7CZ1PHB1-3ff-sBPt8SzhaYo9LNDYNPWzKG1DPq4Q@mail.gmail.com>
References: <CAJZ5v0jSU7CZ1PHB1-3ff-sBPt8SzhaYo9LNDYNPWzKG1DPq4Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jSU7CZ1PHB1-3ff-sBPt8SzhaYo9LNDYNPWzKG1DPq4Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.16-rc5
X-PR-Tracked-Commit-Id: de1675de39aa945bad5937d1fde4df3682670639
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49dcc4f601017c3fb5dec6754a90403a07d043a6
Message-Id: <175167565627.2360325.16890784090278434736.pr-tracker-bot@kernel.org>
Date: Sat, 05 Jul 2025 00:34:16 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Jul 2025 22:23:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49dcc4f601017c3fb5dec6754a90403a07d043a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

