Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F10D325766
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Feb 2021 21:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhBYUPk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 15:15:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233603AbhBYUPi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Feb 2021 15:15:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7AAAC64F30;
        Thu, 25 Feb 2021 20:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614284097;
        bh=3lRXcC5Nb0jngwBIIayUtlICAegsbgfzWzybeKT67sI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hYKfdhxzKFw/O8M0J+8/Z4/g72xQ1V549Hqe1uvt/kTniG0B/58mxrNaouVdZc1/+
         p4/e/G2I4UZlQnuKdodFd024JHMEBSriOTtUyRPK3Y/3lcGzJ5UZiZTwiyg7zipKqI
         pULbjjnPNGUeOW73KnrHH11c+Onm3kEDejBaCfBuKH8btQcn7ImGWkJ9TpbnbdoZ9D
         gYbESXXeMVWb82HbFYuDZQtdnpzNXOhjKtUmAhTzvbhVR+i7G1JnU2frm9+/DKekDj
         Ux6ZNdSPttJodiIXfA4eYNn3o0j3veOD+DvLNQ8dcxHDXoIFjrC8MnmF83RxDaCavY
         2AM9epZF1PvMQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7215360A0E;
        Thu, 25 Feb 2021 20:14:57 +0000 (UTC)
Subject: Re: [GIT PULL] Additional ACPI updates for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gQ-T0_75Wx37=W4g7AKNR5C_wOKEu9VB2u-x2uTKxJGA@mail.gmail.com>
References: <CAJZ5v0gQ-T0_75Wx37=W4g7AKNR5C_wOKEu9VB2u-x2uTKxJGA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gQ-T0_75Wx37=W4g7AKNR5C_wOKEu9VB2u-x2uTKxJGA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc1-3
X-PR-Tracked-Commit-Id: b11ffaeacd1984b1fca41374c769fb0ff0aa0a42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 268f77b5250998b871fa54a2a9703871fb44544e
Message-Id: <161428409745.10391.9845610920246369379.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Feb 2021 20:14:57 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 25 Feb 2021 19:39:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.12-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/268f77b5250998b871fa54a2a9703871fb44544e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
