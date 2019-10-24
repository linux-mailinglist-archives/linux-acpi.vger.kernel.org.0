Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7017E3C92
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 21:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfJXTzJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 15:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408339AbfJXTzG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Oct 2019 15:55:06 -0400
Subject: Re: [GIT PULL] ACPI fix for v5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571946906;
        bh=bGSRfctfbi92+SwkyHPK0TBBVoU6JbkPgITd8TyIpkM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LNOkcxWz8L+8sBvfzjry2l3PII+39MdouvMU1u9//5mk03NQABNRHhjv2JGhxYxSc
         5tdIWpWyOXI6Y0MkxTfW0SHntb4p+oK5juAiTWbv0ENZKqP9okzj/ZSx66Vy7cVKzk
         WCtrdw6AKRkVwAUedqqTO1Kz22dc0ZMSHwUtWcgg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j98Lhfs1cW88vuEHZcjjQpCPCBS9B8yBvW1wWfWLSFYQ@mail.gmail.com>
References: <CAJZ5v0j98Lhfs1cW88vuEHZcjjQpCPCBS9B8yBvW1wWfWLSFYQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j98Lhfs1cW88vuEHZcjjQpCPCBS9B8yBvW1wWfWLSFYQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.4-rc5
X-PR-Tracked-Commit-Id: edffc70f505abdab885f4b4212438b4298dec78f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f65d3541676a9f0e27f6545c6f53367fd248f7b
Message-Id: <157194690632.28436.6944497118215055740.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Oct 2019 19:55:06 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 24 Oct 2019 19:30:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f65d3541676a9f0e27f6545c6f53367fd248f7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
