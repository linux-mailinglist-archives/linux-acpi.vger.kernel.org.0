Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A744CA34
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Nov 2021 21:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhKJUMv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Nov 2021 15:12:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232524AbhKJUMu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Nov 2021 15:12:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D108B6109F;
        Wed, 10 Nov 2021 20:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636575002;
        bh=CfhFsJTxtemER7Oj+RqFkICRnFZzS2IANSQP5xh2jsw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QxqhTNw70wKBqnHCvZi4K5qpjFm7K4tMcUl6PnbPF/EfxFrdk81XFzajqHm+mXblt
         ac1KhfnwDswhoWDDG5FgyQtYPCAfyl9SyQ+3LWCB7gtsJQvaheWnxwCHRRuK4pNK4G
         pT3IYLrSjsieimRUB03k91RNZJXmy9OAkuQPGjBqQ58/zhJqj738CXJeTJb1qEdEA1
         VbLeVkHZzMbXXow2w0aO0Zn2ZXe1iwAkz2B9AOMI+U57ktWW5Vlsvs2rdYekL7MOVl
         BbERISg0/tZk12LXLz6TcTJFVWqx5kuhkItcWQ2nYmzjF6xkNr5qJABMbW7sozjfV+
         Dd9Jx9WOOAgzA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C9CDB60A6B;
        Wed, 10 Nov 2021 20:10:02 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hjcR1z_kD_jXthbXuebYbRCG3-BZsaZBD+Ta83-Kf+og@mail.gmail.com>
References: <CAJZ5v0hjcR1z_kD_jXthbXuebYbRCG3-BZsaZBD+Ta83-Kf+og@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hjcR1z_kD_jXthbXuebYbRCG3-BZsaZBD+Ta83-Kf+og@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.16-rc1-2
X-PR-Tracked-Commit-Id: 314c6e2b4545efd5b88988f2308e90eda6a4bcf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 285fc3db0aeb7befdba433e286fa994dc9c9874d
Message-Id: <163657500281.19350.7862262916458797237.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Nov 2021 20:10:02 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Wed, 10 Nov 2021 15:30:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.16-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/285fc3db0aeb7befdba433e286fa994dc9c9874d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
