Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED08C4565EA
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 23:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbhKRW7R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 17:59:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232704AbhKRW7Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Nov 2021 17:59:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 18EFC61526;
        Thu, 18 Nov 2021 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637276176;
        bh=yx5p1gw54g9vXqjg0kbe6UPVZGhnaNZgLPLwB1yOjn0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XrGBRcmy4PiUXFlggwxtV99o+B3mtgoJWjO6kOSiRmQ4Ftpbpnfk4NaoSouex2vA4
         rCWwhnlzGLAyeXZytfCpL17F0RBBT/MU/sQGRdrrctGJwRJ2FiYMtO9I7Q0eOuwV+a
         966fL2EwkQDGzjVln0su7LcAtowN3YczqC6kFFkfzN781Pishu/kcMO6aZ0tN8WvlK
         13VnE8FdpK5VsGR35xTQO5L473xbvAGLcRNC55c0mOOJG2csbPDS2dACsETqjklTvR
         +4eBKASWdFxVx2NeiEQ7TiulHwABbJw3tYgmvdWBUz99uQKjMRVMkpYUxWLmFo203k
         cRIA9JmJJpKZw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 12B3260A3A;
        Thu, 18 Nov 2021 22:56:16 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iE0eRnfid-3+_X1+efdVpA4N6LBX2nKYgWo8bOmp7Arw@mail.gmail.com>
References: <CAJZ5v0iE0eRnfid-3+_X1+efdVpA4N6LBX2nKYgWo8bOmp7Arw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iE0eRnfid-3+_X1+efdVpA4N6LBX2nKYgWo8bOmp7Arw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.16-rc2
X-PR-Tracked-Commit-Id: 3b2b49e6dfdcf423506a771bf44cee842596351a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17e10707059d60fce4ab0f1e24785d6ec41a71eb
Message-Id: <163727617606.9679.17074896119002905436.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Nov 2021 22:56:16 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 21:12:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17e10707059d60fce4ab0f1e24785d6ec41a71eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
