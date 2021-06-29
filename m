Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978D93B79C0
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 23:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbhF2VOO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 17:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235593AbhF2VON (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 17:14:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2A94561D8E;
        Tue, 29 Jun 2021 21:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625001106;
        bh=7umkmhI1lbet+HUTvSFJthfsCN4NNTUXiftvAiUPw2k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kbI5huwDJUUynl6A1aenBkqZuVSzpA3Q2jgOZ7MQwOHzyauvcnsAaLs1VLakrdTCk
         LU1jNkZpH0VcSvu7irfFyIasNpBiMQwjmRVn4mB7wk1DCjL98jlgY/qPSpCqopjoka
         OyG/t2GALZfeqrd/GiZSemQUJOzPTaR/3NrQ7uCCXjKuwwLnjvkeI5kPyc4KtHTXBh
         2XwZP1Y0L8qz4uMf31zbzu0izEVisOrI+6tPo+aMyplB6fntzYxWsbO4Xhkv5sfk9b
         uZcYHnK44oM/WpOuRVM7N25Irt6p5njr00ZFowA1P24+5J2Z96yuwECy7bifADQWeW
         mR4BRzj/r2jfA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 259996095A;
        Tue, 29 Jun 2021 21:11:46 +0000 (UTC)
Subject: Re: [GIT PULL] PNP updates for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hNnTcoTUd8fn-kRUP6+1Nd-1zRMFgaa_ZL-VaGpx67PQ@mail.gmail.com>
References: <CAJZ5v0hNnTcoTUd8fn-kRUP6+1Nd-1zRMFgaa_ZL-VaGpx67PQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hNnTcoTUd8fn-kRUP6+1Nd-1zRMFgaa_ZL-VaGpx67PQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.14-rc1
X-PR-Tracked-Commit-Id: 17aa26c96fb240de92db90ec1bfd616f28b6dc16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72ad9f9d215397aa0ffacf88c5f7e020b856d47f
Message-Id: <162500110614.4657.6789599989102506107.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 21:11:46 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 21:03:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pnp-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72ad9f9d215397aa0ffacf88c5f7e020b856d47f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
