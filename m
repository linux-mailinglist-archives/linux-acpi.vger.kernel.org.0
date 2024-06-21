Return-Path: <linux-acpi+bounces-6573-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25092912D26
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 20:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0F21F263AB
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7C41684AC;
	Fri, 21 Jun 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAdyTIoj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9A13D521;
	Fri, 21 Jun 2024 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994390; cv=none; b=U+fyEzFtanzkhqBC2e8L2SbzZM8Po7Qn5BtggBmDXWzWBTTS+pe1QnZ2FoAYGWED/oGAYLVEHh0iAXtWCNXEWfWHKpmdSVv4DJCElODEYk9r4Vw66Nqxe8SuBZri1DpRnp3zvANzTcJAAS0GlY5EpujvBByGxv+cqcqF8ZXHPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994390; c=relaxed/simple;
	bh=2sr9dzHIizCqDfoQiw6EbDnYd8gZfAaOTXLZc2xtNi0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DuDonqvT+qPvpDId1NKRz34B4XgdGrHFXCwEiWKzEzDBAI59xvDg/h2ZsnBijHmKfzZWalB3im7OWyz79xNEbjvtjwYKnL6RZojLwGwmMmBh5hdWMkOYE/LQl8uKiIaL3gja3dtTJD1qIo+QZ8sCmlXRwjRj0v6T+5Av356qD88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAdyTIoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E32EC2BBFC;
	Fri, 21 Jun 2024 18:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718994390;
	bh=2sr9dzHIizCqDfoQiw6EbDnYd8gZfAaOTXLZc2xtNi0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SAdyTIojhpS5FZqjqKhj+BR9pA749ZfFBwHBcxuKmrs1k+PMXnDH56sfFWjT9eqvT
	 oGN9MFZWisq5qWH+FgQhYZtJMIgEbSsMz3ZYry1h440lQk92fl7pslnxyxO3k2bswN
	 eXWHyU7Er/aWj/I8ikucjcw0sv49zUv6dXznO7RIKDncFp/JhudyW1fZeEgMXqcYq6
	 TvegGOpHo6+4w4PrPj4KQ29x0zmjoFgrvzQNk9LgsvrfSy37xA1alvEuGbQ0lCH4Qm
	 gVzTuEuJq+NM1UgtsowzE+HCnXoitZafCGPNHAfVG2fkjW6k/A08NUvSh6gRdtiSWi
	 I4bHbnfYT93og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69762E7C4C5;
	Fri, 21 Jun 2024 18:26:30 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.10-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g0_idYr5VhHc_Uy6h2PQBf7ekFVAygUOOKiui1QkRUSQ@mail.gmail.com>
References: <CAJZ5v0g0_idYr5VhHc_Uy6h2PQBf7ekFVAygUOOKiui1QkRUSQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g0_idYr5VhHc_Uy6h2PQBf7ekFVAygUOOKiui1QkRUSQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc5
X-PR-Tracked-Commit-Id: 096597cfe4ea08b1830e775436d76d7c9d6d3037
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbe7ef3f2f05d8272b84ef2adb1fcfbcf9367b5d
Message-Id: <171899439041.27430.14155768763531295696.pr-tracker-bot@kernel.org>
Date: Fri, 21 Jun 2024 18:26:30 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Jun 2024 14:36:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbe7ef3f2f05d8272b84ef2adb1fcfbcf9367b5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

