Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14D4315F8DB
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 22:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388727AbgBNVk3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 16:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388153AbgBNVk3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 16:40:29 -0500
Subject: Re: [GIT PULL] Power management fixes for v5.6-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581716428;
        bh=oa+kZsrKTSn+2u96HUaHzFL+l3Q38YOUBibk/3f6Tdg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wyVW0923HjVqQYiM0tCbnrEhweANOhbyJUTyjAmx+x6KC++tnKKK70NBkElgeLsPK
         Sep65wro5qZsbkPNaVwxXG5sKWM77zFUt/lRMfeyPly1yONUZMJlu6CLaCLRiSn+e2
         IiWHNw2aeXVi33nKBpR3K0JC6lI/lUxFZWHyfY0g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hpEebbSFUFdtRnLWvXhyruzNgNaL9o-Od1a3jkgYRQKg@mail.gmail.com>
References: <CAJZ5v0hpEebbSFUFdtRnLWvXhyruzNgNaL9o-Od1a3jkgYRQKg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hpEebbSFUFdtRnLWvXhyruzNgNaL9o-Od1a3jkgYRQKg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.6-rc2
X-PR-Tracked-Commit-Id: 3629ac5b92535793ba6226e243c2324a20c35fae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e03e4e6d2a03a9f2edeefaec12d4f336dee824d
Message-Id: <158171642868.8400.10585778113157556990.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Feb 2020 21:40:28 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 14 Feb 2020 11:24:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e03e4e6d2a03a9f2edeefaec12d4f336dee824d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
