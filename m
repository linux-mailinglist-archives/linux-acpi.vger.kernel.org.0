Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E232345F612
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Nov 2021 21:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhKZUtY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Nov 2021 15:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhKZUrY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Nov 2021 15:47:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF15C06175D;
        Fri, 26 Nov 2021 12:42:08 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B756362379;
        Fri, 26 Nov 2021 20:40:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 1619560184;
        Fri, 26 Nov 2021 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637959207;
        bh=vlInJ/DK+J61Zx5PEJdRH1trST/kJcn44p12hpI+00o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Fgc1843IKf5Vc7ey+i2y2iawA6iSb4chX+ctCHBA4CPQVSxi2zpv2w1oRWBJeDMfC
         0aqDn9pif76Z32EhGEpb5incdcKUVnU2U8lNk3Xixtkw8Kp8i2eroBd8td5sbkpNIL
         MgwVCcOInA2xpQJJo15KNP1XSibVgalPFzm2It9Jhm1lxPqrS2RFoOoqoQ1tZ0kktk
         BdPtyFdhBcU+dyDrWuqopsAxgbOJs8MBaqrdYJY7x4mdA4RzmtdKZQIi7rybN3OLmL
         pwoAMTJsBg5PpsPrt86XizvWQP8ma6C8kUZZmfwR8BaEpYUdAAcTXEVgQ/4ZDghUC1
         LZRSiPyQ8ZYHw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F0B21609D5;
        Fri, 26 Nov 2021 20:40:06 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
References: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.16-rc3
X-PR-Tracked-Commit-Id: 2e13e5aeda156f747919c7111723b9302836fb38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5367cf1c3ad02f7f14d79733814302a96cc97b96
Message-Id: <163795920691.10744.16179332108716724763.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Nov 2021 20:40:06 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 26 Nov 2021 20:38:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.16-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5367cf1c3ad02f7f14d79733814302a96cc97b96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
