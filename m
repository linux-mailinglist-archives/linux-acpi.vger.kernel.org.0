Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D53C463A81
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2019 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfGISFi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Jul 2019 14:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbfGISFN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:13 -0400
Subject: Re: [GIT PULL] ACPI updates for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695512;
        bh=89lQlfOfSd3HSJAw8s/M4n82ej115At7eabudrrX/cE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wijv4JYUF3eh8VwIAKvzDKb9vtHV9wa+6DFo8sbzJP5+E+JQM82nZZdCsqthIjsHX
         ex9L1l9BL9/L1YI6zZdhTqqQ5FT13tlLHPNV0up7vNpeVfBF5OiBKidSBWVS81sWDv
         nO6WrxOSio5uSWSLv8rmrb6Css6lHWNHFXNFXijE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gSbQy-GFz2Bo4bGGj7WemDvS21TW6=VHVvivDZCvEKWg@mail.gmail.com>
References: <CAJZ5v0gSbQy-GFz2Bo4bGGj7WemDvS21TW6=VHVvivDZCvEKWg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gSbQy-GFz2Bo4bGGj7WemDvS21TW6=VHVvivDZCvEKWg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.3-rc1
X-PR-Tracked-Commit-Id: 64372c0b7dcbc9ad08b1bad877ae8d8cddb62e45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b4704520d97b74e045154fc3b844b73ae4e7ebd
Message-Id: <156269551253.14383.2107920086231798542.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:12 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 23:37:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b4704520d97b74e045154fc3b844b73ae4e7ebd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
