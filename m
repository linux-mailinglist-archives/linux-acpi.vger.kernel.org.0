Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299CE417B07
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 20:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348169AbhIXS2Y (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 14:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348165AbhIXS2Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Sep 2021 14:28:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B85A061241;
        Fri, 24 Sep 2021 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632508010;
        bh=22FKpYLa8Y4WGhgBOcxmGEfIsvI26zLZn7qeqJI95cw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QwDI+xRvb75LHx3Kvub6J9yhrDwqOnTmIeU2Z/lwSJ8taEIItlxRHI2zsu4MsX5IF
         /VJZf/3Adhqe6+SXj2uc1eLM364sZad41esN1PxPa1hlIJI4qICjJXFL/0sf7+n8zI
         AlPRqiez/GdDB+BZDu+rDaeaqopynDnA8Ggtieu5J3d3rAXof5IDMwVlYTVGQQcUBE
         U6ywUqZREo6jyNV/Rm2MK7nJy71u7xLJYPWbOczEJk9CWS8i5meTUzh5E7GGDxxWS1
         +x0rC3OB829flzOLTWrYSQiVwqeFtKRij/SX/Bu8hTKdiqRRDxQ29CcBK6xv1oyis7
         1AXgmvrSFHqCg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AD80360A88;
        Fri, 24 Sep 2021 18:26:50 +0000 (UTC)
Subject: Re: [GIT PULL] Device properties framework fix for v5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jVNqcqHET2W1uPiBtGDJ=C6JMxJVCnRB4UyiT1ci=9-w@mail.gmail.com>
References: <CAJZ5v0jVNqcqHET2W1uPiBtGDJ=C6JMxJVCnRB4UyiT1ci=9-w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jVNqcqHET2W1uPiBtGDJ=C6JMxJVCnRB4UyiT1ci=9-w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.15-rc3
X-PR-Tracked-Commit-Id: 5aeb05b27f81269a2bf2e15eab9fc0f9a400d3a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47d7e65d64cc72756b1aa0ccfa3dcbd38c638507
Message-Id: <163250801070.5900.1202989588115736229.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Sep 2021 18:26:50 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 24 Sep 2021 20:02:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47d7e65d64cc72756b1aa0ccfa3dcbd38c638507

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
