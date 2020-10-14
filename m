Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B4A28E6C0
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 20:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389606AbgJNSxS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Oct 2020 14:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389365AbgJNSxO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Oct 2020 14:53:14 -0400
Subject: Re: [GIT PULL] PNP updates for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602701594;
        bh=EODUHICOutUrZvholT7x0WG1JmGe7K6gXyyW3zkRlUY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gDNIRaAWXG6dog/BxHXlMcouPq03An2Z+D5D4Qxtuxmml5/pgvh+a5yht07zpb8T9
         QHeMhS2qtXbztkobsIqr3HXjTeOFzrtfpWd2THt07WEL0OV8EAz4QU/DfKvAas5K2W
         CakW9WW4T33CbDQUItOd1DEummG1pUK/brkeCtQs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gj1X7kO2uVX=zMzR6+y1BWAERT+HDT+0zY0ieXs+Lx3g@mail.gmail.com>
References: <CAJZ5v0gj1X7kO2uVX=zMzR6+y1BWAERT+HDT+0zY0ieXs+Lx3g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gj1X7kO2uVX=zMzR6+y1BWAERT+HDT+0zY0ieXs+Lx3g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.10-rc1
X-PR-Tracked-Commit-Id: 2ef0342530b0f487a65b5f6c94c85dce5f9b53b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: defb53a7c790f9e37a765de8a5d830ed15e2055b
Message-Id: <160270159396.3085.6835413321253755227.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 18:53:13 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 19:35:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/defb53a7c790f9e37a765de8a5d830ed15e2055b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
