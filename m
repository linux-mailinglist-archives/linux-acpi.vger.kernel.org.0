Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30113AD2D8
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 21:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhFRTcq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 15:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233757AbhFRTce (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Jun 2021 15:32:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 86DA66127C;
        Fri, 18 Jun 2021 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624044624;
        bh=aJ23b/50p4hPQ4zpsikYoPqv4wYUC68yYO9D4kgkPpo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NPc7DQlVhW+le55XutfCOh0zXPVOcg7UUDRajYpk6t3Q8xKzAro4J164LMy0BiW4S
         3poh4fn1t+murbcU6uqKQju7TMpiAZAeY5QGzZ6jLIKGX1Xb/y+sFmar0byN1VPirH
         UB5mbeu7c8nZphD5a3URL8zjdlTdC7NyzfBcIHTTtf8hUZE6pRJgU5AaK/poiGaYUT
         hNBHd1EOfpV7F8qB6DYOnndC/NjflGtla7XG+I2T405NGKkwlUgYIaN3Qu2cxKqVAE
         4KSNl+PSKMox7uzCxNAeL8jU4fxfdDTHD/X/2OCcy8CJJfCtbsjyn0wZSFXIWThizT
         ZQ6TU66dn9SGA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 809A0609D8;
        Fri, 18 Jun 2021 19:30:24 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v5.13-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iUeL_A4iVO4SizSMtuAMnQ6YUT08nWPXidr8q_wajT2g@mail.gmail.com>
References: <CAJZ5v0iUeL_A4iVO4SizSMtuAMnQ6YUT08nWPXidr8q_wajT2g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iUeL_A4iVO4SizSMtuAMnQ6YUT08nWPXidr8q_wajT2g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.13-rc7
X-PR-Tracked-Commit-Id: 771fac5e26c17845de8c679e6a947a4371e86ffc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 944293bcee92acb1cfbbd315f833b4384bfd35fa
Message-Id: <162404462452.17995.6904418745432691307.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jun 2021 19:30:24 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 18 Jun 2021 18:49:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.13-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/944293bcee92acb1cfbbd315f833b4384bfd35fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
