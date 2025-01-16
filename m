Return-Path: <linux-acpi+bounces-10727-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6275A14070
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 18:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B827A164B
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226C222CBC4;
	Thu, 16 Jan 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLV6v4Xs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA615442C;
	Thu, 16 Jan 2025 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047605; cv=none; b=eVMKUFMYeWdzY+tdbhejozjdxjTIppmwSOajeG7FR8K7aIPZhdsLGb0ETVKFHs1pPwY0hIZFXUsjSo7CwxTjb4bKozueTMEjNp4IzFMsdClAlbSYg4pNEgWyk23BoAtpA97U/iXTcn672SUaAXYqTM4uXaSUEp9amvswwdq7Q74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047605; c=relaxed/simple;
	bh=fbRDpbwOyGknSDo8TmaVZ11rDnlooopadO0xhKw5LGY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DEG3jdPH66IHAKHn4zXN43uoSUnarlndWyrOayduG/mPUFgHtsybihZWSeVrcRP5pzlCanX5RDlydhK/N5VcTIgDSvM3c+S0+KAadAUx9Vfatv+5mg6lc6ue62NkN9QK+bYmnJsdiS2DWgrfjEKSHG152rKqfE2UF4DwoGu1zL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLV6v4Xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB509C4CED6;
	Thu, 16 Jan 2025 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737047604;
	bh=fbRDpbwOyGknSDo8TmaVZ11rDnlooopadO0xhKw5LGY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bLV6v4XsYt+d/Fbkmj7kDG8yYBwR8MUrHbwvWRYel9jCjBzNYDr9a7A+xiucNzy1p
	 iiIst6R5x43eG7jyqnYS0PfZMG+TjzXoE7t6jT1SrTad3b7fgb5m+1WoXnlJA82k6Q
	 rSiyXia3yw0JriPVkQ9nBYH8hl8yXCBY6floYPSgnfWY0QxRq+UvvMk/aBk3ufn7/b
	 XC3g4WHpJhanFTS4/Z7wcDoDEhk67X12jylQlXs2Uz8zUH4gTQjKYWgc8tbQd2p9Vl
	 wjOHfWRc5HpeMO4upcR6FohYFECdMtmoIIRftvoJB1wmuW0FUvQMkJnBHl2NgkQNNr
	 ygN8LN4vcG+dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34020380AA63;
	Thu, 16 Jan 2025 17:13:49 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for final v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j7Kf_zWjB0kv=b=V9DBKoodGap5_-QimbZzz=WZnpkpg@mail.gmail.com>
References: <CAJZ5v0j7Kf_zWjB0kv=b=V9DBKoodGap5_-QimbZzz=WZnpkpg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j7Kf_zWjB0kv=b=V9DBKoodGap5_-QimbZzz=WZnpkpg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.13-rc8
X-PR-Tracked-Commit-Id: 14578923e8c251091d2bb8a2756cde3b662ac316
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d5c4787595268a5ac11f77660d4673feb744c57
Message-Id: <173704762764.1527932.3748643162959346341.pr-tracker-bot@kernel.org>
Date: Thu, 16 Jan 2025 17:13:47 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Jan 2025 15:44:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.13-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d5c4787595268a5ac11f77660d4673feb744c57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

