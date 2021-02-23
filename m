Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEAE323459
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Feb 2021 00:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhBWXp3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Feb 2021 18:45:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232746AbhBWXg5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Feb 2021 18:36:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D8EFB64E83;
        Tue, 23 Feb 2021 23:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614123374;
        bh=KgDwU8KoKoMqfKg60BuP6wQZGI32Aq/RjRV55UMa3pQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mlp/JglFP+NSyyVcuyH2gR3dwcXAKPFMi6JYHHhD1uoILVH28ypsEOGvhZglWulMl
         QSLr0O8qQlhIYH1bm0RaWQKHEEZHxRex4P043f4gDn8ilRXzQOee7vimnpP14hDrts
         Kyfwp97hiCGavV5i3S66XlYcgZjA/X6n2ff1E1S2BZC4mkOK6bv0j5+kjQOUUp3jzh
         Q1fwL4+GtrCB3cuqRQzf5ojlfEfxl89gY5MWQiT85UcwGAbAKyq/GezRaEnGxZy74x
         cCHZcefJHqqo+xzjSDXgD8xvPqgi0XiX96oD9zbknjR+NTV+PRGnDV/8MmRl8BnmKj
         AOJjBeI/2DNoA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D49D460973;
        Tue, 23 Feb 2021 23:36:14 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g9-LpR2JM4VBotHQhCKj5jYPdW3g_eqh0pGMkRhoSUWA@mail.gmail.com>
References: <CAJZ5v0g9-LpR2JM4VBotHQhCKj5jYPdW3g_eqh0pGMkRhoSUWA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g9-LpR2JM4VBotHQhCKj5jYPdW3g_eqh0pGMkRhoSUWA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc1-2
X-PR-Tracked-Commit-Id: 833a18d0715d97db8fa5e8d7eb614fc143ac78e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 628af43984feeecfe086ae885ab407bd0e7c329e
Message-Id: <161412337486.20258.7308639294738566618.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 23:36:14 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 23 Feb 2021 21:07:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/628af43984feeecfe086ae885ab407bd0e7c329e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
