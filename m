Return-Path: <linux-acpi+bounces-9690-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AC39D2F28
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 20:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1B52822CF
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 19:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF091D416A;
	Tue, 19 Nov 2024 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6WrwEBs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479311D414E;
	Tue, 19 Nov 2024 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045947; cv=none; b=ZMAnyBjjZqRjJl0XVQ7TKbn5dJ2oHzdkEfhjBMg0gx/HBYWF7PnoOG3nralRLqx/YNj0rJ7+LXrNBikjHRq8UwFqZcq+reC1fLQoYUOFtAZ2mBWRpPlu2KU58P2VRvu003SksNUnj4T4aeiQcCodatJlTEp3RgUmkSALkcs3qWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045947; c=relaxed/simple;
	bh=7fpdnOjBpr4wda6p3qPZtuf+k/uSsEiNyc6whzI1K/A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jY+jxSaVPpLRT9pbuNlNy0cSIh2+tiwT7xhULDBrXMs6CtJfeeuobGpcExb2hQ46OsloMm0ZbO8imjKT9QEggZqnnDkcgFb5T/ktoING16s3Ric6Bz3AehL1//T89mLibrC3pyaOx+8luTAqB6kdT1oM1tJ40FrFn3A7GR9iTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6WrwEBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3F1C4CED0;
	Tue, 19 Nov 2024 19:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732045947;
	bh=7fpdnOjBpr4wda6p3qPZtuf+k/uSsEiNyc6whzI1K/A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=g6WrwEBsjFfgm26qU3mMLyMnDXk/79XvjrapxH52JnwL/8DQ65n7LRg5HcIJu8BKI
	 xljcwaj2ci9oXYcXVzRGS0woiIYKRaSC3C0VdbYt2dhNZKDw723L0Cf5OBg4Kvxrm8
	 z9Xgt/E8uXsvTFfaYoZTdoE/hWRXLg1S14m+r6u288hVdQN85ICPGOftCYw3o7Q5UR
	 ZSUcMImyX7sSZ7+gyL4bf1T2mLcXK9Df80g6Tn9X7bw3cLu1IiqU/7vLo7ZRxAmuRk
	 yWNuXY3K46Gvo7EbH3F7gncv79J4OX2GZwro1kuaTztzgaAoYh8fYavSjYE84317g9
	 bcSSgT2EBGexQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC693809A80;
	Tue, 19 Nov 2024 19:52:39 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hey+FYr5KAbs=Eg_6u9Hp=gqH99G8nCwfr_ibRgkkiQw@mail.gmail.com>
References: <CAJZ5v0hey+FYr5KAbs=Eg_6u9Hp=gqH99G8nCwfr_ibRgkkiQw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hey+FYr5KAbs=Eg_6u9Hp=gqH99G8nCwfr_ibRgkkiQw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.13-rc1
X-PR-Tracked-Commit-Id: d47a60e487fbb65bbbca3d99e59009f0a4acf34d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e9ad033b405336cea3c19b68e2acdf47d88c339
Message-Id: <173204595847.668199.7077490808702783229.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 19:52:38 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 11:25:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e9ad033b405336cea3c19b68e2acdf47d88c339

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

