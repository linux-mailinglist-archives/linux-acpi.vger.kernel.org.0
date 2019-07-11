Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9499565F84
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Jul 2019 20:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfGKSfU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Jul 2019 14:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729071AbfGKSfJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 Jul 2019 14:35:09 -0400
Subject: Re: [GIT PULL] ACPI fix for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562870108;
        bh=uLI8XsUrsMivjpRt4GLRCsqFss+e5wuvCE81sVyzSXQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pjWk15XfEhaAZYrI0Le8Nv+09mX0zlWVsLN/FsmHAIBfxYmFkI5PPJ9VDvgjYor7C
         d6+Gq+q0dCh9rtU8NrRx80tKrFT/cMBoUxIh0InrrKLiuh4jh/ePFkW6k1xjLLrVze
         01sNQqPWhjy2VIpjP3iiJHwjFnMtRt/rBGliXWDw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jTMK6rMomux6JfmRX_nRxZ+JqA_V8WKt-UJTGus6TfOQ@mail.gmail.com>
References: <CAJZ5v0jTMK6rMomux6JfmRX_nRxZ+JqA_V8WKt-UJTGus6TfOQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jTMK6rMomux6JfmRX_nRxZ+JqA_V8WKt-UJTGus6TfOQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.3-rc1-2
X-PR-Tracked-Commit-Id: 6cf7fb5a95dec9743f4bfd96f9ece580a355cdd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a131c2bf165684315f606fdd88cf80be22ba32f3
Message-Id: <156287010892.13847.8485955181846012272.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 18:35:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 14:40:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.3-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a131c2bf165684315f606fdd88cf80be22ba32f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
