Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9951076B1
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 18:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfKVRpH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 12:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbfKVRpF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 12:45:05 -0500
Subject: Re: [GIT PULL] Power management regression fix for final v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574444704;
        bh=9x1hxC3qi2eaamCM/dHXu4NQ/2NJTHkhMoy7sos1LU4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xXCqc8aTzWlubuKtIXno+XuTfuYOUnSDjtbAI1fzL35Gll9+Smc2G7gRtqs+WLsD+
         Cw8GDPgeXl/SQhqO1O5HCDMLAskSyq9PAX1QnAR/aPunrUcmxsV+cLxGzrlD6kDpsU
         lNdulm9MVEOnZNPFHKdyTpZmPVDH3cvwL+3r+bLo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ioXnbzy86fV7=JfZwjawfN45xXs8-b2xMtnTEy8ACsuw@mail.gmail.com>
References: <CAJZ5v0ioXnbzy86fV7=JfZwjawfN45xXs8-b2xMtnTEy8ACsuw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ioXnbzy86fV7=JfZwjawfN45xXs8-b2xMtnTEy8ACsuw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 pm-5.4-final
X-PR-Tracked-Commit-Id: 05ff1ba412fd6bd48d56dd4c0baff626533728cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6b0373ffcd8950b9121195e09c5d7c73e6e9f5d
Message-Id: <157444470467.7762.11731245732169668008.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Nov 2019 17:45:04 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 13:40:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.4-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6b0373ffcd8950b9121195e09c5d7c73e6e9f5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
