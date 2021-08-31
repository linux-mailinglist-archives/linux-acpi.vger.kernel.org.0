Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441913FCEAE
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Aug 2021 22:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbhHaUkd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 31 Aug 2021 16:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240795AbhHaUkc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 31 Aug 2021 16:40:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E158961090;
        Tue, 31 Aug 2021 20:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630442376;
        bh=UQWcgsXKyZ//pOEHqmQt/ikMfZ9SrwESxUXttCme1I4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CpMUu3sTFDGLNATsok697mmF4Ny/2EW45wz4werRpxUDHzSrQ48G4oRzCXQ8K0J42
         gMJ7Y8J+m/ABLvPEbQrRB3x+G9IG6GdGNJwe7dTPmumbEnFbRk0cp/OHvcWMMtmhMt
         34EPQNyB5wH6hGtXChOeWlvO2YS/7izNRHUlx9dsykh7lZf76h1kuSbKkhJQm3PcZB
         WvV2JDD/J0wgpcO3nR3ZME693VOyUXT5pbSLoXYLUuoYJRuD3MskExkQ7Q3fARoPvR
         O5luciKEJeoYAX67puppJWADaAey0NTdgpRt1Lxnd+DbGjhr42d8+hi3XTQ1Malw0D
         HwV2PZHMPT1kg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D832A6097A;
        Tue, 31 Aug 2021 20:39:36 +0000 (UTC)
Subject: Re: [GIT PULL] Device properties framework updates for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0icj4uaJ7NuH+V-JQ_5h238juqPsx173Xcs2dMaRK9nvA@mail.gmail.com>
References: <CAJZ5v0icj4uaJ7NuH+V-JQ_5h238juqPsx173Xcs2dMaRK9nvA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0icj4uaJ7NuH+V-JQ_5h238juqPsx173Xcs2dMaRK9nvA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.15-rc1
X-PR-Tracked-Commit-Id: a90887705668fc5587bf5092c38f353ad36c69fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e235ff9a1e3dc3d800224ab97bcd2418d3b19c3
Message-Id: <163044237687.32655.919131295487319991.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 20:39:36 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 20:45:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e235ff9a1e3dc3d800224ab97bcd2418d3b19c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
