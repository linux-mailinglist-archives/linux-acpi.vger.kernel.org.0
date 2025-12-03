Return-Path: <linux-acpi+bounces-19393-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6932BC9D88F
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 02:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F1354E04B5
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 01:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80B324677B;
	Wed,  3 Dec 2025 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7CqlhQO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11D24466B;
	Wed,  3 Dec 2025 01:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764726794; cv=none; b=DL9lu912FAZ0GnQx1RG5v3Y2lyzsz48Ki1o5G5q1RP4LRQuI2w7Ryt14W016TPgAz76+3TyFHL6BXL7d/9nJrircZyaIwca+4Dn0MgItZsdSFE5OGEeECqvGANYlDRWb5TKpgbdPfn0NiwDEeTO/y2M7yV5AV234gUrISrZEtfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764726794; c=relaxed/simple;
	bh=AFhl+98PeD6UdsHL22wvtaJWEpd/X4o28gYMdxpVZ1s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YWV8bCZkzHMwDt8swjwYA/DwRYEMJ5YC54VixgB/jPbXL1B4/h3N/neNILZp2tJ9yHgPfm2Yc2NPc4O+Ha9SNqAd3WDgrF91DkmKq+7EY2mbzAAiUo/oJyygSLFMAuMr3NTnfgei7CODXAdxfNf+Nxk8F8x89s+MJHVDFMyNZ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7CqlhQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A75C19423;
	Wed,  3 Dec 2025 01:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764726794;
	bh=AFhl+98PeD6UdsHL22wvtaJWEpd/X4o28gYMdxpVZ1s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=C7CqlhQOEvZYfG7G/oeWh2X7VJB/AqEhnamZ+OiJmIhZO7aeshcvaxUXW31JdcSlQ
	 vOpVT5KvD/fv0jwoTFmrn9yoy/lovCFjmUpjnHo62eBVxxKReit9Lf8yl/4iLPCGt0
	 HLm5g4bvz66e6gX2mfV81Urpl01WsEYEdA9Vq8Arl87PFBNSrDe7DvTczJL1sqv4Uu
	 zoiZIdHDHCYDWLaLKDB/mN+xT1meSsvc9C5e/mDU4ZdhN12byJcQiyeV5vkDJ807d+
	 rKIBzULKtD18UcgvfSj73yBjtmx7+42dvAg5zv235Tr3YhNpWwZdRFImDusd86ns1u
	 zLgHTjTNYMeeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DDCE03A78B36;
	Wed,  3 Dec 2025 01:50:14 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iTbaZyAOqb=x4COUuX91u9CgJs-qi2pMBrFrOvC2e0ZQ@mail.gmail.com>
References: <CAJZ5v0iTbaZyAOqb=x4COUuX91u9CgJs-qi2pMBrFrOvC2e0ZQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iTbaZyAOqb=x4COUuX91u9CgJs-qi2pMBrFrOvC2e0ZQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc1
X-PR-Tracked-Commit-Id: 7cede21e9f04f16a456d3c3c8a9a8899c8d84757
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d348c22394ad3c8eaf7bc693cb0ca0edc2ec5246
Message-Id: <176472661367.3473163.537856880367587125.pr-tracker-bot@kernel.org>
Date: Wed, 03 Dec 2025 01:50:13 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, Shuah Khan <skhan@linuxfoundation.org>, "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 21:33:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d348c22394ad3c8eaf7bc693cb0ca0edc2ec5246

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

