Return-Path: <linux-acpi+bounces-6431-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C24909102
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 19:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9767F285F44
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637301A2572;
	Fri, 14 Jun 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJxdA7VM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3614319EEDA;
	Fri, 14 Jun 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384713; cv=none; b=Ud+o0ZcjQUT3Lca2Yr1znYeEMMbMVQTL9+qvWNe1CHx3ruy0CZW33gC+xHv6PYAhUdnNhrOW1sl0iN7v+5ybgwE3uW+ykOkn7IFUe/Z0QpPcWgfEqfunNTAE3kyTmQwSes9SCrUijgt3skcbeHMr6eTT3Rajsb5Z7YsMHekyVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384713; c=relaxed/simple;
	bh=msWPzHfZJFJE7eSWNlwQVdw+VfimOaygVu8T6d8omG0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t5S97FtgYJ7zYVR8OMEtZoNik2LwlzmC3H00iXUkt3imnrCd26I4/oSHYk1mBg+XP/SyPhjXXw3hNMuSJPkctNmLliG1erjCNeCfVcmmWLFLR+8GukEdBdupEYiDx084sm1wVg58KcODcSNJ40c2KGVrCmdAVpOqzQ70r1ppgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJxdA7VM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB266C4AF1A;
	Fri, 14 Jun 2024 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718384712;
	bh=msWPzHfZJFJE7eSWNlwQVdw+VfimOaygVu8T6d8omG0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VJxdA7VMTjBOtFHJvxBQqTdcK+9hPV8AraqQOw32TmrjWcXC24IGi81jVLhEdQYcq
	 KWrizQP8Q0anQumOgerVdvJ152yDfTnLiheuyyWEuE+VFFQoymUIq2a0YbcAFyPJr7
	 J8kqJ+gQbb6bzy32KSuVOhBNTADM7x53d89zrcWFhXBd3K+eL+e3RKVTGvZhfZNyfO
	 1cYY2pDv3p1veCYGZmERAIIXX/TMj8/BKv+WJvaZaYwoXyFL2jTkkTD3I4LXIwsv94
	 qKUu09UcCUafMe9bS9N6RBvQqLe2HKzwrhlyxxn1/wldrcJnePOJyz5qH8jFYKyNpl
	 8qqgWw/cLEKGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D4DBC43616;
	Fri, 14 Jun 2024 17:05:12 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hki_YFWhBU8vZ9eubo0yVhDGRCx893Qd21UENaNXfaNA@mail.gmail.com>
References: <CAJZ5v0hki_YFWhBU8vZ9eubo0yVhDGRCx893Qd21UENaNXfaNA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hki_YFWhBU8vZ9eubo0yVhDGRCx893Qd21UENaNXfaNA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.10-rc4
X-PR-Tracked-Commit-Id: 04f82fbb8686995f17b51ccd23c10fee12f1a2fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94df82fe5bfd6e38ca33d70b97de289055b33c7a
Message-Id: <171838471263.1909.13211105715294135911.pr-tracker-bot@kernel.org>
Date: Fri, 14 Jun 2024 17:05:12 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Jun 2024 15:30:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94df82fe5bfd6e38ca33d70b97de289055b33c7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

