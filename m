Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA79932476
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Jun 2019 19:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfFBRZO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jun 2019 13:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfFBRZO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 2 Jun 2019 13:25:14 -0400
Subject: Re: [GIT PULL] Thermal-SoC management fixes for v5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559496313;
        bh=bQHJLHPNT5pP74l9jEgP5wetQf4mrRfdkVTymsb0zEE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ql7ARcVedNMlFAl8nhgH8gEaomIeyax4o61Q3VYf9n7MhLdNc54m/4oj2OtCMqJKD
         tMYwZF+g3nCJY8RfdHigq8Jvwf0ik9/nVkvF4ZsPPuUEWiovo3hWEHFWJPpRCQghXx
         IFRh4cewg5szFcrayX3PCk1S2HKE7WomyIEaPeGE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190601232205.GA7411@localhost.localdomain>
References: <20190601232205.GA7411@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190601232205.GA7411@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
 fixes
X-PR-Tracked-Commit-Id: ca657468a0d4bcc25445f6636485a19a525267bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 378e853f68e9a9548c64687880715ac3cca31c22
Message-Id: <155949631348.24242.8443286616973099270.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jun 2019 17:25:13 +0000
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Sat, 1 Jun 2019 16:22:06 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/378e853f68e9a9548c64687880715ac3cca31c22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
