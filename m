Return-Path: <linux-acpi+bounces-6430-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF608909100
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 19:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678021F22CF8
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 17:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F2319EED2;
	Fri, 14 Jun 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHZgaGe5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F7C19E7D3;
	Fri, 14 Jun 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718384713; cv=none; b=PhjK9PWrs/MqZobS/gAkYhl+1GunI0G2wG86zPlSfAENqWTfa/mC+/lvuSBUU0qeCYYlgozt1HoAdbvgMGm/ledZ+Q4r7iFn9xw+NEbM/IP5MTWj0YtLXTqysUFM8Ug8ijGJZ5JBvKumB3eQ/coRC9UlTQpyaR2RarHfgWFzQe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718384713; c=relaxed/simple;
	bh=wciPLmNmG/shDCeF3AnOapDSvmGonBgXpnVInOIZgk4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oNnPpenIAgEsNsRCaeDXer7+HKx4G5VZoSfDkM+SSe/p4Q/gJAUnrswaZgrzW+sGdLVy0alF3GSrevN9TNNs59YuWvqkN/OTWO/keFstKum2fRC7Y2fMleMPRr58tO7K3DF7G2VskpyKJ6cwJZjtYHkHgEdBOv4Y7LyYn2q6VK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHZgaGe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E20FC32786;
	Fri, 14 Jun 2024 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718384712;
	bh=wciPLmNmG/shDCeF3AnOapDSvmGonBgXpnVInOIZgk4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PHZgaGe5n+2sbZgY+IRhYGcWlPIBwhiZsTb35dKuMird/H/EdbDNoSKCdBI2GNis4
	 fuvduZ2UPY6T9RnhRtvXh6K+9rAhQMPRzdcffG1V4hcw+vJGbdS4vSfH/UZXkAj0h4
	 nvSCqkVhvw9kAi+vwrpsD4dX6YywMFBsvrwmTns18WxlmPvqPBN/hCdEthZBTdprc5
	 RcUCOZOqPCcz24sFfAasCmLKRYXhTaH01aKnMLCklgvLOVAJAt6SQPMTh4JE3obMph
	 WWl4yODZJiTIpzk/lR7t5UOLmhIY43iO1oM27Mz/nRHj2Fd9jmCr+SP4PS6raOOhqe
	 zitAfwwV5RiFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88A8AC43612;
	Fri, 14 Jun 2024 17:05:12 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hfkO1E1ymviaiqK92jzG53JKf0mHj6S3tjXCkRuifTTg@mail.gmail.com>
References: <CAJZ5v0hfkO1E1ymviaiqK92jzG53JKf0mHj6S3tjXCkRuifTTg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hfkO1E1ymviaiqK92jzG53JKf0mHj6S3tjXCkRuifTTg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc4
X-PR-Tracked-Commit-Id: b6846826982b9f2f2ad0e79540521b517469ee92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cee84c0b003f2e0f486f200a72eca2bcdb3a49a7
Message-Id: <171838471254.1909.15044458825404770716.pr-tracker-bot@kernel.org>
Date: Fri, 14 Jun 2024 17:05:12 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Jun 2024 15:28:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cee84c0b003f2e0f486f200a72eca2bcdb3a49a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

