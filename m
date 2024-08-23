Return-Path: <linux-acpi+bounces-7812-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A365E95D9CE
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Aug 2024 01:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48B11C23689
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Aug 2024 23:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC311C945A;
	Fri, 23 Aug 2024 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8GX6W7K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEF71C93B4;
	Fri, 23 Aug 2024 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724456722; cv=none; b=C+AoX7MBgBKaArpK3PsXLY1u6klYUvP8AsNwRtVxojggM08i5HGtd7M5gZkyKeBT73YT9deh9I/L8QjJK994TGxdd6zTGbtsQquUTA7V470AkQLi4zHAgDnaASjPutbYbxeR53GcEztvSpMC79k7Znr5cpOSHSLuxJYCYti0UNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724456722; c=relaxed/simple;
	bh=YZ7B+h+ctI0YdPLpK9id50AuFg2bLLAtUi1/9abrzxY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IFrp9R+ymvdAfWg/K7yfSj6B2YKFrdfWwu27ilFofMNQTNG5WTZz8hpdB5eHPKPETiHg0GzUAIi4KrVv45Y+aGKhIqTaAiE3wA6EesllVbJ2sy/f8c6rwGNkUoYdf5M7ykl6mbKbnOJO5Swdj5Eu/2KvUuknvOrMcuNd23zKxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8GX6W7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC76FC32786;
	Fri, 23 Aug 2024 23:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724456721;
	bh=YZ7B+h+ctI0YdPLpK9id50AuFg2bLLAtUi1/9abrzxY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K8GX6W7Kle6KahdSuXi+stDBZmANtz+PEEmxr1oxLb6MOjvPDMZB0lnr9rBAcCLAL
	 ADihmB2K9WMRylR78Ntzi4rxsoEz5S4D2lK/3WyxtNpNIh6yb2tXQ9rB4BQ27iN7oL
	 ph+ngsaUhI8mBRYv5FSyaazHtHbosj9gRJpNuIkCIKqgligMM/HFeU9vNYekvM8rPk
	 SWtB4PZa76j2R73ZKT7CBUUypoH2HMjko1SuxTI0ylc7esh5qNfedA80Ee/klWoMD+
	 AY920eGEZ+8U2rDe/fEF+qmx1GNn0nGBfUuSW0Kpx/+gWzr95sontij/zMQNcDffDk
	 +9j3s0roT3Zfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE09B3804C87;
	Fri, 23 Aug 2024 23:45:22 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hJobeqPY7fZCQAiZg-fP=Vyeak-6mEt5Rt2cdat5ChvQ@mail.gmail.com>
References: <CAJZ5v0hJobeqPY7fZCQAiZg-fP=Vyeak-6mEt5Rt2cdat5ChvQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hJobeqPY7fZCQAiZg-fP=Vyeak-6mEt5Rt2cdat5ChvQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.11-rc5
X-PR-Tracked-Commit-Id: 5c7bb62cb8f53de71d8ab3d619be22740da0b837
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b09f6ca99c46e4a561ac943253aca9beae8c1146
Message-Id: <172445672130.3112782.2943562548215395003.pr-tracker-bot@kernel.org>
Date: Fri, 23 Aug 2024 23:45:21 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Aug 2024 16:32:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b09f6ca99c46e4a561ac943253aca9beae8c1146

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

