Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC8E3AD0B9
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 18:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFRQvW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 12:51:22 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:40582 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhFRQvW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jun 2021 12:51:22 -0400
Received: by mail-oi1-f179.google.com with SMTP id d19so11190786oic.7;
        Fri, 18 Jun 2021 09:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=i1x6TD/6SS/OmGBCarFK671QcgNdKC4Bvk2+/pH4TwU=;
        b=sWvjgA90RzuVRU+8ssVRIaG2EKFClkguY7YzkNy9lg/Hm0RhxafqHkexThaorxe/9+
         JrOF2NPMbyU75AtBPK9lDsofz0sDwZJ6yvONz7EWtnxUYe8KkOEFKqk/k11OQUO5h7PA
         oojd4Md7hC3SvlscDj/I8LdPSSxD8rV5G4UEA7mVZ4D4y0l0MRyBytBAXi3452HwMDMA
         A+3AwSpQH9EDQjoQx80jGsnEzP1p9cwfd/wMkUpZkgYKW7UzP59NLzdg4GvZMLOsVG51
         NAH072PkEiPDi1/mYqjF7MRsUpzyrZtnhWVCAPw4G8AI8M09cSMov1zi6wvDCNN4OfV9
         eJ/Q==
X-Gm-Message-State: AOAM532UCvGAvO8ZdaEyRDV9wY2xdTvdHXL479Xt85Hh8S4NKA1l+RkB
        xHyobGffMjoFfdvtd2zSYnwZe/znNkhHyQhPErtJ2iue4Ww=
X-Google-Smtp-Source: ABdhPJzMjcN62ugZhktlJtHRSHVmnX24e8ye+PTJWqV/k0iNDmRTtFEbofBjzLr7raSvWgvF8/Fukz6u+4A2YLnEibA=
X-Received: by 2002:aca:49c7:: with SMTP id w190mr15627692oia.157.1624034951314;
 Fri, 18 Jun 2021 09:49:11 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Jun 2021 18:49:00 +0200
Message-ID: <CAJZ5v0iUeL_A4iVO4SizSMtuAMnQ6YUT08nWPXidr8q_wajT2g@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.13-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.13-rc7

with top-most commit 771fac5e26c17845de8c679e6a947a4371e86ffc

 Revert "cpufreq: CPPC: Add support for frequency invariance"

on top of commit 009c9aa5be652675a06d5211e1640e02bbb1c33d

 Linux 5.13-rc6

to receive a power management fix for 5.13-rc7.

This removes recently added frequency invariance support from the
CPPC cpufreq driver, because it has turned out to be problematic
and it cannot be fixed properly on time for 5.13 (Viresh Kumar).

Thanks!


---------------

Viresh Kumar (1):
      Revert "cpufreq: CPPC: Add support for frequency invariance"

---------------

 drivers/cpufreq/Kconfig.arm    |  10 --
 drivers/cpufreq/cppc_cpufreq.c | 245 ++---------------------------------------
 include/linux/arch_topology.h  |   1 -
 kernel/sched/core.c            |   1 -
 4 files changed, 12 insertions(+), 245 deletions(-)
