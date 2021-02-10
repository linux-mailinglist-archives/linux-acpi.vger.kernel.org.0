Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0255317128
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 21:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhBJUUJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 15:20:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232268AbhBJUUC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Feb 2021 15:20:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 5508E64EDA;
        Wed, 10 Feb 2021 20:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612988362;
        bh=ZwiqYsk3HyYV9gW5oNg5nLObl1K+lf3F4NsqZVrOyuc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M6k3MVgzhCRBycPqDjiHYN/BdvxdgY5+bnFB/hL7vR/+OzrFhMW7NtQwzi2ipOs5K
         12BeeLzG9NiQvc5qkpIHVoHMw3GP5a0ceEciIDZvaor971lpNRjejtp49ByiRufTl6
         JRQ8MX8KcQRolQPAglSiJN75Vn96wazwLY+wk9yhxKhOLN+H9hCmKJrJDiZ1kbgk8z
         2rAn2j+Xat+AATPkIuk57F3LvB7NhZH52MerAlsrSGDoFuDOwNUdUr5OQeatyWAveh
         uqLB54K+Vpu0ZefXjQeVcEas6KLYu8pK0QIFn10eAXCpST4Y6zkHv7S7YBD8YZjNZf
         NvWGYWoKyscdg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4A9FB609E2;
        Wed, 10 Feb 2021 20:19:22 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v5.11-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ikQ6D0V2c7xL0_jHm+UwiwqgRSSm=4fCqPkkApZe54Ow@mail.gmail.com>
References: <CAJZ5v0ikQ6D0V2c7xL0_jHm+UwiwqgRSSm=4fCqPkkApZe54Ow@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ikQ6D0V2c7xL0_jHm+UwiwqgRSSm=4fCqPkkApZe54Ow@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc8
X-PR-Tracked-Commit-Id: fe0af09074bfeb46a35357e67635eefe33cdfc49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3961497bd9c7ca94212922a46729a9410568eb8
Message-Id: <161298836224.25163.17920638099953713327.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Feb 2021 20:19:22 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Wed, 10 Feb 2021 18:45:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.11-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3961497bd9c7ca94212922a46729a9410568eb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
