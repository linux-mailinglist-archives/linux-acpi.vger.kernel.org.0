Return-Path: <linux-acpi+bounces-15694-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A6EB26B98
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A771CE4DE6
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D058F242D70;
	Thu, 14 Aug 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwqDsygz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567F24169F;
	Thu, 14 Aug 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186532; cv=none; b=sFKV+7a4EWIuqvm0U0WetekKP00OsgJPfX9Qxpiyh6xdXGbyvbhswrL6AEap73nGzXufAeJercTiXGPeidkdvYenN36dUQYTci9uyIG8yf9v1IYwjSzoVWJYtq9EkX7k27CylS6vC5I5z6f0Aa09TT3uDiT6f4NhsOOJJo64ICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186532; c=relaxed/simple;
	bh=eIFsSz76AliyucTe8pPVSzoN+vUPorQO/IOjxs+h3Zo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iqjR3+7a2F1iCVhUqtMLsAZLAbfROLiqvHEMgzjQI8jmewIIcqSGNL0/CSasx9KMOZ6aFW2ZnMrBBs0EeqWNnaZk7emmE6uedf7eDlogY3M3o5AievTvjyOK4rv1TwSakRcHlgyWuNkZX6VROfLORWnu1/Z5apjhajjKZ8WN3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwqDsygz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8546CC4CEED;
	Thu, 14 Aug 2025 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755186532;
	bh=eIFsSz76AliyucTe8pPVSzoN+vUPorQO/IOjxs+h3Zo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZwqDsygzLrWWPnBX2KI3Q86s0C7zGhpBaZZ9BIpBG4pkiggSUiRAGhIuY2dv6Jg7Z
	 4/jYDwuZqSerk+ErjeLHM/LX+Nh0C81NqIT6EVXIFt4KmgmaXksp3bAplmEh4GvwBW
	 Z8vzGGDuFGWWTrwQHdfMUR66aowooNEujzv+rq4mi6R6BNdy8yGrslcvWfsdDxgcdi
	 cVQsxR1WVFIUq13yyWjToBpWQVEA28gliflzf/+IG+1oTdOdBXPmSMQjloLRAJyfXH
	 2mhNuDdKCZEao6zkQO2x39RYei/3M6NAjyatXEswxFNodYRvBklUAfhAVjc/IDQMSJ
	 /OCHV6oxg/Dow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E8C39D0C3B;
	Thu, 14 Aug 2025 15:49:05 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hdFatBoM-o3s_-+Q+529npq8FNo36pESFQrBGqZJdm=w@mail.gmail.com>
References: <CAJZ5v0hdFatBoM-o3s_-+Q+529npq8FNo36pESFQrBGqZJdm=w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hdFatBoM-o3s_-+Q+529npq8FNo36pESFQrBGqZJdm=w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.17-rc2
X-PR-Tracked-Commit-Id: 40f2f1aa62578547e2977e8c0516048e0b71018c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24ea63ea387714634813359e2c8e0e6c36952f73
Message-Id: <175518654369.350189.11395102858323243449.pr-tracker-bot@kernel.org>
Date: Thu, 14 Aug 2025 15:49:03 +0000
To: =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Aug 2025 13:34:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24ea63ea387714634813359e2c8e0e6c36952f73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

