Return-Path: <linux-acpi+bounces-1123-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5867DDAFD
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 03:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FB2B20C8D
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 02:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984481106
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNh7CO1x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6ED1374
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 01:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72DA1C433C7;
	Wed,  1 Nov 2023 01:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698803060;
	bh=xLqwMmOgZhXjxEfYmxFCdxKR3P7QuMdU4k8J9gjGGa0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oNh7CO1xhaeNLanEBhKByu9+ghRTsF3BLyvbmTewQ4zyyQSDzGpFntybiIkAAYET4
	 iD15LsKoHRmwqhYo1ReTUNaIlZrrgFetGyCBo1WItkFRwiW9qDGu7rjxFdZ8Yb3IVc
	 jsYdjOWXKYwzF9niQI79KB0GBTHutWVS9NG0CKO7F+9jpdSn/HqXRv0sfYb0C0ABg7
	 uDgPkf0fyl6ZXCjx/rBBn10xFEQOGFlNc+tNWwz1j5gSiRtaM/eN/B9Dc9NeqPyivT
	 EdHkEkvOsh0kY/uRUmNSgqYfCA9XGIfBkQcfpz0KQnr9CvtYOz/ufvavd9YaYoDOUA
	 jrkAy8wnmFVPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57CDFEAB08A;
	Wed,  1 Nov 2023 01:44:20 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gxSDM_0DTzyKHtNXyf06hGJK4fU-ByRqoUh89M=OM-Yg@mail.gmail.com>
References: <CAJZ5v0gxSDM_0DTzyKHtNXyf06hGJK4fU-ByRqoUh89M=OM-Yg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gxSDM_0DTzyKHtNXyf06hGJK4fU-ByRqoUh89M=OM-Yg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.7-rc1
X-PR-Tracked-Commit-Id: 607218deac6e29c52f4ce521ed467a0d75090a0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ac4677fdb76f644e09a6331bab65919b85f617d
Message-Id: <169880306035.15034.1145407508156698137.pr-tracker-bot@kernel.org>
Date: Wed, 01 Nov 2023 01:44:20 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Oct 2023 15:48:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ac4677fdb76f644e09a6331bab65919b85f617d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

