Return-Path: <linux-acpi+bounces-58-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6F57ABA8A
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 22:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B8081281E84
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 20:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0853436BE
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 20:30:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6067D3F4AB
	for <linux-acpi@vger.kernel.org>; Fri, 22 Sep 2023 20:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C772CC433C8;
	Fri, 22 Sep 2023 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695414483;
	bh=4E1DoFpsX4Vhf9ILzR7P7NP9E5YwvJIqnKKyxEeJBNs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Moq35vnU8jLwcZdnGFi+ZeyCemh45a01Q2PtlaVzBOwpt+4nx9DiJl5xrlGgyeEwo
	 xveB6EJ1l6IDEybykCV+DpLSQyIjrV4S5ruO5NsWznVYRmFKA9selxglhSfZ8Q8Ajg
	 vNwHO14+TrZFVH4xi239jzPBCH9ZS01QnGok3lIHa17i7bDNf7X8hnX4Z5clOhjpwM
	 mYvKyvf325bVBpFwzVvW2DOj53H/A6Ip3SZf/wng085+gKC/UkQViCxgJlxc1oINvI
	 OZ6+EDQAKtqbqXNXL4O48l23ADuCLOsPP01dGt0dxGzcCJff4B7zEzeH5UE8rhiqsX
	 KwQ/ROCAy+efw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD3CBC561EE;
	Fri, 22 Sep 2023 20:28:03 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.6-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iYLvO6VbzKo0-1sbpuVGF=Y-y2ajoRMMz+wAO0RTUNLw@mail.gmail.com>
References: <CAJZ5v0iYLvO6VbzKo0-1sbpuVGF=Y-y2ajoRMMz+wAO0RTUNLw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iYLvO6VbzKo0-1sbpuVGF=Y-y2ajoRMMz+wAO0RTUNLw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc3
X-PR-Tracked-Commit-Id: a1001c37f83b30a75c17796b453769773b71f9b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b184c040dc393296301ee2fa522f44ad61237d68
Message-Id: <169541448370.12920.15632829553792685525.pr-tracker-bot@kernel.org>
Date: Fri, 22 Sep 2023 20:28:03 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Sep 2023 20:23:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b184c040dc393296301ee2fa522f44ad61237d68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

