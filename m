Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1131D3B84
	for <lists+linux-acpi@lfdr.de>; Thu, 14 May 2020 21:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgENTCz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 May 2020 15:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729281AbgENSzD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 May 2020 14:55:03 -0400
Subject: Re: [GIT PULL] Power management fix for v5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482503;
        bh=jSFuh1HRAAsWW0XNlV0/HxGEK839AdrmIy4HxKs/NXU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yAUy5yEbeFjNwxSC0JPFvRlQViHCgIACEFN7Xmxeh7lCSkA9V/FbPuzm8RrZXZfA2
         +2SH70hfXmxzG/euNzxcKYGCAGlyY2DRIP6Tb1ErSJHd2T18UJf83okBZzBOgpiMWa
         DnCp4hoMVvg3ovd+10nNmdACoQFXnicxUiJg6fkk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jgvBE4=14fwsFUx1q+iOO+xt2Jv4L6ER1N5pTLNk1fDw@mail.gmail.com>
References: <CAJZ5v0jgvBE4=14fwsFUx1q+iOO+xt2Jv4L6ER1N5pTLNk1fDw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jgvBE4=14fwsFUx1q+iOO+xt2Jv4L6ER1N5pTLNk1fDw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc6
X-PR-Tracked-Commit-Id: 7b301750f7f8f6503e11f1af4a03832525f58c66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f492de9dcf04fde2b3671b9e188180fc684aa4e2
Message-Id: <158948250345.25823.5012928432781293760.pr-tracker-bot@kernel.org>
Date:   Thu, 14 May 2020 18:55:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Thu, 14 May 2020 12:15:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f492de9dcf04fde2b3671b9e188180fc684aa4e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
