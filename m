Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11BDF753DD
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jul 2019 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389736AbfGYQZZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 12:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387917AbfGYQZU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Jul 2019 12:25:20 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564071919;
        bh=cfY8bCJ/OuwGmvvnpu0ntokwPjSgMK2lslzCSKYKiTY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xa/EoouE/KUDscXwTHDOIuzC0UDnazY10rQoUtRyrBS35fCsFyAJfJM2JgL312NoK
         DJuHdevSlM2SCaNN4KUMN0ojogopLZ7u7m3FRJwUMVK0e3AdoXjD/WMhov/Cj/IvNo
         bbWOIR9h1GHDXIp8fJyGt+dhrnX3ZBLIhmend0Lc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h5ZR9EhER_J1Qn9PJL-OAWbFvUb1rjTJkBg22p+Db6Kg@mail.gmail.com>
References: <CAJZ5v0h5ZR9EhER_J1Qn9PJL-OAWbFvUb1rjTJkBg22p+Db6Kg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h5ZR9EhER_J1Qn9PJL-OAWbFvUb1rjTJkBg22p+Db6Kg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.3-rc2
X-PR-Tracked-Commit-Id: fdc75701578269f6931975aebf4069d9d8c77d34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6789f873ed373319cbf83b56455baf00769bb79a
Message-Id: <156407191963.26857.17535064372378613610.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Jul 2019 16:25:19 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 25 Jul 2019 11:26:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6789f873ed373319cbf83b56455baf00769bb79a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
