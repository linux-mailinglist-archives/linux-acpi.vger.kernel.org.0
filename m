Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931C7308FE5
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Jan 2021 23:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhA2WNo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Jan 2021 17:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232902AbhA2WM7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Jan 2021 17:12:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E471C64DDC;
        Fri, 29 Jan 2021 22:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611958336;
        bh=/SVJ+uL1rQaD4F5YhrrFT/Fd13xIvTRb0HXNGjSwgsY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=civvN1fF50R3FxfDWc/uJKetHhydGscWCBj89j2e2WKmBrrR6LXLrC7LNBtrvgSDz
         6jsUOA8tlG8WFTTe8/pdEijBe+J5zZl7K0VVPLpCV52Ef1AchXEzZtVbgFY6giM6UB
         JRzr3ISreWj3cnsisDqNGRMYN0Pl8bLrTgp2rPJn0TkGpNzVBtCjxTS23UQ7Vs3x5L
         BPbiA4VvthFw+iqiJfJVIPd3Ymvb71SDfTN/astRV85EMaU8tgAb75QeFGHa9PtZqR
         dSj8eOMuRDhu/D0HnL4G3OuIBrb/vqxRinPo2tN7Vd04yJLELA+RhmHH+6oIjXfKFh
         30V8g6lVfxgsg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D933360953;
        Fri, 29 Jan 2021 22:12:16 +0000 (UTC)
Subject: Re: [GIT PULL][Resend] ACPI fixes for v5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0is8qQ91Nx_hhMgc3Ga8NgFbE-JAu03=M-L9sCpf8pVmQ@mail.gmail.com>
References: <CAJZ5v0is8qQ91Nx_hhMgc3Ga8NgFbE-JAu03=M-L9sCpf8pVmQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0is8qQ91Nx_hhMgc3Ga8NgFbE-JAu03=M-L9sCpf8pVmQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc6
X-PR-Tracked-Commit-Id: b584b7e9630acc65a4d01ff5f9090d1a0fb3bbb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 016decc0d836b746faac03de5e1ac976c53a3958
Message-Id: <161195833682.1476.6884925231244087533.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jan 2021 22:12:16 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 29 Jan 2021 19:11:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/016decc0d836b746faac03de5e1ac976c53a3958

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
