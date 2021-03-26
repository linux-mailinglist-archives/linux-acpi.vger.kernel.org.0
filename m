Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C2534AEBD
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Mar 2021 19:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCZSsj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Mar 2021 14:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhCZSs1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Mar 2021 14:48:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C258961A2D;
        Fri, 26 Mar 2021 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616784506;
        bh=YbZcSK3OgDNSMdwfFGN225NtIayrvR9UzGj6uxuQQVc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UfR6EJhjYk3sPUsGs0U13IBoRYKcZ9XZUNnxBv3BfxzZxUEJAEoSau5xZeunbbjSI
         R8h6rVpskKpjdUtv7XryIfFDnYaxxq6fWuzPi1D3ExDpDu5kYeG7TF/C5NkaxqYb8N
         Fq0FU9s7KaSAhnsV70pwc4qKKYOyC/ZbVO4MfL8TfTbDeCb5/cqCoE8lnAmIf+xUEP
         rXCnuOq7PvmkHMHuuerrp95eqeExRjzljoh1Fq7Ew9QoSnOnE7uX9hJmr/7I0GuJJb
         eX2URll4TbMnzh6sKqiBlcHgNbYNUu3fiQr+FFa2XapI8TGpX9eMPy5u3Qh4S0r1iL
         cGo1vF2/WdKrA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A800E6096E;
        Fri, 26 Mar 2021 18:48:26 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.12-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0inc+R90Ra2Bz0QUAUS9Ev1awRkfdDvUPBXjF4FNnJ5og@mail.gmail.com>
References: <CAJZ5v0inc+R90Ra2Bz0QUAUS9Ev1awRkfdDvUPBXjF4FNnJ5og@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0inc+R90Ra2Bz0QUAUS9Ev1awRkfdDvUPBXjF4FNnJ5og@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc5
X-PR-Tracked-Commit-Id: e1db18b59729e24f001459b98955019344d5b12b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7931c531fc527da650e1761d35216ff8edf28a94
Message-Id: <161678450668.8437.16422566882291307071.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Mar 2021 18:48:26 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 26 Mar 2021 17:31:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7931c531fc527da650e1761d35216ff8edf28a94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
