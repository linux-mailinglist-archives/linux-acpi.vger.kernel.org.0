Return-Path: <linux-acpi+bounces-17491-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5020BB23A7
	for <lists+linux-acpi@lfdr.de>; Thu, 02 Oct 2025 03:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BC019C642A
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Oct 2025 01:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDD1199EAD;
	Thu,  2 Oct 2025 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU8JQJVh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8489B82866;
	Thu,  2 Oct 2025 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367453; cv=none; b=PRMA7WfuGYJyNHHlMZ7Cao2fSu1dTufqzsxRjtvBTEW2JCmb9B3aqGTp8QozQqsZlmLQJHSLTad8G6krwG7YTNq/T8wbTRQhuGQf3UJkoTaIXxwxTLYR/YGeiqUr9EwIN5jwoa0XMkn5qyBnOVOQAX4foH0g1CeLRapXQ7/lEu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367453; c=relaxed/simple;
	bh=Wwo3f7/SRNITX1uEFdH1bofzmMlr5ApLWxagxMGq0Ns=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cbhRaou3HatbJ/H2fMVxMC3LGd2NcaN1UvDP+U3pDKTHpy89H8SN+1BwBfv94CvYJJnzNp3sGtMqXsKTPTGcAfQ/2Ehmnm0EvRh92AScAEfnRmws0Yj+Cmq3/7tx8Y7SBUg91tdE3+P1blXLZHPEuOZeMmSBfQ5Zxfg2zWvF6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU8JQJVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0C4C4CEF1;
	Thu,  2 Oct 2025 01:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759367453;
	bh=Wwo3f7/SRNITX1uEFdH1bofzmMlr5ApLWxagxMGq0Ns=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QU8JQJVhtdNh9ZRLBgQtchTl11kJ626mnLug37Q76oi+pT7bZdTizXUDHDsErdWlx
	 PJwX6HJxC9jnpNjVKxZmbszEWEKs03O4MMWSXp+fSsmxvb94D1P7VAghZJo/fLHG/r
	 dWqcySioGB62RRmaf+ULn/xxtkD8knmLFPFr1R09tXpNAlE7hMkpjLbgAYyvBMQ0Ht
	 Xf/aUJS4eJSbajjSMa81UNexe1Jqtcaq5kYmhzzzfhtr26o+Q1H5ORJc0uQ5E3vN5U
	 LU4lTKgCpfP3YcQ/wUY6RdTIxjq9lwjhejt6B0JT+15/AQ3xug1mGUymBaKg5J++QL
	 6/VZCP2nVqrDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE6439EE03D;
	Thu,  2 Oct 2025 01:10:46 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support updates for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jcXB0jGz_50Fr5Qj=p9esKE9565Y7_+qQjer-DpnOn4Q@mail.gmail.com>
References: <CAJZ5v0jcXB0jGz_50Fr5Qj=p9esKE9565Y7_+qQjer-DpnOn4Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jcXB0jGz_50Fr5Qj=p9esKE9565Y7_+qQjer-DpnOn4Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc1
X-PR-Tracked-Commit-Id: c87072064bd482930a021e88c11f438e780d36de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 679a16399af08088a83e1d30e01c31832f055ae7
Message-Id: <175936744579.2689671.6699663346930555174.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 01:10:45 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 16:55:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/679a16399af08088a83e1d30e01c31832f055ae7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

