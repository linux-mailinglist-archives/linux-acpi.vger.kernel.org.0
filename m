Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487C044C004
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Nov 2021 12:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhKJLTc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Nov 2021 06:19:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:59937 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhKJLTc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Nov 2021 06:19:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="256340017"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="256340017"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 03:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="534016057"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Nov 2021 03:16:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 62DC118E; Wed, 10 Nov 2021 13:16:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 1/1] ACPI: Replace kernel.h with the necessary inclusions
Date:   Wed, 10 Nov 2021 13:16:40 +0200
Message-Id: <20211110111640.62807-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/acpi/acpi_numa.h | 1 -
 include/acpi/processor.h | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index 68e4d80c1b32..b5f594754a9e 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -3,7 +3,6 @@
 #define __ACPI_NUMA_H
 
 #ifdef CONFIG_ACPI_NUMA
-#include <linux/kernel.h>
 #include <linux/numa.h>
 
 /* Proximity bitmap length */
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 683e124ad517..194027371928 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -2,11 +2,16 @@
 #ifndef __ACPI_PROCESSOR_H
 #define __ACPI_PROCESSOR_H
 
-#include <linux/kernel.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/pm_qos.h>
+#include <linux/printk.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
 #include <linux/thermal.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
 #include <asm/acpi.h>
 
 #define ACPI_PROCESSOR_CLASS		"processor"
-- 
2.33.0

