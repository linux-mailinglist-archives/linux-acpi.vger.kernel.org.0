Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635F730FB3D
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 19:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbhBDSW3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 13:22:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239005AbhBDSUx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Feb 2021 13:20:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7D00A64F4D;
        Thu,  4 Feb 2021 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612462809;
        bh=tXKNpie789U3LKbi50irPO/NqqIVBvEAxMks1HpsYPc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ncygWutmcQpzylNKLUP92Yv/zF7cw/SudzqSKZJW76kKYUN0O0Y8CAACGBi5RHAuL
         cNRICP8aZaVVH6bxfUkdIsd9jIuIEB1+KGq/7KUKF9Iv8TMb++A4YEc0A+coNAx9VV
         nbieGhoX/jFP8FmkyoO1Nkxmn6WXa5l6UAP+AuVdjLUzvCjKS4AFMDKC8GiV8m5y8D
         /aRonoDfUEiKlgayfHUD5dbJnf8llY4Ap1um6JB1vwCr9RYyUZTNFepdRdAmsQi/Hh
         xQAEIdT6aD3hXYhOTnCmPkXsb1RrNS/Fu64OGpj1JDVBl1AZZoRYyiCjUSzUAmr6dF
         gg8iKmSsStxEw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 623D0609EB;
        Thu,  4 Feb 2021 18:20:09 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hvbEQehBdq4FNtU9t0xQ1jEtcDVH5b96Bo=Me-dbNg-w@mail.gmail.com>
References: <CAJZ5v0hvbEQehBdq4FNtU9t0xQ1jEtcDVH5b96Bo=Me-dbNg-w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hvbEQehBdq4FNtU9t0xQ1jEtcDVH5b96Bo=Me-dbNg-w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc7
X-PR-Tracked-Commit-Id: 0f347aa07f15b346a001e557f4a0a45069f7fa3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 927002ed29e2dda6dfacb87fe582d5495a03f096
Message-Id: <161246280934.20291.3959318873933475356.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Feb 2021 18:20:09 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 4 Feb 2021 19:05:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/927002ed29e2dda6dfacb87fe582d5495a03f096

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
