Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DDAC18A7
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Sep 2019 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfI2RuX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 29 Sep 2019 13:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbfI2RuX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 29 Sep 2019 13:50:23 -0400
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569779422;
        bh=bHXIm8Z3qU0UO34CYscDkvZ0mPCZy0QUZD2hU22CW5c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k6uf60Sq/6j5t12+qKwBc8d9ZI7mmwmj3V59MX7ZlVmy0mgosZyv6qRFDrTvsGT1x
         Mo4ksvI05dIA2/XrIE5RByLLOjVgGBry58RndIhHwQq1rqp1m+qgfzQOPt9I0NFb3o
         7B9N3XzeHQvsdvO3IieAk7MUyHjSvm2iXdgJML0E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190928231236.GD7360@localhost.localdomain>
References: <20190928231236.GD7360@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190928231236.GD7360@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
 linus
X-PR-Tracked-Commit-Id: 6c375eccded41df8033ed55a1b785531b304fc67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 939ca9f1751d1d65424f80b9284b6c18e78c7f4e
Message-Id: <156977942273.28081.7573269007324807343.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Sep 2019 17:50:22 +0000
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Sat, 28 Sep 2019 16:12:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/939ca9f1751d1d65424f80b9284b6c18e78c7f4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
