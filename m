Return-Path: <linux-acpi+bounces-20916-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF7LM9ioimlBMwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20916-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 04:41:12 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 753FB116C7C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 04:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F7323044168
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 03:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB8530BB91;
	Tue, 10 Feb 2026 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvC+EnKg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2628A2D0601;
	Tue, 10 Feb 2026 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770694809; cv=none; b=ou+UKLXypUj2xCwWegZavbA1/34OAYuhZxDmzXJdHkw+0Gtq8rve0co03kWsPMupAEhXtwuXoGB4LanO4Jd1PbyrAF1If80W/lFnSgVRR3pojCLG24bOSPI8K3/kwlvHsQBufn5RUkIs2SxdGksAplfM9mZN6kEmjph0Wwredx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770694809; c=relaxed/simple;
	bh=85g67HjY/CKEeWxPKTqjQ612hlMC2Lt/JkoPbuSq08E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WiFdSCj5CxjglOXHzr+P3tyC1VR5a6ehJXvl3OsSz4jjrh1ml/vVkdkNsW7N6RKwMgmsIZ1oV5LUi19irDwGkBk5h8e81QgathwsMtAHBru/PaFYMyhZTaWJmmdu8S0a8r5ODlXSSWqMHawJ5IUp7eJHbKWE5YmHZOChPAJro+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvC+EnKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCCCC19425;
	Tue, 10 Feb 2026 03:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770694809;
	bh=85g67HjY/CKEeWxPKTqjQ612hlMC2Lt/JkoPbuSq08E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RvC+EnKgGxgvN+ENWMsQ1FnR/WGXFtlqjs2QTfvupGqYakRScOUN2IJGPI4P3h1ss
	 B7rmYyQhZdl9i6W1S4YkFNJHJumhvD6lnJALzduFMYdAyNZsiV5ZMxOoMeR1nd+VIX
	 vfD9yusp9zlUfsLBoaKEXCnrxXF5fBZUt8oC3XksZuFmuaeIk9oWzpDjQV3mULd0TW
	 xwf7JAELALWAUOYMcXw9R5fkH+syHlmNpdazDSfxcACcenK/TNfCtgXID/wwDS3snW
	 BBGrbRb8htpwfEn6NSTLqWJXzQRIqcaZ5ErT8UVhick5FUmEiMZLJfAwynw1JgfDRW
	 ssHbDXxSv6LPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E48E4380AA58;
	Tue, 10 Feb 2026 03:40:05 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support updates for v6.20-rc1/v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hP_9QeMbeB=oa8+4GaO77HuhpdqEngHsd2K-sF_yQ+Ew@mail.gmail.com>
References: <CAJZ5v0hP_9QeMbeB=oa8+4GaO77HuhpdqEngHsd2K-sF_yQ+Ew@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hP_9QeMbeB=oa8+4GaO77HuhpdqEngHsd2K-sF_yQ+Ew@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.20-rc1
X-PR-Tracked-Commit-Id: dfa5dc3ad3b15a519101f134ed76c068526004e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d84e173311c4f0b0300755e6445f3224d252eeed
Message-Id: <177069480489.3327783.5607057782875341035.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 03:40:04 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20916-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-acpi@vger.kernel.org]
X-Rspamd-Queue-Id: 753FB116C7C
X-Rspamd-Action: no action

The pull request you sent on Thu, 5 Feb 2026 20:40:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d84e173311c4f0b0300755e6445f3224d252eeed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

