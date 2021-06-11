Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7DB3A466F
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Jun 2021 18:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhFKQ0D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Jun 2021 12:26:03 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36572 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhFKQ0D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jun 2021 12:26:03 -0400
Received: by mail-oi1-f169.google.com with SMTP id r16so6016110oiw.3;
        Fri, 11 Jun 2021 09:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CacLDdx3nbX3wtm4voe7QDCSyxk6h74a9LHL7GYdR2U=;
        b=ZYf3udpjQPkcCJLOfPIGmGpkYsJVeZWXbTgOrc27tzwhkaLg951wabMs4JNuf6oOlp
         wAd5BBqhCDElIMHFCoDa3YXCec9cSqBTHB8H8NcJMpll/gfH3Xe8bn+KzlSPQaej2Aff
         Fs8sbc+wLS4TCGpp2/bbJpFoI1+wVg0q8xBDpUNGKaFQr1qHpWoFwvzlrFVB7Vy8zXxJ
         56/gZccMFuGpzwM2XnZOTTJP6/eYml3vemxc0vWaEllzPP/b+4Z3ZA9ZQfE7+NtzzNe+
         2XxD9wgbRLu0wksiDraDHXtTb5GjQkfFnUKv/K3UlJd+PrnEwguwH2J3Sbe5edQn96Ko
         BwQA==
X-Gm-Message-State: AOAM532GdM0j+uqjo0c2VhJZqt4CUverWl/6NFtDPAH03FXaL6ygebEJ
        TUt1vNoD8TewDjxHnBvRKKKNXI+i5W+3QxLMFGkCkX00xi4=
X-Google-Smtp-Source: ABdhPJwMS72N0PKIYNlzv/5ofVU8NQSp6/IVUBlqVGTGFaBFOSdU5cUKZ1jvKCHE5pbMTLTNsh3OJ7uZdz0g2tPyvNQ=
X-Received: by 2002:aca:49c7:: with SMTP id w190mr888372oia.157.1623428630663;
 Fri, 11 Jun 2021 09:23:50 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Jun 2021 18:23:39 +0200
Message-ID: <CAJZ5v0h=mwaux6QuyjTF09HZ4Q6AjOhr+fBwHdQBoNXVvURiSQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.13-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.13-rc6

with top-most commit bc8865ab32bb8d71b607cf73a8367ceebda88767

 Merge branch 'acpi-bus'

on top of commit 614124bea77e452aa6df7a8714e8bc820b489922

 Linux 5.13-rc5

to receive ACPI fixes for 5.13-rc6.

These revert a problematic recent commit and fix a regression
introduced during the 5.12 development cycle.

Specifics:

 - Revert recent commit that attempted to fix the FACS table
   reference counting but introduced a problem with accessing
   the hardware signature after hibernation (Zhang Rui).

 - Fix regression in the _OSC handling that broke the loading
   of ACPI tables on some systems (Mika Westerberg).

Thanks!


---------------

Mika Westerberg (1):
      ACPI: Pass the same capabilities to the _OSC regardless of the query flag

Zhang Rui (1):
      Revert "ACPI: sleep: Put the FACS table after using it"

---------------

 drivers/acpi/bus.c   | 27 ++++++++-------------------
 drivers/acpi/sleep.c |  4 +---
 2 files changed, 9 insertions(+), 22 deletions(-)
