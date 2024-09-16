Return-Path: <linux-acpi+bounces-8312-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EEC979AF5
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Sep 2024 08:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79962B22DA3
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Sep 2024 06:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AE913A863;
	Mon, 16 Sep 2024 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bssxodb5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13ED5EE97;
	Mon, 16 Sep 2024 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726467134; cv=none; b=Gip4HcLE9BdpGRcdrf9Vj2XIsvh+9BW9i5iT4JFFmqBX5AjQ2152yVqOWKTKnMwpjdGLo2IbXcmTSefjcZT4OENhQMQC8nySH5Lp/NhLLS12x+GABlpLjqZHdFsUDjwL67K6AAbHFPXSAIQ5lLOggIEejI/kyYSLlthJ7Gdq5U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726467134; c=relaxed/simple;
	bh=msGcSAsQbF0GLfpBHniHEHRGuGj4TIQgI5HEq+A4jT0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pEUHrho3C6CUutPfaZlLZrKSsrCRQp/w2+gPgDf7jITUD2yPbsD5WBqBJQJqd9bunis2DH/NZSwTCWafnCInx+KB/H2XNG4VtwpNhyUj8WtJxIwBrTPai6Dbzs8l92xM9qb9PnVd2VetOmP+lD8+nKDIqF+7Yx/eyJNcm2tNqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bssxodb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3067BC4CEC4;
	Mon, 16 Sep 2024 06:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726467134;
	bh=msGcSAsQbF0GLfpBHniHEHRGuGj4TIQgI5HEq+A4jT0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Bssxodb5SytOTBQkaVrqs9tbnll0QrqH0ncFren0yAsZRlFm/3GAF2QdNRzPL9Ran
	 Co5nLr3zBlSed9jPqVwA5Qao2BrCqMhD8LAMN11xi/1VaAgVJ325lgqoRmb7Zgfkqg
	 cxFTpCdYNsXHuoWCRAnYqcm7onieYRNoq7bvGmYJlkJLafFOEskqvv7SXD+NS4Xuhv
	 pqaCT4Yr0fvL2TEZKikHivr5V7wWVnC8RPD6MyJdpH1H00VI9a+P9S11wypGtiGs7n
	 J4bAfp2UvXj+VpaNf1mk+9V8UstfEhFnq2Kzp6xGlHpHLLzwoQTtlkUQCPbP/SqqF5
	 XxohXq5wDwZjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBE5A3809A80;
	Mon, 16 Sep 2024 06:12:16 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g_7rOA1AvtCsHCHsde8wJqq8prFmXq3oKEPUY2buWvbg@mail.gmail.com>
References: <CAJZ5v0g_7rOA1AvtCsHCHsde8wJqq8prFmXq3oKEPUY2buWvbg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g_7rOA1AvtCsHCHsde8wJqq8prFmXq3oKEPUY2buWvbg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.12-rc1
X-PR-Tracked-Commit-Id: 3bc5ed15bdc5077d7ee621f44872f550babbea3e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d22300518d875f78203e9afacb5aa0b0316da523
Message-Id: <172646713558.3261404.14913162166675628680.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 06:12:15 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 20:10:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d22300518d875f78203e9afacb5aa0b0316da523

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

