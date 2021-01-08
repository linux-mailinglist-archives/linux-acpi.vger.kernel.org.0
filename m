Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41EC2EFBDE
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Jan 2021 00:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbhAHXuX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 18:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbhAHXuW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Jan 2021 18:50:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B41B923AA3;
        Fri,  8 Jan 2021 23:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610149743;
        bh=jdTHaiixay+OFIzCJSGsnlb6HAptIR3pm3TXn6UoUcE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l+rESUh9kzqJJJtG6UvUATDigxgjCXK1cifcoXs15swhHRPfPqhXCJi2MmpBlV8zc
         EciCt8ZWeENd5o3QJT0cuiOO0tAB29Y0Y6wm8xO2xO4w8w8LokqcjtbjKcxOI3DSDw
         d3JRGwUaTvhDuQcG9RHl9M/1DxGKh1ipq0OQiJ+boQyZpUIbOoRf2OaBgOlvAcu12m
         oPGMzn+v07v6W+CUxtK+aIMr9x1NRJwnCek4rHee0nO4P86BC0n+5OuWOsICHl2dsN
         qStBy3m4sT0o6U+hJR+9Z81iC8TdP0kaAVzmCD05j/cHDSGrjhq226hQ6FimybzTZv
         PXcbCjL5Kvyfw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id AF54160157;
        Fri,  8 Jan 2021 23:49:03 +0000 (UTC)
Subject: Re: [GIT PULL] Device properties framework fixes for v5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h0kagZ6n+xC0wcCN5Zg3=HQ0NS_HO6fC0do8H5BqbD-w@mail.gmail.com>
References: <CAJZ5v0h0kagZ6n+xC0wcCN5Zg3=HQ0NS_HO6fC0do8H5BqbD-w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h0kagZ6n+xC0wcCN5Zg3=HQ0NS_HO6fC0do8H5BqbD-w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.11-rc3
X-PR-Tracked-Commit-Id: 3f7bddaf5d5a83aa2eb1e6d72db221d3ec43c813
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78d42025e5bb83f9071e4a60edf1567dd12ed9dc
Message-Id: <161014974371.3246.9793485382844941356.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jan 2021 23:49:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 8 Jan 2021 18:54:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78d42025e5bb83f9071e4a60edf1567dd12ed9dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
