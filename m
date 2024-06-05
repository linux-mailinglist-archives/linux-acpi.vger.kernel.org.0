Return-Path: <linux-acpi+bounces-6209-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0C48FD9E7
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 00:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71141F24896
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 22:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657B3160793;
	Wed,  5 Jun 2024 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxSJmzxs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF816078D;
	Wed,  5 Jun 2024 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717626931; cv=none; b=G33yFnc/0q1Idby1CBKo4R0eop5WxIowU8pswLiWQLTBMoEJ0bNHPmPKjFZSyDNduSsl5KCGWtkWxQpebTkkIwM35onqB9JzP1XK3aWt5UCMK7KvcBGGBhBAXb0i4Dy6B2j7Max2vUhrARXY338z5PeHde3nIksUvb9PJluv+zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717626931; c=relaxed/simple;
	bh=yT6sfjO0qQ420JtoQYJhmwpOwp3a3B4AOsBJ5nSvz6Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dF+GIrjjOtaj9oOiDSbbkjuSpI0Iq5agTe+MfNtZcTP1dAekqVPVSaaEJKiOCLOZPIlaH6L7G7XYAPPzyAOwUkdhrhGtg1TSbMSpxo0ha1ydNSKGhrF/8Ux7WtIGpSqm6wtfgVsds+aCmeV7OVvViTg2HzTvQj49/Qw/hxOPnx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxSJmzxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92DA3C32786;
	Wed,  5 Jun 2024 22:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717626930;
	bh=yT6sfjO0qQ420JtoQYJhmwpOwp3a3B4AOsBJ5nSvz6Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qxSJmzxsbBJN9SnbcOxERvP33F1cvD6BjJXqjI0NQehA9v+/8yR3yQpYBTCCSILkY
	 6JrgEdxq6FpqWOaAflre0N+Z/w12BTpLsqleB6BzPwMzNCwGdAiONDjq9JI/oJH91H
	 5Kc07Ni70FI1AIPrV51/fa+eY32E9MuWmF0wAek2fZqVLeKkCf9D+Ikie/Y9KhIIV7
	 Sezre3BJSnTPXeayIEzWRzfw6sET4tmZhQorkPdzgOmgFRHvmip4s2ZgexDFo33Sim
	 +h8z4kS2YP2qOBybbR99rah2CZrUGNJBYLzKuAEUHLB9cCgSjSzaI+5QFEULzCpFa1
	 CUcEKGOsjXMjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8014EC4332C;
	Wed,  5 Jun 2024 22:35:30 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.10-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hkHRB-obYEnYzVAy9u9wVUKwu=FTCn5rMKtAwf1HGMjA@mail.gmail.com>
References: <CAJZ5v0hkHRB-obYEnYzVAy9u9wVUKwu=FTCn5rMKtAwf1HGMjA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hkHRB-obYEnYzVAy9u9wVUKwu=FTCn5rMKtAwf1HGMjA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.10-rc3
X-PR-Tracked-Commit-Id: 1bfc0835d40c8b4f19f8c1db8c42edddb265df5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 553352597d1c975ba7f734051f7946bffb3464c6
Message-Id: <171762693051.28636.2337710197039154838.pr-tracker-bot@kernel.org>
Date: Wed, 05 Jun 2024 22:35:30 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 5 Jun 2024 19:58:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/553352597d1c975ba7f734051f7946bffb3464c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

