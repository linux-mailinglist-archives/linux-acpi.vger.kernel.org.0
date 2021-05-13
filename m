Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF5137FE4C
	for <lists+linux-acpi@lfdr.de>; Thu, 13 May 2021 21:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhEMTiw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 May 2021 15:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231552AbhEMTiw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 May 2021 15:38:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 002EA613CA;
        Thu, 13 May 2021 19:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620934662;
        bh=urIVaBvOXkySRDTdohK3qtGKMbms1z5ZUJSOKCsLh1Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kd6N7O8AdNx+zDwJFoansVxD4EkyPsDTP23HTqAYRsgD8NIuZL0rSLRuVyDts4LH1
         go2hj2pZBNE0VKNjg7yUshZPcPtoZ3svis7Omc9wQQU7T9A5aNhQM/fdjTnBn1zfpp
         haSg/wb7US+K75iHUHCZ2N0RfO2CbMy34iYfefxHAXxHVl9VnpgXfSHuqEV5vUUWZ/
         0xcvnw5ctK7bKy+Xdw0F902jv8d5bnltZwEzolWgXz0r7g5rPuN5YkjCgzTiBhKESZ
         jf8RAYypSuJAJHt0EOJvK76IKlPsoMWvpeTDZ2FIHV13HHMIPMGYH1LgK415KyEngi
         Jtp7+4M1dBWnQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E424060076;
        Thu, 13 May 2021 19:37:41 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0in2AeuGt-YRjKE5r4AKhu1kTf=zRfFWfb+cPFZL-NESA@mail.gmail.com>
References: <CAJZ5v0in2AeuGt-YRjKE5r4AKhu1kTf=zRfFWfb+cPFZL-NESA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0in2AeuGt-YRjKE5r4AKhu1kTf=zRfFWfb+cPFZL-NESA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.13-rc2
X-PR-Tracked-Commit-Id: fd38651716b45f817a542c34cd5336ff372d06e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2df38a8e9b838c94e08f90f0487a90cea4f92c25
Message-Id: <162093466187.18883.16680420030744725732.pr-tracker-bot@kernel.org>
Date:   Thu, 13 May 2021 19:37:41 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 13 May 2021 21:05:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2df38a8e9b838c94e08f90f0487a90cea4f92c25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
