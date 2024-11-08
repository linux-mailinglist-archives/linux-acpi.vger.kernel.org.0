Return-Path: <linux-acpi+bounces-9457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C189C280A
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Nov 2024 00:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1E91F224B7
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2024 23:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DF91E32B5;
	Fri,  8 Nov 2024 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUD/xa+q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD101E2600;
	Fri,  8 Nov 2024 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731108291; cv=none; b=SKkYODcplFagczZauOY2U7R+fI9jZvNr4Cym5FYqcMUBH8NgZmoYC4HG/Y7OWbAckE6GnEKwmQrntRWov/ODbFJI66FN/NrWErTygKFVMaEkO8QyG4/per810P2SLG7hO5AXvBVIdcEn41pjB4C6vMFANpKDIFZOeaU8VYRc4l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731108291; c=relaxed/simple;
	bh=cu+Su9oxVuDTevOHwr8aLaICFzYSL67WwuYtQXgvTUc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G0Cru6BeyOVZ/oRNzLKWnkRbkj224yOq1y9jysfoJ3MC3Lbir68tJGdu2RZAh6grvqz9XP0LA7DIWHbpbXIah3XXAdIhScJRD2dAklJCeCKo9zn3MHmIZoAIyfGn34913rSACRexMIU7VH/ukmLA6sGwekX1sxQjVV5+ZGWiRGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUD/xa+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99A1C4CECD;
	Fri,  8 Nov 2024 23:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731108290;
	bh=cu+Su9oxVuDTevOHwr8aLaICFzYSL67WwuYtQXgvTUc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LUD/xa+q/G7sEeEINQAm/tjI+MfpRdtg41x/CPCXoEWhOVWMa7dqpWFyfZ4E8byZ9
	 4nYiQPwX9ZOeeIs+1hCWqyr38NApcYmKmplWXeAvIn/4Ib+x8ENHwYuf6dgpdKTXkL
	 C3sUOx9boT6ucngI8t/uNcOOd2rTLNeORRLamrTbnr2dvJO20TnRXOFhYl+J8mxST5
	 ZRleTSuBUQNHFz/2GvSrRB9OFzsn7XViMHbGe6p/tg/wDroqUiJM9MuXXcAJvUkhfW
	 aTnVGbn2SLVvvtSmq7fpAezQFtYUkmxUMcXm8zZoCr8EQmvRT0FBx/joF17X1RQzm4
	 Cj/wdjqytRXvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7142E3809A80;
	Fri,  8 Nov 2024 23:25:01 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.12-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iiZQV=G_ZTomtK5isPEQFJXmD+wzztDSvumcx56uSw+g@mail.gmail.com>
References: <CAJZ5v0iiZQV=G_ZTomtK5isPEQFJXmD+wzztDSvumcx56uSw+g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iiZQV=G_ZTomtK5isPEQFJXmD+wzztDSvumcx56uSw+g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.12-rc7
X-PR-Tracked-Commit-Id: b79276dcac9124a79c8cf7cc8fbdd3d4c3c9a7c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7a8f2a504c396f229e6025eca609c4e66f44c8b
Message-Id: <173110830002.2790059.11358672066516785713.pr-tracker-bot@kernel.org>
Date: Fri, 08 Nov 2024 23:25:00 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 8 Nov 2024 21:00:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7a8f2a504c396f229e6025eca609c4e66f44c8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

