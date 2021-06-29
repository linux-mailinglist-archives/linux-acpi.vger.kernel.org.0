Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876893B79BE
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 23:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhF2VOM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 17:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235579AbhF2VOI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 17:14:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AEDE060200;
        Tue, 29 Jun 2021 21:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625001100;
        bh=2aFM78B9Ux3Y3o/9PlJRFNEZEcWWDZHSquCXRDCFxPY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uH9pYDY3mHEJF3gqyKQlHfZUb2rxdUzH60T8Lcgx0GrUyke82LJkUMzfZ3y57Dr97
         pAk4IfT32orhhSUJrWVwg5CwzgcLxh7l9FOb9fCcQLgjP2ukRXl3+0OBw0XczEMlFV
         i0MTEyGnyNHAa0Rti8fmzMQXiEy2ezI/MB3voWeIiMEINqx3U/fpXeZoalju5HXBFq
         83PMivWh9i0nP5HwETvPsMrG8pbi07H0oeH7hpY2AMTBMtkEVVc6HukzJ2W2IVDRyo
         lcjpE5f8oyBIjq3e4xZVeA8LuP8j32Y9BV/XNMry7gjSVZzWwo3pcomSEviw8/VOOl
         3H+Fs4Qv4jsSQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A3089609A3;
        Tue, 29 Jun 2021 21:11:40 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hm5ihfU_hBbMB9u7SmH18PLGp6+Z6=wBLa8WxaVQRTpg@mail.gmail.com>
References: <CAJZ5v0hm5ihfU_hBbMB9u7SmH18PLGp6+Z6=wBLa8WxaVQRTpg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hm5ihfU_hBbMB9u7SmH18PLGp6+Z6=wBLa8WxaVQRTpg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc1
X-PR-Tracked-Commit-Id: 64f9111dd6225a50b8fdd365dfdda275c2a708c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e6928249b81b4d8727ab6a4037a171d15455cb0
Message-Id: <162500110066.4657.304240203537983404.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 21:11:40 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 21:01:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e6928249b81b4d8727ab6a4037a171d15455cb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
