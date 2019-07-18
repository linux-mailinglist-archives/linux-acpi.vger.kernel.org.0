Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95CB76D25B
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2019 18:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfGRQuQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Jul 2019 12:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGRQuP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Jul 2019 12:50:15 -0400
Subject: Re: [GIT PULL] Additional ACPI updates for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563468615;
        bh=2+1BoB5bEtqzs/LpNmGvSdP1fR1U2GDDiFyBPfTbr+4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=F7w5ZD9X8PS23UwBgEuoj1Tmpi6r/V8NWbPdXJvikO4Z4SPugAgjpzqWBqEihqR5q
         hjbEJh4bTLvY+jDhrUI5CzRNTW/S3r9Ch+B/9IGITDznpdXJx8DksMoarEBUG2XuZH
         HM5lv//whjTHjiTEBMgI0d+s4/2wPYoUghQu/jUs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gMu2TUBVdoL2X5koz7giQYxjkaHv8SXKWToedYURHzuQ@mail.gmail.com>
References: <CAJZ5v0gMu2TUBVdoL2X5koz7giQYxjkaHv8SXKWToedYURHzuQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gMu2TUBVdoL2X5koz7giQYxjkaHv8SXKWToedYURHzuQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.3-rc1-3
X-PR-Tracked-Commit-Id: 2c66a5b52e9e328cd52af0d961f99a0e6717a065
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b09ddbcd107e280077bd3e918c8089dfa426980
Message-Id: <156346861505.19804.7366870145988564874.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Jul 2019 16:50:15 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 18 Jul 2019 11:05:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.3-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b09ddbcd107e280077bd3e918c8089dfa426980

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
