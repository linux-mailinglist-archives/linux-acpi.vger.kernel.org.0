Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CEA3B79C2
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 23:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbhF2VOO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 17:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235672AbhF2VOO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 17:14:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4D35461DA0;
        Tue, 29 Jun 2021 21:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625001106;
        bh=piKVhxZQrsvkEwbzFquacQvoZOSGZwpB1/Vd0gxP8KA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=abt6JwRoLTafjupMVJUKnBpxtsqZ9bjX8rcNmzBb6qPkLJPZf4TIrLf3RXG+CRYtZ
         Hjb0yav7Hg0BV7LGhSF1G8ZKQx/+i8leWeoETJekUEk4WxfSOc6S/3w3+oIHosprpE
         K5d4MSvTGQwIUc8HKxmVlcbqZMRV+AcgyTxLymQCJIxAzKQQ0vD+znXimp9GlF/LZR
         r0FaYOARz2qAgxf2POF+kR8xY7DBtC2UQqD8PsLXrq8i0BopVwk1+aQQru2en8xcw5
         uPBF6yY0y1GPrl2qahsPDbWwG1DecrW9zb/naizzJmNzD31pRxS+WOOXlN6QqWaP4N
         UOa+sPnPWUkag==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 47C6A609A3;
        Tue, 29 Jun 2021 21:11:46 +0000 (UTC)
Subject: Re: [GIT PULL] Device properties framework updates for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jWTynLe9jQ+KnPU97ed4CQ35dKssuXQHDEPdwMqtyqgA@mail.gmail.com>
References: <CAJZ5v0jWTynLe9jQ+KnPU97ed4CQ35dKssuXQHDEPdwMqtyqgA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jWTynLe9jQ+KnPU97ed4CQ35dKssuXQHDEPdwMqtyqgA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.14-rc1
X-PR-Tracked-Commit-Id: fb38f314fbd173e2e9f9f0f2e720a5f4889562da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 349a2d52ffe59b7a0c5876fa7ee9f3eaf188b830
Message-Id: <162500110628.4657.15586561517981668290.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 21:11:46 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 21:05:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/349a2d52ffe59b7a0c5876fa7ee9f3eaf188b830

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
