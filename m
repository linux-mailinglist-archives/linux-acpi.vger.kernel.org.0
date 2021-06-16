Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4169D3AA20D
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 19:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhFPRF4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 13:05:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:16774 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhFPRFs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 13:05:48 -0400
IronPort-SDR: 1duNbgzm0SglgN5aMKdzU26IefBwuGA08ZOE7VAC7MxyihZnFppMPcaycjpUbqSc1KT3PtFXAh
 fT1gyC0DOSvg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="193340152"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="193340152"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 10:03:33 -0700
IronPort-SDR: NsXH8bBHoq5LGBySL4CA7URPewhSFECNvRvI9t3nN5MiZJ7oPSHMd6iujIfd1cwvqDMUosKUuO
 6bY6bK/9OZvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="479167399"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2021 10:03:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 29F5F2DA; Wed, 16 Jun 2021 20:03:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 2/7] ACPI: sysfs: Allow bitmap list to be supplied to acpi_mask_gpe
Date:   Wed, 16 Jun 2021 20:03:33 +0300
Message-Id: <20210616170338.23057-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
References: <20210616170338.23057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently we need to use as many acpi_mask_gpe options as we want to have
GPEs to be masked. Even with two it already becomes inconveniently large
the kernel command line.

Instead, allow acpi_mask_gpe to represent bitmap list.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 drivers/acpi/sysfs.c                            | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a06a8bfb02a4..c00792362d28 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -113,7 +113,7 @@
 			the GPE dispatcher.
 			This facility can be used to prevent such uncontrolled
 			GPE floodings.
-			Format: <byte>
+			Format: <byte> or <bitmap-list>
 
 	acpi_no_auto_serialize	[HW,ACPI]
 			Disable auto-serialization of AML methods
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 767aa65e4bdd..44e50c36e70a 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt) "ACPI: " fmt
 
+#include <linux/bitmap.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
@@ -794,6 +795,7 @@ static ssize_t counter_set(struct kobject *kobj,
  * the GPE flooding for GPE 00, they need to specify the following boot
  * parameter:
  *   acpi_mask_gpe=0x00
+ * Note, the parameter can be a list (see bitmap_parselist() for the details).
  * The masking status can be modified by the following runtime controlling
  * interface:
  *   echo unmask > /sys/firmware/acpi/interrupts/gpe00
@@ -803,11 +805,16 @@ static DECLARE_BITMAP(acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) __initdata;
 
 static int __init acpi_gpe_set_masked_gpes(char *val)
 {
+	int ret;
 	u8 gpe;
 
-	if (kstrtou8(val, 0, &gpe))
-		return -EINVAL;
-	set_bit(gpe, acpi_masked_gpes_map);
+	ret = kstrtou8(val, 0, &gpe);
+	if (ret) {
+		ret = bitmap_parselist(val, acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX);
+		if (ret)
+			return ret;
+	} else
+		set_bit(gpe, acpi_masked_gpes_map);
 
 	return 1;
 }
-- 
2.30.2

