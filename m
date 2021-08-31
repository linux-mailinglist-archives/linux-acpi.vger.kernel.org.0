Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C593FCEA9
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Aug 2021 22:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbhHaUkc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Aug 2021 16:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232803AbhHaUkc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 31 Aug 2021 16:40:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B25DC61074;
        Tue, 31 Aug 2021 20:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630442376;
        bh=zbtDN9VrboUSGhLzSw8oNqaQBt2etOLD1hX4mU+A0qc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZB/wqtlVY1aI3nFCvWYrO68HkqVxjavXJusVRDe0i+lfr/hGbm48Do1iHtQnKMKsg
         agkPaeNKIiQ9f/a3d3/RI78MxANTGCgReYtUEyb9ju/bX5fhbO/uBi3hOiZQ5Jrpwu
         De/zr0RPlRyFtRzZ0KnapdKAAMMvFKOxpmHnOnIPVO4hRBEZpnMPSMLAzG1Spx5EvR
         cqj6I4YAHnaM0Q1XinVEnC+vfpyOiAWuFtgLm8690frldl6Qv9o+vpnDhfIZwrQeLW
         HMkkmDOSX1823RMDYpqy0le13uQu7YmZIoolGj4J/MGoOAT986yQzByw0mL21SjkHP
         cjkgrDNRQTYGw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AC8756097A;
        Tue, 31 Aug 2021 20:39:36 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hydPvLrqEuHhxAOp3fUVqA6hiKGbGXgch5xADfQiM-Tg@mail.gmail.com>
References: <CAJZ5v0hydPvLrqEuHhxAOp3fUVqA6hiKGbGXgch5xADfQiM-Tg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hydPvLrqEuHhxAOp3fUVqA6hiKGbGXgch5xADfQiM-Tg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc1
X-PR-Tracked-Commit-Id: 2cbd40709a9d44b8b0d418589de12efad6f71c15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f1e8b12eec44ee047dc9e0a9544b2cfed739503
Message-Id: <163044237669.32655.545157047500017157.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 20:39:36 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 20:44:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f1e8b12eec44ee047dc9e0a9544b2cfed739503

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
