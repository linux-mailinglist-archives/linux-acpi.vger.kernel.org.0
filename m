Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1103FA04E
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Aug 2021 22:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhH0ULy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Aug 2021 16:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhH0ULy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Aug 2021 16:11:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2CD01600AA;
        Fri, 27 Aug 2021 20:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630095065;
        bh=qdasnpqVL1ldk/1IaFGIn6XYtysbrAlDLz36BUDq1MQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QqzHaHll78LLDhrmjdpeprcuzuYCiOdSNBSA7Ezq/ie7uXWTyzUIjgwM/cHfGRjrO
         J1bk7ycnT9T7okiOMMeX1bUsIfpXzCTB/xHw7IWMbuDOY8GtNuRPMtEFNuaE7yNceR
         6NAMh4WnvzsFJ6YKhWv57paAT9RFvG7avaNf/IKQr3JtSHTnFiigzqKBIhiY+uCv4p
         e8irzsIP65PhvaA5L6NlXkSvzqNGBsxEHvgikP2EOvvjvqxcxB8QC4bgyG3MkOIFyP
         TkHWNpT7En9vcmlpd258H7fcOoS5acy5VrsQ6wsQytS/jd8Ii/v+21f7VJtB7DI3+W
         ZAYGGD+mHUdAg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 242BF60A14;
        Fri, 27 Aug 2021 20:11:05 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.14-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hxquKvcHR_YYd+csGWwHB5HW2uXMYtM=uT5QDqFLH8ew@mail.gmail.com>
References: <CAJZ5v0hxquKvcHR_YYd+csGWwHB5HW2uXMYtM=uT5QDqFLH8ew@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hxquKvcHR_YYd+csGWwHB5HW2uXMYtM=uT5QDqFLH8ew@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc8
X-PR-Tracked-Commit-Id: 294c34e704e78d641b039064ce72d4531afe0088
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f9d0349841a2871624bb1e85309e03e9867c16e
Message-Id: <163009506514.27622.6354119366992452590.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Aug 2021 20:11:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 27 Aug 2021 20:56:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f9d0349841a2871624bb1e85309e03e9867c16e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
