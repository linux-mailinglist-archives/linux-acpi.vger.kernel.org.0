Return-Path: <linux-acpi+bounces-19345-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D2EC9083F
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 02:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781A53AB922
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 01:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250552494F0;
	Fri, 28 Nov 2025 01:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBWNXRmy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD00E248176;
	Fri, 28 Nov 2025 01:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764294110; cv=none; b=P4jMv3xL0uWm6Voa+eRoecjnzj9H8NBYXjaZ0OERTQHsOtJYzNUQxnKYkKZWH6sPe5fqfmfdU65Z8P/VNxqM17Lx/2XUVaaR9lKOWJxEHqylObfygQ29Z1I7s1bAszMtqGVU9SbT1W6n2P02C7ctDWvqEvUApoVxR91fZd8i0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764294110; c=relaxed/simple;
	bh=sbRgd123mQbjCtTv4XsQQ3yJxBbXromTuuaSAASnPRI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=poSt+aN2Ade0iKYSSJxabppQjv11AzBd52wlz9yMBe5LM3wN2Q+4iGKbZFMejMbTzw1x16l+RuebZndXN73NVBkq+qvxEMS6VH/q1moSLbUj8P9yIyaKZXefhDOumEKMgFjebmTE2OLwcz8YCMsUtxzg2U0r4dHEcKH55yiMDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBWNXRmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B11AC4CEF8;
	Fri, 28 Nov 2025 01:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764294107;
	bh=sbRgd123mQbjCtTv4XsQQ3yJxBbXromTuuaSAASnPRI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eBWNXRmyZicpzd5d+qW1NCgrJBpUkn7O7MpVxPQLvKAvdAtOM/3XlTidj6NqQbEi+
	 yPZ+T8slj1Kdsa1exKRRd1NoytAnE4cbSnw4uHKEu55fFOXIO668KuRCEJANfU3JIF
	 N3sKNAaEnXCxoRLodJMXJ1al3PiV9Q4p0M35snkD6YYuUOEfk1XyqhUoXFh63z2zqB
	 +BDK4SdzqhZPuT/yiM3E7RYyddvioj3fOB7EgAB4AG7qr7LeR7LUX3+kICNYG4nZqC
	 fOJ8HVQbAyDvOh+a8MHzLiZRzdjAiJasCiBkTEMSEQQnMfIsX/+2O9JLzqIbUTjL/S
	 um2si8N0Rd3yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F299C3808204;
	Fri, 28 Nov 2025 01:38:50 +0000 (UTC)
Subject: Re: [GIT PULL] One more urgent ACPI support fix for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i1TdwXcXnv_L15kVZXJKjM8eCHwunStXssb1=J7LzLgg@mail.gmail.com>
References: <CAJZ5v0g6c1HNbxxh088xh_nTgD-SE6c2qtDr81AgD1+by-jnKA@mail.gmail.com>
 <1ea445d0-0949-4a28-9f76-325861a3c57f@huawei.com> <7487e99d-421b-4ac5-bb77-e61c3131bb13@amd.com>
 <CAJZ5v0ij7XizsUkhGRMy_1pqjCAjsHfjsBCuvVarExGGMknPEA@mail.gmail.com> <CAJZ5v0i1TdwXcXnv_L15kVZXJKjM8eCHwunStXssb1=J7LzLgg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i1TdwXcXnv_L15kVZXJKjM8eCHwunStXssb1=J7LzLgg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc8-2
X-PR-Tracked-Commit-Id: fbf04215d9966da61feee3f4ec24dbf4544cfd0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fa77874b4a7ae96d4ad40623d449cef6265ae4a
Message-Id: <176429392967.102139.2915015472082223744.pr-tracker-bot@kernel.org>
Date: Fri, 28 Nov 2025 01:38:49 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>, "lihuisong (C)" <lihuisong@huawei.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>, dhsrivas@amd.com
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Nov 2025 21:05:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc8-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fa77874b4a7ae96d4ad40623d449cef6265ae4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

