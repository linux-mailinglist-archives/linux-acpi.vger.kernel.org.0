Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8419F173E1F
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2020 18:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgB1RPK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Feb 2020 12:15:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1RPJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Feb 2020 12:15:09 -0500
Subject: Re: [GIT PULL] ACPI fixes for v5.6-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582910109;
        bh=xDAZZtFV1EibALfcVTCMV5kttkdTN7Lzoa/vbHh9BS8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WBxSQgOR3tUgzLO6pOAaFUAymfNuPH0R/czh2ZTTyXu9GQ52iplz9hBpH2+AGFHeb
         zzYWKaE+BKOk4P8x4NFRE1z6q6aWNr0HHca9y2hdGIRPiaeau8gnzPHOVGRNvIbnqA
         BFvA+aT8dO5pC9Aw71eLki1VDjaXGKhaogKhOTjw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h6eQ72p8uNnxRkAYJjSZ7yTC5yyZitoZ96KA+05Dq7Dg@mail.gmail.com>
References: <CAJZ5v0h6eQ72p8uNnxRkAYJjSZ7yTC5yyZitoZ96KA+05Dq7Dg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h6eQ72p8uNnxRkAYJjSZ7yTC5yyZitoZ96KA+05Dq7Dg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.6-rc4
X-PR-Tracked-Commit-Id: cabe17d0173ab04bd3f87b8199ae75f43f1ea473
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c60c04021353c55b133519804734415f647f08bd
Message-Id: <158291010942.6279.13509633892252691233.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Feb 2020 17:15:09 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 28 Feb 2020 11:27:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c60c04021353c55b133519804734415f647f08bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
