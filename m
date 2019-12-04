Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2DF81135A0
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2019 20:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfLDTZX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Dec 2019 14:25:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfLDTZW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 4 Dec 2019 14:25:22 -0500
Subject: Re: [GIT PULL] More power management updates for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575487521;
        bh=XZtADZnpinuWWFZh/QBaWQe7L4kh/5dQn9wCR9gX+6E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pqr0OuwdqVWdo2KUEx75MCBMAPsFb7/Sf9EFZVfwIkxfT0NesxvooZURSyptuLw1Z
         w0w5lnjZ+zDNCXWO5rSVwo2BKjZrlYE0+VEIHhKOT86GLgTpZ6Jh9SveXl+1CIp135
         E555alLpM33gl1fAhfBOC4498iZPRfwCx4uQuA4o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iWz6HG4C19U2Pax8KpyGm=AvwDbU__w=Yt7ij1JqQZFg@mail.gmail.com>
References: <CAJZ5v0iWz6HG4C19U2Pax8KpyGm=AvwDbU__w=Yt7ij1JqQZFg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iWz6HG4C19U2Pax8KpyGm=AvwDbU__w=Yt7ij1JqQZFg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 pm-5.5-rc1-2
X-PR-Tracked-Commit-Id: 1e4230f56dac141eb149ebec01f41b6fad27e503
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef867c12f31dec4a03be5678d70893f97dc76ea7
Message-Id: <157548752154.30814.1151121865881033072.pr-tracker-bot@kernel.org>
Date:   Wed, 04 Dec 2019 19:25:21 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Wed, 4 Dec 2019 11:34:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef867c12f31dec4a03be5678d70893f97dc76ea7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
