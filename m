Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518BC2A0F12
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 21:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbgJ3UGC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 16:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgJ3UFu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 16:05:50 -0400
Subject: Re: [GIT PULL] Device properties framework fixes for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604088350;
        bh=MJCQ+fR8ThFNOdqDprdPwfj2KCy0NNzzpylJqvshCPc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JBcSxVOyTkotoZDy6IHJdNFzrIP+XDTpaEgE/YYvERMI4DfhqlhpqMLp8mHYOU8EQ
         dJ18Rmpyw/w/Sur33B9Cm5UrllNEP4Yk9to6kIg2GNR1YQO5upj5ijrKGq9ccGdouA
         Fjiy/6NymRkgKlkkTT6Xveikb4fk/K1zuoAMYi6I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h+-s3yazW079SVeLV+Bb7=bN90_1VxXSPeDJqmPtd09A@mail.gmail.com>
References: <CAJZ5v0h+-s3yazW079SVeLV+Bb7=bN90_1VxXSPeDJqmPtd09A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h+-s3yazW079SVeLV+Bb7=bN90_1VxXSPeDJqmPtd09A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.10-rc2
X-PR-Tracked-Commit-Id: 99aed9227073fb34ce2880cbc7063e04185a65e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5a16050d78dd4a8a5a2a6614e64f76d59ef8a2e
Message-Id: <160408834994.13990.12019281787044173967.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Oct 2020 20:05:49 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 30 Oct 2020 17:31:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5a16050d78dd4a8a5a2a6614e64f76d59ef8a2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
