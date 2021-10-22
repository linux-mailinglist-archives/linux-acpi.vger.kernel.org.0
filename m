Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13671437F13
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 22:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhJVUFk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 16:05:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234303AbhJVUFj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Oct 2021 16:05:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8925F60FC3;
        Fri, 22 Oct 2021 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634933001;
        bh=jUYyBry42ZWpV9aOKHVYs+hrOFJlq6ogBcgxp7SWFks=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bX13YtikfQB0zf2pW1Ert7CsAkiNUTk1RmzCU065vviro2YDkO3RQQMjrvLj8jACY
         DpFZbdl4atilG/HErrGF11Vs4LNu9cO69tpIc4o5SWS8TU023a/nig392S8zIVN7jd
         OqR+E68fEz18ayRFfkS1h5nBhaq8iDMjtWlmqF1IiAjAC/WckC+XgXRDl7bA+k5z6c
         /Z3+lRhb0NXSkCpo9GBn7djt+vijLmNzxp6jIIWSXd7a1RnQot3hJADfr/pjRmi4Vc
         eAktvbjVVLK5vZ4smT5sgVE6g2L40auQ82E5bhPBoymfRrXD4BmvLiuaGLgsf5c8dg
         poqyMus2TBIDg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7B72860A47;
        Fri, 22 Oct 2021 20:03:21 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.15-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hTtyu981j91vxH_u3bvHWWBho4YSAhd+os9Zn=sbwe2Q@mail.gmail.com>
References: <CAJZ5v0hTtyu981j91vxH_u3bvHWWBho4YSAhd+os9Zn=sbwe2Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hTtyu981j91vxH_u3bvHWWBho4YSAhd+os9Zn=sbwe2Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc7
X-PR-Tracked-Commit-Id: 7a7489005a80af97ba289dc0579fccd50af4fe8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d4590f5069bff7d41d7ed1a7e7674fb9d6d502a
Message-Id: <163493300149.2975.8979345114869611132.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Oct 2021 20:03:21 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 22 Oct 2021 21:01:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.15-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d4590f5069bff7d41d7ed1a7e7674fb9d6d502a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
