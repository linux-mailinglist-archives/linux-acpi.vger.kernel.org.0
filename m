Return-Path: <linux-acpi+bounces-10942-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF885A2D074
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Feb 2025 23:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D286E188EFF8
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Feb 2025 22:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684921D61B5;
	Fri,  7 Feb 2025 22:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGDIPYDp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9ED1D5AC3;
	Fri,  7 Feb 2025 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967160; cv=none; b=mUTpDZ2/zgTsBjLVCuX11SL263pFwUH+GZo92GaAsB7niNwUJlBjuVSRsQ/v5RNYgXxYwbemaW6JZE0qTYeoYEoqrHTx+ixpquoNp/JfpOembmHSpI2oUznH/FKLJtdvNVEqp7wJ/9lrdgrfMV0PWjV0kilfay9ZRmOo4RvIs+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967160; c=relaxed/simple;
	bh=4c08p8arazQa8gECrvhr+hcXIc9phgLVQAUASBZ3qBk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Bzy5ZtwqJUmK0/6OATBFP+qz4p9v6de0cxdj9siJY38+jdb4qv+gEniEXdmOanmBDUCfJj36Iue+nQlFV6/sW9ZOqi1oX/gJ/sVr2CLsZBXFX7jIS/aJxnj3F8Xh7zK01E0TeOYqesoCUbivuzR0R9VJ7gX824L1H5Wn13ERVRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGDIPYDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78B5C4CED1;
	Fri,  7 Feb 2025 22:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738967159;
	bh=4c08p8arazQa8gECrvhr+hcXIc9phgLVQAUASBZ3qBk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VGDIPYDp1aiszNisDYUy5FaEgFCalYll3ejXIZo7TkJ77Y9A0RZOHnQ9jHrjTUkWa
	 cldxFnhM+fur8vgxCx53390kLejTPI+cZza0DuRbQ2CKlywwIRVMlPxzC2IKcm/KeU
	 yYGM8OAVS8JXslDTOl+G8badTUDpTL5t72o+tQYSA44GeCmAxONhAHyddUHxERrUzq
	 CYOiZDrgoWW+KuDRme0MGz0dj5oJ2RXVq1cKbR/9fmNHjG5+7ufwT/zr/gN0LDEgAz
	 W0/WEWhpst/HjzDsYsDGjUSYr/04dFaLOwq4HlihM2jiYZSiSL3eYh0qfAQHfwnUkD
	 egsSMVfK2/FEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF13380AAEB;
	Fri,  7 Feb 2025 22:26:28 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.14-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hOVsML89netZiY751QiPqQD-7mUYxpdJFwNmxgxu6JZA@mail.gmail.com>
References: <CAJZ5v0hOVsML89netZiY751QiPqQD-7mUYxpdJFwNmxgxu6JZA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hOVsML89netZiY751QiPqQD-7mUYxpdJFwNmxgxu6JZA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.14-rc2
X-PR-Tracked-Commit-Id: 3e3e377dd1f300bbdd230533686ce9c9f4f8a90d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0aa0282a720fd7c58f131eb5a5b0440e839e2977
Message-Id: <173896718743.2405435.17861272670890125347.pr-tracker-bot@kernel.org>
Date: Fri, 07 Feb 2025 22:26:27 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Feb 2025 14:01:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.14-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0aa0282a720fd7c58f131eb5a5b0440e839e2977

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

