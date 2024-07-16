Return-Path: <linux-acpi+bounces-6924-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6423933490
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jul 2024 01:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5218FB244A9
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2024 23:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC53144D0F;
	Tue, 16 Jul 2024 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHIsOMYN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871F1448F6;
	Tue, 16 Jul 2024 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721172487; cv=none; b=UurtE5FopDh5wx4WI4fN4R3NSr9I4av0hv+9jUxnZ4h57EOFCxbTSWtGFLzsajriHVbr+uRJMX+uHrFwFeEl9mcj4uZ12bb2LX0ZYpH0La1rpDMb+iKFnFZvm9u3IxQLbuLMA3ugocGLX+OU0zaKm1xli/8VS5w+hlgFD90oqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721172487; c=relaxed/simple;
	bh=me5gPm0zvTl6FoiiymDRySZgRa1UAOD/BETar4caxs4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Zy1IuAX3NbTA2q44+UIMLoixxfd0KK73F854/WNKk5p3/30k1tRoWcYJF7RtbJitjBZhGVVTauSu16azTe6J7ZlTRpBllXBLUa85mr9MWDZUYVLli1CJ0sGiyFAYQhWW1BkAo81deCPLTePfLDoijGgtsdNjZYMgYssNE54QZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHIsOMYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C57B3C4AF0E;
	Tue, 16 Jul 2024 23:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721172486;
	bh=me5gPm0zvTl6FoiiymDRySZgRa1UAOD/BETar4caxs4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HHIsOMYNl3ReHUCyWiqDqcrN1DTP0rkBMQlJcG3HGrUfzhQlu42IxaBOUDETvo1nY
	 qqbkop9fe0VQhgPvJl/4hFA5wBLzwoBieCK4ZZsJkBx9Sc/drclrsU1AkFoQkJqfT/
	 3ub/R1sidjbf3wIla+EbXodg9Ap+SIrnSP8QUOLXfxhanh65pO7CzojvEiLuEi2RXs
	 xSggoD+32BjxZJPJ6tE/7wrzWzNd5wMm7iKcmnU+S/wkwMiokQZLRHHSSAx1FFhoAw
	 Bt0rkEWasr1+xYzmfKU7uI0QO3cjz4ZALKX6o1Lw9s/CoIsEOa+DlwjJXoea7LnYsQ
	 q4STbb6kdA6uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9620C43445;
	Tue, 16 Jul 2024 23:28:06 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h7OHR7ipj6ubgTLEz238JZkTshh93CYe_gDx5j+zBwfA@mail.gmail.com>
References: <CAJZ5v0h7OHR7ipj6ubgTLEz238JZkTshh93CYe_gDx5j+zBwfA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h7OHR7ipj6ubgTLEz238JZkTshh93CYe_gDx5j+zBwfA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.11-rc1
X-PR-Tracked-Commit-Id: a02bed4183c48d42a2855a4e70867b6239c45770
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41906248d0d78e3a620a86cf715f6f630912a4eb
Message-Id: <172117248675.20323.11976457968022615871.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 23:28:06 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 21:42:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41906248d0d78e3a620a86cf715f6f630912a4eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

