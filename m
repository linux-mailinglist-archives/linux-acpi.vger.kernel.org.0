Return-Path: <linux-acpi+bounces-10794-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9796A19945
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 20:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A623A8C84
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jan 2025 19:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B9F2165E8;
	Wed, 22 Jan 2025 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMibr5Qq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDC2215F45;
	Wed, 22 Jan 2025 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737574855; cv=none; b=mmHwpDwl9OfOdap6d83hXFIXcPT063t5pZhZlIz7aCGmhxK+FOWAIk8I89K9K1Zv+BBq8AQ/rXNozoVlxBoy05M2ZIVIpOJ72MLig8WNaFYsev+2bCHMmF1PCy1SeiLhn3T6OL53Dfl+6qjnfgvysKMPZIH7bPcwssGCdf3iO10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737574855; c=relaxed/simple;
	bh=f5lvpJwrDuJXw0oBAU4D3pBmey1T/zkd8ex6UWE3dxY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QxpOYQfbqodQ0d0Dl1O70/dG2UEBxjHESX+Nu35k7TyI6B3QvOfeWUXulcjwhQmNULkp9w8P4puzxai+VGQjoRRpvzaOJyyKKRplqGqwGdxzf4y6dyzvB0bMSvZ+cA/EpF75hMIGJ+OKgULbRs8m9oRXPMHnT7mAS7wXiEv7pMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMibr5Qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E31AC4CEE4;
	Wed, 22 Jan 2025 19:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737574855;
	bh=f5lvpJwrDuJXw0oBAU4D3pBmey1T/zkd8ex6UWE3dxY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qMibr5Qq2Gz+NdGBWyuzclfgutNJ8JTaO02nSX+q1kri1hscb8TVCzqPoTcPSVmTi
	 PJAyrOH2/MI1hRVpSxDKl+EGTBvldCj0orcfy6RRW1tc3bLMFHG6OqTehEzVC6TvpL
	 IBcUFvb2w40ozDyUtnwL1CNwp13A4a2myeuYgEQ2tqh65oYDgAl0GyK/KqOQRsnLQ4
	 q3YkMS0RmVmsjtQ+MqGqmswzQa9bpYrVITvAg4C01YUwOvqlZ735HauGleHd6JZM3h
	 0ElwxerV9aLwCgI3E5gpvABDOkdoF/az1gy3RZrFQfgf6Nro1RfrgagRH19Pf1NVIz
	 U/wJsdR9iKxUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DCEE4380AA6B;
	Wed, 22 Jan 2025 19:41:20 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gF8OwN3W5uLXf_DVtcKgPc0cTy4XWfyE1mcG2iSkRe=Q@mail.gmail.com>
References: <CAJZ5v0gF8OwN3W5uLXf_DVtcKgPc0cTy4XWfyE1mcG2iSkRe=Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gF8OwN3W5uLXf_DVtcKgPc0cTy4XWfyE1mcG2iSkRe=Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.14-rc1
X-PR-Tracked-Commit-Id: 2dc748695568a02199e813d408a8f6f58919f4bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d78794d4f4dbeac0a39e15d2fbc8e917741b5b7c
Message-Id: <173757487961.794141.14397102703801393258.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 19:41:19 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 22:07:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d78794d4f4dbeac0a39e15d2fbc8e917741b5b7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

