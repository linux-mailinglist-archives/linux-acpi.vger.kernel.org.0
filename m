Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996653B79BF
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 23:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhF2VOM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 17:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235288AbhF2VOI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 17:14:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 98B5C61D92;
        Tue, 29 Jun 2021 21:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625001100;
        bh=+6XrR1IedjpmCWyFFmE8lUZLdI08JUB2Noc+XVG1t5o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z9hZv8qVI6SRJsFA0XMsgizQ3C7PkdWtUuu9Y9pw07GpfRNLzHRY/LolfHoY/GfK/
         kTm/QXELfT4BpSmizFv6HM+9JKTsCM5/VKJ9u36lVF8DySB/NjOS9sC5BkIEq3mEG0
         qfsYkekSFGOPBGlPnmFvABo2p45C+M7SN9ehAGPdnG/mzK6308nUh8B8krTQimAgDO
         7+8B5g8uYYK07T0VXbR0LoeP9FDjGbF/DiO9xPe8oqBhLYRUjazQmDGwW4K7Sdm/MP
         lwk9fFNeo4pQpJYnhaB6n5rsjPvkQN2yUB8elJnnuMNcxpDq3Zvi4MVArpzOSMpQ12
         dvG/vmkVRpA2g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 87BD16095A;
        Tue, 29 Jun 2021 21:11:40 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i+RhTN4LYqG0X5oUg8e2gs1AbwHP__PSvCRoFT48P7Ug@mail.gmail.com>
References: <CAJZ5v0i+RhTN4LYqG0X5oUg8e2gs1AbwHP__PSvCRoFT48P7Ug@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i+RhTN4LYqG0X5oUg8e2gs1AbwHP__PSvCRoFT48P7Ug@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.14-rc1
X-PR-Tracked-Commit-Id: 22b65d31ad9d10cdd726239966b6d6f67db8f251
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3563f55ce65462063543dfa6a8d8c7fbfb9d7772
Message-Id: <162500110049.4657.4126985644338376220.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 21:11:40 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 20:58:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3563f55ce65462063543dfa6a8d8c7fbfb9d7772

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
