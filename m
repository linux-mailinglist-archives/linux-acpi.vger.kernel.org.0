Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683CEB648E
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2019 15:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbfIRNeO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Sep 2019 09:34:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:61804 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbfIRNeN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Sep 2019 09:34:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 06:34:12 -0700
X-IronPort-AV: E=Sophos;i="5.64,520,1559545200"; 
   d="scan'208";a="199046230"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 06:34:10 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id A2302212B4;
        Wed, 18 Sep 2019 16:34:00 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1iAa69-000265-6P; Wed, 18 Sep 2019 16:34:21 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v7 13/13] lib/test_printf: Add tests for %pfw printk modifier
Date:   Wed, 18 Sep 2019 16:34:19 +0300
Message-Id: <20190918133419.7969-14-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
References: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a test for the %pfw printk modifier using software nodes.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_printf.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 944eb50f38625..bb6a7d334084b 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -22,6 +22,8 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
 
+#include <linux/property.h>
+
 #include "../tools/testing/selftests/kselftest_module.h"
 
 #define BUF_SIZE 256
@@ -588,6 +590,35 @@ flags(void)
 	kfree(cmp_buffer);
 }
 
+static void __init fwnode_pointer(void)
+{
+	const struct software_node softnodes[] = {
+		{ .name = "first", },
+		{ .name = "second", .parent = &softnodes[0], },
+		{ .name = "third", .parent = &softnodes[1], },
+		{ NULL /* Guardian */ }
+	};
+	const char * const full_name = "first/second/third";
+	const char * const full_name_second = "first/second";
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
+	test(full_name_second, "%pfw", software_node_fwnode(&softnodes[1]));
+	test(full_name, "%pfw", software_node_fwnode(&softnodes[2]));
+	test(full_name, "%pfwf", software_node_fwnode(&softnodes[2]));
+	test(second_name, "%pfwP", software_node_fwnode(&softnodes[1]));
+	test(third_name, "%pfwP", software_node_fwnode(&softnodes[2]));
+
+	software_node_unregister_nodes(softnodes);
+}
+
 static void __init
 test_pointer(void)
 {
@@ -610,6 +641,7 @@ test_pointer(void)
 	bitmap();
 	netdev_features();
 	flags();
+	fwnode_pointer();
 }
 
 static void __init selftest(void)
-- 
2.20.1

