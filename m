Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44F63759D4
	for <lists+linux-acpi@lfdr.de>; Thu,  6 May 2021 19:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbhEFR61 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 May 2021 13:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236338AbhEFR61 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 May 2021 13:58:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A676E61107;
        Thu,  6 May 2021 17:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620323848;
        bh=IPvO7dCuUjYWMyqUlLSXScbwv5j5I53rPPMwvXJHZkw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=chqOxWl7Cl3sXXN3TayfyWRc5M4uuLFIbXEOHkmTLgDrWcz36R7r68uufXAxGdZTJ
         jm/HWuSSqQHoLvDk5EedZtT10sYCPkzCoitM+9l4ZyxIM37FdHFQMPHEtYe70fw5tj
         Q0bZLnHpm5xcPqT4RKTg1c8sy+H/dp8m+OG2UAorXLqgqC/qPabslim1eeItWrAj6g
         VfbhkTsF9FKW4HmmjkOqhgVb627jLaHRooYtnFdw+DPeCvSEzHsAEymeubhJRbw0Ou
         Q2GIG67PFjBmv2x+6qkjIQwCEMzy81mAfwXPDfB9kFhADqYdP9D5i3INpW4LyBywze
         QI41BSuU9WTfQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9F6B3609AC;
        Thu,  6 May 2021 17:57:28 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hLfXuUNRw2B48S7mQK5bnsZFFKQfqf5mCncMnak6uXYw@mail.gmail.com>
References: <CAJZ5v0hLfXuUNRw2B48S7mQK5bnsZFFKQfqf5mCncMnak6uXYw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hLfXuUNRw2B48S7mQK5bnsZFFKQfqf5mCncMnak6uXYw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.13-rc1-2
X-PR-Tracked-Commit-Id: 3da53c754502acf74d4d9ba8ac23fc356e6c3d0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 164e64adc246dd4239ab644dff86241d17cef218
Message-Id: <162032384864.1989.1740026520389167319.pr-tracker-bot@kernel.org>
Date:   Thu, 06 May 2021 17:57:28 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 6 May 2021 17:39:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.13-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/164e64adc246dd4239ab644dff86241d17cef218

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
