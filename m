Return-Path: <linux-acpi+bounces-11961-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 916D0A574E6
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 23:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C44D3B55E8
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FD2257AF7;
	Fri,  7 Mar 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXUyQv1S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FC1257AD8;
	Fri,  7 Mar 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386588; cv=none; b=iEcdZyGLYvXw7msWLf+oCxvSuhs+95yxaPbH4gh3rfAIPw3v1uWHj8LRvqlG6jtzfso5G1OtBUIlqtI4JjH4WS2GAvnkmV+oYkUP7cz8Rn5Bf5/M68/hWkNQR+xKs36FHY0a9kbM97EaIJam6YuulWwf+DR5rUYVkMmCWAob2B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386588; c=relaxed/simple;
	bh=JS4CNVgyz4cxqL3lqcSEpoEJMaYvGcf60/CsCMlCMpY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rzpx0SntlqJ/oXta4FmtZyIghVlVSvS6hC4rPn6KvCmsqq+btC4tqf3GDl+7dxcKAbuSUIoT31NPON/N9HqM5c4IKzB8oQSV82gNI2cUPJhg0rnf3CQ0RcfD7PEadUK80MaEmjXDEPTU7CwWfrQfeOPUfvi+HEuAm/4flj33ZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXUyQv1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3E2C4CEE7;
	Fri,  7 Mar 2025 22:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741386587;
	bh=JS4CNVgyz4cxqL3lqcSEpoEJMaYvGcf60/CsCMlCMpY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sXUyQv1ShjFrzBkAB9RglHhMmY2KCA9Q9Funkj0DK4IfaQ3RqZqm77u+BYvt7z0fb
	 b6HfE4SiBVaOy5OlwGKi5hX1In4lbhLOeG9W3VQ/j2j6oEO8mUBsKXqm3msIwRuusD
	 SB/FNYeBAxoTuJHunbhOxOFAPZVmliYakjGdPV0cLJVRuWirCjZSxhYAQT3bSaLSpI
	 fIq6YQxsd2zs1GBn2RV2/9Xf9x0aqBqMSkvcvUlNgWtl7HxvG8DfpuGjUJWM/kJvkP
	 yC5ujzaMoPaPF7weFqV2wphoUJDFZawc7866wpLSc7es2gC/3YTXP73YCqJ1fvUU6b
	 6TrZK0cDZo9mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72628380CFD9;
	Fri,  7 Mar 2025 22:30:22 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g8fE1TvUNyN5PXiRexycuWn63inwdKon5aR=BM7cBHYg@mail.gmail.com>
References: <CAJZ5v0g8fE1TvUNyN5PXiRexycuWn63inwdKon5aR=BM7cBHYg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g8fE1TvUNyN5PXiRexycuWn63inwdKon5aR=BM7cBHYg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.14-rc6
X-PR-Tracked-Commit-Id: 9a43102daf64dd0d172d8b39836dbc1dba4da1ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4fd25b6f883db41194e1760041560779d412d98
Message-Id: <174138662108.2505911.8199823077885971966.pr-tracker-bot@kernel.org>
Date: Fri, 07 Mar 2025 22:30:21 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Mar 2025 21:52:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4fd25b6f883db41194e1760041560779d412d98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

