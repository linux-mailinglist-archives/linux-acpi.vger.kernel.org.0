Return-Path: <linux-acpi+bounces-13278-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDA2A9D01B
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 20:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A511BC3593
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF37E2147F0;
	Fri, 25 Apr 2025 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQnV5hKj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DFC4437C;
	Fri, 25 Apr 2025 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604066; cv=none; b=CF0q76ZwxDI0gOIEyoS7nlAKymQ4QLG99tMJODAsarmUboCKm0eihEA3DQMlgKqL0KwcB/wEYNcepj4DHFisRIOgikh8ctEQNHlqnunwP7krEWclO0LnekgjEjl1oMh4c/9/pz6Eg+RZuzS45yrklqfnvEtg9m3M6LLFvLsraOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604066; c=relaxed/simple;
	bh=B7S3jsnLK+6a+pJmYBIJPJ1DZ3uvK05movMLScxcX1o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eLYcDOUSSdHP8iqU1BWZwGgFryzsmdc9Gd/Vmh1jiPi0n/Wl3lEgDsaXJukQ8AMyc26Re9UekcVjOdkqJz6hiBBxf/lG6dvbbRdAizOmzdIL79xImuT5Ue9Y9OaPHP2HcMrlHSOJV/n8zugqW3jaodaP+b43xszspiPWJcXavhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQnV5hKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8948DC4CEE9;
	Fri, 25 Apr 2025 18:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745604066;
	bh=B7S3jsnLK+6a+pJmYBIJPJ1DZ3uvK05movMLScxcX1o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fQnV5hKjGPhM0bQVtOXJ3ToNz/I6irzWXWxr/uG2JZej1wAtpMf9irORJebtKYUIu
	 THJrDg8zdg95DGtoGFfxKNM7O6nhToKmLjr429bfNcQSoed1PxDOr7ACS0mb01w1Ej
	 nsjbRipd5F5GzdU7v71EL4cUZ+0VCJL6pV10psaSq9n/5ybZEVoIusBHyvewluBnCw
	 1fvGXaWxeAKPcf9VOjnLe5ho7gUa1+ZaRZU0xhYspGHavjwhZSquE05nhzEOrIGKt9
	 jKnC3cUt89gG7WKW1YfRo8Np3EXiETLFCnsdaYWO12/n8kz85yMr5zLrQ5QknkBWLv
	 gYxauO3oaeCug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC3380CFD7;
	Fri, 25 Apr 2025 18:01:46 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.15-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i3STvUcv15K4RhpNa9t7hZQ8nJGFfFD77WU-3-4X0zog@mail.gmail.com>
References: <CAJZ5v0i3STvUcv15K4RhpNa9t7hZQ8nJGFfFD77WU-3-4X0zog@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i3STvUcv15K4RhpNa9t7hZQ8nJGFfFD77WU-3-4X0zog@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.15-rc4
X-PR-Tracked-Commit-Id: 5786ef8ad8d4222fdc2e7cf65337880695cef60e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e3597f12dce7d5041e604fec3602493e38c330a
Message-Id: <174560410514.3790119.11186503738841537431.pr-tracker-bot@kernel.org>
Date: Fri, 25 Apr 2025 18:01:45 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Apr 2025 18:16:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e3597f12dce7d5041e604fec3602493e38c330a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

