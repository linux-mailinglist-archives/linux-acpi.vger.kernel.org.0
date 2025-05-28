Return-Path: <linux-acpi+bounces-13915-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8E9AC5E43
	for <lists+linux-acpi@lfdr.de>; Wed, 28 May 2025 02:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893864C1649
	for <lists+linux-acpi@lfdr.de>; Wed, 28 May 2025 00:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEA91DB92A;
	Wed, 28 May 2025 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPhhBH8j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C931D8E10;
	Wed, 28 May 2025 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392157; cv=none; b=StquJ3zcjrzq+XKUKStX30tjI3R6lE+KVV5noQkTyQd1hIDXCyCKe5KYRMSpGXpL3+8WokPY7YDVhoB2Vym1itBd8YHiqTBG15+PBNEMjFbLQQG8MuWuvuy2DptxHUKHwQBmPnTvgOJ9QFIUDPHx0CzdZKGPY5hpSW74HHuVtpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392157; c=relaxed/simple;
	bh=cGhmg8ARdx2wYAkWfOvPwjDmaAAsZp466GUUzPvUPIg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eOsuGhrWn1m3kNWmE5ZCem8ydEJTWL0882QzXbZIrcZEcXuXaglZDI/ERzVAhouZSwbg1dYqmRM/cGq27pVH4FTGBiu8GU/fp4gfvgEMAQ2AkDpELwTu6LZ6UwiUzXmcHw+avqnKV4SRhwNNABIh+5ENHjYZSDyUxSlV1VBH+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPhhBH8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF9AC4CEED;
	Wed, 28 May 2025 00:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748392157;
	bh=cGhmg8ARdx2wYAkWfOvPwjDmaAAsZp466GUUzPvUPIg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jPhhBH8j6IqFDG0dy89VfTwmPI2KQjI60ONN0QPBz0FK3ioa59ERy1N92hHH0/BGO
	 mgS2mo0b5oejbRNhEyFNHUVdg3FNswIqKTVcZIoqIhG1ECKm82rRB+pCI1EjEEH1jj
	 /eXWtOZcJiRaT/5zhTScI8pEtGRD9Z0kIleHwI4lENDlQPet0bZYVYB4eIYQhegX1U
	 cJ1zYt7izzZ2QslcDMrNhPGVbxjufN1LY6nOGFAM/c9QiYx5cbVh2Y+GYp9uoipwwN
	 D7XxKqzzq3iiNTXIuiw+Awa8sECx9wUhJeHDH/A2POw9eOQgeB0fF6UXmmwLhwhY7a
	 UtMw/4Up2D+pA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBD1380AAE2;
	Wed, 28 May 2025 00:29:52 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gK5=_HkTg-O7GOz-xUw27_484_AeoJHaz9vN0XRZvmqw@mail.gmail.com>
References: <CAJZ5v0gK5=_HkTg-O7GOz-xUw27_484_AeoJHaz9vN0XRZvmqw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gK5=_HkTg-O7GOz-xUw27_484_AeoJHaz9vN0XRZvmqw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc1
X-PR-Tracked-Commit-Id: 3e0c509fbdb106ba2d2fa13beafe58f4ba11e13d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c89756bcf406af313d191cfe3709e7c175c5b0cd
Message-Id: <174839219130.1837144.14239282792044585443.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 00:29:51 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 26 May 2025 22:12:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c89756bcf406af313d191cfe3709e7c175c5b0cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

