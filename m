Return-Path: <linux-acpi+bounces-13756-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDBBABA0EF
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 18:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5847A4791
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 16:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7656A1D5CFB;
	Fri, 16 May 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bn7kosGE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0087261B;
	Fri, 16 May 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413821; cv=none; b=aZH5m/Q683B4wMW1gI7IEJn6NShxnEqY0fSXuMGFlpTatP99T9WDe7tWe5eN699KCfmhpLwS/18Olmh8GhCRNsHttOzBnDcx4Wnt0WTXc4FAhTNpoRLg6nQ+b8LZSXTZ/Z7Mw9ECm6+3vcnRMaPsiSsS2vMj+lc5tcviRU8xjco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413821; c=relaxed/simple;
	bh=DkGgJobdvQOCEZelezDvSdBYSKh1GHHwyEbOO25w4Y4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qY4cIjpjRzbURIgZtECUIHucpY/c/nEsWWKkqfGstfabV6BRd8+Xky0lXNsTLdylmvHRH64Gd1kpGsKW+cIc/4x7+T8rmXMJZk/6aKX5Gz1+PAG9UAR+ec69bEcez1YAR4bCWKWJBsp7BbKTsc6UiRbiQ1yFjCnw0JIFb75AL/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bn7kosGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D365C4CEE4;
	Fri, 16 May 2025 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747413821;
	bh=DkGgJobdvQOCEZelezDvSdBYSKh1GHHwyEbOO25w4Y4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bn7kosGEW6Ue+ZACNVg3Dm3AzYFrY/kdMWgy2UqFUgDn/+y7MOcsy9QxJDEAW7pDB
	 GbQ4T4aGj1E3s8CQpRRoYLxzw99/bXQl1KyvuTnGsK1l4EqWnKKmDHVYlZMnqwWSLq
	 9I1jK76Q/RRXS36PM4MfdXH59HlvrKO/KpfWbe85uo1NQNsLcGliWlT211ahwfMMZa
	 P0MTYTp6qWYWxvstd8utNnHrbnPaaNUqhqzBu+/ZlJQDDHNzuZ5DLJc54sRXifHBfV
	 KrC3Z9O7nX/T+3Q+ML3CXvff40G/V+fhp11dBAqxu7RPu0Yhgk/2PJIHtXlmCVUn14
	 B/HD3q9dgdEPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342C43806659;
	Fri, 16 May 2025 16:44:19 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.15-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i8HbDaYStdN-isATh-+gPM2ztacvvgdux1WHy2aiiSoQ@mail.gmail.com>
References: <CAJZ5v0i8HbDaYStdN-isATh-+gPM2ztacvvgdux1WHy2aiiSoQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i8HbDaYStdN-isATh-+gPM2ztacvvgdux1WHy2aiiSoQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.15-rc7
X-PR-Tracked-Commit-Id: adfab6b39202481bb43286fff94def4953793fdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c21441eeffc3fd7eb990ae2fe99333484b1f7f2
Message-Id: <174741385775.3992786.15430254664072986220.pr-tracker-bot@kernel.org>
Date: Fri, 16 May 2025 16:44:17 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 May 2025 18:15:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.15-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c21441eeffc3fd7eb990ae2fe99333484b1f7f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

