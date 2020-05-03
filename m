Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB1F1C2E81
	for <lists+linux-acpi@lfdr.de>; Sun,  3 May 2020 20:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgECSfH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 3 May 2020 14:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbgECSfH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 3 May 2020 14:35:07 -0400
Subject: Re: [GIT PULL] Power management fixes for v5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588530907;
        bh=iAA/BK2K8L9aAuphhVJVosilOtXQj7bchRw8XI1G8g0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BMTlnlZwazFGSntz9vHAFe21lU+wBdGizwpjQPRMKedXvOhR02J59k3s+L98lLhyp
         BCj0Jx6i3tmGsniUgbI85eyaLh22CS/OOBsYAwblElNm7qXeYZuAj8HpEtA8ukAbfE
         4HpjF2jEx3LY2SQIv1r3V9HZGvptxCPM+nI3XTSw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0huWpQa3NgmmJ_OWGB_ngQvA4V3YCX1i3-QutqSxZOzdw@mail.gmail.com>
References: <CAJZ5v0huWpQa3NgmmJ_OWGB_ngQvA4V3YCX1i3-QutqSxZOzdw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0huWpQa3NgmmJ_OWGB_ngQvA4V3YCX1i3-QutqSxZOzdw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc4
X-PR-Tracked-Commit-Id: a53839963ee22470a716de665bca39d2dae63c27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 743f05732f49bacd196306de87864aa074492026
Message-Id: <158853090723.15713.12905345329050167255.pr-tracker-bot@kernel.org>
Date:   Sun, 03 May 2020 18:35:07 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Sat, 2 May 2020 21:56:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/743f05732f49bacd196306de87864aa074492026

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
