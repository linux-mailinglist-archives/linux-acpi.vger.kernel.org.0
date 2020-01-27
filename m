Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11C0414AAFD
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2020 21:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgA0UKF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jan 2020 15:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgA0UKF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Jan 2020 15:10:05 -0500
Subject: Re: [GIT PULL] Power management updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580155804;
        bh=bVGPYd0m5n9mOjPFfwnbX0TiI12pstEYGOPRjhX5Paw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=syNOoydmADybBaeeBA72mzmGYart8lnO2n/7lGyc59hawl5hn/OrCryQ4ypm6S/rJ
         0zla6g2+EDoGJCh+yFceUAeDuLhnt2NGOZXV+RlwFbshVYjrHBxJbKRVFzyY5ZrHYn
         tcM5kPtK2813aCyM2RXOrQcGqRoKxff3g2c+WwIs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jGdfSUK4s3nq_uCiQrg8tWrycv_C_xNg7CYk4LC8o-Dw@mail.gmail.com>
References: <CAJZ5v0jGdfSUK4s3nq_uCiQrg8tWrycv_C_xNg7CYk4LC8o-Dw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jGdfSUK4s3nq_uCiQrg8tWrycv_C_xNg7CYk4LC8o-Dw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.6-rc1
X-PR-Tracked-Commit-Id: c102671af085aacf17219e9bdcfccddc6620a866
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d277aca488fdf0a1e67cd14b5a58869f66197c9
Message-Id: <158015580436.19143.11425012533765425564.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 20:10:04 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 17:31:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d277aca488fdf0a1e67cd14b5a58869f66197c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
