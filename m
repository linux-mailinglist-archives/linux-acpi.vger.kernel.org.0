Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E8D48CF80
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jan 2022 01:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiAMACA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jan 2022 19:02:00 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38096 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbiAMAB7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2022 19:01:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CF277CE1E84;
        Thu, 13 Jan 2022 00:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A857C36AE5;
        Thu, 13 Jan 2022 00:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642032116;
        bh=40J9lo24h8Q7Yn5BEkIqSrxLgBYH4N8akUCvAxaxtDk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sSRwvFhktgq+HxIHqbXb7xZA7Aji7nz9fhqYDMpQUa+BjCL5ddNjE0ztZuBRLhmZ7
         GYz2ht1w86Q6B/wh0Ozv5W+wj6wdRLVNzs1iG4+ZaFyvNLnfb4n5zj7RUphq//MUbP
         oMsF9Qx5R8Jl8JtzpF9D1CjiG4IYvs99S8gDxhj/KR9j700K0KcBIOCj2I5UbIiK+Q
         e7Xkzf578cIKfahbibO4IXOCnwTbBpoUQBfF1BXAqNQy41NmxDE2JJyZCY9+phAvz8
         SuoBUxnNAfR9e/8GKCPkHrAoOEcMZMLIMMI96tpiIvXL+OZYaJrGpsXmG9EMahH4Ef
         +LH4BSqFwsJFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EADF5F60794;
        Thu, 13 Jan 2022 00:01:55 +0000 (UTC)
Subject: Re: [GIT PULL] Compute Express Link for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4j0NfC4RKr=VU6yUKrqVRKdAer9YeSezRctpp-k31iAzA@mail.gmail.com>
References: <CAPcyv4j0NfC4RKr=VU6yUKrqVRKdAer9YeSezRctpp-k31iAzA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cxl.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4j0NfC4RKr=VU6yUKrqVRKdAer9YeSezRctpp-k31iAzA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.17
X-PR-Tracked-Commit-Id: be185c2988b48db65348d94168c793bdbc8d23c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 362f533a2a1098fe95020cb59340023e9b11d062
Message-Id: <164203211594.31844.12249269737261172428.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jan 2022 00:01:55 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-cxl@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 14:49:09 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/362f533a2a1098fe95020cb59340023e9b11d062

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
