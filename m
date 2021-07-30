Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C31F3DC16F
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jul 2021 01:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhG3XK1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Jul 2021 19:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231192AbhG3XK1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Jul 2021 19:10:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A93C560F46;
        Fri, 30 Jul 2021 23:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627686621;
        bh=Sjp4XaUrf6HxEvu7npUCI/ehDdZe1dulAD0sjDUDhlE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pZi95NbTenUi7hiYCLIAEqQotMERG486710SuDJBpXbvvyMMj+Hx5SULOJwKx4MIp
         vL0/Jb0RGToYrsp/CxNovfgeheQiyJGmDfofh9zOHO55CUK4W/8XLpUYqVjVTSEWSC
         2y4BdnbB56jyv0c1EL1UykMdB8n92HsGOEk4TyyZoyAD6cobmGgU8/3a5PKGqMq8em
         cBmcERKIIts514xMYueCDbb9zpAC9GbSz1eTjknGjmLekXmhW4nOODLrsg1LXtRTN6
         TYagR0+z86XzdH0wY26dEhvrh7/6mR4z1bn/lm/V6J8NYheTsIqharXpHxJzXe1t+X
         BZFAGa+0UaQOQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A28E9609F6;
        Fri, 30 Jul 2021 23:10:21 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.14-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h_QSqNjAz9EEp4DBk0jQSE3W+m5niC_7KWgvETwS1Yyg@mail.gmail.com>
References: <CAJZ5v0h_QSqNjAz9EEp4DBk0jQSE3W+m5niC_7KWgvETwS1Yyg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h_QSqNjAz9EEp4DBk0jQSE3W+m5niC_7KWgvETwS1Yyg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc4
X-PR-Tracked-Commit-Id: e83f54eacf137de228a52c20c74e77f575684600
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1dab4c02de0b495a9393915d71e452f8e77a464
Message-Id: <162768662165.18102.14339168640741366406.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jul 2021 23:10:21 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 30 Jul 2021 20:52:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1dab4c02de0b495a9393915d71e452f8e77a464

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
