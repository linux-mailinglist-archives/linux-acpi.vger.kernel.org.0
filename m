Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A1D157D2
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2019 04:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfEGCzN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 May 2019 22:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbfEGCzE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 May 2019 22:55:04 -0400
Subject: Re: [GIT PULL] Power management updates for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557197703;
        bh=4ut9ZcLtqxhm4Xv6Hl7Re8O2R+beiHRl2DvA3Z4m87U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ayQrKf98jzsnFRCKmtraslHvgUoxczIvMxASlYghk/gxKMrdq8jmmTP/fRa6Nnnzr
         Ybj+jwp/B/2oM3as9Jzbi0BSeN70wFHCKZTcnWs5X8ynxrT07dI8nEGUdXdynYvXel
         h1qY4SDVVhbYdwabO6C1r5en+REZzvWv5oxr3Oko=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ge6JhqYEAiFY9cVF5rMW1u_VgC1Cgi=XQOVt4kw0oKTw@mail.gmail.com>
References: <CAJZ5v0ge6JhqYEAiFY9cVF5rMW1u_VgC1Cgi=XQOVt4kw0oKTw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ge6JhqYEAiFY9cVF5rMW1u_VgC1Cgi=XQOVt4kw0oKTw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.2-rc1
X-PR-Tracked-Commit-Id: e07095c9bbcd296401bec8b6852d258d7c926969
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f5e823f9131a430b12f73e9436d7486e20c16f5
Message-Id: <155719770356.24898.11372056159509895164.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 02:55:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 13:14:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f5e823f9131a430b12f73e9436d7486e20c16f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
