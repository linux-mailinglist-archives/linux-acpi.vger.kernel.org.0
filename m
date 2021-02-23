Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DA632345C
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Feb 2021 00:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhBWXpy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Feb 2021 18:45:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232715AbhBWXg5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Feb 2021 18:36:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A898364DBD;
        Tue, 23 Feb 2021 23:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614123374;
        bh=+iwX2bRoJoT8m1Q/2/H09Rq+ZccI+5sIKun2f5PlJV8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hTjOvxwfN/lrK/EtQTjdxmUFfIXbsbt+0haJEK8ir/XVUFfZphP5LylHpg0vbMtI9
         VC/Vus+XEnO+TFchmVezdeiXn/DSHThvM+cc4d8f+LwrQjiOTitvg0lSCSPH/oWBuQ
         HvZREDsmf+w9ybkpoKZEiibbdETV800Hzuj/egpMb/cNoTAhWPv778JVhZXQCZ9K0q
         7/VBbmYjyvIYeZqMngnFnrzqx4/GlmRy/LFOgX1KoKy/1jCTCUQ/9is6H2jEX92wr4
         qbiiE21AipLm3B7InhdpDFXZM3ktDYfCFKilw8Cq0/t75OUi30kwnC3Vi6hkudkjz4
         NzXmKLAe5vw5w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9461660176;
        Tue, 23 Feb 2021 23:36:14 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gOvJ4OXK2Sqt6ncm-G0BVeC1Aiuettd02E=7wq73g=oA@mail.gmail.com>
References: <CAJZ5v0gOvJ4OXK2Sqt6ncm-G0BVeC1Aiuettd02E=7wq73g=oA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gOvJ4OXK2Sqt6ncm-G0BVeC1Aiuettd02E=7wq73g=oA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc1-2
X-PR-Tracked-Commit-Id: 08c2a406b974eea893dd9b2f159d715f2b15c683
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 005d3bd9e332faa976320cfaa2ae0637c8e94c51
Message-Id: <161412337454.20258.13397708719153679523.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 23:36:14 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 21:05:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/005d3bd9e332faa976320cfaa2ae0637c8e94c51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
