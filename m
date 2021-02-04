Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4ED30FAB6
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 19:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhBDSGt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 13:06:49 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:41838 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbhBDSGj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2021 13:06:39 -0500
Received: by mail-oi1-f174.google.com with SMTP id m13so4620067oig.8;
        Thu, 04 Feb 2021 10:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QbiftXdgo4OS5KlhnsjjNU/h9Dr7caei4UL2Hb2vTbM=;
        b=JzQ7IusY3FzBkK4pvlwHQU8lmGsBg3rx1eJKX3WNyyXrgbg5FxuBOPnuHw0gAMyz3h
         HYv9TYNkFS9M6+wYHtmsa5vYOUln72QI96mnav2vikGLoP0LHmoLXWWYVz85l5oa1rM4
         tffVzsl2YLIOgP4m0/ELCSMjQzP0RMqQvFoBzfmnLbCu6JqHyRUNKkJChbqC3ZmVx/6z
         CqGfjJe68mr7OzRMQY7sOzrzqpOlaDihWMLZZe317rj3icZLeGqKRtpv7CnysBvokMxO
         +JPqqcTKAbf7cnuuP99gZB62mXAbuHq7uEcS/VVGGP0PuEwoG5mDYU4cmO6vmUMeVCgX
         wvDA==
X-Gm-Message-State: AOAM531NOZbyVvCoHxgfEaTFTptgyOmdKqFH7k7o6dYyJI4AVo1O5czH
        M/DlK4iKt5j8XEKqgttlFzRgfB0AAb16hUHD2zc=
X-Google-Smtp-Source: ABdhPJwyb4/S5DaPrmtXR8vW3qSvXlxciI3NGr5Y19WV6x1it70XYyTXrNeOR3HAaqQ5fVHLvLEC2Nv07xea6earflw=
X-Received: by 2002:aca:fc84:: with SMTP id a126mr481903oii.71.1612461955151;
 Thu, 04 Feb 2021 10:05:55 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Feb 2021 19:05:44 +0100
Message-ID: <CAJZ5v0hvbEQehBdq4FNtU9t0xQ1jEtcDVH5b96Bo=Me-dbNg-w@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.11-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.11-rc7

with top-most commit 0f347aa07f15b346a001e557f4a0a45069f7fa3d

 ACPI: scan: Fix battery devices sometimes never binding

on top of commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac

 Linux 5.11-rc6

to receive an ACPI fix for 5.11-rc7.

This addresses a recent regression causing battery devices to be
never bound to a driver on some systems (Hans de Goede).

Thanks!


---------------

Hans de Goede (1):
      ACPI: scan: Fix battery devices sometimes never binding

---------------

 drivers/acpi/scan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
