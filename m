Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186AB278FE1
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgIYRsr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 13:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbgIYRsr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Sep 2020 13:48:47 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.9-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601056126;
        bh=I6kqxpB5hsGUryaQXat2XetpsgUwLtdKU100daHEVIQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jNvemSVBFNzV6W4N6fI6Bz91MBobAaUpg8vz4krTPHr9xipyL/f+uXV0XDVYvlcwQ
         bQs5+5XiSt/7bRQ8gd/2oUMFoTLPDUCyB78toE2l22sNlTVn0mcuvcAOxitCD4Spls
         dloV71JeVDcCm9Rwc0SgOeszlpeakhJy9cKIIKKQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hyx0Jh7Cc2ZpHTM0V+QzFrQtwsXbMjcBRp3TRFgY9vUQ@mail.gmail.com>
References: <CAJZ5v0hyx0Jh7Cc2ZpHTM0V+QzFrQtwsXbMjcBRp3TRFgY9vUQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hyx0Jh7Cc2ZpHTM0V+QzFrQtwsXbMjcBRp3TRFgY9vUQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc7
X-PR-Tracked-Commit-Id: 6040723009060ed356dc93dd9a27e80b2206e59b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15083aa02561f6f208a253132c9d3b72af8c2b40
Message-Id: <160105612653.19145.5008383902164847237.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Sep 2020 17:48:46 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 25 Sep 2020 18:53:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15083aa02561f6f208a253132c9d3b72af8c2b40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
