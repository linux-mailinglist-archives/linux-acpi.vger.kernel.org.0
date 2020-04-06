Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6112719FCD0
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Apr 2020 20:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgDFSPZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Apr 2020 14:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgDFSPZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Apr 2020 14:15:25 -0400
Subject: Re: [GIT PULL] More ACPI updates for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586196924;
        bh=c0kpAE7kAm7f3obFSQl+v81Vk3i1MbreWkcsxsRWApM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CgM8Rcki1FghgmNiubkkrmUUCXVcMCRrbtx0G2XaSWNyiWuB+asfAr4vwJVc4Ha1m
         a2DRqQbdWtI9rU8JqMePNgVNJfZ5PNAm5lETAPnyU1BHwlVKsxZSR0sDP7az3bz2QJ
         PWX6HzMLvdUqfaxalf8+HX126HJG/LKzKOyG+BVs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j8rEiD0uv+LQoAQyfdXORF+joz-vLVH4ryH9_xvZebOQ@mail.gmail.com>
References: <CAJZ5v0j8rEiD0uv+LQoAQyfdXORF+joz-vLVH4ryH9_xvZebOQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j8rEiD0uv+LQoAQyfdXORF+joz-vLVH4ryH9_xvZebOQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.7-rc1-2
X-PR-Tracked-Commit-Id: 33ae7f715e30a674599c7f57dce0512b6051edbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e63420847ae5f1036e4f7c42f0b3282e73efbc2
Message-Id: <158619692442.24927.10673804266808259609.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Apr 2020 18:15:24 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 6 Apr 2020 17:13:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.7-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e63420847ae5f1036e4f7c42f0b3282e73efbc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
