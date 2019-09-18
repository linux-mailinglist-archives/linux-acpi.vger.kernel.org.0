Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2385B59E2
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2019 04:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfIRCzW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Sep 2019 22:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfIRCzW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Sep 2019 22:55:22 -0400
Subject: Re: [GIT PULL] Device properties framework updates for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568775322;
        bh=lxbgVaOJpewzTG2sPzGQSo2Vm/Mu739o3WiRamk2OYQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LIaLn/a7DaKS76wGZj9fUDUaifrUQoRCq9fpmukA8NQVMgp9DWb1GLPA3XNtCWkkP
         x2gnsCEhYRL/bx+jr1218dT9s7SsLrRwJ40J2oV+UMYg+3gCkmQ0vhMMOocfbUrnbc
         kuNKRrN8Z/IzRvFxIuHukUDLuWoRKA8kmvCvU2Qk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iJupxXBYRDeV4_V14je-uZYRf7d_CZ7WRUw7++n_575Q@mail.gmail.com>
References: <CAJZ5v0iJupxXBYRDeV4_V14je-uZYRf7d_CZ7WRUw7++n_575Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iJupxXBYRDeV4_V14je-uZYRf7d_CZ7WRUw7++n_575Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 devprop-5.4-rc1
X-PR-Tracked-Commit-Id: 016049a816774edc9c3cd81afa7724d7ab001585
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35f7a95266153b1cf0caca3aa9661cb721864527
Message-Id: <156877532218.3897.1303101166211641144.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 02:55:22 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 12:27:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35f7a95266153b1cf0caca3aa9661cb721864527

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
