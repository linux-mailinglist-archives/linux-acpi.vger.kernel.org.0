Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADFC14F519
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Feb 2020 00:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgAaXKR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jan 2020 18:10:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgAaXKQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jan 2020 18:10:16 -0500
Subject: Re: [GIT PULL] More ACPI updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580512216;
        bh=fDOostFsatkqK1b+xjApDcmLIHm+xKEww0/e5l+uQZA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Jh5VTfpkpr5rEmpn7+94Ot6DCO7vC8y+RXK3PesePde+sMS+kVdiixRFjdffvrpjK
         Bvnzs7KT4kso7bJnutB1BnbMmOvKjJ9ZZKBpMJIfsonbXPnXgx6cVshbFq0Ko0OJIZ
         35JZVmoH18Z6g6UAHd41B4QsMRfPcEjH7dtAZc6Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iL0Qd9aDzkeidpngyPUcqSxYc++cqbqTFq93S+Tt7XiA@mail.gmail.com>
References: <CAJZ5v0iL0Qd9aDzkeidpngyPUcqSxYc++cqbqTFq93S+Tt7XiA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iL0Qd9aDzkeidpngyPUcqSxYc++cqbqTFq93S+Tt7XiA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.6-rc1-2
X-PR-Tracked-Commit-Id: d8639f0d6c230d4c632cbf8ed1f3b9456f338ca0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffda81b69fce50f2543be99ef2d7c77dffc1ebc1
Message-Id: <158051221636.10603.14417455265371328112.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jan 2020 23:10:16 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 31 Jan 2020 11:02:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.6-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffda81b69fce50f2543be99ef2d7c77dffc1ebc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
