Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79A14BC36B
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Feb 2022 01:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbiBSA3K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Feb 2022 19:29:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240382AbiBSA3K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Feb 2022 19:29:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD670B7C4E;
        Fri, 18 Feb 2022 16:28:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E691B82732;
        Sat, 19 Feb 2022 00:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C639C340EB;
        Sat, 19 Feb 2022 00:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645230530;
        bh=V51nKj5al366IWu0bB/o4b2q56GYa0ZwsLnnNkcI2/c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iQdvKMbWQGuGfum3Jnc9e65GOLMFw30CHQ4qDB7BGQZuWUqWaYJZj/mPT6u3+VWYW
         +D7v4VHfUSfdmAyCDdWRd0fNqZuxCBuzHawwfuUAAfLFR4a0HIhOEkgbtx5RcZrFID
         LFkqm2a1S1/9ggjy6qfvV3S2XQnWI1Q6X/2lTKQLAqquBW7uXl9zWDxHKAyNX8kgKe
         lmkT/66Vx9LEiScCRVMDfarzfJV9F2ZJzqfu1Rzj2YeVPL7D1Le4FOaLdFL6mX/yfI
         Ow2RIcUm6ntiF8XJiQGysMZ98ZNmqPEN2WiLCEk32EkEApGOS7kQbK9NIZeyaj+HOg
         R6W4lk3Bog2MA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2868BE7BB08;
        Sat, 19 Feb 2022 00:28:50 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hpQzGdX0HW94fgFG0LjTcKs0s9PgczzjVUcz8AaRPpqg@mail.gmail.com>
References: <CAJZ5v0hpQzGdX0HW94fgFG0LjTcKs0s9PgczzjVUcz8AaRPpqg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hpQzGdX0HW94fgFG0LjTcKs0s9PgczzjVUcz8AaRPpqg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc5
X-PR-Tracked-Commit-Id: 8292656464e5f066d46cb73da957930613a2c597
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c2a33d0ac6961d36cd653638c7841b179969906
Message-Id: <164523053016.25426.7046733863089488955.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Feb 2022 00:28:50 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pull request you sent on Fri, 18 Feb 2022 19:50:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c2a33d0ac6961d36cd653638c7841b179969906

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
