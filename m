Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608E628E6BE
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 20:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389452AbgJNSxM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Oct 2020 14:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389365AbgJNSxM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Oct 2020 14:53:12 -0400
Subject: Re: [GIT PULL] ACPI updates for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602701591;
        bh=nErTft64H5nzbKtlIJLoG3X6uTJxyM20ulWm6vz5q4Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nm3uFStr9DDRDrHkwcdPTr1VWK5CWU4xZVyCUXEv4tki4bOm0CynR+yVZ4auNwZvU
         3SkMgHqImQqaDuZaH4/BoMEW03GIjazxgdKP6BYY/Ngql4u5qkge4s2W/oJYR4v8cS
         m1isMpz2IMgQMBEqo1DMvURS3jw7Rs46KA/hPW3s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
References: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j7XkDh9ddK0BtjWjHqC=xkcyiEEDzTJN=Lykje5-wf3w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.10-rc1
X-PR-Tracked-Commit-Id: 8be2362d10e8b0ea9844706d8c388480d37226d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf1d2b44f6c701ffff58606b5b8a8996190d6e7d
Message-Id: <160270159174.3085.10357270487041944176.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 18:53:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 19:33:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf1d2b44f6c701ffff58606b5b8a8996190d6e7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
