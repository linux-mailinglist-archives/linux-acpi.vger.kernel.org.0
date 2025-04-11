Return-Path: <linux-acpi+bounces-12981-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBF0A86216
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 17:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6754A2214
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 15:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9D020FA90;
	Fri, 11 Apr 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP2/l+t9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D4F126C13;
	Fri, 11 Apr 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385983; cv=none; b=g1bBCoVrQLsq6OgIgwT7GzaDUrjz21YaUbAZy3HThbn9Fjyx8pRHQp3Z1GTJYh92CP+BGRKd6EHdIYSzguL2lVzfv896Md1Jzslx1AnoPgOx+hQVWV+kZmNxw4SDQD9RfwbKXpt8LodAvf1wh566vkOsrexXVmDPHGXLQcCuObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385983; c=relaxed/simple;
	bh=Pp8gWwsTe95m4POPpr0p+oZ8ctEVyWyrO2gkk+rEL0o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rv4prJ3knN1skm04lzAa4oUWmdlOGjgAwMvC/uuSh9d/gYonTfmjqjc3AA9ScffOY/1Hu8RTQlmFWkNfaQxcTxCVEhhqgufDENpg3WM9h3B0Fb/PPtA3R7mocmyeqtVg1iT/IkuJ0Lzl3N9TwSdM/sc6NT+m3V99fCHRjHdjb5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP2/l+t9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C34C4CEE2;
	Fri, 11 Apr 2025 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744385983;
	bh=Pp8gWwsTe95m4POPpr0p+oZ8ctEVyWyrO2gkk+rEL0o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eP2/l+t9CK9ENvJZSLL+WWtUictdTtYfxAQeLBRNLgJ5E0zVg4ZgxMwNhqk+6wv11
	 Q0OST+KDsFuiMPmscSQDx4J4LyKbBNMujpAupn3LZCaA0FUKBAEiNbZH/RiFRIqOZ3
	 kmvfU9X5WXPS09MPv8ktcg2tFD3xaytcMBqcihfhMLLU15DVfiTaHBaInJD1HPeK23
	 R8mQ3cQkCQHdyYtrS9cFDCFeZ+op0zRtOKipDiikCPVUcfy3l9u6l0b8Xr/D0KHAQZ
	 a5S0WnWH0mpvvobHa/KStTSUMdQhzs3THZPYcMnjLOkeUIm7hX6vclARKNxpOaTxIy
	 zOPdottLH50oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3435238111E2;
	Fri, 11 Apr 2025 15:40:22 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.15-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iEn-Lyic6zxDehxF1HHfNfg11_S7COMsHnZeQ+TzZAsA@mail.gmail.com>
References: <CAJZ5v0iEn-Lyic6zxDehxF1HHfNfg11_S7COMsHnZeQ+TzZAsA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iEn-Lyic6zxDehxF1HHfNfg11_S7COMsHnZeQ+TzZAsA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.15-rc2
X-PR-Tracked-Commit-Id: dcc4aca53338d09f7b3272e00aab4a1ff8c69067
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c86e5b561a4a6b81828528fe61adf7352b756c7f
Message-Id: <174438602105.317646.16092832788959241563.pr-tracker-bot@kernel.org>
Date: Fri, 11 Apr 2025 15:40:21 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Apr 2025 16:29:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.15-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c86e5b561a4a6b81828528fe61adf7352b756c7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

