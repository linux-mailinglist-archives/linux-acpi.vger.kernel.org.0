Return-Path: <linux-acpi+bounces-18389-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 480E8C23111
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 03:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECD544EFC40
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A9C3126A9;
	Fri, 31 Oct 2025 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+gBHpUQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98B6311C24;
	Fri, 31 Oct 2025 02:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879134; cv=none; b=gfPtZVsAJ28oT8iofr9w59WGU3NyLl3/nPbPC3uOvoJUTFPEohbJd1NIHSIUYZp9oA7TZPDikOsWXHbXS1ek4DQuATtBygsC40WzZqeW3aybhB8VIgjoAhKjDeJORM1t/S32DR0VF7MzzcNOY6DnkCbKvfiG8idrwo7d/2UC4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879134; c=relaxed/simple;
	bh=F97eyzduk0dtXXS79jtjFLiPCjGoSa9uJnW9uDVLDM8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=su2GxeGZjbprWosiAakwEEZahEofK5Ihg9sXmDJ+IVYvFSYHSPXTLi7s9TSQm7lgsBAlloe95LVWMDQbeDBe768mbZfj1ePER4PSC5xJKo5MWvnSET8Rn42oFRNxkhfo6IOqvNABWOO7s/AOhVJRxQ6Yz69CZaGlSOUQeezUVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+gBHpUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C152C4CEF1;
	Fri, 31 Oct 2025 02:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761879133;
	bh=F97eyzduk0dtXXS79jtjFLiPCjGoSa9uJnW9uDVLDM8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i+gBHpUQb0ly3PIMeYmPf3zO3nnkX1ACN8tqWYxfGj5gXk0NXK4bESKVgtNABsDBL
	 1MDGKE4YUl7JA2mh9kH5HQiqQaoUekKDiMzBQxNLBeiAGeH5q1MY/imr31LzUmQVcl
	 04+/ENIgLzPCCsrXbwTPdQgfjXz6cM6txaw8I2lCKa+S3ZWbPusu+s90jm/LBJDBNg
	 xau6RUt76PD9dEJgb65L3IjwP40Ub7PFrmBXJK6UaxNjapnzNuyIyxexHa1sjZ9cPj
	 mbhnF9dHph0JQv8DuYb6vpIUJC3td2btfcbE8T0TTNms5/6LPuIC95sDfEYR7x2kXx
	 NO5rhvSoZ1oWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0F3A78A76;
	Fri, 31 Oct 2025 02:51:50 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.18-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gWU1sKjFQMcnhP17F4h6HbeX3Fvw4GQDqd6zbQknD4VQ@mail.gmail.com>
References: <CAJZ5v0gWU1sKjFQMcnhP17F4h6HbeX3Fvw4GQDqd6zbQknD4VQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gWU1sKjFQMcnhP17F4h6HbeX3Fvw4GQDqd6zbQknD4VQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc4
X-PR-Tracked-Commit-Id: 8907226bed1ebd10d069f6f70ff0aaa8840f3267
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5355e98accb20d8ea06008fd8fb5755cc52e8c0
Message-Id: <176187910954.4119220.4537946220956420368.pr-tracker-bot@kernel.org>
Date: Fri, 31 Oct 2025 02:51:49 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Oct 2025 20:58:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5355e98accb20d8ea06008fd8fb5755cc52e8c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

