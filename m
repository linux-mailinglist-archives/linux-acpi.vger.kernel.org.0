Return-Path: <linux-acpi+bounces-14032-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108CBAC9808
	for <lists+linux-acpi@lfdr.de>; Sat, 31 May 2025 01:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26DB17E10F
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 23:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE59128B511;
	Fri, 30 May 2025 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLvs/LuH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6B215990C;
	Fri, 30 May 2025 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748646968; cv=none; b=ElOcljxobbDRzoNMsk0xT+AWE2OLV0C0NdJrDR0aX9nOXSv3R8FcTYRQIFny3K12gVkfun6Uk4TVkD6IOar1aqOM3u/N2uf5QdwfV8v43lxCmVZMgvLYSeATSE5cT0wTl/NoY8mkvAlU7Zm6ab+psPHFrmSPeQKfm5H5Ha10Afg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748646968; c=relaxed/simple;
	bh=iHa3AMabhADSubCaxtxruhtvYhfhu25Rv72coO8RgyQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g8IstepOB/auJQaxnsOLHc5OKsuCa9FNerQsue6GB+E5Ry4cjQwQIYbkASt0CmQLH1/H6ivtkQtWIwElg9yktHGge/30JN7mjNcIIDiVNbWzcnb/yMlIV6wygqbvHAd5IuzJhgiDAJRhz/6sWeS9uyD34aThAE+Qay9GlgAl9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLvs/LuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38021C4CEE9;
	Fri, 30 May 2025 23:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748646968;
	bh=iHa3AMabhADSubCaxtxruhtvYhfhu25Rv72coO8RgyQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PLvs/LuHo0QiPtbBxVNZKWBDuMVZpOymTGcAuMVV/uYGxYycqNntEYHUYwUGclmRY
	 V7T5+8iwnhxonSJgQbONdhdueyVO1QMqufsaPw7bk30cOJr0AGPQSjl0OeibQxTpiB
	 zb4cRsjN67Clp6Wg+i/90R7Yb3vfuvFPwa+jtZyv3QlzhFU9kUFyPNV74JxM5Rw9tV
	 es1Q/NTa9nP9FLvFq/e/5kmGA/r6WlBU93UAOkZrVW5M755k8WV5hru7f6DKoOP4Mr
	 EeskZEGY8NSMf1ujUO4h9QGAftu5lVsdb/WK+hISl0TbNP/vwX2iuiqAOcLFVRUOi6
	 bP3ZaosnlB+mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B057139F1DF2;
	Fri, 30 May 2025 23:16:42 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g5C_Zk5-PxsO+W-ef=1oDgbb-PCMYq8UmE9uPi9bASvg@mail.gmail.com>
References: <CAJZ5v0g5C_Zk5-PxsO+W-ef=1oDgbb-PCMYq8UmE9uPi9bASvg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g5C_Zk5-PxsO+W-ef=1oDgbb-PCMYq8UmE9uPi9bASvg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc1-2
X-PR-Tracked-Commit-Id: 3d031d0d8daab86f9c3e9e89c80fec08367fb304
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 976aa630da5b5508c278487db31b873ddf6bae8f
Message-Id: <174864700116.4165071.472418416452749427.pr-tracker-bot@kernel.org>
Date: Fri, 30 May 2025 23:16:41 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 30 May 2025 20:49:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.16-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/976aa630da5b5508c278487db31b873ddf6bae8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

