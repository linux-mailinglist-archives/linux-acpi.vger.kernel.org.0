Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77EB316D39
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 18:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhBJRsM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 12:48:12 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40229 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhBJRr5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 12:47:57 -0500
Received: by mail-wr1-f52.google.com with SMTP id v14so3541011wro.7;
        Wed, 10 Feb 2021 09:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xS94Nmt7CZoKfe/ooNogCsxo74+nRHCXmzdXYf9v/zo=;
        b=T96m2rqN4xv3nL0zaowVWqjOrNnHGa7Zy2eSJ4Tya0/S/SEVZ6hDkLZgIJOzUbFgTi
         dM5lTBPvZJUDJz5m8LHCgehCzKZPeyL8b8i4/R08aNTKyBdvP9vQ4aG2vKw4Ln7ZK+Nb
         63EJPZO+j0/35gL0JP0Dq3jDJg544B+6xszItK43Z9ydmkOiGiTo7SPJuGlSqbFQGN0u
         sfFwUdoLtS8RjYYPL3+w9aKaQW3sCrJ/v1V7YkxmCQwHx9xgYfwVE8n6Ooj9KluUqw0+
         aAUlTwU70/RbfOx5ebEcXkwgJ/Q9hAbdUBnMsMMrDQEg1Ji3yczPjvKmeZ/8qT0O/X5K
         TV/A==
X-Gm-Message-State: AOAM530l4cUqe4vbO5qiDSmw/eE+otMP85qq/y6qWCvU9DUXikyutxfT
        zFcaSrh338M/fxdtRjgWInoMYx/tPczLnU2+sBQ=
X-Google-Smtp-Source: ABdhPJygX1Cr8XmSICtNKIcQTAl+inc+NuAmMYpiUutZOsZfRcInJ6mA0q/Ex0blppw3kd4dipVPjcMUA2Fs31iGDSw=
X-Received: by 2002:adf:f7c5:: with SMTP id a5mr4965509wrq.243.1612979235397;
 Wed, 10 Feb 2021 09:47:15 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Feb 2021 18:47:04 +0100
Message-ID: <CAJZ5v0iEwAvR3EyQp0Qy=7ehQyufrUvMPR4CyCUdVd=qE-5OAg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.11-rc8
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
 pm-5.11-rc8

with top-most commit d11a1d08a082a7dc0ada423d2b2e26e9b6f2525c

 cpufreq: ACPI: Update arch scale-invariance max perf ratio if CPPC is not there

on top of commit 92bf22614b21a2706f4993b278017e437f7785b3

 Linux 5.11-rc7

to receive power management fixes for 5.11-rc8.

These address a performance regression related to scale-invariance on
x86 that may prevent turbo CPU frequencies from being used in certain
workloads on systems using acpi-cpufreq as the CPU performance
scaling driver and schedutil as the scaling governor.

Thanks!


---------------

Rafael J. Wysocki (2):
      cpufreq: ACPI: Extend frequency tables to cover boost frequencies
      cpufreq: ACPI: Update arch scale-invariance max perf ratio if
CPPC is not there

---------------

 arch/x86/kernel/smpboot.c      |   1 +
 drivers/cpufreq/acpi-cpufreq.c | 115 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 104 insertions(+), 12 deletions(-)
