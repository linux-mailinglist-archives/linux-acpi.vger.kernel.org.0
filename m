Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354CD1DBE01
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 21:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgETTaE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 15:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgETTaE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 15:30:04 -0400
Subject: Re: [GIT PULL] Power management fix for v5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590003003;
        bh=DBC1ySMu3GUFU7h8ZiQfJ32UKjW5VmXm7PUvd/lAiEI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2UggvqTCXsA4NNHtOvB1Zv6vHn+MKoWMuCL5CFZ1EU4UkRGG5cBDscDYBw08fBffJ
         m80ioFhURTvLhj7c8rVk/CKfvjIsmCjZI9PHQJVT8cdFRDBMVn7D19FFM/zXPN/erI
         xPd5MGxP6D1bCz4UON8JY0jBDa3QowDYfn5aAvO0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jE6tnyd741Y1B_1gzVMtcf112e1EOqjJ1AR+oUd5ee_w@mail.gmail.com>
References: <CAJZ5v0jE6tnyd741Y1B_1gzVMtcf112e1EOqjJ1AR+oUd5ee_w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jE6tnyd741Y1B_1gzVMtcf112e1EOqjJ1AR+oUd5ee_w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc7
X-PR-Tracked-Commit-Id: 607b9df63057a56f6172d560d5366cca6a030c76
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ea1940b84e55420a9e8feddcafd173edfe4df11
Message-Id: <159000300388.7201.5708064379590396620.pr-tracker-bot@kernel.org>
Date:   Wed, 20 May 2020 19:30:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Wed, 20 May 2020 17:17:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ea1940b84e55420a9e8feddcafd173edfe4df11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
