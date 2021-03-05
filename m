Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB3132F5AB
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 23:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhCEV7c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 16:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhCEV67 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Mar 2021 16:58:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 27F9A65012;
        Fri,  5 Mar 2021 21:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614981539;
        bh=QpsIf33O/53YutbYi+JGFUHbDVey9lLa9XKirngSbt8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FeFECbKqW2pKq2pJI0Ws8K4+n0M28kiBSL6hylfiVIzMdewKCsLvYCPjRhOuAxB1p
         KKamI7Q5zILlbqyVu5yPaPb7yWccXe84vUP69ZV8CE1RGNEPGy8Ox0oSMiOHp2QLy6
         C1omDKAtfCJzaLx0TUrVeaGP165ZcWInau40XxfSC+5ZfNX5KQRX3gGAZtku2Sk3b7
         cP5qCVkPFR5diuDT3/6f24S83dWPipVRAhBYiS8sKRiMJwj/ozqqRonoQ/uKqvQCKJ
         FtNfbCve2NHMldwnA4N62GJnw5CY5kj9Jm2uvqkMA2JkHlIydSoLo04u6epFvRLrdN
         QyDjsVHA5lpLA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1B47260A12;
        Fri,  5 Mar 2021 21:58:59 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.12-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gVgrV3eeHtiVS715RJXOfd1-_nQR4D5J9a6ggjuUNokw@mail.gmail.com>
References: <CAJZ5v0gVgrV3eeHtiVS715RJXOfd1-_nQR4D5J9a6ggjuUNokw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gVgrV3eeHtiVS715RJXOfd1-_nQR4D5J9a6ggjuUNokw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc2
X-PR-Tracked-Commit-Id: ff70784ab9f89e78e67d5d172bf7644de673f61f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea6be461cbedefaa881711a43f2842aabbd12fd4
Message-Id: <161498153910.14373.11161126735855214884.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Mar 2021 21:58:59 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 5 Mar 2021 18:25:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea6be461cbedefaa881711a43f2842aabbd12fd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
