Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48ADF339952
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Mar 2021 22:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhCLVxI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Mar 2021 16:53:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235372AbhCLVwi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Mar 2021 16:52:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A4B0F64F8E;
        Fri, 12 Mar 2021 21:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615585957;
        bh=PUZ5OjT/9nMkpNYiiNmI+WW4zl4U5PI7v73dmy1agt0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JyvEuPmRCuFh7fGW0Z4pfQK0JKxOxjOFIFEnygmqyQ5KsuLhlfgN151TW0+WtCtIX
         5+qrFqKsf295e0MY+N/ccXVSaKPtm6zImmmj45rM4qTVCPzmopoL7XE2qbYGJJxbpy
         OoLPKrU3iAXhqSafmY89eX8BwIokM56pv2Muj+Oj2mrpdw/s1hkGWi1d5nDxMA4bZX
         5TASAEYi/ilaTwYpgeEE26bxixUu9sI66msXG9PhFmc8iF0izna8ZG70wF0zDzvjZt
         pKfgPw5LovSEopr/YNkBxeqM6Eq66879beqzUTYspORJKVvMUQ1mCDeeiEz2B1Reyl
         1cUqiyYyR+rjw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 99FFA609CC;
        Fri, 12 Mar 2021 21:52:37 +0000 (UTC)
Subject: Re: [GIT PULL] Device properties framework fixes for v5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ikL-0es_QyQ5XQvxiaYp4a6B1VJ1by_7W2=vp-sWMznw@mail.gmail.com>
References: <CAJZ5v0ikL-0es_QyQ5XQvxiaYp4a6B1VJ1by_7W2=vp-sWMznw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ikL-0es_QyQ5XQvxiaYp4a6B1VJ1by_7W2=vp-sWMznw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.12-rc3
X-PR-Tracked-Commit-Id: 2a92c90f2ecca4475d6050f2f938a1755a8954cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 261410082d01f2f2d4fcd19abee6b8e84f399c51
Message-Id: <161558595762.23578.17851945833841368521.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Mar 2021 21:52:37 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 12 Mar 2021 19:21:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/261410082d01f2f2d4fcd19abee6b8e84f399c51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
