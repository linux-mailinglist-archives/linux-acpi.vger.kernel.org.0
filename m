Return-Path: <linux-acpi+bounces-12664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9913DA79947
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 02:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502067A5228
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 00:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991682E339D;
	Thu,  3 Apr 2025 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJxTg9w1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8912E3382;
	Thu,  3 Apr 2025 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743639064; cv=none; b=pffdTdCrIgdWTys9Dgz4zBDyo4pBkFKS2ThX13KR/x72WolZntCtlCdFi/lNb0O1V3LpllD16nqeagk4g3mtVKaXO8HmfHdWl1W4bpFSRO27jNco65b4wvp9VVeufhOtdZflBbi55dDGpFUHDB0HxW3dTZCNwl+GG6AnCruKSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743639064; c=relaxed/simple;
	bh=3iyqj35pahwtODecXPIHosfxycY1vY07hSbo8ZyT170=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rlY1S/XPjreCTdfbvvtyP4lgl5etS24MS0b02+FIXZEHM8f/xsmgDtsoR3juPLdz30J5KJF4qNYxxX2lC/Mt0OEgmnYdZrYGnRifhD1pFwdNVPBOVizNU2zZypDAN/QLFtAwXdOPcFwwZYgv/HkgRbU/LrVi6th/CPngf2c8cyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJxTg9w1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4F5C4CEDD;
	Thu,  3 Apr 2025 00:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743639064;
	bh=3iyqj35pahwtODecXPIHosfxycY1vY07hSbo8ZyT170=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KJxTg9w18dZsV8CO6xZkZlypSY4ucbgriXezS9OS8pId38jiOdq1TD+9wswjh0d09
	 Mxi/NV2ttB1GkzyCGZErCL4s7DeJHnjGvzZnOsKVSRRRVU+7kVrG6vQMLuU73xEIG/
	 uasVZZs0gHQoPqquPPe7xtJ293MLau7n6QMs7RAvNmZuSYC0aMw2G3gbjCALD5hS8c
	 e+00+60cNYe8LMDVSsmse/mhApiXuoff9ldN19YhTOB4kAFZQRU90oI6V1m1shf0c+
	 qtiiR+bNqS2o5oAkUUFInhGt40EKrfqp6yNJWsMdatJeTnW0zIdQ9Nnom1SmWN067u
	 pFa5mLEUcc2AA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E30380CEE3;
	Thu,  3 Apr 2025 00:11:42 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gEidr++vOdw9rAe3z=TCU5jfAY6_6WJrm3_VD1nq=8Kw@mail.gmail.com>
References: <CAJZ5v0gEidr++vOdw9rAe3z=TCU5jfAY6_6WJrm3_VD1nq=8Kw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gEidr++vOdw9rAe3z=TCU5jfAY6_6WJrm3_VD1nq=8Kw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.15-rc1-2
X-PR-Tracked-Commit-Id: 9e4e249018d208678888bdf22f6b652728106528
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0a02923c2cdfc4b8f1ef19181bf40f6529812d3
Message-Id: <174363910092.1725867.10152053861008073178.pr-tracker-bot@kernel.org>
Date: Thu, 03 Apr 2025 00:11:40 +0000
To: =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 2 Apr 2025 17:01:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.15-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0a02923c2cdfc4b8f1ef19181bf40f6529812d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

