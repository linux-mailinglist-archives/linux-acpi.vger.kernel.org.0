Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7517BE3C96
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 21:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393075AbfJXTzO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 15:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408340AbfJXTzG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Oct 2019 15:55:06 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571946906;
        bh=etzCMheFwraUGu+Vf2rDZYhj89yY5OJSUu02blmI1F4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QAYNMvs6LQV+C5ssCOpnkyim28h0+JW4hTVqGbfdd7qD+kn318fhqIMmzHqliwb8n
         55sYYLruk04B15qT6hIpWaidN/kZZ56IGdoRYIRsK7DYqGtsSAQjXvWibowa81Nti9
         7c/ruDuOwgvGI/cmdsxYuXii0fgGJhjgvc6M3ksg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jJ_hWQKH0FNoTk+EtzLS=y3ovC4+pXPq+NWB1vPZU9pg@mail.gmail.com>
References: <CAJZ5v0jJ_hWQKH0FNoTk+EtzLS=y3ovC4+pXPq+NWB1vPZU9pg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jJ_hWQKH0FNoTk+EtzLS=y3ovC4+pXPq+NWB1vPZU9pg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.4-rc5
X-PR-Tracked-Commit-Id: 767d2d710e9066c47919a4e5f05a21e1ad40ddc4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5fa2845fd794419fbeaf240aaa0c6d62ce6191cc
Message-Id: <157194690604.28436.15553776591358377680.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Oct 2019 19:55:06 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 24 Oct 2019 19:28:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5fa2845fd794419fbeaf240aaa0c6d62ce6191cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
