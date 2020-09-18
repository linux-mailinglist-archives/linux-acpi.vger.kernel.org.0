Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D63270174
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Sep 2020 17:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIRP5c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Sep 2020 11:57:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42243 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgIRP5c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Sep 2020 11:57:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id m13so1331612otl.9;
        Fri, 18 Sep 2020 08:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=opjEZ6SLPUR8mQtZMsAA6wmK3fGCNwHrfwNDy0h6zpc=;
        b=WTwr57nz11hj5UQbiYrA14iVCkc4VW1IRJEbmJEpl47mGP41qrEXLQTN4sbqkXCQqN
         31C51Rf/vVYsFi5zSEDW6oOnmauqdgjGD3m3dUiyBK6/dWL18WKyA+1K+Di0VVlkPq3w
         xQs1VMFlqJxZynvEYUbM0xTXt5eguxoE5HOLkBXm7sMDCsn0vDXj2lU07JgnNej+1qEO
         chNpdYZMtUp9ibVgz6KZXNFFQIbgN2+hmwhMX7DyEJewZ9U+NOZWgKJMpK4i7pg+0TQW
         VImz/eLhoDHATPpgjjkjPbrqI8jpjZhCD0dU6lrS/F7B+IqnHAtiUA4dmHXF6kw6Fg7v
         ttrQ==
X-Gm-Message-State: AOAM533jz1FYC099Od4j7kVMPr7bmuSOIg0DLtkkQDkHJXYyRxOUaDRY
        Kcav0VNesiXtN7Swsza42mrIdVywm1PDAtckKpPoHgEN5hc=
X-Google-Smtp-Source: ABdhPJyTSlj2UEeHkynnjnJztlFv5jVdGZEodAYbnE+eq6Udymkz9mK0HHBMCMKLKn9o5ybcwqLsRFm+g2C2h9qJOKM=
X-Received: by 2002:a05:6830:1f16:: with SMTP id u22mr22331206otg.118.1600444651425;
 Fri, 18 Sep 2020 08:57:31 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Sep 2020 17:57:19 +0200
Message-ID: <CAJZ5v0h1R51F01za5x3DFEdtWOSKez=FCcqAmGtcE9ANZ-+m9w@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.9-rc6
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
 pm-5.9-rc6

with top-most commit e8dc676e2a35e753fc46664968963f22e6e8af4a

 Merge branch 'pm-cpuidle'

on top of commit 856deb866d16e29bd65952e0289066f6078af773

 Linux 5.9-rc5

to receive power management updates for 5.9-rc6.

These add a new CPU ID to the RAPL power capping driver and prevent
the ACPI processor idle driver from triggering RCU-lockdep complaints.

Specifics:

 - Add support for the Lakefield chip to the RAPL power capping
   driver (Ricardo Neri).

 - Modify the ACPI processor idle driver to prevent it from triggering
   RCU-lockdep complaints which has started to happen after recent
   changes in that area (Peter Zijlstra).

Thanks!


---------------

Peter Zijlstra (4):
      ACPI: processor: Use CPUIDLE_FLAG_TIMER_STOP
      ACPI: processor: Use CPUIDLE_FLAG_TLB_FLUSHED
      cpuidle: Allow cpuidle drivers to take over RCU-idle
      ACPI: processor: Take over RCU-idle for C3-BM idle

Ricardo Neri (1):
      powercap: RAPL: Add support for Lakefield

---------------

 arch/ia64/include/asm/acpi.h         |   2 -
 arch/x86/include/asm/acpi.h          |   2 -
 drivers/acpi/processor_idle.c        | 108 +++++++++++++++++++----------------
 drivers/cpuidle/cpuidle.c            |  15 +++--
 drivers/powercap/intel_rapl_common.c |   1 +
 include/linux/cpuidle.h              |   1 +
 6 files changed, 72 insertions(+), 57 deletions(-)
