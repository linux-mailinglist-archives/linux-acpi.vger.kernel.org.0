Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575B627048E
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Sep 2020 21:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIRTEZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Sep 2020 15:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgIRTEY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Sep 2020 15:04:24 -0400
Subject: Re: [GIT PULL] Power management updates for v5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600455864;
        bh=9qP3YD1QlzGpjQRAkzxFJxtw0sEArX00T6ceH1IJTn8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WFFs1+oYgoS0Dtq5tyatcm7AgMBDRS8DW8lrjG24JLXQfu/+p4a0/fRotEr4oWYEq
         t2NQXik37D41AibfkOCu4BJtNp7yFjNzFHJR/HIVmGUQNWn2ADrjl6IuQu1nf/H5Nu
         ruffdhX86Z5/2owtxYAk1UtzZt9RL9ZQ0Gyt2gG8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h1R51F01za5x3DFEdtWOSKez=FCcqAmGtcE9ANZ-+m9w@mail.gmail.com>
References: <CAJZ5v0h1R51F01za5x3DFEdtWOSKez=FCcqAmGtcE9ANZ-+m9w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h1R51F01za5x3DFEdtWOSKez=FCcqAmGtcE9ANZ-+m9w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc6
X-PR-Tracked-Commit-Id: e8dc676e2a35e753fc46664968963f22e6e8af4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 794a9965eef498f6e4c466167880acb4ab990b63
Message-Id: <160045586399.18461.10454495543347953981.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Sep 2020 19:04:23 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 18 Sep 2020 17:57:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/794a9965eef498f6e4c466167880acb4ab990b63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
