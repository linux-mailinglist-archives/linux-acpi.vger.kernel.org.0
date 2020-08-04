Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3AF23B3BE
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Aug 2020 06:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgHDEPJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Aug 2020 00:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgHDEPJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Aug 2020 00:15:09 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596514508;
        bh=+2EsRC+Qic0KkQ3kzuRBcNtXJGYrxA9ONzB9tygN+xA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DDFm0Vdozzy+J19hWwK5ioxApI/bI6Z9dY7nHaxHPU0K8kYWE3xglS2ulpNRUu52u
         kfS7RfrLyBWNthffXxJ/4V5hvJSepxWn1vQMSlmxZdM1vc8MvqIbRnJIieoEaKJcWj
         NUkqAocAI08toKJwddLeV5ItpLhgJgbCRcxeGQms=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gu2wsaPqb=qTVh1+AfQJQviHF=33EyB5kYS6-ZqZTE8Q@mail.gmail.com>
References: <CAJZ5v0gu2wsaPqb=qTVh1+AfQJQviHF=33EyB5kYS6-ZqZTE8Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gu2wsaPqb=qTVh1+AfQJQviHF=33EyB5kYS6-ZqZTE8Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc1
X-PR-Tracked-Commit-Id: 86ba54fb0816480941cda78a99f107ab2bbd4249
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04084978003c1a1810a0b1fea581078106394a32
Message-Id: <159651450873.27277.14268882515890352291.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 04:15:08 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 18:50:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.9-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04084978003c1a1810a0b1fea581078106394a32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
