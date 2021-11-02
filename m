Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062034439A9
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 00:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhKBXaD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 19:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230155AbhKBXaC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Nov 2021 19:30:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7B4E96109D;
        Tue,  2 Nov 2021 23:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635895646;
        bh=97aWa4QaX8sZHDe5MJ11EOWCX7euHXvxWoEpwDHSGCQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iuv+VpWcIl3uEOxWekkUFFuPR/67FM5Nh73mOdYFoDAmDsf+jIekzTmbxoGJSoQAk
         ehHbBQDfaLFqJdFk9QhQZw39RVc5ZkVxuSE6nvVb7Pf/hbKhqKPGvmSiIhTL8aptlX
         RDf42jtbMt6dnHAEYG75R66W89zXHRiEhMLDc2mQrcBbrB2KcdC6wKNZoT9ctQQWa+
         2i3ZaXV8T8oWONlkcB8YXqmtkSzUsqLQljK/dn9+QyKrcxJxfr2vTwiab/sqMcjgYj
         vxLhkiTWCz76Uh2Dxv8fFwJGS7jfR2QrD3Sr13GKf2PLoRXRGL8kRSolG6bY3BIGmG
         bdE9SEqIAMZkw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 72D3C60A90;
        Tue,  2 Nov 2021 23:27:26 +0000 (UTC)
Subject: Re: [GIT PULL] PNP update for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g4KiDt5Ja-bnP-kJCk311wbOwwr4q7UjXTsoc3ePdbbA@mail.gmail.com>
References: <CAJZ5v0g4KiDt5Ja-bnP-kJCk311wbOwwr4q7UjXTsoc3ePdbbA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g4KiDt5Ja-bnP-kJCk311wbOwwr4q7UjXTsoc3ePdbbA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.16-rc1
X-PR-Tracked-Commit-Id: 47e9249a6cc78c2856bdc8c2f8bd495309cbc060
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 464fddbba1dfbc219f1e9145127a482d2159dee5
Message-Id: <163589564646.24792.14612963573516583926.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 23:27:26 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 20:55:49 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/464fddbba1dfbc219f1e9145127a482d2159dee5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
