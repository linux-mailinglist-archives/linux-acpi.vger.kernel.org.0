Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B2B1F5DD1
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jun 2020 23:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgFJVpi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jun 2020 17:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgFJVp1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Jun 2020 17:45:27 -0400
Subject: Re: [GIT PULL] More ACPI updates for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591825526;
        bh=MIvGt5/yZO/DyrUvl8pDAZtf5AK4VvEdsJp5CQrG1tI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EeQYQCrT3R1ceVZTypezXO9pSpJIaH8j90sAPrrTR8PvYjuvQM7UE47w+fFMZEzgH
         GOHvNpQtd7wTQJ3zMm+EHkRxuNj2ITgqz0uz5N/QxHspbvCqkSMPlPvHmOE3vxyYCX
         necRT+Ww20aSpDi2xWq7gRvdekzpWIAtYnW09Y2M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iWARxun+oYiu5qx1p7E3=U-GJMEF3hHwYxagkSn_BRFA@mail.gmail.com>
References: <CAJZ5v0iWARxun+oYiu5qx1p7E3=U-GJMEF3hHwYxagkSn_BRFA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iWARxun+oYiu5qx1p7E3=U-GJMEF3hHwYxagkSn_BRFA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.8-rc1-2
X-PR-Tracked-Commit-Id: ede439be684c54f01147e1f65cc565c6baaca1a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6672966d6c854d5b05a10227fd21e4e0895719f7
Message-Id: <159182552679.4867.7886774079355195120.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Jun 2020 21:45:26 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Wed, 10 Jun 2020 17:52:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.8-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6672966d6c854d5b05a10227fd21e4e0895719f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
