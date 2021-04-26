Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C473236BBD6
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Apr 2021 00:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhDZWwN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 18:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233919AbhDZWwJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Apr 2021 18:52:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8AED261185;
        Mon, 26 Apr 2021 22:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619477487;
        bh=hZtA61Bv53WKexRZLYj3O1Uo2iI+j7O7Jsfn7MqQ8ew=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IEDMd1sxDm5862IDXDyfxKqqKSvdBfHhnji0LufiQCxjk8r1OP0CRbf6MYDRV5jhJ
         X3l3Iv8r+37FVZg6X1PJ9gMVN6c9ciYJn/WFNBxPD2kZEp7+2N19F0zhOab9OLJ/TJ
         ja2irXA9fJHFS1e6KL1si9O1Nl7HcyP2r0yUqMax8ylTcIc8mKOBrBGfyJQSsfp3LS
         rukOr1CP37+ts+ea2jxQvr8S4+etpuVGJvBHvNaAD8PQDdFKUw5zv6ymwYVo8w36Ci
         lirOLUEpZJeZzLB85WLn9chQ0T2UqLma7LWjAvMgR/BBjy9K2/P0opWdjUrxmVwlRE
         Jl5lExjsnuKQw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8393A609B0;
        Mon, 26 Apr 2021 22:51:27 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jdRxPj-tJaxbOYHXk505NoG1EefSJUmtgso9KGAm3rzg@mail.gmail.com>
References: <CAJZ5v0jdRxPj-tJaxbOYHXk505NoG1EefSJUmtgso9KGAm3rzg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jdRxPj-tJaxbOYHXk505NoG1EefSJUmtgso9KGAm3rzg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.13-rc1
X-PR-Tracked-Commit-Id: b6237f61fc9ca79b8771a4fa412d2c630c9f8d2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8f9176b4ece17e831306072678cd9ae49688cf5
Message-Id: <161947748753.6408.4745043706520347761.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 22:51:27 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 20:24:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8f9176b4ece17e831306072678cd9ae49688cf5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
