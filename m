Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9ED1A48F7
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Apr 2020 19:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDJRag (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Apr 2020 13:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgDJRa2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Apr 2020 13:30:28 -0400
Subject: Re: [GIT PULL] More ACPI updates for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586539828;
        bh=2PjPck5e4YOg0jyyCOfRK0PmObgijABvV9PcXnnsAx0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fISx9EauO4w9YCogM3/5xYSBckgtSJJJ4VeqX97P+eKd9txU+OjJkyuFpJzPKKteD
         h9sPPTMi1Zzx1fmRcZ2qXNWnElNov4F588HNLufpCz62tFBFEAqUr5U/skr3NW3Cih
         roytdQiUk9Y0augMw9yb3zpbMXRf69qFwRQ2zMN8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g8hyYjx1eTZ7U+zvE+UrPjseZSAd-r6=-G4U_2M05yEA@mail.gmail.com>
References: <CAJZ5v0g8hyYjx1eTZ7U+zvE+UrPjseZSAd-r6=-G4U_2M05yEA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g8hyYjx1eTZ7U+zvE+UrPjseZSAd-r6=-G4U_2M05yEA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.7-rc1-3
X-PR-Tracked-Commit-Id: 0214da7cce2030f1a71fb555e2967faf3b92aebf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3e5e977abe2b6c98455e4f6acd3b09cb4a0a940
Message-Id: <158653982882.6431.5463424105364172917.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 17:30:28 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 10 Apr 2020 11:50:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.7-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3e5e977abe2b6c98455e4f6acd3b09cb4a0a940

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
