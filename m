Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E35820AC1
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2019 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfEPPKU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 May 2019 11:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfEPPKQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 May 2019 11:10:16 -0400
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558019415;
        bh=mUyc2xuEAed3mqC/ucfURS9n6vSCDevchf0xwuprgJY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NAEsEg81ofSviZZ7rqrBV0s5+zoHV2HvDsZQ335DSfniwDm0VXHZSC3S+l1DnVqmI
         qZ1/WALenK1o/ZhwwRQ36x6w23yP2l5X5sO8vtTbwaTDI1JVDgmHNJL1kEPSr0iStB
         4l3Ftm1DrVNtquDf1vqQRxzT2uNdEwa7teJIQ9rI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516044313.GA17751@localhost.localdomain>
References: <20190516044313.GA17751@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516044313.GA17751@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
 linus
X-PR-Tracked-Commit-Id: 37bcec5d9f71bd13142a97d2196b293c9ac23823
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a455eda33faafcaac1effb31d682765b14ef868c
Message-Id: <155801941590.14983.9829892889813749060.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 15:10:15 +0000
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

The pull request you sent on Wed, 15 May 2019 21:43:14 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a455eda33faafcaac1effb31d682765b14ef868c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
