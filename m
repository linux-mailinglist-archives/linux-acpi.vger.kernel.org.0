Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F58393587
	for <lists+linux-acpi@lfdr.de>; Thu, 27 May 2021 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhE0SnX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 May 2021 14:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhE0SnX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 May 2021 14:43:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 428EF613AC;
        Thu, 27 May 2021 18:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622140910;
        bh=LORWVZlLu83pAyB/QRvy+Br0rns+Q9Ogm4QW+K6dg2w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qzq0BleLoS362e+2rNNFwbRPURs/WQyam2FA6TCHyJmx/C5l+O+gc7o4gFBGpBsXr
         366fzuKhxFXpgElDPQFUWoZL/LpnrMsoBEtVq7HDYYLV3NjpU9UOKbrusOXJhWZqHv
         BweHZCijU8qIF57E7OoE9uf48qVKfZUcoSngLOuTyGFIZMOYFqpfpTj1DyVeukmKCn
         8JmkWDJ/HV31GVaCXoUb0jq/TCeWMBxFQ9jBrW5YI0TZNQTNpNNyO9m/Qr+bRItdd1
         40+fTd1I+A52ZZWL+154h/pVou6vT3QgvFbZIj+C2atZbq6vdtZliTvKNnb0ARzeT+
         gzxRcDzHGEkTA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 310AC60A4F;
        Thu, 27 May 2021 18:41:50 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i1WebaCZL3q-6rQOexMnYXacD6KTnO1ONcxN1Li01LSg@mail.gmail.com>
References: <CAJZ5v0i1WebaCZL3q-6rQOexMnYXacD6KTnO1ONcxN1Li01LSg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i1WebaCZL3q-6rQOexMnYXacD6KTnO1ONcxN1Li01LSg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.13-rc4
X-PR-Tracked-Commit-Id: 9b7ff25d129df7c4f61e08382993e1988d56f6a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3224374f7eb08fbb36d3963895da20ff274b8e6a
Message-Id: <162214091014.4321.9952958885965277813.pr-tracker-bot@kernel.org>
Date:   Thu, 27 May 2021 18:41:50 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 27 May 2021 20:32:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3224374f7eb08fbb36d3963895da20ff274b8e6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
