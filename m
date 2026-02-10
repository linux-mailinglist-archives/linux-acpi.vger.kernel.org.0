Return-Path: <linux-acpi+bounces-20917-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJDeOCmpimlBMwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20917-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 04:42:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D59116C92
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 04:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 284D53008D0E
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422C23093C1;
	Tue, 10 Feb 2026 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOjAe95b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5CC306D3F;
	Tue, 10 Feb 2026 03:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770694820; cv=none; b=cjJ5WlqCes75yf1bTAkBq9z0YebptIhEBbTbBZpF5uoZkhRFwgBjS/eb51+o5QOT6VLwHJNfhsEV5qpAsWWM1VLLZkIrn+wRJFW6pINAR0wcA2osWD6VMYMA4tsNxmtB4NgsnMdlaVD55lZG8TeHC+fUovH9WNaxXokhUGEz4MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770694820; c=relaxed/simple;
	bh=VftFGMTBeuhAyXIbv2sjBMbIxkiP6/b+jMbSEJ8Froc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YLnl2ApXyMwDGDL3/P+mMbFocOtU0IQt87xEFqUGBXDmiGTtzjVnqP3bU8YISoE7a6XTZbItKf7kpACkte7TAeVU2MjjOAhRnvvY5COw4q5bTnzZJTAQr5buIUN6Piy0I+gsHYLtSQ3oJammemwSCLd2EOYAXjs1t7ow5Kjo5TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOjAe95b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCF6C116C6;
	Tue, 10 Feb 2026 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770694820;
	bh=VftFGMTBeuhAyXIbv2sjBMbIxkiP6/b+jMbSEJ8Froc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vOjAe95beLyaedVwxBpLKn24j6wKZFCSGi+cLdXF6uOuu43WES3aSPxG4C7yof6ce
	 W6XJgHQWTlMPoOTKRURcFTa7vImaTyIRftoP5623FtzjCxvcTiCcQaMdXtdaHHGjJp
	 Qfvfup6gf4G7uTVAO+/5CYrBHXPnhiiwJ9CNMX0dqNP/Op314AJ2nxQL8RgMOzEGLU
	 mIWCmlCSlgu/0sVXoChlt21h0M7zM0DoHaKJe/qfnDqvqHKrYXbESF4wxIyuvU4BnJ
	 vzDYdGzrUoxGovP54SRSfx8jIGg3vhppVXgvJ6/qVQ/2DkzU4SKhmOVky8tCAU/fPl
	 wkWudmuxh6ZkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C209E380AA4F;
	Tue, 10 Feb 2026 03:40:16 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.20-rc1/v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hOUCPEPeE1bN3BkgRnM3ouDX301f5qnK53BTD+oU5=rw@mail.gmail.com>
References: <CAJZ5v0hOUCPEPeE1bN3BkgRnM3ouDX301f5qnK53BTD+oU5=rw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hOUCPEPeE1bN3BkgRnM3ouDX301f5qnK53BTD+oU5=rw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.20-rc1
X-PR-Tracked-Commit-Id: 8035d70cf85e86f36f5eb1e07b243f300a936b8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0506158ac7363a70f0deb49f71d26ccb57e55990
Message-Id: <177069481529.3327783.9914234024033718204.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 03:40:15 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20917-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-acpi@vger.kernel.org]
X-Rspamd-Queue-Id: 50D59116C92
X-Rspamd-Action: no action

The pull request you sent on Thu, 5 Feb 2026 20:42:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0506158ac7363a70f0deb49f71d26ccb57e55990

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

