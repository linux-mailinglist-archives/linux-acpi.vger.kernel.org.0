Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71073611D5
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Apr 2021 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbhDOSPZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 14:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234595AbhDOSPY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Apr 2021 14:15:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 82B42613A9;
        Thu, 15 Apr 2021 18:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618510501;
        bh=Oq7ChG52LXF7KOKeRl+E1OFukGLw4Z+f+z8khLb9jks=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jrpXaCV5/PnpDuVJL2wa7Qe1xbwEzpMU2NKWsBneTJ9Vwxr08VvT0loBKBT4c9GDB
         Hm/ENKEt1w2S+WUssIlzJNz47JtWcIn1frFZtlIbOobNstkgU2x2zkkacj/rOyrGhq
         oU1+dS8qMK/81dwF2tTB6LrQmCWKR535xbEY/fWOnFVr9SBJG+lZPqHsNh7eYA8+nH
         LyrcKftbXSUxCyu5ufk7HVH337ph7rLQ2c1yuatW5P15nJb4n6Su4kpADwCXIk1VFk
         6TXzlKP65LA90ximMcL6/EnXPUr1XHrMp3TIBWZ3wJru86nkLwHtyIlz1/a9XJWNK3
         NSrBHQABJ41aA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6FBDE60CD4;
        Thu, 15 Apr 2021 18:15:01 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.12-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iGcYnp1Skmu6_9xfOTj9f--8J71u0kxV0jC8HGwDp8Ng@mail.gmail.com>
References: <CAJZ5v0iGcYnp1Skmu6_9xfOTj9f--8J71u0kxV0jC8HGwDp8Ng@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iGcYnp1Skmu6_9xfOTj9f--8J71u0kxV0jC8HGwDp8Ng@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc8
X-PR-Tracked-Commit-Id: 6998a8800d73116187aad542391ce3b2dd0f9e30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e25f40eab52c57ff6772d27d2aef3640a3237d7
Message-Id: <161851050145.16434.1789196060421357636.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Apr 2021 18:15:01 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 15 Apr 2021 17:55:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e25f40eab52c57ff6772d27d2aef3640a3237d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
