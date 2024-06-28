Return-Path: <linux-acpi+bounces-6657-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9226491B424
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 02:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE7A1F215FB
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 00:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900EB1170F;
	Fri, 28 Jun 2024 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHGVjs4w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6526610A0A;
	Fri, 28 Jun 2024 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534954; cv=none; b=SLpTi1rmgFq30q/P1PWMGVNzEDV/+s5Tt5T/hFO9yKBcHYgNhS3Zw+6aH2/rAkgPm02TN6Yr5ok/AulgeQAqPS441G/rguwa3x1Ts45YZ2Dk8RAlxfjHCDFnam8FqyYnVXUo6jr95cUlKvNQoK7m41NdLu0k1yEXhLESpt+kur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534954; c=relaxed/simple;
	bh=KZGc57PwNKKBjR1Y41HgoGhfesZHCqttZfM+n+ceHXg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aFMCN4Y72U5XMNvI7LFKaqNasKCSEDcfRllIZ5Pv3D+RnThC2HF+SzpA31OwCR+5flI9WWPeMStEADu/pny6YTv15ohjZw86IdqLRHqXZfHDzOXofm1DdjQdWv9s6jqeuC2n3JPIUmPXOZ/P6FNxQWKqADxtv0cnfAGnEbqKCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHGVjs4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03370C2BBFC;
	Fri, 28 Jun 2024 00:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719534954;
	bh=KZGc57PwNKKBjR1Y41HgoGhfesZHCqttZfM+n+ceHXg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eHGVjs4wR/ciXAduVQ0+oF2OkxafQPie6YnC3bXfSzLOi3o7KmwLtbHVaK2ea9k8M
	 oShj0CaAdr7rnAssd23hHKDD4MylYi2vdm2SkAoIi3p7RP9CmGIs0pqwdi768I+uFc
	 0U8n14J78ii6ILSr1MardOHy04a9/j4HREd0HDXwXGuLzo2ZG+rUVimfFl+yOssCZp
	 uP/ALRTEtBTq4FtOWuChdlJCqb/Tn/JIiXni+S4GiQSa5mDu+1cHJOJQRbNexgx3lq
	 5MbQy0hRHJCJFFKts/L9pTL0iMX9uBnqRCsyLNemnBzYyyGum2giMe4UchITz/Y87F
	 eMqq/40fkQeJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E366EC433A2;
	Fri, 28 Jun 2024 00:35:53 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h__X99p9mZLT29_pY3_4Z0wz=EDmaGmo1HntF5SO7HfQ@mail.gmail.com>
References: <CAJZ5v0h__X99p9mZLT29_pY3_4Z0wz=EDmaGmo1HntF5SO7HfQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h__X99p9mZLT29_pY3_4Z0wz=EDmaGmo1HntF5SO7HfQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.10-rc6
X-PR-Tracked-Commit-Id: a1ff59784b277795a613beaa5d3dd9c5595c69a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef8abe9668ce38d8b8b7048724c896cfccb40307
Message-Id: <171953495392.15056.7405196554862222289.pr-tracker-bot@kernel.org>
Date: Fri, 28 Jun 2024 00:35:53 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Jun 2024 21:14:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.10-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef8abe9668ce38d8b8b7048724c896cfccb40307

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

