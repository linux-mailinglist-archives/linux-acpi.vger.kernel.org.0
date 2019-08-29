Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94792A157A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2019 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfH2KKt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Aug 2019 06:10:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:24391 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbfH2KKs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Aug 2019 06:10:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 03:10:47 -0700
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; 
   d="scan'208";a="197773294"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 03:10:46 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 8FFBB20D81;
        Thu, 29 Aug 2019 13:10:40 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i3HO7-0006W0-KP; Thu, 29 Aug 2019 13:10:43 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 10/10] lib/test_printf: Add tests for %pfw printk modifier
Date:   Thu, 29 Aug 2019 13:10:43 +0300
Message-Id: <20190829101043.24963-11-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
References: <20190829101043.24963-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a test for the %pfw printk modifier using software nodes.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 lib/test_printf.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 944eb50f38625..9c6d716979fb1 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -22,6 +22,8 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
 
+#include <linux/property.h>
+
 #include "../tools/testing/selftests/kselftest_module.h"
 
 #define BUF_SIZE 256
@@ -588,6 +590,40 @@ flags(void)
 	kfree(cmp_buffer);
 }
 
+static void __init fwnode_pointer(void)
+{
+	const struct software_node softnodes[] = {
+		{ .name = "first", },
+		{ .name = "second", .parent = &softnodes[0], },
+		{ .name = "third", .parent = &softnodes[1], },
+		{ NULL /* Guardian */ },
+	};
+	const char * const full_name = "/second/third";
+	const char * const full_name_second = "/second";
+	const char * const second_name = "second";
+	const char * const third_name = "third";
+	int rval;
+
+	rval = software_node_register_nodes(softnodes);
+	if (rval) {
+		pr_warn("cannot register softnodes; rval %d\n", rval);
+		return;
+	}
+
+	test(full_name_second, "%pfw",
+	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
+	test(full_name, "%pfw",
+	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
+	test(full_name, "%pfwf",
+	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
+	test(second_name, "%pfwP",
+	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 3]));
+	test(third_name, "%pfwP",
+	     software_node_fwnode(&softnodes[ARRAY_SIZE(softnodes) - 2]));
+
+	software_node_unregister_nodes(softnodes);
+}
+
 static void __init
 test_pointer(void)
 {
@@ -610,6 +646,7 @@ test_pointer(void)
 	bitmap();
 	netdev_features();
 	flags();
+	fwnode_pointer();
 }
 
 static void __init selftest(void)
-- 
2.20.1

