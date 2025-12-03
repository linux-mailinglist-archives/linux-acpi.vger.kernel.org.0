Return-Path: <linux-acpi+bounces-19392-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEDDC9D881
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 02:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 29665349716
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 01:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5CC23EA97;
	Wed,  3 Dec 2025 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISUPCeNW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD0622FE0E;
	Wed,  3 Dec 2025 01:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764726793; cv=none; b=VovA1etHPem9FqpWynGFqxlpcGsalQ8iWT48sp3wGe9lchCwIKu9hTGPAesgTzqm6E7/B8Jtd7LumcFHwuicfvK89kT/BOqHRf7fS5iJjAFiTqI0byqNHTKiEmrfGcNSMHSitetsPm3x/TuRJST05egyTiYDKsQ9yJoPxmXdafQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764726793; c=relaxed/simple;
	bh=K8k/iyVq0vSH3yZ8mXF88NaVdKSYVY3fe1XYq2SUolA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Sa9Y44EE1tRoibv8EONZIA1qLVLfOBWaMSDdLlPoBVqErWngYA7PVKG+daK93DInhkLTP0LtwVQfMwhRVubqFROWfNrKf3otxyfW8lXyMUzTfupQWNk7CmUl5WG6/5bQzqjNS1MMmdbjOjLiRociet5jTfrFNhlQvkNyCpuhG+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISUPCeNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009BCC19421;
	Wed,  3 Dec 2025 01:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764726793;
	bh=K8k/iyVq0vSH3yZ8mXF88NaVdKSYVY3fe1XYq2SUolA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ISUPCeNWChBs+OslwX1ngdn+gwnl6481IwwUi98ap6opfUscI3BaL79VqzebWZQmO
	 IJxU97Xni0P8YNTbD99ISn/cPK1JeMtSB6DWJ9wmOU5SBjoPSDTZMmQ0LSXhRyiqYV
	 M0Yy1oNumYiywsppZzwm1di6qWpShaRgqe8K1Ez4yWZ634gTifYWYIeoogWUKlRSE6
	 q7sdpc9WUqZZxAPC5OXVrTNzZshhGvsSNyURtJhAP0dWkfrVLFNy9EcQJLfsKf/tBb
	 OmxrUD4SAQdW1+UIeKR/+fHHKYJh/PdLGSwsg0yQ2br+8P1WfT+dEi7yqrGrO30WWR
	 QICdZPZwH9vAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 738CA3A78B36;
	Wed,  3 Dec 2025 01:50:13 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support updates for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gaDJaBGHY-6krpyegAZXvtMka22J0q4Hgg9dPMs19FkQ@mail.gmail.com>
References: <CAJZ5v0gaDJaBGHY-6krpyegAZXvtMka22J0q4Hgg9dPMs19FkQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gaDJaBGHY-6krpyegAZXvtMka22J0q4Hgg9dPMs19FkQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.19-rc1
X-PR-Tracked-Commit-Id: af47d98064e900f279c98bb3bb57445a1e7a8f6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 959bfe496bbaf3daa5dca32d397e29ea12471779
Message-Id: <176472661218.3473163.2036950373936848429.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 01:50:12 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 21:31:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/959bfe496bbaf3daa5dca32d397e29ea12471779

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

