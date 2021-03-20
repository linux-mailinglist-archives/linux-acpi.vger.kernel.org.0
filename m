Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07CA34294E
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Mar 2021 01:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCTAJi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 20:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhCTAJV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Mar 2021 20:09:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C68F661985;
        Sat, 20 Mar 2021 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616198960;
        bh=X3KkZJibrm2jPx6QahvwC+ddxtn55XQ6lo/Pq6uL8P4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PvnZrQW/u9rObZtvHAMOosuagXWKI+c0YAzfrdYmzweIeDpEs9xuQm8xeWOUaEnIY
         svDzNuDRIHtcrimG0MGpz/RIWMghA6BXoo43z3QKYTQ1uoqUji1bubDkXuVHh6XRXV
         WGK0tFy9+mxePV1OIIr67bzekzpp7Mvplj7POIscPsRWETUCtmEj0a8z4vB0TkXvgm
         /dNLpb06UZLfpYdEiq+CDYqgLgx+h27kVyqg6PFqSfpM9/yG00ccNGa7DidFMu/wA7
         60VAi2e5wX1KaGu4G7/RLjBkOPwr/40WtSM7ptGvqdWy8BfzPlQLzx+LO11p2FIVED
         o4tjxsEXEpGhQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C0348626EC;
        Sat, 20 Mar 2021 00:09:20 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hES51MM9J5nM+An_ON-rxRJ5s_9KCa9n7Fe9nWFziLeA@mail.gmail.com>
References: <CAJZ5v0hES51MM9J5nM+An_ON-rxRJ5s_9KCa9n7Fe9nWFziLeA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hES51MM9J5nM+An_ON-rxRJ5s_9KCa9n7Fe9nWFziLeA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc4
X-PR-Tracked-Commit-Id: 49cb71a77ce760f20487c38f891aa3132bef782e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec85720933863015b1c26bc19cf4e044da139bc5
Message-Id: <161619896078.24257.12391413078492854789.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Mar 2021 00:09:20 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 19 Mar 2021 16:58:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec85720933863015b1c26bc19cf4e044da139bc5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
