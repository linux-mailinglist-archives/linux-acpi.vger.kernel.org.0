Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6737F3F3589
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Aug 2021 22:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbhHTUsu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Aug 2021 16:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240403AbhHTUst (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Aug 2021 16:48:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 49A036115C;
        Fri, 20 Aug 2021 20:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629492491;
        bh=DWxz+E9y8QfqSwer/XDINgmlgbDQqH6OFTpIa3LlqdE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XHyKusFrCU2tweQhUw7HXSYHeEpCpuYN43xQloQKRHJ4Q3CJNBYvxu765OEsN33Tt
         e9hWyC4BLkb5EeHh+hgGZQU9gaUDzlyDPNfOBi/aTrQ5ZGBJ/AvocLXhJQ8UKf9sdI
         XEKP9HODrckdlTOK1D2gYevnpkAbqT7ifWpB0fpyqvSLYaAD6PqCCYTkxnganxZ3oS
         rPEpwAEZGPH46IiOiI0PE29oBQFXZH2/A20ZzMaGeBHrnyjfUwZ8ZwH5XAkVX1Y9s0
         occoICyBYWW8mn3Iem8uu1kxX5FNHh0r612bihPpCEKFBfUfKpjghDinpbfDhCHfEs
         jAuQXVA/0ol2Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3CEE760A21;
        Fri, 20 Aug 2021 20:48:11 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g14eg5PT5+AnKh_Uf+a7Ap5t5+G_LcU8+A-tQS3UY15g@mail.gmail.com>
References: <CAJZ5v0g14eg5PT5+AnKh_Uf+a7Ap5t5+G_LcU8+A-tQS3UY15g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g14eg5PT5+AnKh_Uf+a7Ap5t5+G_LcU8+A-tQS3UY15g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc7
X-PR-Tracked-Commit-Id: 0f09f4c48118ce3c562e1028df7fe0f8150493d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa54d366a6e4fe3e16322abdb8b5115f8be0da8b
Message-Id: <162949249124.8168.17683135104906314521.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Aug 2021 20:48:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 20 Aug 2021 21:36:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa54d366a6e4fe3e16322abdb8b5115f8be0da8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
