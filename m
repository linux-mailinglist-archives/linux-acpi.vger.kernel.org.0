Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A2228E6BA
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 20:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbgJNSxM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Oct 2020 14:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389252AbgJNSxM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Oct 2020 14:53:12 -0400
Subject: Re: [GIT PULL] Power management updates for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602701591;
        bh=cnHAfiDTPTFeRLw1h4713cng4+uNBrDkbdOVBRy66gg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gP5+MRJMuL3gC2tXq7wcnrTpCSsJjXmiGLFu6DYD87ggfrR71sjThIeTXhp2dIE1k
         xSYRTVWX/rsZhIuJ//Y7H6pHhk7gk6aOjLTTZ4BK2HhEqog0gT7eddiCsaeS/VSWgU
         wOz9wzYDkWHrQDMeJjGQBy20K3JQxmtuvqDJcNuY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jMkgxQ=Aa0z4YnhXudgemzET0jBgPu13+Q3RtEspaNgQ@mail.gmail.com>
References: <CAJZ5v0jMkgxQ=Aa0z4YnhXudgemzET0jBgPu13+Q3RtEspaNgQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jMkgxQ=Aa0z4YnhXudgemzET0jBgPu13+Q3RtEspaNgQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc1
X-PR-Tracked-Commit-Id: 16641d81f9ff5f902d084754c84b2bde3a60bc6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b8417c14181595997091145342954332fa016cd
Message-Id: <160270159151.3085.12044182936475440683.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 18:53:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 19:31:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b8417c14181595997091145342954332fa016cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
