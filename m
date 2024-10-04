Return-Path: <linux-acpi+bounces-8561-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226EE990F7D
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 22:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16E528154A
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472C01F9407;
	Fri,  4 Oct 2024 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kotMDb/0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9941F9401;
	Fri,  4 Oct 2024 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068659; cv=none; b=QPrhunq5anJDOBaGXD1TthcXqpcqo7I+6Tr3NGp9YVQlK4CO+h83/MdpqJ6p03+5oO/6rj8sU/C8HU1vmqnXKoscXfxxxoznAoAytWfxsjk7geBFymVAid0vauZKdrm3i8xC1OWDgo/pd7fRTYmDrK9iwOOWgMF3b2WVStZd9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068659; c=relaxed/simple;
	bh=dW6LClOokcp76Blkok3lLgQhE08zfgLdNRZRsKjHXdE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fGs04k9dBGVdh+PL5V9y6UYvzAZJ8jvTjXFS5k/vPOqEXXUtUBoYLhEzCCJJO3Ggcm/titky9VNUco9nVjYNZZ6qn59OU6vZozsIYI4/ioJpIXF9Giry+UFVKTH64gVAjnd9m+LnJlV/xoqRsHgIegKTxUQNs+xKc/26oAZkMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kotMDb/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57085C4CECD;
	Fri,  4 Oct 2024 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728068658;
	bh=dW6LClOokcp76Blkok3lLgQhE08zfgLdNRZRsKjHXdE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kotMDb/0T061T1sh8A7W+c8gOxKPH8A1v+zHnkGpF7nNZoJj7HVIi6HPFIY4HcnWP
	 pIKgkSmqwJMmTrNAsx2RwwkixJ7pBGrgIsnFpPlI7UKrW+Ngjli1GJIASad6Ph1PJr
	 7Lm2WjbwXrkLZ2rKYnlKhzfyVSYykxqVnqAL9cIMwN3N3XcXcACJIf93JatpGFwz0n
	 pIdZrmfk24NJ+qCzaT/9mdRDaDMz5mE+4bRJkpIaAMsUYMxTQoE3S0IZzrKpa8LBXy
	 c6GnKXX3rEZjcZUMLak5XGdxzd6ry9jhE2VjYJP/KozGrjiG66rZnlg/irqEzY9s24
	 +LL4vyS+atmKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A6939F76FF;
	Fri,  4 Oct 2024 19:04:23 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.12-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0izSML-nVycdK69DwRuqdixnvriqkMm2ZM1eYRiqddYMQ@mail.gmail.com>
References: <CAJZ5v0izSML-nVycdK69DwRuqdixnvriqkMm2ZM1eYRiqddYMQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0izSML-nVycdK69DwRuqdixnvriqkMm2ZM1eYRiqddYMQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.12-rc2
X-PR-Tracked-Commit-Id: 3be5c171025baece9a0793170eb3b47ad08bf6c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1043b6765d6ca310a10be342e25d5451d58ee53
Message-Id: <172806866163.2706447.11424712123365524863.pr-tracker-bot@kernel.org>
Date: Fri, 04 Oct 2024 19:04:21 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 4 Oct 2024 19:40:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1043b6765d6ca310a10be342e25d5451d58ee53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

