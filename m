Return-Path: <linux-acpi+bounces-21434-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB0rHhLdqWm4GgEAu9opvQ
	(envelope-from <linux-acpi+bounces-21434-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 20:44:18 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB93217B49
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 20:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F40B230603C4
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 19:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20063D564B;
	Thu,  5 Mar 2026 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2LTJ+Tm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5563CB2CB;
	Thu,  5 Mar 2026 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739797; cv=none; b=lSTxqP0syq8VEVkxOgd9uIFhtFMm8lc4EvGg7wbreyAK06hMiI+usLJVENqsYgxWYeI3COp3l7O04PymE6uahYxH7XDYlNB7H8vuS/WlUX7FkTDleo+Gqt8sAh8Nio8w/oJf7OWlg8Io17pqlpaLGXtuOlc/i0ir6XWbokwxpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739797; c=relaxed/simple;
	bh=+ezaNRzpP2FBYghuxu+hX0+P4DB4a7sR4NaAwDQbHuc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AXyZj+K2GlbMl0Z5h7/uvlZm5L4I5wyfr5f+F+FpWhCGgQsmf5TooyCn6f+cPGa7F4omlTLojxMNEjRmJcvBCW8sBYP7oj4ns2YhA3Q5mHaDqyV6eb/C+v6Sx2Wzuj3E7vCuxuQfCqJcElNjXdLaG32j3r0AGdx7uX9G2bAU3iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2LTJ+Tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E72C116C6;
	Thu,  5 Mar 2026 19:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772739797;
	bh=+ezaNRzpP2FBYghuxu+hX0+P4DB4a7sR4NaAwDQbHuc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q2LTJ+Tm64zeDhghkXJ5oVexVrHQVHabc5MNr7agq/1dM2pO12bF494lAg6h3KpdD
	 eZ1KgJNEdDJDUgvkuch5xQEnemUwu27p4h5eKzkR6ilwGF9EegHBQfKaUtzQgfDNw+
	 fgV4mGp4XJSpnDbeuUWdY6UHVlUi7L5KqRU48jrZDBxGgKVsYTsBmKhhwSXxBp0waZ
	 VF0SjpcVEWDvcUJ+tVZlVFBDcGTe1r5BmPP3KT9WS99aJJbd64JmFO7H1gat/6g1ZE
	 PjecJcqkXDbetCNC2/K/r0a0x3QdugV6YDvHJ6xXeTRjkdqzFlAQsivrFk1v5+RWA7
	 ZnY/i+8v/N1oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0883808200;
	Thu,  5 Mar 2026 19:43:18 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes for v7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h7iE4hg9ni=sCbbqsK+7uqa2+O07ve8T+s8xFa=E1E1g@mail.gmail.com>
References: <CAJZ5v0h7iE4hg9ni=sCbbqsK+7uqa2+O07ve8T+s8xFa=E1E1g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h7iE4hg9ni=sCbbqsK+7uqa2+O07ve8T+s8xFa=E1E1g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.0-rc3
X-PR-Tracked-Commit-Id: 084f843093bee5563b179fd4b630122ba820e0c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 398871616ffd8a793f01861b0ee66f6bee494389
Message-Id: <177273979735.3262774.14171788932502512658.pr-tracker-bot@kernel.org>
Date: Thu, 05 Mar 2026 19:43:17 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3AB93217B49
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21434-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The pull request you sent on Thu, 5 Mar 2026 19:05:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-7.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/398871616ffd8a793f01861b0ee66f6bee494389

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

