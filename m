Return-Path: <linux-acpi+bounces-21010-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JXkEKmBDlmmYdAIAu9opvQ
	(envelope-from <linux-acpi+bounces-21010-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 23:55:28 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0213E15AB2A
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 23:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD7963036EDB
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 22:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1389333891F;
	Wed, 18 Feb 2026 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEQaOZPU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0E3385BE;
	Wed, 18 Feb 2026 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455325; cv=none; b=e0IPkdAE6ee1/jIe8mFTqd9KMTMJoygpPwbsybZ66gPQi9rqL8DjchiWq2q8huKLY66MijapvCcsSzlHhuBHdZpHNc9UKerZHx9Q7GaHwHTyDwn8lEBaPSFlv1PXjc5hVZALqJ1oDmeL6voCvnEj1zZf03MdDdl7Bo4usgUv+Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455325; c=relaxed/simple;
	bh=6aqgvQld6aCfEz/xLzB4/1vXCBciFhMeIO5U3VgTAr8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bXlSAeXTfi3nWjxw335qSOBnysMKSCGlqzhU0gCMUHgfCHVPgO9wdK9TI7wOcE7NI7KEmJSuPDOZUl4e9gIlIeFXMTDMRbmVco73wvuBchRpBCgVfUN1IDv05UMZMQ6oOQv0ydPjXrB/EZJCZ2eM5vZiCCX2cHb2xLQCbm8mp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEQaOZPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEFBC116D0;
	Wed, 18 Feb 2026 22:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771455324;
	bh=6aqgvQld6aCfEz/xLzB4/1vXCBciFhMeIO5U3VgTAr8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KEQaOZPU1qUtDUGWH+lc/ioU7hMDV5Sqm0f07eEWMouJ9O5Dn1Ge2xfcKEdo8EoDb
	 bW8HxY4O14FgKh2nbXlZRdjhIuhFifbuh78fMM+Mm6cg0Oz9S7adKeAbJQB/b7ezmy
	 c55KXV+W1Yv6E7Apip1acih5okXsYezmGaKGUcjEpjwQpzqoD3otzkPwq0M0ip6SST
	 9Vf0Ncb3qkfsXoNJj30FHx/QYHz8qyJDN7C+3pMz2iMyaX9cBZAO9zZbIJw74hyV2u
	 aUEw/ubrTbiqaE2T3K6YpjWYyBxQRyY+vBjmW+5tIhfsunKNKLL7Pv2kjFkpvWnvAK
	 i9OI0Ow017aMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 48249380CEE0;
	Wed, 18 Feb 2026 22:55:17 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI support updates for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hz6b7Dtr_Q40y8yqQ+iOrzcobuALzSM+p7tyTKZaKScw@mail.gmail.com>
References: <CAJZ5v0hz6b7Dtr_Q40y8yqQ+iOrzcobuALzSM+p7tyTKZaKScw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hz6b7Dtr_Q40y8yqQ+iOrzcobuALzSM+p7tyTKZaKScw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.0-rc1-2
X-PR-Tracked-Commit-Id: b89d8be0dcf9d734583f10d88b85256ec67dd0dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a199794fd789c783d34281ac1acde011a7affa8
Message-Id: <177145531588.1584616.4502787825844853557.pr-tracker-bot@kernel.org>
Date: Wed, 18 Feb 2026 22:55:15 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21010-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-acpi@vger.kernel.org]
X-Rspamd-Queue-Id: 0213E15AB2A
X-Rspamd-Action: no action

The pull request you sent on Wed, 18 Feb 2026 20:53:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.0-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a199794fd789c783d34281ac1acde011a7affa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

