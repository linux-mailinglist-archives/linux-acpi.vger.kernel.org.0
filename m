Return-Path: <linux-acpi+bounces-17647-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB78CBC2697
	for <lists+linux-acpi@lfdr.de>; Tue, 07 Oct 2025 20:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98A8C4F8893
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Oct 2025 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266512E9EB8;
	Tue,  7 Oct 2025 18:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhiUI9YR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFE2E92C3;
	Tue,  7 Oct 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862321; cv=none; b=Yj30264Fnc5n43znFYMD1L3dScrbaKDvsIHFLZJYw2OWzhdJg7THXouQYctQSoY2aGPDuvdejNL1UgV7AWFmUXGIPTZbi3LQXECeFN2jHcyBKjOViuMQ6pSU7V8Dfp2lpsVjxvPf81RDWetCCfOzNXJl2arSUer/OApGjSSmSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862321; c=relaxed/simple;
	bh=eLA0a10O4J0jpRHzlitmEDNbNFsKjc5u1Y9qJwvFt9A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VsflMUirrtKHl1fB4MNvOG0ssxD31cSNZtTKgK1OCX//pkd0BtEQpKhGDqm7dEMlYVK5wAyqU869Y8jA3ViZBUjt4fsYMjfq4jqrxZa8HFZdDuy+TxFcz2LCUHc41uH22TuWy4yGBuYU1Kutg94+aBYENmXPnxaYq0gGl7I0MT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhiUI9YR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4720C4CEF1;
	Tue,  7 Oct 2025 18:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759862320;
	bh=eLA0a10O4J0jpRHzlitmEDNbNFsKjc5u1Y9qJwvFt9A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IhiUI9YRRmrz75LUQneogJA57Iv+d75wmxv3GpH8WlVGdjKO7I2Bd7qdsinuKs+2U
	 gBBRo2tJc3RnGCnZ2AoODjjw/Dg9sbIa3DAIkcMxn3ZYBVUjN/V/I1ducXcfjlRDjc
	 D0BeoN1QBjz3dgkr3OYCkGDIyy+yHvPg5lLeNNhcsxzv+lvK1TMjcZvyjrczI0/E9x
	 tRQQhZZCDv8XT6Vet9XBlKZaCIJXC7bHzz3E4Jvh/baZ9EGYmWyIvGiP71JM6SQOJI
	 vQ7zT9aXe4WYbUjDIczdcGE0/+Xzm5EENnaarBcPZFq55+yueAK8z6kgEAs7pO2w0F
	 Eb2NU7GfS1Eog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B8639FEB72;
	Tue,  7 Oct 2025 18:38:31 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI support updates for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gb7Rvd_nOd5Z2r95WsenmWb-YZOSLW804+Nif0o+mZJA@mail.gmail.com>
References: <CAJZ5v0gb7Rvd_nOd5Z2r95WsenmWb-YZOSLW804+Nif0o+mZJA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gb7Rvd_nOd5Z2r95WsenmWb-YZOSLW804+Nif0o+mZJA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc1-2
X-PR-Tracked-Commit-Id: dd68fd72e516d57e7f2e502113c9345a3bc277db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89b59f0979926fb22ae7ecb8f4a1b5ecdb04b3d4
Message-Id: <175986230985.2733874.1178530708771111401.pr-tracker-bot@kernel.org>
Date: Tue, 07 Oct 2025 18:38:29 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 7 Oct 2025 13:32:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89b59f0979926fb22ae7ecb8f4a1b5ecdb04b3d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

