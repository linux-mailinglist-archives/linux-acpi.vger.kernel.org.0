Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498BD3D408B
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jul 2021 21:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhGWSaE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Jul 2021 14:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGWSaD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Jul 2021 14:30:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D028D60F21;
        Fri, 23 Jul 2021 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627067436;
        bh=EHxfErzQ7VS9z13ZemEtr0R2+zPwluIq5xYEuMtWQ6s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fQuQPK1oVeUvIlNki1JNlJS8jgWQNAH/oNMELISPY7TJWvpm1cZQ0QbZBw2im+Psm
         riP+7HVkTA4GgwDGtZZqPQgq0qFBD9N7/Y+gLekauUBUW2H6VBBAKNXxOzbM2pBTuB
         zUpxiLBq0UmzZ/0DrFD5kcUZdUEBlZGA1PV3/sT0Hgd2RFs55VeugGu6/hMVPVf2lN
         hsFv0b/af36hYCYB1UjZYhrnR7KUywSAv9pcK7s3IsUmCTiA29qNP7BMu9hjtiBT36
         OMZV2gwOQgvjZvIYs+gayqVeTk6uu1nROw6RjD9mxhaiM2iyEncMnxAMVJ/jYI0nsw
         U/rkmnk3tWvgg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B8B2E608AF;
        Fri, 23 Jul 2021 19:10:36 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gEn3X2FCc0kC-BJ_7D8VXH4XRmhpj3Qn2dEC9K_BUCRQ@mail.gmail.com>
References: <CAJZ5v0gEn3X2FCc0kC-BJ_7D8VXH4XRmhpj3Qn2dEC9K_BUCRQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gEn3X2FCc0kC-BJ_7D8VXH4XRmhpj3Qn2dEC9K_BUCRQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc3
X-PR-Tracked-Commit-Id: 0b8a53a8444c267114f6b5a85d21153ddea190eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec6badfbe1cde0eb2bec4a0b8f6e738171156b5b
Message-Id: <162706743669.23984.7408657958598552168.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jul 2021 19:10:36 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 23 Jul 2021 17:23:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec6badfbe1cde0eb2bec4a0b8f6e738171156b5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
