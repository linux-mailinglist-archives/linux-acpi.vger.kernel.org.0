Return-Path: <linux-acpi+bounces-14496-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA08AE29F4
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 17:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B921899374
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C8221723;
	Sat, 21 Jun 2025 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaQHsWyV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EADC22156F;
	Sat, 21 Jun 2025 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750520823; cv=none; b=XYKzwJ6fhb00kXKa7+5yKPKxaOY4WczwCrjnqEfwzUjeTLAKRiQ2rYu8TyoMHi9D9bei7xGZ+bzm0bis0YAaAGPhYddCze2ldZ7z4HlN1VOT6sfHJ/+npAeo7cTiVw8uqmz2v13VcCRvF/8OTrl4PHWqZKe7jnUl2RQcc6w9Ci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750520823; c=relaxed/simple;
	bh=r72WIju7XMY8JvBxvpF6buIzM8NqF2TTpEHw66b6MSY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jMlpOmDijdyk8wbQrZlMW7Py5cZqQduLvxmpcxWvo8jRttYcscYpZYj3nFuh1QfnObb6s3JzVXWtZEyQQAF/J+Uhgr3rBLa8sEbBl2YcsHvdvsGiMz7XUrx3ltZAk+gQCZt0TcqurwVN//7u/4DPyN4/uUtV7/2IAv1xXod41OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaQHsWyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21463C4AF09;
	Sat, 21 Jun 2025 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750520823;
	bh=r72WIju7XMY8JvBxvpF6buIzM8NqF2TTpEHw66b6MSY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KaQHsWyV+DdUlGT1QD76X4Phx95MM6xOb+ikA4VOO2caOds4Q6s09U2tC+x3UTmUu
	 IAV5ZT/8+v1LjbC4J+F5iVDL88VBAQ+f1QeZSSjK/GWBdFE2J5ZDtD/EeegYkMjuAc
	 j470ttx8MzRVcYn432PTDGRVtueN6OlDQEq/yL74FmwNW277qpOCFj8/82wVdi+x9C
	 RttTWV5LYqASEqtcT3T54+ynAKGAD0mTWghojX55EoaDlf/2DBtD4Sjv6Yx5J+1S6T
	 g9Aac4tlEcSDNsex85/c5abvN7hLonG5lZVGUxLEjqmH1euYB9pYEbty+drm0/txsp
	 gHfbsoCovHuhQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACD538111DD;
	Sat, 21 Jun 2025 15:47:31 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.16-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iNVFFJVgzeMx=+UMw5MTOUgdu_WGpJxE3qjHikQ4Sp4A@mail.gmail.com>
References: <CAJZ5v0iNVFFJVgzeMx=+UMw5MTOUgdu_WGpJxE3qjHikQ4Sp4A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iNVFFJVgzeMx=+UMw5MTOUgdu_WGpJxE3qjHikQ4Sp4A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.16-rc3
X-PR-Tracked-Commit-Id: 6fcab2791543924d438e7fa49276d0998b0a069f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26fef998eb4df8781c038ffa4be8287219a8df0a
Message-Id: <175052085050.1887408.18085858719363321608.pr-tracker-bot@kernel.org>
Date: Sat, 21 Jun 2025 15:47:30 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 21 Jun 2025 13:31:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.16-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26fef998eb4df8781c038ffa4be8287219a8df0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

