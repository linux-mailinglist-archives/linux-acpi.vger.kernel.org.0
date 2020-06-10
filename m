Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F101F5DD5
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jun 2020 23:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgFJVpp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jun 2020 17:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgFJVp0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Jun 2020 17:45:26 -0400
Subject: Re: [GIT PULL] More power management updates for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591825525;
        bh=HcV42kZSuE2vWuYag3VZRphUQeBdX+FQjXA4BqJaTpk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZAxomdMaeSg119tjRveDj5/S5h4gZdCAAhV4YUuJuxIY0oo+TicrOo7IpEtv7ztr0
         yxYe/nlroWMjjFkhziIx5osTXGpwtm/+DvDAWpAbrDg4cZk7J67Q2OfmJeuUpFph2c
         Xaoasr4o5uW7zH8G8Po+YFskQhy8CZ5sLOXcQv3E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iEWuYG7-FtYMSk_kJZn-vVgcUimPfud75zSF5MU1Adbw@mail.gmail.com>
References: <CAJZ5v0iEWuYG7-FtYMSk_kJZn-vVgcUimPfud75zSF5MU1Adbw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iEWuYG7-FtYMSk_kJZn-vVgcUimPfud75zSF5MU1Adbw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 pm-5.8-rc1-2
X-PR-Tracked-Commit-Id: 50dd154ed7b17a8b3a1983fc32a8e41d4cc4211a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c67f6b29715ff888cb967cc98336221a8a23916
Message-Id: <159182552563.4867.15640566154384885126.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Jun 2020 21:45:25 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Wed, 10 Jun 2020 17:50:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.8-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c67f6b29715ff888cb967cc98336221a8a23916

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
