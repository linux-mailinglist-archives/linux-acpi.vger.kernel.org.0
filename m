Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC0E3E3024
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Aug 2021 22:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244681AbhHFUL3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Aug 2021 16:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244658AbhHFUL0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Aug 2021 16:11:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AD34E60D07;
        Fri,  6 Aug 2021 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628280670;
        bh=KJBBRB8cD/1zOGXZ4evyeoDieeHXhA9LjEWD6beRD1Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kU+syVQhqncPfLQRBxCqQtF6PFnGXAJ4GMQdWMr2VuZiqyzF2X6oCehrCEC2fYeF5
         uYVJZMs7RwhBBjFfsFXQuGO/+z7RmUHsWVTD7IxJiCGgvA/fWHB9sdw3HTEG6XlQm2
         JWU77jEhpCCLASp8WlMU3Z5dXDG7wDH5C/sIqnvYSpupKx9q3k+FkLppB7P3gajn9I
         WQwR4Yl5y2ymDsXm+keFtiBJRqhqAm9OhwCVi5HmmVzn75VnxRiis+qQrCL5u2uC26
         YU56XOyp1ntjsWPGTikycWetav5gtcWv62fWTFYcCHyZwvQoHGCp4Y0r3WYNVFkHpQ
         iamMG4Y/JjQQA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9CB6560A48;
        Fri,  6 Aug 2021 20:11:10 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.14-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ju+gC_Yt4JUu-BOgL8+YuJ75RDeT7Vk=ACmBVB4F419w@mail.gmail.com>
References: <CAJZ5v0ju+gC_Yt4JUu-BOgL8+YuJ75RDeT7Vk=ACmBVB4F419w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ju+gC_Yt4JUu-BOgL8+YuJ75RDeT7Vk=ACmBVB4F419w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc5
X-PR-Tracked-Commit-Id: 6511a8b5b7a65037340cd8ee91a377811effbc83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d609689d9ff4db12cd38074518e3a19ef0b24a1
Message-Id: <162828067063.25549.234975517348499798.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Aug 2021 20:11:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 6 Aug 2021 19:55:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d609689d9ff4db12cd38074518e3a19ef0b24a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
