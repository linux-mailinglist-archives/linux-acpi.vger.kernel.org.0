Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339E13BF0D4
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jul 2021 22:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhGGUmu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Jul 2021 16:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232684AbhGGUmt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Jul 2021 16:42:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AE3B161CC3;
        Wed,  7 Jul 2021 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625690408;
        bh=CGgqv3EPzaHwgQLMZMVOaCsqU9dDrg9p7K0J69o02Cc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K+8DmV6fCo9HMU8TeGCT3jv4nqCYNAS2bomWgHV8x/6s3vlV/kh0wNTs2Es7lxhiO
         L1R86Cy4IEFCrGLX5XjSBJTUZxR4IqsiGqZdfh+ub2zkVuquPSI5Q1ynrbFCUpU70G
         H9QLjP3ETq3GSEM/EaC9BsLJeNIH0RXoXXIida6PTslTcBU+p9JWItf1JSLAUAfHrU
         LDoMNoOj+zCzFaBysAI9/Yu8OAs5oD+8rZdI7nqszAeIKXKocj0afnL+pGfbCBFpmQ
         ZmhsKbugtuzBdHQgqckGMzQ65Fpqx9AoRhdK++aAFaH3xgDVCRGP3SW5ESfWNadtaZ
         xqbq7JxV5/Cnw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A3311609B4;
        Wed,  7 Jul 2021 20:40:08 +0000 (UTC)
Subject: Re: [GIT PULL] More power management updates for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gQhJHNn99sEpen_CK3+7vkn=t-56bG574k_TyTPGy96Q@mail.gmail.com>
References: <CAJZ5v0gQhJHNn99sEpen_CK3+7vkn=t-56bG574k_TyTPGy96Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gQhJHNn99sEpen_CK3+7vkn=t-56bG574k_TyTPGy96Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.14-rc1-2
X-PR-Tracked-Commit-Id: 843372db2e3bf9694e98a1ff9d0da6dc3d53aab8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aef4226f914016cc00affa8476ba5164dcca56fd
Message-Id: <162569040866.28701.241337221814920850.pr-tracker-bot@kernel.org>
Date:   Wed, 07 Jul 2021 20:40:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Wed, 7 Jul 2021 21:13:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.14-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aef4226f914016cc00affa8476ba5164dcca56fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
