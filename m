Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7A5256206
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Aug 2020 22:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgH1U3X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Aug 2020 16:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgH1U3N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Aug 2020 16:29:13 -0400
Subject: Re: [GIT PULL] Device properties framework fix for v5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598646553;
        bh=6s+JKAcukgHJvyOlLcKcKxulszNqq3PTtN0lElB7ZyE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lEcy0m+2aeLENGI/3v5BonKt9rsIE41df2PAotJZ4DhZB7yj8nUf7y5/eHyejswZs
         b6yh1BF+JLQ/BlL32xhMtj4E1HnmQevL6SvVHx4TqEiltupgZrD0UmcaLrDawRSAO/
         22L5bM/6Lp6sDorPCvUG2d/+QcTdiQi/H8PzOYXQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jWBqqU_-w5yn9iGaJZT6wFnaqNHUvE9e6TRKZhxyxFkg@mail.gmail.com>
References: <CAJZ5v0jWBqqU_-w5yn9iGaJZT6wFnaqNHUvE9e6TRKZhxyxFkg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jWBqqU_-w5yn9iGaJZT6wFnaqNHUvE9e6TRKZhxyxFkg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.9-rc3
X-PR-Tracked-Commit-Id: c15e1bdda4365a5f17cdadf22bf1c1df13884a9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 005c53447a63cbce10de37406975a34d7bdc8704
Message-Id: <159864655299.14109.18285197718685056798.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Aug 2020 20:29:12 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 28 Aug 2020 21:52:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/005c53447a63cbce10de37406975a34d7bdc8704

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
