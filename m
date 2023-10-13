Return-Path: <linux-acpi+bounces-633-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA8B7C8B91
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Oct 2023 18:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3668A282378
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Oct 2023 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E443F219EA
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Oct 2023 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cri0Z5dv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF31C691
	for <linux-acpi@vger.kernel.org>; Fri, 13 Oct 2023 16:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 981CCC43391;
	Fri, 13 Oct 2023 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697215196;
	bh=8fSs8AJtEmy9n5PjW2LDrfGx+3CafPXXlym29DLZvVY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cri0Z5dvVPAjlOGMQzka79X5vxTh6Aov+tINOzgN6uKgY5RNFv3VZsoWTBFC5MovT
	 HJf2EOInYfdsnUfxWeppe50G7crSZutIV5HuV3V3XxR/+B3IXxqY+mJEuXsLZiuU4h
	 nbanxKemSgbjgT2N7IZb5xNkT3tVbiYI+mYvIHCJz6NEkmV7xzG9XMdZ2/G5O4rD2+
	 Cn2LGjUsiDbaZTEC+7Y8qTeAUjw7GT9+v81mI41YdsiiPDW8rJt0PoV6O3Sv88wCFc
	 jAXEiENhR4cMc3A20ybQdHWwW3NMrZ+nRUSptqkyevJES1RkSiXOAlV5CSQbL51PNB
	 pYkPLvBJiVnTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C485C73FEA;
	Fri, 13 Oct 2023 16:39:56 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.6-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gcP2o_mDOyWP_C3u+6nHqT8gXFhUxGHSC7OgywBXsNMQ@mail.gmail.com>
References: <CAJZ5v0gcP2o_mDOyWP_C3u+6nHqT8gXFhUxGHSC7OgywBXsNMQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gcP2o_mDOyWP_C3u+6nHqT8gXFhUxGHSC7OgywBXsNMQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc6
X-PR-Tracked-Commit-Id: 9bc2fb9a7e41542a193658deff3df572fa24cb68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad7f1baed071f4536d7cfc32834a36d61c512c70
Message-Id: <169721519649.5219.443378342249328036.pr-tracker-bot@kernel.org>
Date: Fri, 13 Oct 2023 16:39:56 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Oct 2023 17:39:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad7f1baed071f4536d7cfc32834a36d61c512c70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

