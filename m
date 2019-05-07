Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE05157CF
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2019 04:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfEGCzE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 May 2019 22:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfEGCzE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 May 2019 22:55:04 -0400
Subject: Re: [GIT PULL] Device properties framework updates for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557197703;
        bh=DKq5ld8azkwCO4PVenfxhI9f/eRPDSvFeZ3ODzcoU4g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lGD2RluWtlpueokiZtnLhVMQpAP0KtcxIDfVxav+r+BBHkiGgbyBD2/w4j3GuFgZi
         G/Upw42wAybw3U7raQIvFvZfQmWh15Ze12TRBx1qfmLlaUf0sa8FdIyAIQt8ceXChJ
         SmjwklcQ7y8M6gMSMC7RmTVUY3kTGdDLNVEZZp1I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jx12=bmcDaVkgd1=mocwPQ2MwMNHOE6KiTSyS+CdhRyQ@mail.gmail.com>
References: <CAJZ5v0jx12=bmcDaVkgd1=mocwPQ2MwMNHOE6KiTSyS+CdhRyQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jx12=bmcDaVkgd1=mocwPQ2MwMNHOE6KiTSyS+CdhRyQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 devprop-5.2-rc1
X-PR-Tracked-Commit-Id: 23583f7795025e3c783b680d906509366b0906ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4dd2ab9a0f84a446c65ff33c95339f1cd0e21a4b
Message-Id: <155719770389.24898.16425239395427218692.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 02:55:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 13:16:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4dd2ab9a0f84a446c65ff33c95339f1cd0e21a4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
