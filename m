Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6BF2B9B60
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 20:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgKSTRz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 14:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbgKSTRx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Nov 2020 14:17:53 -0500
Subject: Re: [GIT PULL] ACPI fixes for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605813472;
        bh=uGeVwwFQyy+WjgsYO0CUmz3sI1IwpoB3ePuxkKPwikc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TdAZA6cCDIHAXD5Rm1hYPzKzqJms0ogIYEki/7WWPMP02ZoDQLpkVVKggbCjtxyiy
         lBO38i4b3dwkn5tR4FvcltILV+dEI7p9Y/iPjpJu2YpzhGWjvJb/RosPcfOIGVOhYb
         fD6Ht7lfGuZcE10q6V+fbpxMPH1wHbmQzeRc8w2I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hEqP=GgF3VZpn8GVX4ajnzDV4T3ZMMMGUbEe-BqUoHOA@mail.gmail.com>
References: <CAJZ5v0hEqP=GgF3VZpn8GVX4ajnzDV4T3ZMMMGUbEe-BqUoHOA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hEqP=GgF3VZpn8GVX4ajnzDV4T3ZMMMGUbEe-BqUoHOA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.10-rc5
X-PR-Tracked-Commit-Id: de15e20f50b126b3a5a753dd259df775e6a0ea5c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 131ad0b6f5294dd4eb1c8e5e5c611a85cbae0c4e
Message-Id: <160581347286.16071.9183254427463286959.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Nov 2020 19:17:52 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 19 Nov 2020 19:28:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/131ad0b6f5294dd4eb1c8e5e5c611a85cbae0c4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
