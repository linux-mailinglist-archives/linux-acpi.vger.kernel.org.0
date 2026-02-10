Return-Path: <linux-acpi+bounces-20915-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAw+McOoimlBMwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20915-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 04:40:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C1116C6C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 04:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A579A303CE37
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 03:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B53430ACE3;
	Tue, 10 Feb 2026 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmvgx6pe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0799E3074BA;
	Tue, 10 Feb 2026 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770694808; cv=none; b=I6KcVUppcYw3gxE0Zux0FMxaYC8icndh2jfz4noaCgeXBF5Nlj9sgtBXuRG4NGEW7XrWKqhnUBb65RtswDLdC9vMH7YcTX65zx95ExwhgHUvgtkfL6rZriiSvwZVTU2sWwUcfCfSHa+DEWRAqSjk9WjqMbXHaqDvhxIPTZ4Oamg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770694808; c=relaxed/simple;
	bh=TWM2RCunXch5XPS8I5jXkjxIt+1qhYOtUSGFlY+w8zs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SxFKIPfUkySrV82Kg3aE18Lcv+JarkQhrCUx86Z9zu3Y6eygS8Ywbv9k891ADtQn3Mfr6po3KFtZy1PdzTX94jI9VgD+U9heuOpJYNuf+tTUsCIpcUQ/wlxPCsWIQXQ/SPIPQp3DKJPtIjLNTjLVZFKRsMtj/MTEf2FFCe9OdRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmvgx6pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E34C19421;
	Tue, 10 Feb 2026 03:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770694807;
	bh=TWM2RCunXch5XPS8I5jXkjxIt+1qhYOtUSGFlY+w8zs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Pmvgx6pe5E9c8Is517OPEDYqR+jw7X3DPGRCpZ4PAJl0P36UaoFGiRTlOitWMYzbd
	 9VwhdPhwwkZAbUo7M6x42ZlnpYbZXUkqj4yaJBHk3CTpOZlCmY7pFf3NjpozutzrKP
	 T5QF6wW4ZkrYHhttNUhUo0++bWFAWLwiH3Lhq1IJN7Yydf6kfbsoylRWBPSaWZ3tP7
	 l0JcSs0qagjEsCs7dQwkaMlbt1WDekATsowrIqZ1TVLSHLiQPPxVdp1AuN1Q5rDicE
	 sR8eOpFLkK5O6O9Di0Nw2FT2PUNb/mAwtZ0+y2rIVGbOF7R6nNSUpUdtrNVaeX1Sdv
	 cWYuyaNJUKSgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C654B380AA58;
	Tue, 10 Feb 2026 03:40:04 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.20-rc1/v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j8M0=M3hO3kJKRPA4Q99TgQODRxPoSu5RFe6qV4Cv_-w@mail.gmail.com>
References: <CAJZ5v0j8M0=M3hO3kJKRPA4Q99TgQODRxPoSu5RFe6qV4Cv_-w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j8M0=M3hO3kJKRPA4Q99TgQODRxPoSu5RFe6qV4Cv_-w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.20-rc1
X-PR-Tracked-Commit-Id: 0f64b6acb0e14559daf1de7be5dbcee3874512aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b1b3dcd28c271fc8c4a87e81860f3a34b6d29b7
Message-Id: <177069480370.3327783.15372023603319174326.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 03:40:03 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Shuah Khan <shuah@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20915-lists,linux-acpi=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-acpi@vger.kernel.org]
X-Rspamd-Queue-Id: 642C1116C6C
X-Rspamd-Action: no action

The pull request you sent on Thu, 5 Feb 2026 20:37:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b1b3dcd28c271fc8c4a87e81860f3a34b6d29b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

