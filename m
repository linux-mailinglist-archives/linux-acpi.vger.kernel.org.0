Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B451560E3
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Feb 2020 22:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgBGVzU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Feb 2020 16:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbgBGVzT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 7 Feb 2020 16:55:19 -0500
Subject: Re: [GIT PULL] Additional power management updates for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581112519;
        bh=fOCxGy7MCh6Fy+wzJ7TB/GLsOp9F+XkQM82zHKt/dy4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gqJTqaewu2c2VeI6pZAfLJ8gD+QlUeHlkV4axuxLfndSj+IcODUlpKdW+8HLk49CW
         Qu+WuFmV4YV8o9XB6shdoIoMs74GihUvgT7izgr6dSvFtTHKm3UFpYrHRhwUiltkAV
         NLeIXmaF0qT5FpnTF7E+ieX9PvLNCRva+cxnUtCI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iDEpbZmZvTKxhZYq0CQWJSRZBDfhXgNOJT-wSxUrsb3g@mail.gmail.com>
References: <CAJZ5v0iDEpbZmZvTKxhZYq0CQWJSRZBDfhXgNOJT-wSxUrsb3g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iDEpbZmZvTKxhZYq0CQWJSRZBDfhXgNOJT-wSxUrsb3g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 pm-5.6-rc1-3
X-PR-Tracked-Commit-Id: 332008256f1f7cd8294acd6e288fb821f685d1a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba7dcfc7badad87e450e4aaec79662a038dbf9ed
Message-Id: <158111251898.9631.17351659043416665666.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Feb 2020 21:55:18 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 7 Feb 2020 11:34:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.6-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba7dcfc7badad87e450e4aaec79662a038dbf9ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
