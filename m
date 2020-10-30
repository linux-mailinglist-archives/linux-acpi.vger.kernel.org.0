Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C762A0F16
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 21:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgJ3UFu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 16:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbgJ3UFu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Oct 2020 16:05:50 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604088349;
        bh=NRfhOFZmIGy8iHIVprhE7Pu3Uv4icjrn/YiieSekcK4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DBC1TWdylAqHMrwM1ZAPUjhxdN8viQd3ROq9cfct2gSNmj4t6MyL7a5qefaKzhk9p
         H4xELqvnTzL8Y6VQaeUJnf8fVk8fMjXmd8RuXrsHJ6Z1SM6aNpU7UmP3vpHPwahj+F
         jQa8wyDDVbieZ7CwkWkgn+OL8XdNl28x5kPkwfYE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jUdG-6MO8BWz0BsJTqFCbaad1Bk6MexFy8ugdgBFexLg@mail.gmail.com>
References: <CAJZ5v0jUdG-6MO8BWz0BsJTqFCbaad1Bk6MexFy8ugdgBFexLg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jUdG-6MO8BWz0BsJTqFCbaad1Bk6MexFy8ugdgBFexLg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc2
X-PR-Tracked-Commit-Id: dea47cf45a7f9bb94684830c47d4b259d5f8d6af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8843f40550dd9f11ff39b6fee37d167516dc2158
Message-Id: <160408834959.13990.4887733966181743720.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Oct 2020 20:05:49 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 30 Oct 2020 17:28:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8843f40550dd9f11ff39b6fee37d167516dc2158

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
