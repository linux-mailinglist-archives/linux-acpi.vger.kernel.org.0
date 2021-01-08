Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1DB2EFBDD
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Jan 2021 00:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbhAHXtm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 18:49:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbhAHXtm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Jan 2021 18:49:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EB3C723A7B;
        Fri,  8 Jan 2021 23:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610149742;
        bh=GdViZsjqagd/iKI8B6SIY3ZaqdowvOZ7DaZcI0KqYX8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r67ibDwsyJkE/3/lS5eterHXrSvJYsBr/rc6r0E5yC9hQjCaiUKe6x3ABxBQjaTVx
         555S8IjOllynSGm7oteBW6BS9n2v8tzipQAPw+QizINqmsouQTR0X+sTPHA2CADdHC
         RQQ9FzX2HlChpPdnjwT4PQlKA/FSGDksvsd+Z4Y+fXXrhNGxPrv37IKuMw/DBl+Vwl
         oRQMdb9keuDBNZMJZToG1Hu95keP0NFBNa900UGjFCUs57ZGBRZoe2Bn6bZv22nVHl
         6oPM5Q7KsOmlzXWnpIntr6rLqFKFPEe26eQNppqMJt0Vq8NUlQN6F5l56oN3DACLlA
         t5tEOoE8g0P6w==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id DE62260157;
        Fri,  8 Jan 2021 23:49:01 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hZP8tsniMBtjBatd-ORJMXqVWXiPEPpJvpfZagUGyPEw@mail.gmail.com>
References: <CAJZ5v0hZP8tsniMBtjBatd-ORJMXqVWXiPEPpJvpfZagUGyPEw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hZP8tsniMBtjBatd-ORJMXqVWXiPEPpJvpfZagUGyPEw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc3
X-PR-Tracked-Commit-Id: 24e8ab6886d80fe60b1d4e64b6d9f15ea9ad597a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb9ca0be63b49eece304f50023e736a678cc4159
Message-Id: <161014974190.3246.4325447728795295973.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jan 2021 23:49:01 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 8 Jan 2021 18:53:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb9ca0be63b49eece304f50023e736a678cc4159

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
