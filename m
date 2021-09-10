Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE6140729A
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Sep 2021 22:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhIJUcU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Sep 2021 16:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233384AbhIJUcT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Sep 2021 16:32:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6EE6A61206;
        Fri, 10 Sep 2021 20:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631305868;
        bh=DaTsC4vFAIEhHRchrAd2bcpRjLy0zziEns5iSRuapxg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jr+pvRF5LgLzenb7obgnlzrQiVVNzTEfX2wL5/YpVqXy3mshRjysOXzpMXFUZryvP
         iLDN3D9XtOIbpnrbgrS6KEo7RF3Do1lph/mK2JucFUMIpY5U6pwsVyM4v2VbZVHCkv
         ERpuIzfPy47FnrstdXLjPtRN/I5RGdP6EwdEdYizlC+sWP0NLRx2EyioMdzCZ1P+rI
         vt5mFVbtQDRuEohJTSLM95dWmx6Uo2Ar4O/G6X5m9ECQwJwZvoaqzpLJBCLC9wbwVV
         0HW1aZROl6GcX4Pck3FMTZ99hZuYomZXVZQcf2oQyKAIP2p3mHM8TOTwNlVHdjyEEh
         h/BaBJSRn9a2g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6862F609BA;
        Fri, 10 Sep 2021 20:31:08 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ha6P6u8pC6nXUipY7ZVDBCh6jMum0A5viFUUamVc=V2w@mail.gmail.com>
References: <CAJZ5v0ha6P6u8pC6nXUipY7ZVDBCh6jMum0A5viFUUamVc=V2w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ha6P6u8pC6nXUipY7ZVDBCh6jMum0A5viFUUamVc=V2w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc1-3
X-PR-Tracked-Commit-Id: 8fbc1c5b91133f7ae5254061d2cb3326992635c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 926de8c4326c14fcf35f1de142019043597a4fac
Message-Id: <163130586842.23508.9793116121936594966.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Sep 2021 20:31:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 10 Sep 2021 21:06:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/926de8c4326c14fcf35f1de142019043597a4fac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
