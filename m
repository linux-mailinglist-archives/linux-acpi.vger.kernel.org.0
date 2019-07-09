Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F55B63A7E
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2019 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfGISFb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Jul 2019 14:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfGISFN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:13 -0400
Subject: Re: [GIT PULL] Device properties framework updates for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695513;
        bh=+vNpwoN2lp1O2/h2yYLLFN2QzaPpKX+omBzKmNgf0iA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=enKy1BDyzsr2hs0CMgLRYjkwwSaTxw0joMc7r8v2+AXT0lu2u0EBEv15+r4vv1yak
         SQPNC9hmXR0M67h+IB6/JTtDTDRxXDsuY7ZOkdtj3TuU3MMfx+zUWHYzKdNkpTvVfg
         e9UfHgiIpUi2x5GEh90jqZOSsEezbknZbjbI/G9g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g8O+XLjSarCiZcj0LnSZYnCqGE3D6tfFD30wOZjprb2g@mail.gmail.com>
References: <CAJZ5v0g8O+XLjSarCiZcj0LnSZYnCqGE3D6tfFD30wOZjprb2g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g8O+XLjSarCiZcj0LnSZYnCqGE3D6tfFD30wOZjprb2g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 devprop-5.3-rc1
X-PR-Tracked-Commit-Id: 33ee09cd59ce154b64f9df942dfa5456db90d5f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0415052db4f92b7e272fc15802ad8b8be672deea
Message-Id: <156269551313.14383.5369373802013265503.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:13 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 23:39:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0415052db4f92b7e272fc15802ad8b8be672deea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
