Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019801135A6
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2019 20:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfLDTZY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Dec 2019 14:25:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbfLDTZX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Dec 2019 14:25:23 -0500
Subject: Re: [GIT PULL] More ACPI updates for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575487523;
        bh=ST2x2hqJZKnpvaVoLO/MItP+gBwWhuoH9sIu8o9CLDI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ev90OTElQnxLxaAJtBiqLTJaCmVm72NsAP3HSpjfWzBMn7DkHDz0b0uu4UwK8/zXW
         T1n3E/JZ7g3gdPj1lFdaz69s+dfutQBMd+N7gybBPtukhsd9mspbv9LKybYTxg081+
         HksKQqAN+32OmewUMdIkCLflFxVzM6NJJu9I/cas=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g4T6cCQr0BegWhY+KD0W2VJRqBTNoeu-bV8RYmPzTtRg@mail.gmail.com>
References: <CAJZ5v0g4T6cCQr0BegWhY+KD0W2VJRqBTNoeu-bV8RYmPzTtRg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g4T6cCQr0BegWhY+KD0W2VJRqBTNoeu-bV8RYmPzTtRg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.5-rc1-2
X-PR-Tracked-Commit-Id: b65d56305c6f5c74b1b4fcaf55d48e949e49d67c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b92f3d32e098a39c2136ee0729174e829a1cf335
Message-Id: <157548752319.30814.11436026609605122114.pr-tracker-bot@kernel.org>
Date:   Wed, 04 Dec 2019 19:25:23 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Wed, 4 Dec 2019 11:36:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.5-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b92f3d32e098a39c2136ee0729174e829a1cf335

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
