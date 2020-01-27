Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560DD14AB02
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2020 21:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgA0UKH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jan 2020 15:10:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgA0UKH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Jan 2020 15:10:07 -0500
Subject: Re: [GIT PULL] Device properties framework updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580155806;
        bh=BgZJcSPN/jIzKCCJrCntyF/GspTRMYdljBhfpKeEokU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ixyKjI5T5ssovOHPem0O8yrUV2iwUsQ3KykEUfnYfslrgWu361K6QcWd1kiatE/QM
         DZM5hrTGcpybdUAP2NnPHdCEjolTscb4hoNZdkwf4lstPV8tuEN4poXzl1MLBnzRqV
         yhYMkAAyMY0kCB746oc+oueQ7QW1mjENbARgb2b0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jcOmamFM6AU4eDJx_ULZfV63P_+o5BoxOmyDHuFKRHOA@mail.gmail.com>
References: <CAJZ5v0jcOmamFM6AU4eDJx_ULZfV63P_+o5BoxOmyDHuFKRHOA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jcOmamFM6AU4eDJx_ULZfV63P_+o5BoxOmyDHuFKRHOA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 devprop-5.6-rc1
X-PR-Tracked-Commit-Id: aa811e3cececac2f65f7fa7e17ab46c73d778b2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85c009e8e5d2794e2efb1019e3648f3d8126f1b5
Message-Id: <158015580658.19143.16491557573063615147.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 20:10:06 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 17:34:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85c009e8e5d2794e2efb1019e3648f3d8126f1b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
