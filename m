Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630AF3A489B
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Jun 2021 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFKS1k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Jun 2021 14:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhFKS1j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 11 Jun 2021 14:27:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 86D81613AE;
        Fri, 11 Jun 2021 18:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623435941;
        bh=l+KmVHjF7noXivp2AeSQDaTJ53S1o1tUW3Te1Zr+1Ek=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VPAlsMXR2LAnlKMxnV3Y4msNdi8odHZOyZOadGoIB4F5wxQPGY572Li4YA5Y/BKJs
         N29TzGCqZCOiwrl3Uj3NVZvzWC67g7BUFursyKIl+MjsrcTfKcpwPexGDVSEMOHx1E
         kBIam3Wt5OtS/HQhviCBiyTEj4ee+b44DWt5LBGTu865TaA6CqpNBqIflbgoUsK0/q
         HEIwB9AlVuKarYEaws/bolMrTtOdvNIXTQ1MWfY2AVaeZeR27GxiwzjLJR2+Y5GDQ2
         q7arQ0CWr9yrBYy/X0XmjPE4XDXCkpv8dXRFoVqHCvvWxjcibMtPmmkAXfRL20RVEV
         uqaPeFbSUpN8A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7FABD60A49;
        Fri, 11 Jun 2021 18:25:41 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h=mwaux6QuyjTF09HZ4Q6AjOhr+fBwHdQBoNXVvURiSQ@mail.gmail.com>
References: <CAJZ5v0h=mwaux6QuyjTF09HZ4Q6AjOhr+fBwHdQBoNXVvURiSQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h=mwaux6QuyjTF09HZ4Q6AjOhr+fBwHdQBoNXVvURiSQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.13-rc6
X-PR-Tracked-Commit-Id: bc8865ab32bb8d71b607cf73a8367ceebda88767
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d17bcc5ede561750c10e842f53f21f3acbde52d3
Message-Id: <162343594151.23611.9340184065303825137.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jun 2021 18:25:41 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 11 Jun 2021 18:23:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d17bcc5ede561750c10e842f53f21f3acbde52d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
