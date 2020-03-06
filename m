Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCCA17BD98
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2020 14:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCFNFF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Mar 2020 08:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgCFNFF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Mar 2020 08:05:05 -0500
Subject: Re: [GIT PULL] Device properties framework fix for v5.6-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583499904;
        bh=OU+efo3JEoojfPqrg4I9k/zm/AeiMBXbyMe326sOMsY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yloVDaYHS0svx2Naq62r4oe/kTIp5rbM/8AW7dqj4SRPcfKg8iCq5wCNNod8cY8/i
         vY+99Mcvyjrl6PJQuR/jQlXtgjEcQ1R02jra/rrWrScDDMXEl9oU7nYtyZRsOFTWhq
         v9HIgmNse4ACjqGHsVeR2w3aJ3FKIGhMd9vhK5SA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j8jvHpHW+BBALg9L8=hq8PjyVyMQHfUCmusMeTLDifVg@mail.gmail.com>
References: <CAJZ5v0j8jvHpHW+BBALg9L8=hq8PjyVyMQHfUCmusMeTLDifVg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j8jvHpHW+BBALg9L8=hq8PjyVyMQHfUCmusMeTLDifVg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 devprop-5.6-rc5
X-PR-Tracked-Commit-Id: 7589238a8cf37331607c3222a64ac3140b29532d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0b8a945ea29166706611820e609bce23e278f6b
Message-Id: <158349990476.8760.7729907131824907273.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Mar 2020 13:05:04 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 6 Mar 2020 11:20:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0b8a945ea29166706611820e609bce23e278f6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
