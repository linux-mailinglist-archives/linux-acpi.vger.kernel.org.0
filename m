Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B45F3BF0D9
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jul 2021 22:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhGGUmx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Jul 2021 16:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232885AbhGGUmv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Jul 2021 16:42:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2259561CBB;
        Wed,  7 Jul 2021 20:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625690411;
        bh=cDseF4YXCkwjczXgjXIlW51CtQ/u/9FnYUOJSKGb79M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=feUfPEXy92P9VTQIYHgacVTA9Lgt0O8aHJEIH57rUMyrCwPUARhZa+H71EHhJ3KVp
         6HopEGAMFCiRUfTHi3bNjcVkf03NyyjVfTWBI4dPVSoIZluNlPXZpst07FhfTKpj2r
         gC4rOOMMCDI6IViGAj1FxF4oGgjReMhvGhUhHzApVtIGWtQZn7X1zRFsOtjU+NSxBS
         AAX4LAhbuAQIoRXbgSKKy7Nr1t7kiIJO43XJVs7iZ8JR8/32W5mSi+1XqRmAn7WLZK
         c/6WKCSWWwk0TqsRYuwYMWoPQtnvdRrtQOPv72Dv5wUwp5T37eFzca1+THDUHc9+dL
         xgInIiyVa02tQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 19D0F609BA;
        Wed,  7 Jul 2021 20:40:11 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ijscuK9x8CbGR1ak2Gdox6J1fzyFrTgYoS-AGca=peuQ@mail.gmail.com>
References: <CAJZ5v0ijscuK9x8CbGR1ak2Gdox6J1fzyFrTgYoS-AGca=peuQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ijscuK9x8CbGR1ak2Gdox6J1fzyFrTgYoS-AGca=peuQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc1-2
X-PR-Tracked-Commit-Id: 166fdb4dd05f2e9f3b3d347682ab6d1b679b362d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9f1cbc0c4114880090c7a578117d3b9cf184ad4
Message-Id: <162569041109.28701.15764493282537292655.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Jul 2021 20:40:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Wed, 7 Jul 2021 21:15:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9f1cbc0c4114880090c7a578117d3b9cf184ad4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
