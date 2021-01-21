Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0650A2FF514
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 20:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbhAUTte (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 14:49:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbhAUTtO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Jan 2021 14:49:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1FE412310F;
        Thu, 21 Jan 2021 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611258514;
        bh=TaV9F1KgmlAbeRrJvDmJkqScIXqT1TJ8FbNzKQcAcoM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rVTmRgc6MXIMw2R69CExAiHNU/A5bpiRVtzKfwei9+7ZC+goMcNx+ktuHNqVFvvs/
         I9ocK3zKnL9vX8CxViuk4C5e+q/i9JSP0785D27Ock+vqJcx7ZvW5EHI+Aag/yMv0C
         DAo6/cTm38h0HLReU+kL7YYIwpNpAH+JdT2+ewYx5kLIz76l9U2g4loKR8ec6zL26y
         GE5Acj9L7McJ2nFoz3Br5f3V8MXQIZilZeh0z8PczGBO/sQQ1q3wxK2MWPOnx3kNM+
         9bOfiW6tGRWp36h3+Z7NEbf9iFXIUmfT9f5QWAbBKQohuSO5mVzMeyNQswpyBpOqse
         PM919+fnRU8Eg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 15B9C60584;
        Thu, 21 Jan 2021 19:48:34 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iN2y5wQNaY3nGEQkq2aXbNzGLHzU29tTqew65CdqTafA@mail.gmail.com>
References: <CAJZ5v0iN2y5wQNaY3nGEQkq2aXbNzGLHzU29tTqew65CdqTafA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iN2y5wQNaY3nGEQkq2aXbNzGLHzU29tTqew65CdqTafA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc5
X-PR-Tracked-Commit-Id: 78a18fec5258c8df9435399a1ea022d73d3eceb9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a52f4cf863a53b8196286e2b95d3ef3bd8183ad
Message-Id: <161125851408.32181.6153273874458228152.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Jan 2021 19:48:34 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 21 Jan 2021 20:05:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a52f4cf863a53b8196286e2b95d3ef3bd8183ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
