Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389473819D5
	for <lists+linux-acpi@lfdr.de>; Sat, 15 May 2021 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhEOQaN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 15 May 2021 12:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233405AbhEOQaL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 15 May 2021 12:30:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0A07A613C5;
        Sat, 15 May 2021 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621096138;
        bh=k7gxnQ3jgb/s38QvG7Txft5y6PiqAO8JYg21ZFlKOAo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pdC4n8ijCmMgq6A9feSTvbmXnLVGEX2c6aKrkm3+oghqt/JMwC8NevHQu5NTP706b
         DfMVR0iqJC5sqOYRAMQ6joZRz6YUDXwBIHQFLu+5nkwRZHtyJDZLfAgQ1LxBTL7K+N
         gPl62LNUFrH/j34SOG8l89pLF5C3IvTg6l/SoClhntdiH1MlNv1f2PKiq9MKqRoQNr
         rhqZbg9kHz8VMTdaodZ6YpeFfzxeWhkoF0uWjqFzS98/jI87ZiXYAyCtzXFLTff/up
         GA8qukDjLmqpe4yoKR67w8hemILZfrx1CxU5XCTapkzTVuF2pctaIq9OrgYTyzEXcV
         iBr7Vl4KOrpfQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 03FA560A2C;
        Sat, 15 May 2021 16:28:58 +0000 (UTC)
Subject: Re: [GIT PULL] libnvdimm fixes for 5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gEKckAC2_mtjdK22OsEH4tHQSprYmuB7hkhafYquKNGQ@mail.gmail.com>
References: <CAPcyv4gEKckAC2_mtjdK22OsEH4tHQSprYmuB7hkhafYquKNGQ@mail.gmail.com>
X-PR-Tracked-List-Id: <nvdimm.lists.linux.dev>
X-PR-Tracked-Message-Id: <CAPcyv4gEKckAC2_mtjdK22OsEH4tHQSprYmuB7hkhafYquKNGQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.13-rc2
X-PR-Tracked-Commit-Id: e9cfd259c6d386f6235395a13bd4f357a979b2d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5ce4296b0416b3001c69abef7b5fa751c0f7578
Message-Id: <162109613800.13678.1977158030499199784.pr-tracker-bot@kernel.org>
Date:   Sat, 15 May 2021 16:28:58 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, nvdimm@lists.linux.dev,
        Linux ACPI <linux-acpi@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 14 May 2021 16:43:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5ce4296b0416b3001c69abef7b5fa751c0f7578

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
