Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6A83E2CE2
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Aug 2021 16:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242203AbhHFOoS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Aug 2021 10:44:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:45748 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241632AbhHFOoP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Aug 2021 10:44:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10068"; a="193974201"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="193974201"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 07:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="459389331"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 06 Aug 2021 07:43:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B11EDE; Fri,  6 Aug 2021 17:37:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        hdegoede@redhat.com, Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] x86/platform: Increase maximum GPIO number for X86_64
Date:   Fri,  6 Aug 2021 17:37:11 +0300
Message-Id: <20210806143711.37553-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

By default the 512 GPIOs is a maximum on any x86 platform.
With, for example, Intel Tiger Lake-H the SoC based controller
occupies up to 480 pins. This leaves only 32 available for
GPIO expanders or other drivers, like PMIC. Hence, bump the
maximum GPIO number to 1024 for X86_64 and leave 512 for X86_32.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 45962aaf2b2c..495ed6229b52 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -340,6 +340,19 @@ config NEED_PER_CPU_PAGE_FIRST_CHUNK
 config ARCH_HIBERNATION_POSSIBLE
 	def_bool y
 
+# The GPIO number here must be sorted by descending number. In case of
+# a multiplatform kernel, we just want the highest value required by the
+# selected platforms.
+config ARCH_NR_GPIO
+	int
+	default 1024 if X86_64
+	default 512 if X86_32
+	default 0
+	help
+	  Maximum number of GPIOs in the system.
+
+	  If unsure, leave the default value.
+
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
-- 
2.30.2

