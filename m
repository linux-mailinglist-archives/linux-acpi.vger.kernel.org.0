Return-Path: <linux-acpi+bounces-12429-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BEFA70CE3
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Mar 2025 23:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC33172B05
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Mar 2025 22:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3986269CE5;
	Tue, 25 Mar 2025 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBtRqyW4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891D813633F;
	Tue, 25 Mar 2025 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941636; cv=none; b=nr8eijJZ/OLR0e+g+ABBTdFe/103sHdASdtp3rJAL2KmgZxHHC+PiveanD7l32g/c0Ve4SRbEf9XDWLUKQ9VQm/ZHAeVy/Mo/RLxA81YkRHcUUYB6k+TZXi7Z65/MAWzyP2Wy4lAHrZ8Jy5JHncv66sxUg7B4PlrPb9i7ktu0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941636; c=relaxed/simple;
	bh=X6ABw96X6bt9yVBOdRc0n9HFdKPFnmTXoqlyi/sJYs4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=feKBmVL5RfnEWQzM03vXbZKuHqD6OTWvimfLb1qQAMnfSBvS4cbFJUjw88Hm/bp6aAAZAUrzvcXZ0xjev6ubKIzcyE5AIgDS9f6QDP04DfxRSnx2XNRzSgLZ2X0gFqk4hUBuRyvygCAjwveEhRuFO4R53WWdRQunmgT+NeFrfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBtRqyW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2D4C4CEE4;
	Tue, 25 Mar 2025 22:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742941636;
	bh=X6ABw96X6bt9yVBOdRc0n9HFdKPFnmTXoqlyi/sJYs4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kBtRqyW4JKru+IFTFSL67BY6WzA9fFkvOqr1qjWC92A0SfUWh1r0p1WBMCkPU4hPF
	 9qBL/vmelOlyR++GWNysJjVBxDP/APsHE+AMBihshp0FqjmT4qBJzTW3mW7fHazjh9
	 obX0oCfmVQgkHiX8SuM1nQpWfiCs63PkQxw95OxG+Z0IOYASGBwvlP46WfvKHJgtf6
	 WTq8t4EPwszYBXFOWPxiRUwou+veD4up5y/F4S9thL41th03jS4dzcsaMxTJlqXRRu
	 xRcnsP60yc0nktIMXmf7cqZvy7nws7yQhfT9K62I31S0M0H3MFX0I0I9NdnwPiiCpJ
	 ej2TOWH/Vtskw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB168380DBFC;
	Tue, 25 Mar 2025 22:27:53 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h2BgjPbZXe7yeXo-Y9MnvX+bXT5QLEq6KKLJc5N6QR2Q@mail.gmail.com>
References: <CAJZ5v0h2BgjPbZXe7yeXo-Y9MnvX+bXT5QLEq6KKLJc5N6QR2Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h2BgjPbZXe7yeXo-Y9MnvX+bXT5QLEq6KKLJc5N6QR2Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.15-rc1
X-PR-Tracked-Commit-Id: 8b30d2a3962ae07e67aee90d6698a6a68e771c6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21e0ff5b10ec1b61fda435d42db4ba80d0cdfded
Message-Id: <174294167244.756596.6230189804241957724.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 22:27:52 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 24 Mar 2025 17:29:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21e0ff5b10ec1b61fda435d42db4ba80d0cdfded

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

