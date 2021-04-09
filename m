Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343D635A77E
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Apr 2021 21:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhDIT7o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Apr 2021 15:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234449AbhDIT7n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Apr 2021 15:59:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 287CC61041;
        Fri,  9 Apr 2021 19:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617998370;
        bh=npXF1Qaz0j0RJC2c9EBMUOTu6euRpJjriL/xwCaLRLg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Si8cHjtL78lTrc62v1AUE+MssYBH0kLn2zmNL5PfcOkxehxPQqPv7h40HpWjAPB01
         +3XWZ4f4Qb9L91e5pfdZz1YDxeHzHqYFbBeCyQ/GpoD6IDJ9ER6wrHtpZ6W8avufok
         WxiSK1dDPtUMO5m+QM2pC3Ob3+4CO4dcb9XKSAeQasJeagKXzlxK4ocR1uBMJ0AM+E
         552WAPPf65Ml7OV5lI028g8v7lN3ilFOSHJaqTaVzrqujgi02I8H8UKnXSpfndGzBY
         QHv2Nl5uoMAnfC+LZJFjeH73/X7jljQo+iAnZC8y990jbCzwj09Tak6T8XTlao7n8I
         kmB2c5exQVxVA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 219A760A2A;
        Fri,  9 Apr 2021 19:59:30 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ii5+k8j-9LwGxjHnJZ5ru3UNSLP=Z_BoE4pOWZN0nTyQ@mail.gmail.com>
References: <CAJZ5v0ii5+k8j-9LwGxjHnJZ5ru3UNSLP=Z_BoE4pOWZN0nTyQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ii5+k8j-9LwGxjHnJZ5ru3UNSLP=Z_BoE4pOWZN0nTyQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc7
X-PR-Tracked-Commit-Id: fa26d0c778b432d3d9814ea82552e813b33eeb5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccd6c35c72c771616c37d1978e02a982da0678ef
Message-Id: <161799837013.7895.1785409507519991680.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Apr 2021 19:59:30 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 9 Apr 2021 17:44:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccd6c35c72c771616c37d1978e02a982da0678ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
