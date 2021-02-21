Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138AA3208E6
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Feb 2021 07:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhBUGAO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 Feb 2021 01:00:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231652AbhBUGAK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 21 Feb 2021 01:00:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id AB20664E61;
        Sun, 21 Feb 2021 05:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613887169;
        bh=FBXIMGi3Oo8dfWi6bZJFEtgB8t5hFuvOpzjjw8P6Crw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=inQWzyzE+jNDI+1IgS8WRTn+5Jb2qtPk53DCZb4UJuDUmiNJIBn3im4XG+WIUwN7b
         vZjPUSVHX+G5Ag9nwnNmlcj5MSJN21/SJElj+Q5cD+emFCvKu1tnvGTJ5ZzTPxMGEo
         nyMaSdZiTyrkeQcHv2N8ovVZ5Vvjoavm6N1tGrdoayjsp8kpBFuCliTZt5WZiXQ8Ta
         KuWXVABgpankJN09X1CEvL2fNvI4A5/w0QsdXvoOF8meHMkfKkQDouS+gYuSbuwXA2
         CLzI9UlRKPG/e00bFFeMavlcA8iM+SDQp9y8i8efuocBZB69Z7whI9Fs8kqzubmNSR
         m5Sp5ijj1N15g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9B71960A3C;
        Sun, 21 Feb 2021 05:59:29 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iGLCC_9pyyYE8AjqBzD+x7gQrAMDzMjkoyy0g3v9iXJw@mail.gmail.com>
References: <CAJZ5v0iGLCC_9pyyYE8AjqBzD+x7gQrAMDzMjkoyy0g3v9iXJw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iGLCC_9pyyYE8AjqBzD+x7gQrAMDzMjkoyy0g3v9iXJw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc1
X-PR-Tracked-Commit-Id: 2d4eb3317248c55268685e80f692c2eefb485a31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c8f504b3a486e4e984ac8dc619eba3afa24cec4
Message-Id: <161388716963.9286.18082702068122454061.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:59:29 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 19:45:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c8f504b3a486e4e984ac8dc619eba3afa24cec4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
