Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA343208E8
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Feb 2021 07:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhBUGAP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 Feb 2021 01:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhBUGAK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 21 Feb 2021 01:00:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CAEC564F06;
        Sun, 21 Feb 2021 05:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613887169;
        bh=9ei5iHGbv8TJb4GlXiTSbfmjpyMB5LnuZI5CuZgB4Lc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FqW5iSxy6ZnxUnPSR9GSDfrLLDDcCn0dYxMxyOUBvQ68wvMxclnVIybadUBMYWq6W
         gmFxkAkiAMi58L/ftHJYrGaoQoGZ3YTtHvATB06Q2s2TgP2eIj0xFFL64Qs4nv4jLv
         jO/yBiPlknEbmnH5llOku9XGp3P07B2w7ZCIDYEF1M/ZPYjEehx2ID4HB88eByrWr9
         EB9lmjLO7ICIbyC/BmZkv6AuIkt7kTFczb32V7Ow/Rtw1j7CnxA49vebwaHGvEUyhH
         BInAFiwuDOWi8admGeF1i3R75FB6TvbfgyadNOZ/U1fjEGmqw4ODKOyxEwldJtAH4r
         5IOIhM5z4o4ww==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BC47060A44;
        Sun, 21 Feb 2021 05:59:29 +0000 (UTC)
Subject: Re: [GIT PULL] PNP updates for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jJqO0FVHptaE27ovFese3wFbwQyKDYdiJB621kYg5U2g@mail.gmail.com>
References: <CAJZ5v0jJqO0FVHptaE27ovFese3wFbwQyKDYdiJB621kYg5U2g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jJqO0FVHptaE27ovFese3wFbwQyKDYdiJB621kYg5U2g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.12-rc1
X-PR-Tracked-Commit-Id: 96228223933bf5ac920f93862c82449ec28247c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55f62bc873477dae2c45bbbc30b86cf3e0982f3b
Message-Id: <161388716976.9286.16945048915554481061.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:59:29 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 19:47:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55f62bc873477dae2c45bbbc30b86cf3e0982f3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
