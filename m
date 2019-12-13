Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85CE711EE4B
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Dec 2019 00:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLMXKi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 18:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfLMXKM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Dec 2019 18:10:12 -0500
Subject: Re: [GIT PULL] Power management updates for v5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576278611;
        bh=3VDMKaOSGPTkNpHGoDx3v+RrnjumjThjkba1A8KfkFc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BkHi6nt36Apy1lP/ei9pr9TOOqlTGXJPjrwyZZNQh+18CKzwwrxqVjwubnHqgYN/+
         I8QhRrt+EclosNFSkHNrtevejA8tBdIn5g3Z31/m6nfie6YWDOQ2Gk9tujK3ByQwiY
         hp10230KRdUBAFeAVMauSiNEwUZrQXDz18uKCOc0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g-xo1f2yPWGzFnrGQKFuHV=aDk_nV6s7hpWNnhnqyv5g@mail.gmail.com>
References: <CAJZ5v0g-xo1f2yPWGzFnrGQKFuHV=aDk_nV6s7hpWNnhnqyv5g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g-xo1f2yPWGzFnrGQKFuHV=aDk_nV6s7hpWNnhnqyv5g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc2
X-PR-Tracked-Commit-Id: 4c84515da8099f4bab5d9312a0ffaf40f14aa87b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bd2c87aaffe0b58ce65233fe922b9eb5f7d9a85
Message-Id: <157627861190.1837.9258292989054106751.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Dec 2019 23:10:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 13 Dec 2019 10:53:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bd2c87aaffe0b58ce65233fe922b9eb5f7d9a85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
