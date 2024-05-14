Return-Path: <linux-acpi+bounces-5806-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121E88C5CD3
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 23:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E931F220BB
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 21:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6E0181BBF;
	Tue, 14 May 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faIToh8/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310E181BA6;
	Tue, 14 May 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722225; cv=none; b=jq9OyRZbciMyarcXRi0ZVBchfhZW5cD3qNbqg0gIxvx//Tly4MRmk1LsbPG+JMo8UVr/pWeNkxutPcYdj55Qj/XZ9Hj9m5KWJeF8aP5C7EUDZZAhOWM6zvz8nKx1qupY5K7CcJKmWXdXGERP4W5UtZc1O3Ij+B9KR9zjtzPgIHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722225; c=relaxed/simple;
	bh=SBM3P3u21hotsnkebaRQOakAaFVX3pO0UQwlQVSc/WE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=B2+JefpToSm22/xl/AY8uh9KC1dTvV/wrT2A53xP/DOiFdi808o2iIpXi8nUhNzXdobcItDYfGdIZa6p3/2dyS6wFzloDhhEqbf+hKS6O91YfWYC97d6tqA5wtv+Cp2onvGpiSjkTg7o0HXl0BUJHcS0GZCBLNrhoZ7TyQ2ka8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faIToh8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 913B7C2BD10;
	Tue, 14 May 2024 21:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715722225;
	bh=SBM3P3u21hotsnkebaRQOakAaFVX3pO0UQwlQVSc/WE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=faIToh8/ULvU7tSBuXf9KbC6eXm3sD2S4WsrTQIZVLDex8g/PEU32MMjIjZermYaE
	 C9VfFyhRk+I/GfpWAFhJ/TdxQ/PcYKJLwdM0SPoNeQwU9H2sINO3eB9CKUIU6J5sM/
	 abUj7biy1OzDqK2enubyAjK2sl73cYIgCLuYmE7FhZe+HlGSbRmWDMIKAfG02fdUlT
	 SoV1SZA6oUBc4VFltbW27eXyeX/QN0jwlzLFMxjJRANIrbR0F2FMQMpXCOAhtHgFDw
	 zZzFE2J4fRdzsdQ2RPQCle9zIM0UHocWmNWaftC/VMqXcBuzP8V7+9lTijH72F3att
	 0GMlD/OC8hJkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8390BC433A2;
	Tue, 14 May 2024 21:30:25 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hjT+fR2+RuSw+XJ_KcxagUpsjdYejJcw=uTicjbm6HCA@mail.gmail.com>
References: <CAJZ5v0hjT+fR2+RuSw+XJ_KcxagUpsjdYejJcw=uTicjbm6HCA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hjT+fR2+RuSw+XJ_KcxagUpsjdYejJcw=uTicjbm6HCA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc1
X-PR-Tracked-Commit-Id: 3a47fbdd1a750afe8c31971e7d3892f08e7390b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f952b6c863090464c148066df9f46cb3edd603da
Message-Id: <171572222547.832.12070643099928235691.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 21:30:25 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 21:27:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f952b6c863090464c148066df9f46cb3edd603da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

