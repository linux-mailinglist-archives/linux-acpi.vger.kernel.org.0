Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DDB2A58C7
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 22:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgKCVyq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 16:54:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:63005 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730990AbgKCUpQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Nov 2020 15:45:16 -0500
IronPort-SDR: MgCmqan+hU+dA8ZYVrAsh5nxCtbz9ws7nf+fiNNxtIA7wRvE47lf0o46pmGYzNc/82omTMstW0
 SHwIZDvhQE/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="253834718"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="253834718"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 12:45:15 -0800
IronPort-SDR: 8/sg97pPxikmAU5eP3azEzXQ+U/4krUTgkxdsdk+aqQ/W7WZJBiIANP/uhvaOwtfK5MsSdxTnl
 qyGzGmoM7tpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="336641271"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 03 Nov 2020 12:45:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 00899646; Tue,  3 Nov 2020 22:45:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 5/7] resource: Add test cases for new resource API
Date:   Tue,  3 Nov 2020 22:45:08 +0200
Message-Id: <20201103204510.19154-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
References: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add test cases for newly added resource APIs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/Makefile         |   1 +
 kernel/resource_kunit.c | 150 ++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug       |  11 +++
 3 files changed, 162 insertions(+)
 create mode 100644 kernel/resource_kunit.c

diff --git a/kernel/Makefile b/kernel/Makefile
index af601b9bda0e..aac15aeb9d69 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_HAS_IOMEM) += iomem.o
 obj-$(CONFIG_RSEQ) += rseq.o
 obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
 
+obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
 CFLAGS_stackleak.o += $(DISABLE_STACKLEAK_PLUGIN)
diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
new file mode 100644
index 000000000000..9fdbca8426f1
--- /dev/null
+++ b/kernel/resource_kunit.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test cases for API provided by resource.c and ioport.h
+ */
+
+#include <kunit/test.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#define R0_START	0x0000
+#define R0_END		0xffff
+#define R1_START	0x1234
+#define R1_END		0x2345
+#define R2_START	0x4567
+#define R2_END		0x5678
+#define R3_START	0x6789
+#define R3_END		0x789a
+#define R4_START	0x2000
+#define R4_END		0x7000
+
+static struct resource r0 = { .start = R0_START, .end = R0_END };
+static struct resource r1 = { .start = R1_START, .end = R1_END };
+static struct resource r2 = { .start = R2_START, .end = R2_END };
+static struct resource r3 = { .start = R3_START, .end = R3_END };
+static struct resource r4 = { .start = R4_START, .end = R4_END };
+
+struct result {
+	struct resource *r1;
+	struct resource *r2;
+	struct resource r;
+	bool ret;
+};
+
+static struct result results_for_union[] = {
+	{
+		.r1 = &r1, .r2 = &r0, .r.start = R0_START, .r.end = R0_END, .ret = true,
+	}, {
+		.r1 = &r2, .r2 = &r0, .r.start = R0_START, .r.end = R0_END, .ret = true,
+	}, {
+		.r1 = &r3, .r2 = &r0, .r.start = R0_START, .r.end = R0_END, .ret = true,
+	}, {
+		.r1 = &r4, .r2 = &r0, .r.start = R0_START, .r.end = R0_END, .ret = true,
+	}, {
+		.r1 = &r2, .r2 = &r1, .ret = false,
+	}, {
+		.r1 = &r3, .r2 = &r1, .ret = false,
+	}, {
+		.r1 = &r4, .r2 = &r1, .r.start = R1_START, .r.end = R4_END, .ret = true,
+	}, {
+		.r1 = &r2, .r2 = &r3, .ret = false,
+	}, {
+		.r1 = &r2, .r2 = &r4, .r.start = R4_START, .r.end = R4_END, .ret = true,
+	}, {
+		.r1 = &r3, .r2 = &r4, .r.start = R4_START, .r.end = R3_END, .ret = true,
+	},
+};
+
+static struct result results_for_intersection[] = {
+	{
+		.r1 = &r1, .r2 = &r0, .r.start = R1_START, .r.end = R1_END, .ret = true,
+	}, {
+		.r1 = &r2, .r2 = &r0, .r.start = R2_START, .r.end = R2_END, .ret = true,
+	}, {
+		.r1 = &r3, .r2 = &r0, .r.start = R3_START, .r.end = R3_END, .ret = true,
+	}, {
+		.r1 = &r4, .r2 = &r0, .r.start = R4_START, .r.end = R4_END, .ret = true,
+	}, {
+		.r1 = &r2, .r2 = &r1, .ret = false,
+	}, {
+		.r1 = &r3, .r2 = &r1, .ret = false,
+	}, {
+		.r1 = &r4, .r2 = &r1, .r.start = R4_START, .r.end = R1_END, .ret = true,
+	}, {
+		.r1 = &r2, .r2 = &r3, .ret = false,
+	}, {
+		.r1 = &r2, .r2 = &r4, .r.start = R2_START, .r.end = R2_END, .ret = true,
+	}, {
+		.r1 = &r3, .r2 = &r4, .r.start = R3_START, .r.end = R4_END, .ret = true,
+	},
+};
+
+static void resource_do_test(struct kunit *test, bool ret, struct resource *r,
+			     bool exp_ret, struct resource *exp_r,
+			     struct resource *r1, struct resource *r2)
+{
+	KUNIT_EXPECT_EQ_MSG(test, ret, exp_ret, "Resources %pR %pR", r1, r2);
+	KUNIT_EXPECT_EQ_MSG(test, r->start, exp_r->start, "Start elements are not equal");
+	KUNIT_EXPECT_EQ_MSG(test, r->end, exp_r->end, "End elements are not equal");
+}
+
+static void resource_do_union_test(struct kunit *test, struct result *r)
+{
+	struct resource result;
+	bool ret;
+
+	memset(&result, 0, sizeof(result));
+	ret = resource_union(r->r1, r->r2, &result);
+	resource_do_test(test, ret, &result, r->ret, &r->r, r->r1, r->r2);
+
+	memset(&result, 0, sizeof(result));
+	ret = resource_union(r->r2, r->r1, &result);
+	resource_do_test(test, ret, &result, r->ret, &r->r, r->r2, r->r1);
+}
+
+static void resource_test_union(struct kunit *test)
+{
+	struct result *r = results_for_union;
+	unsigned int i = 0;
+
+	do {
+		resource_do_union_test(test, &r[i]);
+	} while (++i < ARRAY_SIZE(results_for_union));
+}
+
+static void resource_do_intersection_test(struct kunit *test, struct result *r)
+{
+	struct resource result;
+	bool ret;
+
+	memset(&result, 0, sizeof(result));
+	ret = resource_intersection(r->r1, r->r2, &result);
+	resource_do_test(test, ret, &result, r->ret, &r->r, r->r1, r->r2);
+
+	memset(&result, 0, sizeof(result));
+	ret = resource_intersection(r->r2, r->r1, &result);
+	resource_do_test(test, ret, &result, r->ret, &r->r, r->r2, r->r1);
+}
+
+static void resource_test_intersection(struct kunit *test)
+{
+	struct result *r = results_for_intersection;
+	unsigned int i = 0;
+
+	do {
+		resource_do_intersection_test(test, &r[i]);
+	} while (++i < ARRAY_SIZE(results_for_intersection));
+}
+
+static struct kunit_case resource_test_cases[] = {
+	KUNIT_CASE(resource_test_union),
+	KUNIT_CASE(resource_test_intersection),
+	{}
+};
+
+static struct kunit_suite resource_test_suite = {
+	.name = "resource",
+	.test_cases = resource_test_cases,
+};
+kunit_test_suite(resource_test_suite);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8596989423bf..663e7238a56e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2232,6 +2232,17 @@ config BITFIELD_KUNIT
 
 	  If unsure, say N.
 
+config RESOURCE_KUNIT_TEST
+	tristate "KUnit test for resource API"
+	depends on KUNIT
+	help
+	  This builds the resource API unit test.
+	  Tests the logic of API provided by resource.c and ioport.h.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config SYSCTL_KUNIT_TEST
 	tristate "KUnit test for sysctl" if !KUNIT_ALL_TESTS
 	depends on KUNIT
-- 
2.28.0

