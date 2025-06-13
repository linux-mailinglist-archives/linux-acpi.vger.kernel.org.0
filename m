Return-Path: <linux-acpi+bounces-14369-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EC7AD9696
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 22:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD831BC1620
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 20:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCEF2367D9;
	Fri, 13 Jun 2025 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZeou1qz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51953C148;
	Fri, 13 Jun 2025 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749847338; cv=none; b=WVnHXtN3fs7t/aArPpkc1hrsl4WGPrhU5SBfXJEOl9+MJVxVW0p2KClushjRM+QpXIDkthBCv3Na/JWIjdiaUpwjf+j+qbUV7xrh6rDElAeAVVQ/NLiOT4bYcP4QOTnCcQPwxmMRRk5p1/KvD4RmFB2gmhIGS8YfdwPh2uwnEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749847338; c=relaxed/simple;
	bh=ER4pslLnz2/Cof/EjBB6bbhLy0frs1vzYVqECK3pOLw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fPO9jzPktckp76FNq75F6/OT5aiLvlJMX6xNn6k+laTPcrtVfvte/Ky4+EPWEevkxSwB8PUEd5oL8llpao+HY2om5wv71o6w5kmtFA6IFvSwTERZ+2oXxWSFOt+8fUV6VdYU14i+HJUQw5Ttvvx+dDl1zo6qHxS8AZCHmH16lTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZeou1qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB89C4CEE3;
	Fri, 13 Jun 2025 20:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749847337;
	bh=ER4pslLnz2/Cof/EjBB6bbhLy0frs1vzYVqECK3pOLw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uZeou1qzfql/0AZCCSY1QkIYJjMhEnkThxd5sifzQRmSl6HiS1XYYEvxogL0SEwv+
	 CL31wFivxSnXws2NhEMMIWrf+HPgtNODOGOb8WThaxqeeFrD5o0ozUASe0w/AG/DtE
	 cVHSId2mJMydEBMjq54s3AGAiq7IlBOqy3vPcLKZD1qhEyTw7eiBmKGAebhY1HWDAg
	 z9ZrclqUp12gmRouwo/Co8RRRJ8wLYtziaEZWM2k4WsK2dCme/Mz7GNJFhuMBwcIBJ
	 MYTKprbCIEjbCfqQSw2KW1U7SnZwCBzU9QOOa+Wup1jtzpWpHwhJuj7J0eoXUhx/s8
	 yrmeMFw4yJoUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADED9380AAD0;
	Fri, 13 Jun 2025 20:42:48 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.16-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jYie5HkuPkRiWrvaG3szhVO2HyHbN5=D0KQsNjrwMzZQ@mail.gmail.com>
References: <CAJZ5v0jYie5HkuPkRiWrvaG3szhVO2HyHbN5=D0KQsNjrwMzZQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jYie5HkuPkRiWrvaG3szhVO2HyHbN5=D0KQsNjrwMzZQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc2
X-PR-Tracked-Commit-Id: dd3581853c5f190c3a7bd1de78f5ecb2905a77a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f688b599d711d169b22e99f2d055847d66c4e0d3
Message-Id: <174984736737.883745.4658580513454142096.pr-tracker-bot@kernel.org>
Date: Fri, 13 Jun 2025 20:42:47 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Jun 2025 22:15:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f688b599d711d169b22e99f2d055847d66c4e0d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

