Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633F531712C
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 21:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbhBJUUM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 15:20:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232178AbhBJUUC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Feb 2021 15:20:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 66E1E64E63;
        Wed, 10 Feb 2021 20:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612988362;
        bh=dhSva5z9w5S8NaISHb9NApJpQbh3aZIVz54oFK1B5fY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q0JRM/cuu4/frjHBT/ry41mGdzydcPH4dwFuYDaIum3s7atGxOrnWY/XXFwg/9zDB
         2Uw7lzYngLCsKiSxQLFaLKv44VoSx6k7So8NxNc6BPsBvZD+fqnE/h8hPhMgGGs7+r
         SxKQAAjuvyx8oOLRKC3w6XqQV6Ud8vHWC6uCnNYj3J2wafJL4ppWzvnSgj+b7kyT0h
         wGqAcHPYu6+oxnAkBlkJAgHdBih03G6xqMJhP+zo6RSuJG5yWQHZIG1bSHp/WsddC0
         3D7Y9O7r14Ov7V1MdSMNIkVU6VutIRhSftbfQm8FZCPV3xQDx5mvGbBvyISct1uQys
         lSduHA6Td1xUQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5AEDA609F1;
        Wed, 10 Feb 2021 20:19:22 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.11-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iEwAvR3EyQp0Qy=7ehQyufrUvMPR4CyCUdVd=qE-5OAg@mail.gmail.com>
References: <CAJZ5v0iEwAvR3EyQp0Qy=7ehQyufrUvMPR4CyCUdVd=qE-5OAg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iEwAvR3EyQp0Qy=7ehQyufrUvMPR4CyCUdVd=qE-5OAg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.11-rc8
X-PR-Tracked-Commit-Id: d11a1d08a082a7dc0ada423d2b2e26e9b6f2525c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 291009f656e8eaebbdfd3a8d99f6b190a9ce9deb
Message-Id: <161298836236.25163.12158861332802664204.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Feb 2021 20:19:22 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Wed, 10 Feb 2021 18:47:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.11-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/291009f656e8eaebbdfd3a8d99f6b190a9ce9deb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
