Return-Path: <linux-acpi+bounces-9689-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A649D2F24
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 20:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C091F23B2E
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 19:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B566C1D2B21;
	Tue, 19 Nov 2024 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWP0kQkt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5F1D1F43;
	Tue, 19 Nov 2024 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045945; cv=none; b=HeYlzDrFyooUjqzsanGHTfB4+tKNnlx/T5wySmsn2viLNIkt1u7i4XUsjNo2k962qc+FFgemhf8Zch7SpKhdWa2zIsGdDfUxJnccxkQAHELTej4KI7PagaV0kVTAFeA1Bx7mHeX2hGHnRVrPJ9sOBF4sKxyeFXdRtL2eHek6XtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045945; c=relaxed/simple;
	bh=rGzjCRtpoRm+G1b+kyTPMTcRYGjvsjghf4ej5AlYTGE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ftN19tnShmO3l6xG6gF4NAf6D4RNLqApkcCWJ4wpevEVrDNl/GAUxSJgL9l682CpPQs49F+AsAaMVTtAG7H+ZFU8ub2Yp2yKeZKRglH2jUwaTq8i+KFaD0/eQM8SYzwXPkytbqBuJe66UxldYKFWJjsjeUsK7mKL5Bg+ctyeWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWP0kQkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7045AC4CECF;
	Tue, 19 Nov 2024 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732045945;
	bh=rGzjCRtpoRm+G1b+kyTPMTcRYGjvsjghf4ej5AlYTGE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mWP0kQkt+TjADK82P33TcIa7G9yKs52i8xrTi/yYHAjSvsl+7UIU+7PWR/eZpKgn2
	 v7C9+UkzQ7BFlm+fqGb8XtzxL6266Kr6FT/hbbWT5xrNOtWlFAW1Gxyg+nGsUtW0Vv
	 Wa11hBcCVFAUJOWxE9mf31G8buzAQk/+4pWzYy/CCzirJ8JHbdIdx39MgFX5obfdbm
	 OwUlIyzvDYv/YM5INrs++MAvtZNR/88v3N3Q5TUCWKtLYraP0Gq29DsFfN5CTYKx3M
	 OVGH6u9TcudfXbzouGKKOamt1FEa9QHwwRzZRhjV8v+oeuaeXvemahSh4R7wkiDLhy
	 9wLdR/FUlfXGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FD43809A80;
	Tue, 19 Nov 2024 19:52:38 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i90sb6CC=obDdmji-WeJnkwSp4Agd3UhGhuo+TVm4uXg@mail.gmail.com>
References: <CAJZ5v0i90sb6CC=obDdmji-WeJnkwSp4Agd3UhGhuo+TVm4uXg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i90sb6CC=obDdmji-WeJnkwSp4Agd3UhGhuo+TVm4uXg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.13-rc1
X-PR-Tracked-Commit-Id: c6e2a4c9eed5249c4158bc621882d44e94af3371
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad52c55e1d3a2e85e05e47b6d7056c662a9c0246
Message-Id: <173204595692.668199.4524478832599875567.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 19:52:36 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 11:22:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad52c55e1d3a2e85e05e47b6d7056c662a9c0246

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

