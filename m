Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 703EBEC742
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2019 18:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfKARKG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 Nov 2019 13:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbfKARKG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 Nov 2019 13:10:06 -0400
Subject: Re: [GIT PULL] Power management fix for v5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572628205;
        bh=l1Kko6zIKsqjrtUyfFoFoSSLPvcqDcVUr8D7mPoyI/o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oixOAemGXJkUMgcDz0DP0dherIA5VGu+vMPonMF/Vq3t7hzxeHfmC0eKVWgaXGTfs
         v5PvYL2LD3XOHZbkJ0FG0SmzpqTDKYahpVBGWfliUUSf03b8gpXMkGVRwXWZCEez+z
         sMEbu9w2VfPyVXNqA8XQKnrB16JqynmTJZoE7HyE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gSz1Pk=7u0s-cgjc9_0ibCyA6RNCcVHw7+GLWWoCj22g@mail.gmail.com>
References: <CAJZ5v0gSz1Pk=7u0s-cgjc9_0ibCyA6RNCcVHw7+GLWWoCj22g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gSz1Pk=7u0s-cgjc9_0ibCyA6RNCcVHw7+GLWWoCj22g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.4-rc6
X-PR-Tracked-Commit-Id: e82b7457909afd2e973ebd251ad79945d04ca376
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65a5bf1c790039dc194507563478137b4314a59d
Message-Id: <157262820561.11375.9184455321473410481.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Nov 2019 17:10:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 31 Oct 2019 22:08:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65a5bf1c790039dc194507563478137b4314a59d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
