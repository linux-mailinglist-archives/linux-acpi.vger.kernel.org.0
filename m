Return-Path: <linux-acpi+bounces-1240-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5C27E123C
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Nov 2023 05:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E1F1C2092B
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Nov 2023 04:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61833D87
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Nov 2023 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kal+1POy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F310E9;
	Sun,  5 Nov 2023 03:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6550C433C7;
	Sun,  5 Nov 2023 03:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699153320;
	bh=FQR9ATd8ddIZBHiEIToFW1Ari4GxDoC9kMLc3FxoHZc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Kal+1POyFd7cgBEAhOAWQlwlhZjG67oPkD2r7enx8rEUceh/c2TNhZIj1Xek8fK9O
	 im5S4NqVxpyr9OCEXqc5YhIwd5jAI+Gfta51My4TNb3QRUo3q56eHbGAuzugjaje+s
	 Ka5SvUHAFb7VEtwJRdBv9G+9u9gTj3seNIPwOZ08Vc79jtFjlnfg1CJeohrfI1kdgt
	 1IRcUYTAEOLs1XVfpYUC+soGrJVMA4Nt8HqTGL/BjDKpo0f36Gpi9bL1Bcao/FiBbp
	 R6DTNWefXWt25HXR8qN2zDJgJrYfCazja2TncCHlYiK0qt3jraA623L3ZkDnF/XE9G
	 9t+lmIPaqseoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4AD9C4316B;
	Sun,  5 Nov 2023 03:02:00 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link (CXL) for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <6546aecbae94b_3f602948@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <6546aecbae94b_3f602948@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <6546aecbae94b_3f602948@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.7
X-PR-Tracked-Commit-Id: 4b92894064b3df472b2cf5741c7f080e16dcd1ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8cc56d0414e2330d9fe05342843512b1ad8cdb7
Message-Id: <169915332079.2133.9651943876124044697.pr-tracker-bot@kernel.org>
Date: Sun, 05 Nov 2023 03:02:00 +0000
To: Dan Williams <dan.j.williams@intel.com>
Cc: torvalds@linux-foundation.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 4 Nov 2023 13:51:23 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8cc56d0414e2330d9fe05342843512b1ad8cdb7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

