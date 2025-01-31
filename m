Return-Path: <linux-acpi+bounces-10869-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553EBA238B5
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jan 2025 03:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0A11889B7C
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jan 2025 02:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293EB7A13A;
	Fri, 31 Jan 2025 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZPiJe3s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39146F06A;
	Fri, 31 Jan 2025 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738288794; cv=none; b=HqxQf3+9Dpvk8FUmxrcQAkedYrtsMc544mWH5NNHBxfru8YgHQYiAswe0oGhToK6Uo6mCdesl5ZIEQ7FZHrPon6ezo9hDII6GK4tG5qjli3POTttWzxpIjurZEbXFfFpxAH7TGYLh4W93cgcvzePzeEa16eEk/8niyDoAyheEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738288794; c=relaxed/simple;
	bh=IhcNBrI+ypILh1hImihIpu9cAvHlO5KTM5kJsWXtt/k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U4EUhmsRw94I6VdZs6us/VNLyGS5gNPgvYIav+h8FxtM4ywlzjUzBiZuJAuUpx3goRoh/L2jk0jbFWIXtKJQQ+Ns7iGhb1vuG+giSk/gmsPrWymfwzmUioxuzGYiGWJGxsslLpbjEmfRlucV6pb3JuUetVU4B2D0rf06e/6FJgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZPiJe3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26B5C4CEE0;
	Fri, 31 Jan 2025 01:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738288793;
	bh=IhcNBrI+ypILh1hImihIpu9cAvHlO5KTM5kJsWXtt/k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MZPiJe3smlspWy4FeTxjHorg6pLNRf+H9AmQzs2ux8E3YBPGLRmNcEC+5/uOFD/hd
	 /iOh3hhlfZ7uDClM3XtzYgvah2It9oI2aW7vdBICR7/EN5/6ztlnnDSMrUM6VcoDkJ
	 i/avDAVadW2tXG1SAOEoTLI1UCpdMuttLLinlUb7orF2IK8PFQsoOmdTLUhZVCOC31
	 m74NibITvaWr5veol1StwcLUqBqSZ9Qne9m5pEsja44UP4wKLW99+LyvMLWzqf12qC
	 WY6YhDhR2QouOdZfvlbdfFua5dQ0f8ytOnLt9dSVrg8X28MdS4XmDapn2pfr47T9eg
	 7YBv+/ChWE2oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ECE380AA66;
	Fri, 31 Jan 2025 02:00:21 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ip_MwjtS+2MfUqkdC+y6nSevQf8-bUosMkLt1yYJEpqA@mail.gmail.com>
References: <CAJZ5v0ip_MwjtS+2MfUqkdC+y6nSevQf8-bUosMkLt1yYJEpqA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ip_MwjtS+2MfUqkdC+y6nSevQf8-bUosMkLt1yYJEpqA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.14-rc1-2
X-PR-Tracked-Commit-Id: a01e0f47a7a10668c178f058bcf136f8ec897286
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f55b0671e3f90824ac06dc06b988075eb9c6830c
Message-Id: <173828881993.1146049.10558745735369794147.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jan 2025 02:00:19 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Jan 2025 22:05:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.14-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f55b0671e3f90824ac06dc06b988075eb9c6830c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

