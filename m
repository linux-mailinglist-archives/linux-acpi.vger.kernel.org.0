Return-Path: <linux-acpi+bounces-19297-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D11C8BFC4
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 22:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C7284E5947
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 21:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49C4298CDE;
	Wed, 26 Nov 2025 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzvlgtX4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A9345BE3;
	Wed, 26 Nov 2025 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764191629; cv=none; b=EbHn+DwYRoVeEevg9UXQRbSw0KVu0SsH8BjMtg9FgNIoYA2qhjD5/oIJPD3PUb/9KoGWKqVv0YadZdSqeQBBhIUGiCdWqxjCm9UgdknOn4C7io6QWDPLbR4W37gj4gLxWUEA+pZQmv6BTvlBBw8hjo0KknwSiuqfwFWGQvboa4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764191629; c=relaxed/simple;
	bh=lSVP+F5nmlRmmOR9RxM46Xh6YBYF6fmIOs3IjYXyRYI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MgkK7EE1kx10Bmf4hEE0IvYoyYFHoCxLgQ9rBivlragdn8QW3XHbxkXwYPc1WMnkub757z4VgvV2xRYpRTGXK7WQ7omioNG76TKlNkebG9sqSW0QUiWURxJzH0JqIjbTyGzfRFiSqeDQc/AYLJTXbzlCDDPzjAQoXf5H7ZFP3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzvlgtX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3137CC113D0;
	Wed, 26 Nov 2025 21:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764191629;
	bh=lSVP+F5nmlRmmOR9RxM46Xh6YBYF6fmIOs3IjYXyRYI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NzvlgtX4PgnFugxM1kKWeEa6DMsY8aXOruPpanRbYhhQHSOnpsieGdnJqhgxVCi5g
	 5kprooyTvw51Aa5Effxu891JzsVmtkB5e9z2wh4dKv8peYz7Vc0WdMwu5cCPcvMYUH
	 Hcb7fwC9qP8Yq2UC8R/sCDUzNxudmoHY0yAgYh6TpjQIVvhXcHB6oNPi5I7GKTRGny
	 eYHhTZntJVtEbE8IqPo6Os1vshvLrEhVwzkpJBsgCShaerkipuAys5Zjd2800UsmQu
	 Si36OPNpT+66oqAwsqgFXJhY5rmyqMz1QFaDXT6UJuD648gmgYapFJ1aPN9BdraHy1
	 zvCIhwvFz/9Kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C09380CEF4;
	Wed, 26 Nov 2025 21:13:12 +0000 (UTC)
Subject: Re: [GIT PULL] Urgent ACPI support fix for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g6c1HNbxxh088xh_nTgD-SE6c2qtDr81AgD1+by-jnKA@mail.gmail.com>
References: <CAJZ5v0g6c1HNbxxh088xh_nTgD-SE6c2qtDr81AgD1+by-jnKA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g6c1HNbxxh088xh_nTgD-SE6c2qtDr81AgD1+by-jnKA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc8
X-PR-Tracked-Commit-Id: 43ff36c4a5a574ee83b4b0d3f3d74f09a3a8c2d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a10d15a08f62bf97c707ef3c2a7493604c1bcc89
Message-Id: <176419159078.1847725.527308176120073524.pr-tracker-bot@kernel.org>
Date: Wed, 26 Nov 2025 21:13:10 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 26 Nov 2025 13:54:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a10d15a08f62bf97c707ef3c2a7493604c1bcc89

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

