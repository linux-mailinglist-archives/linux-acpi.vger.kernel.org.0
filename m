Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CBB30316D
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 02:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbhAZBZT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 20:25:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:16614 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731998AbhAYTlw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:41:52 -0500
IronPort-SDR: bzPt1bODTRUitduzaTYXnovNVKeghXJWJmEFWmTOzHj4wnvuxf9nACZ0fGpj/ofRzOsBH+nqXq
 h3H8aNvL/msw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="243868346"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="243868346"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:39:55 -0800
IronPort-SDR: dvFDP12JTV0dhALIPwoSQO4M9HlSKXVyC0jRF1jlgjB6qc8Qqr3Q9+7J9AccBMG2Q1KZqOHNqK
 G9DPkCkQgAeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="350410868"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jan 2021 11:39:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 77C79143; Mon, 25 Jan 2021 21:39:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 00/10] mfd, x86: remove msic driver and leftovers
Date:   Mon, 25 Jan 2021 21:39:38 +0200
Message-Id: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a second part of the Intel MID outdated platforms removal.
First part is available as immutable branch [1]. The series has functional
and build dependencies, so the mentioned branch should be used as a base
for these changes.

Note, that some of the drivers, that arch/x86 covers, seems never appeared
in the upstream (like msic_ocd).

There few ways are possible to proceed with this:
- extend existing immutable branch
- create another one based on MFD
- merge everything thru tip tree

I'm also all ears for alternatives.

The entire branch with all patches is available here [2].

Rafael, can you please help reviewing arch/x86 related code?

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=intel-mid-removal
[2]: https://gitlab.com/andy-shev/next/-/tree/topic/mid-removal-next

Andy Shevchenko (10):
  x86/platform/intel-mid: Remove unused leftovers (msic_audio)
  x86/platform/intel-mid: Remove unused leftovers (msic_ocd)
  x86/platform/intel-mid: Remove unused leftovers (msic_battery)
  x86/platform/intel-mid: Remove unused leftovers (msic_gpio)
  x86/platform/intel-mid: Remove unused leftovers (msic_power_btn)
  x86/platform/intel-mid: Remove unused leftovers (msic_thermal)
  x86/platform/intel-mid: Remove unused leftovers (msic)
  x86/platform/intel-mid: Remove unused leftovers (vRTC)
  x86/apb_timer: Remove driver for deprecated platform
  mfd: intel_msic: Remove driver for deprecated platform

 .../admin-guide/kernel-parameters.txt         |   6 -
 MAINTAINERS                                   |   2 -
 arch/x86/Kconfig                              |  12 -
 arch/x86/include/asm/apb_timer.h              |  40 --
 arch/x86/include/asm/fixmap.h                 |   3 -
 arch/x86/include/asm/intel-mid.h              |  28 --
 arch/x86/include/asm/intel_mid_vrtc.h         |  10 -
 arch/x86/include/asm/intel_scu_ipc_legacy.h   |  17 -
 arch/x86/kernel/Makefile                      |   1 -
 arch/x86/kernel/apb_timer.c                   | 347 --------------
 arch/x86/platform/intel-mid/Makefile          |   2 +-
 .../platform/intel-mid/device_libs/Makefile   |   9 -
 .../device_libs/platform_mrfld_power_btn.c    |  78 ---
 .../intel-mid/device_libs/platform_msic.c     |  83 ----
 .../intel-mid/device_libs/platform_msic.h     |  15 -
 .../device_libs/platform_msic_audio.c         |  42 --
 .../device_libs/platform_msic_battery.c       |  32 --
 .../device_libs/platform_msic_gpio.c          |  43 --
 .../intel-mid/device_libs/platform_msic_ocd.c |  44 --
 .../device_libs/platform_msic_power_btn.c     |  31 --
 .../device_libs/platform_msic_thermal.c       |  32 --
 arch/x86/platform/intel-mid/intel-mid.c       |  79 +--
 arch/x86/platform/intel-mid/intel_mid_vrtc.c  | 173 -------
 arch/x86/platform/intel-mid/sfi.c             | 124 -----
 drivers/mfd/Kconfig                           |   9 -
 drivers/mfd/Makefile                          |   1 -
 drivers/mfd/intel_msic.c                      | 425 ----------------
 include/linux/mfd/intel_msic.h                | 453 ------------------
 28 files changed, 4 insertions(+), 2137 deletions(-)
 delete mode 100644 arch/x86/include/asm/apb_timer.h
 delete mode 100644 arch/x86/include/asm/intel_mid_vrtc.h
 delete mode 100644 arch/x86/kernel/apb_timer.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_power_btn.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic.h
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic_audio.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic_battery.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic_gpio.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic_ocd.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic_power_btn.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic_thermal.c
 delete mode 100644 arch/x86/platform/intel-mid/intel_mid_vrtc.c
 delete mode 100644 drivers/mfd/intel_msic.c
 delete mode 100644 include/linux/mfd/intel_msic.h

-- 
2.29.2

