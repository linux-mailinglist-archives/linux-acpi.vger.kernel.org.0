Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8862F84EC
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 19:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbhAOS6n (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 13:58:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbhAOS6n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 13:58:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 387A723A9C;
        Fri, 15 Jan 2021 18:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610737083;
        bh=m5Abs9GoTrDjEJP5wnCSJV6n9l34gJNDIIRNnOWIdGY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cuwLYeV90GsUWYlXAs3l0VemIN4fquT6IYkcZjLjHWFHMgN140u4o+CA8tF5WUVUW
         7r1cbLuRscKoEhefezT6wg7oLYMJo8ejJGxTJxXRsntazyaGR1Ft1gvTsDko0i2THO
         odU4S0kmhjiVRzCNTz/q+rUlraB787ltMX34PfBJ4wqOdgH8LCSPEwJQS77TAX8Ogm
         QnZTHaeFoWaJRH6ZMSiv0ZRE7VuodeyPZk5H4JqvNzf6xnSZ090VTIl7xvAPVSL0lS
         T2GVyDqX25T4AjGDnEHgDOGx5dhPYwGdoT9w6e6+6NomJWqHS9NLPZJlPAZ/dGusBU
         ZSQPP1D9ynHFQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 331AD6017C;
        Fri, 15 Jan 2021 18:58:03 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.11-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ipfG_GBT0nYjZk3LA9LDpWQLoe81-309h0P1X5BvOOdg@mail.gmail.com>
References: <CAJZ5v0ipfG_GBT0nYjZk3LA9LDpWQLoe81-309h0P1X5BvOOdg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ipfG_GBT0nYjZk3LA9LDpWQLoe81-309h0P1X5BvOOdg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc4
X-PR-Tracked-Commit-Id: 179892adb0436139fd8e6af7b27f54219c1750f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4e087c666f54559cb4e530af1fbfc9967e14a15
Message-Id: <161073708320.18503.12939850071793543288.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jan 2021 18:58:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 15 Jan 2021 19:45:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4e087c666f54559cb4e530af1fbfc9967e14a15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
