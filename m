Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C99417B06
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 20:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbhIXS2Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 14:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346239AbhIXS2Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Sep 2021 14:28:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9ACA260F24;
        Fri, 24 Sep 2021 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632508010;
        bh=MZ6zhIeooVyustjHOkCFkHVycqzmXa6fHjTlHbYIPSM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iexpTVMz5RDBB8VpHy4uW2L6+gAh2oe0RsBazHRG2tpBVR6GlA544di3+VC4iheY2
         LT2N5roGk9mHDz0oDVAZXjU7L+PvyypETi7zzArpESLrLuDYsfx3D1J7NT7GuU1mrt
         jvfvWgS+wPWV90zvbFf2znzJeqHLoI68V2yf97kw0UybIactkKdvUP0CyEJ/8hpGRK
         CEMDoW8xYoR4EJQbiQBRoEZyAr2CvhgxEFADRkuhXm5BUrfYzEzHFSF542Om79jSrc
         X0SVgzdTPE2YO5OHopFY8VkzCcuTmYInvIMWf4+ycx6Xc4ahPU2THJ77e1ugNCvBaj
         mwXvEDhoVNiyQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9460660973;
        Fri, 24 Sep 2021 18:26:50 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j+VDWvzoH1iuTqYm6epwhBf6R6JdxkoCZvzs6835AcWQ@mail.gmail.com>
References: <CAJZ5v0j+VDWvzoH1iuTqYm6epwhBf6R6JdxkoCZvzs6835AcWQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j+VDWvzoH1iuTqYm6epwhBf6R6JdxkoCZvzs6835AcWQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc3
X-PR-Tracked-Commit-Id: 12064c1768439fa0882547010afae6b52aafa7af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea1f9163ac83fa537f58e00a81028844702279e4
Message-Id: <163250801060.5900.13406898185899783358.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Sep 2021 18:26:50 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 24 Sep 2021 20:00:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea1f9163ac83fa537f58e00a81028844702279e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
