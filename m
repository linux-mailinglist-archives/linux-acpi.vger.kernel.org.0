Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CB7353152
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Apr 2021 00:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhDBWon (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Apr 2021 18:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235567AbhDBWom (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Apr 2021 18:44:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D9E7861184;
        Fri,  2 Apr 2021 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617403480;
        bh=rkDhXU156TQPnbeRmlP99Zm0oznIao1oF2mfY2kUCbw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SHjJVmIf748KI5RKZRUScMKuMwKtVqP1YQZsc8NU7UiUXpR8i4ayHzvOCxnCTg+QQ
         4+uB6QyryFOjjbAzuQIdXFj8IVQZcmeO+i5dH8iFej++NwoP7StV/6Dki4254iZsrb
         r5nuBovSq/sTmiJyrmY630xa/f7jJWxddwOUNqHId5nIVWq+EK3KTY0kDOyV7BTIo6
         rZHf8daQMTO/Q8qCgL9igE9PDAaLXYgb+CyvjMse/54MpZj8oJowVY0nOtg1mTv5E9
         i2Q276m/7QGFg2X6m43OQePUxtnTZWWWGqe60aFlH3ytO3raDNdYOG6YygEDZvLBzG
         FLvkVWSO6yBFA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D23BF609D2;
        Fri,  2 Apr 2021 22:44:40 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i0xTJfQuS5QK1Mkc-wkBAf1F4ga=tuNLrp9uHcQPUKNw@mail.gmail.com>
References: <CAJZ5v0i0xTJfQuS5QK1Mkc-wkBAf1F4ga=tuNLrp9uHcQPUKNw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i0xTJfQuS5QK1Mkc-wkBAf1F4ga=tuNLrp9uHcQPUKNw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc6
X-PR-Tracked-Commit-Id: 91463ebff32d3e6fc71134784ae6aa91402bfe3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a84c2e440f74cbb2064084cc7ff4f74f5565ba7
Message-Id: <161740348085.31502.7898647118295775851.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Apr 2021 22:44:40 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 2 Apr 2021 18:04:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a84c2e440f74cbb2064084cc7ff4f74f5565ba7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
