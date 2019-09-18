Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71864B59E7
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2019 04:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfIRCzV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Sep 2019 22:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbfIRCzU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Sep 2019 22:55:20 -0400
Subject: Re: [GIT PULL] Power management updates for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568775320;
        bh=0itgr4Lk43mPwAixc5+dLq8FkdNTHu3fKrvPWWLZAO4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=q1mmcqSTMeQkMIORUxUynvXFL5PjZDU4eOZyauVM7FeYe0cJwfIO9YfeJgd43B5fE
         obc9g8iSxOY1fLycVLZE9WUgkVB8HYXAceq9otLOosUQ4Q9qhWU2V9nD8cx5nOyMd/
         TeuN3kgW+MSuJw1q2zkPaiOvY7pni5Kayn+eJ51U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jrNv=V2oVCNu5HO5akRW1m5Z9tbuW3GxL6H61vqxP7ng@mail.gmail.com>
References: <CAJZ5v0jrNv=V2oVCNu5HO5akRW1m5Z9tbuW3GxL6H61vqxP7ng@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jrNv=V2oVCNu5HO5akRW1m5Z9tbuW3GxL6H61vqxP7ng@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.4-rc1
X-PR-Tracked-Commit-Id: fc6763a2d7e0a7f49ccec97a46e92e9fb1f3f9dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77dcfe2b9edc98286cf18e03c243c9b999f955d9
Message-Id: <156877532026.3897.187741978995228674.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 02:55:20 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 12:23:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77dcfe2b9edc98286cf18e03c243c9b999f955d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
