Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D4610E35
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2019 22:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfEAUpE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 May 2019 16:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfEAUpE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 May 2019 16:45:04 -0400
Subject: Re: [GIT PULL] ACPI fix for v5.1-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556743503;
        bh=aOsUiEEydAYsE1AYWCufYPpPeb8VXTYGHy3HcEo8+NM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QfSASIQGYVcO3+D3aq/U1o9JEICuFlNrHGhW42Go0pHhYaKeEwrfFEonF0T+ERuZh
         gNZ6u6dPiGUlZpRL7AdJpV/9uj+jl379KmIfd0SQTf5YKlhKf6fJAO9NRzG8WD+hUT
         +yITCyYupa9oYfB22vfzG5Ue/WgkmkWzKOgt7HrU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i73At_cTv2FJEgSzcqnWUuVnDY-cyX5XWDGFw1f9fnQA@mail.gmail.com>
References: <CAJZ5v0i73At_cTv2FJEgSzcqnWUuVnDY-cyX5XWDGFw1f9fnQA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i73At_cTv2FJEgSzcqnWUuVnDY-cyX5XWDGFw1f9fnQA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.1-rc8
X-PR-Tracked-Commit-Id: 2c2a2fb1e2a9256714338875bede6b7cbd4b9542
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb0af61d3afe0b8f8b7bd2ed7c9fcaae670ced4a
Message-Id: <155674350366.10978.11321440204270892451.pr-tracker-bot@kernel.org>
Date:   Wed, 01 May 2019 20:45:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Wed, 1 May 2019 10:39:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb0af61d3afe0b8f8b7bd2ed7c9fcaae670ced4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
