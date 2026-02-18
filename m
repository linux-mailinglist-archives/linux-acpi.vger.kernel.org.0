Return-Path: <linux-acpi+bounces-21011-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFUsGnJDlmmYdAIAu9opvQ
	(envelope-from <linux-acpi+bounces-21011-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 23:55:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0747215AB49
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 23:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E48CE30488DA
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Feb 2026 22:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BC3339863;
	Wed, 18 Feb 2026 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfVWVzDZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F551338911;
	Wed, 18 Feb 2026 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455326; cv=none; b=Z6jht9T5Mu9wHgOVyNTw/T0Qild0Bbi9F6uI+eJtHop/2M4bynGm/VuOPwxNeq/ojvj3Sra4dveqOVK3JSxoD0xQRO6tleqLifE+P0oiX+w6M985s+ZwKjyfbFyrRoY9Omj/dI31CfqozolUxaf+OIwiR6P/YSGVxtF29rVpsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455326; c=relaxed/simple;
	bh=V7Jwuso2T5zb+SJ303/rseUojjGdDUmtBHne8zleNQI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=URdplq5riQd5VZKrOlTrHpDoU0FzQ6+XO6fEA9K+nuN9BjkP5kbRZBRy5KGo4xk5CmgUX1GV5rbyaMbBEV4LLtw7YCjbr7nnqKMdbKCyUkw6fPjc3rt9ywyCUjEBVlwXNpvNfJ6PRSpsYCS2Hoh1SnJvY0ItT+y3bSHY+NfJSFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfVWVzDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83475C116D0;
	Wed, 18 Feb 2026 22:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771455326;
	bh=V7Jwuso2T5zb+SJ303/rseUojjGdDUmtBHne8zleNQI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EfVWVzDZnTxW7o5xffxImK0hHalvFQxyhxs4hJqqSba6/MeuwPT74ekoOzXcqdTUe
	 E0YWHatewvOJJ6nI5XNz6iXFcWK5mgKSsx6mqw2ZPMKsmClMl9Lv8N26oFqc6daMG9
	 w3ruUVOj8cV9sUvZ5SIC4IOwcq37HEnfoZh5DwLM76KT1eZAP2/knWAjxuWn1/0vcH
	 IeCGUpbmPwVqkfY1/kWGHdsoyqY6KtKzm8LVQriGSJb12yk15a8YLX3oXbIMfQ2AhU
	 eFwyMFF5oBc79ue4ARjU36qrSR5jjZYkGnB3b+R9/u6iQWt0Me5PWvM+E65VUmJrMT
	 p0+Hhvco65Lsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0AFA6380CEE0;
	Wed, 18 Feb 2026 22:55:19 +0000 (UTC)
Subject: Re: [GIT PULL] Additional thermal control update for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hjJN0=wu9CSAOdhsbNUT26cF18uv==eKddCzdK1dHw4Q@mail.gmail.com>
References: <CAJZ5v0hjJN0=wu9CSAOdhsbNUT26cF18uv==eKddCzdK1dHw4Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hjJN0=wu9CSAOdhsbNUT26cF18uv==eKddCzdK1dHw4Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.0-rc1-2
X-PR-Tracked-Commit-Id: 15176b818e048ccf6ef4b96db34eda7b7e98938a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa2827e72cfcfac683e2e3ab355a0dbc97d52522
Message-Id: <177145531767.1584616.12776341501318860972.pr-tracker-bot@kernel.org>
Date: Wed, 18 Feb 2026 22:55:17 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-21011-lists,linux-acpi=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-acpi@vger.kernel.org]
X-Rspamd-Queue-Id: 0747215AB49
X-Rspamd-Action: no action

The pull request you sent on Wed, 18 Feb 2026 20:55:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-7.0-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa2827e72cfcfac683e2e3ab355a0dbc97d52522

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

