Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D29A51A8
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 10:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfIBIcp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 04:32:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:64395 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730446AbfIBIco (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 04:32:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 01:32:43 -0700
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="333504272"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 01:32:41 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 3849D21057;
        Mon,  2 Sep 2019 11:32:34 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i4hlQ-0005Jw-Ky; Mon, 02 Sep 2019 11:32:40 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v4 11/11] lib/test_printf: Add tests for %pfw printk modifier
Date:   Mon,  2 Sep 2019 11:32:40 +0300
Message-Id: <20190902083240.20367-12-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
References: <20190902083240.20367-1-sakari.ailus@linux.intel.com>
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

