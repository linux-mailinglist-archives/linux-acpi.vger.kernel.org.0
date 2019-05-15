Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD41F83C
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2019 18:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfEOQKT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 May 2019 12:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfEOQKS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 May 2019 12:10:18 -0400
Subject: Re: [GIT PULL] More ACPI updates for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557936617;
        bh=IaS8SR4msxQ33KhgErr361vWjOFHO3roJYspVJGIp78=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mTIuRhR/4ousfpQhbsLvP0zGTJOdB3Hf8LkRedlEDPOXnT9iMaaNV0pduFOr8L8xA
         5cPVtNGJAXWoPMkWD/5x0zoicODAqxPRzbl0jGsjlnlx8NjVeSkGV8pQ0MvAB9fn6l
         r4ycikdv9Q96APtQEf98FYVGC5eWyEau53y1Uh94=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j3pD8rqiQoR7e3FbQx3JjaBh32f4+bHjxza00RsYBmcQ@mail.gmail.com>
References: <CAJZ5v0j3pD8rqiQoR7e3FbQx3JjaBh32f4+bHjxza00RsYBmcQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j3pD8rqiQoR7e3FbQx3JjaBh32f4+bHjxza00RsYBmcQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.2-rc1-2
X-PR-Tracked-Commit-Id: e3e28670bb28ad52d0d0224e86ec11c3f31ff1ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcdec14365ec96f490cf1c8d9b618643ec88a95e
Message-Id: <155793661754.5377.8436869417444896027.pr-tracker-bot@kernel.org>
Date:   Wed, 15 May 2019 16:10:17 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 12:14:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcdec14365ec96f490cf1c8d9b618643ec88a95e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
