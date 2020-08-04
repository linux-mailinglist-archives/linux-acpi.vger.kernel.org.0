Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F3023B3C1
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Aug 2020 06:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgHDEPM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Aug 2020 00:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbgHDEPJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Aug 2020 00:15:09 -0400
Subject: Re: [GIT PULL] ACPI updates for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596514509;
        bh=RtHRjX5uz60KiT01VyDBusXOp1tmigjG1k003aEivJU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cj7pm/41HRUjxS90WiANv8rNk3CxH1yoFPhVghX7FPSj2KqL3/z49YrhnsQde6eLY
         e6FYAzYdULzFMMwJsv0NGdGbdkig3pJwAj4WqTlZCQ0nk+FTrdjXN1WNhpQNXWbWfw
         sJ/VwWqvUOjxO9iXXuWP8LZAmlGUhuWKgPmHnARg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hNz4ai_wmrGJzwRe179=swhG9iFMQRzRuyv4NVer2Erg@mail.gmail.com>
References: <CAJZ5v0hNz4ai_wmrGJzwRe179=swhG9iFMQRzRuyv4NVer2Erg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hNz4ai_wmrGJzwRe179=swhG9iFMQRzRuyv4NVer2Erg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.9-rc1
X-PR-Tracked-Commit-Id: db1da2f52ea5477e917957dd80c1da63affa60e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2baa85d6927d11b8d946da2e4ad00dddca5b8da2
Message-Id: <159651450926.27277.12447229148295500184.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 04:15:09 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 18:52:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2baa85d6927d11b8d946da2e4ad00dddca5b8da2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
