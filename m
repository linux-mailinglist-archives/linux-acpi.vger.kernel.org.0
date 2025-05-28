Return-Path: <linux-acpi+bounces-13914-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065C7AC5E41
	for <lists+linux-acpi@lfdr.de>; Wed, 28 May 2025 02:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F974C133B
	for <lists+linux-acpi@lfdr.de>; Wed, 28 May 2025 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6031C700D;
	Wed, 28 May 2025 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqfS6XSN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51991C5F2C;
	Wed, 28 May 2025 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392155; cv=none; b=XvzsFDw3UnwVS4JIMCo6pY/gZFAornYcMEFoooO97CYzdW/iiDtdR6DgzeOhdWs4sDgAAQT206jekCcnzZBfq6qX7LJBYYUrvr/OSiM8FCfqHGXehs46W1ylbHe7WFX/e9Ib+N7UtvK2ukhsFpf8GKfMHgBSsT4TIk5LgctAH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392155; c=relaxed/simple;
	bh=Caq1PiX3zOa9PUt/MlGH6G5BY7+Z/IIsuCq9Kmq/5Uk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UYFzryguln6cgeiyYOs9/pRZJTe5y+xKsjPDW9Ko/XGTx7j2qfBrYlClPt73MJNbFOMHz+JI9YPXRHLBmsxQ9eoQq7cGuZ7veBx8CnCWUYZ5+4JKOTsapD5lQ2MbLBsbBCzWOmpOkEVdn4wAEiy+RvdhdrzhAZXTkPKGc3x7WLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqfS6XSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884B0C4CEEE;
	Wed, 28 May 2025 00:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748392155;
	bh=Caq1PiX3zOa9PUt/MlGH6G5BY7+Z/IIsuCq9Kmq/5Uk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UqfS6XSNAZ40ZYGihEgYgrJIQ5tD6wEGeyNZJZ8htcLgMgdqbESNhMFUUubMQzir1
	 KVlVOs6xG60EEIVK4u1qQU/ZiGlDmzrZwbotJcrrHuZ1LYpWJpTPprP3D3PPlyElt6
	 lRMqGutdo6RJAX0k5CvOXqJkZk/j2y4Kf/PeBFhHuioWbWG4+tKUEObHLheSdX6x0Q
	 Ja/b5QmAT+ylCDPK2lbly8u1MQqCIt+q1DEFDXYbqTgkjBaDvult513NTRBU030+fK
	 X+hfsqaNkMkzBeu/fRPF4GT9tOPb0ZsYHmxgJlbMitqAvCbWOK8c+Fg/UUvBjWDoJi
	 Hv2t/HtC3Q7hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE64380AAE2;
	Wed, 28 May 2025 00:29:50 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jgQeZnOaAT-00xfM-_4QDfH=RhKJWDPM9NMoMNfWpr_Q@mail.gmail.com>
References: <CAJZ5v0jgQeZnOaAT-00xfM-_4QDfH=RhKJWDPM9NMoMNfWpr_Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jgQeZnOaAT-00xfM-_4QDfH=RhKJWDPM9NMoMNfWpr_Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.16-rc1
X-PR-Tracked-Commit-Id: db0e4d5429c909db9c252be59bd872ab628c78c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3702a515edec515fcc7e085053da636fefac88d6
Message-Id: <174839218955.1837144.7886076307479363918.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 00:29:49 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 26 May 2025 22:08:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3702a515edec515fcc7e085053da636fefac88d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

