Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39E4914AB06
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2020 21:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgA0UKG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jan 2020 15:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgA0UKF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Jan 2020 15:10:05 -0500
Subject: Re: [GIT PULL] ACPI updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580155804;
        bh=jsOvmDuRfd1VIQkjHzP4ZikgDWrUFXtHUjnOciPSgH0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pwIsA3O1NkNLX5WT+roETzjx8rtXXMhHKU3nfPiEgM/O+/CMeAQxzjqP9Cv9WfvKz
         MjHfMvgCsRqCq5Cpkn4AJNAUsKrDJYtCwxLDTndleYdMEZpPETVJJEmKWIxalnXk1y
         CXhYY7WHUt7IaSioovL81npes+eadjGAK9ZnuDhk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iRaeR4n=ddVM9pJj0oxRpv1K2UWXqZbwiNmkrOPr3h1w@mail.gmail.com>
References: <CAJZ5v0iRaeR4n=ddVM9pJj0oxRpv1K2UWXqZbwiNmkrOPr3h1w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iRaeR4n=ddVM9pJj0oxRpv1K2UWXqZbwiNmkrOPr3h1w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.6-rc1
X-PR-Tracked-Commit-Id: ca11abf113474fe8e1205c6851a9a6ffd598bb26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55816dc1a50463ec0ea45954e87ec3dff70e2863
Message-Id: <158015580487.19143.15342357529557939272.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 20:10:04 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 17:33:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55816dc1a50463ec0ea45954e87ec3dff70e2863

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
