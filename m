Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB3910A95A
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Nov 2019 05:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfK0EUQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Nov 2019 23:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbfK0EUP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Nov 2019 23:20:15 -0500
Subject: Re: [GIT PULL] Device properties framework updates for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574828415;
        bh=7A6G8eDNXBHvSxkGbNlpuogo4QdstXRb8kq+cPMOslQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X+vxRzMTfC97OrIk2t2Tmlp6pCkR6F4VMRNpSYaZwHG+H6xt5mr6zqHY27I/XX+xf
         MyVG2idCfLzUqR8PHrmYVM9qiaeKJ+YM/FuuRwlyNTsKQGQZxafTzIIRupZDYttB/J
         VE/H9sI677fNs4BkYkHx+Ljx+6AvKqNvoOYH4qjo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ih9pkWuMkDyKxG3rRnwELtNt+zz9JRudOgEAjS=XZawA@mail.gmail.com>
References: <CAJZ5v0ih9pkWuMkDyKxG3rRnwELtNt+zz9JRudOgEAjS=XZawA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ih9pkWuMkDyKxG3rRnwELtNt+zz9JRudOgEAjS=XZawA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 devprop-5.5-rc1
X-PR-Tracked-Commit-Id: 1afc14032e54a7e6c38304dc9a6bda1b6416f2b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 361b0d286afea0d867537536977a695b5557d133
Message-Id: <157482841525.9403.16826294056156755440.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 04:20:15 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Petr Mladek <pmladek@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 14:02:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/361b0d286afea0d867537536977a695b5557d133

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
