Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CAFF3CB4
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 01:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfKHASY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 19:18:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38069 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfKHASQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 19:18:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id 15so2990413pgh.5;
        Thu, 07 Nov 2019 16:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RFrM/IahGbn36aeCNSBF2NbdB2UIEkSbp7j1U/R43X8=;
        b=vF9qL09Nc5VFyECrfx2/sutggpKwZRxb5vzvhEYLHuLdOjx3aVC9RH575LhqNTX8k6
         xUV++MKeUYwv1idw9qQh6ZsqXRWwFHWcUEDIAEwS/M2Ui2S22u+BSHvWh3M9VC0RY2lW
         tMOcHfnw0xj0VziFuwnuN9+DsRJ32aQ7Ywf5MQi0xcwLYkCkAxQz885XUjMUJDS0dn0s
         K74NlGvfBKQaQoKom+Jw3UKEPCHQNJ0VU8OGr4+iuoQzFq1a8oj4hEibrTpLhnwPUZX9
         E0qpZ1Fh4lVBSQgn1s5N2+dDdoVjEvfxvX5QPdKwMbTePS3+v8IwNsp7hijKoJvTZvFg
         WEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFrM/IahGbn36aeCNSBF2NbdB2UIEkSbp7j1U/R43X8=;
        b=nq/Gy/cUlNsvPbT2vvK5rDqzwPgXGa+aZAeA6pGm38HgzVb1R/KY6bxjh3EYCzUy/H
         sl47qMrpN3S5R8jBL2JHHjg0iPi8S3h8QpZXBQRHZEnIQv9n2i8hD7FuH/oKuXh0XKaW
         T2hssXmY9LC6jz4S6JhwzMoCJFOfInBZYQbgQDOdwXBc+2dJhAClE2MVKwxCwgNLbb2A
         lUKJnuEhUjqWbSQTSx73hu2pV25UoCuqmPnGnPggjy29o78NhfqX/0vSwDvY8C1fU099
         kX9iG+28R4nmE0HNIV58GIRcpHZM18WnGLU1mMyiwdxbJNQkwDYkCVbWPbIemN4hCSFy
         DWrQ==
X-Gm-Message-State: APjAAAWFDnSqZfE9RReqPl2LDqxaKyWSHW7HwRomQ7FBDwbFVOFbAQIc
        VJSd+5FbTknKreKlPenTLtM=
X-Google-Smtp-Source: APXvYqyuEbXnFkngCDNfkfHDVosVsyKpIs9kq6iPrcvoyP97dZ+2NdtDJbtaSOizO2TXFemeUjEzmw==
X-Received: by 2002:a17:902:441:: with SMTP id 59mr7033736ple.300.1573172295178;
        Thu, 07 Nov 2019 16:18:15 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m68sm3688764pfb.122.2019.11.07.16.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 16:18:14 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v7 6/6] software node: add basic tests for property entries
Date:   Thu,  7 Nov 2019 16:18:03 -0800
Message-Id: <20191108001803.191541-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191108001803.191541-1-dmitry.torokhov@gmail.com>
References: <20191108001803.191541-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This adds tests for creating software nodes with properties supplied by
PROPERTY_ENTRY_XXX() macros and fetching and validating data from said
nodes/properties.

We are using KUnit framework for the tests.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/test/Makefile              |   2 +
 drivers/base/test/property-entry-test.c | 472 ++++++++++++++++++++++++
 2 files changed, 474 insertions(+)
 create mode 100644 drivers/base/test/property-entry-test.c

diff --git a/drivers/base/test/Makefile b/drivers/base/test/Makefile
index 0f1f7277a0139..22143102e5d21 100644
--- a/drivers/base/test/Makefile
+++ b/drivers/base/test/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TEST_ASYNC_DRIVER_PROBE)	+= test_async_driver_probe.o
+
+obj-$(CONFIG_KUNIT) += property-entry-test.o
diff --git a/drivers/base/test/property-entry-test.c b/drivers/base/test/property-entry-test.c
new file mode 100644
index 0000000000000..d6ac84c8ebd06
--- /dev/null
+++ b/drivers/base/test/property-entry-test.c
@@ -0,0 +1,472 @@
+// SPDX-License-Identifier: GPL-2.0
+// Unit tests for property entries API
+//
+// Copyright 2019 Google LLC.
+
+#include <kunit/test.h>
+#include <linux/property.h>
+#include <linux/types.h>
+
+static void pe_test_uints(struct kunit *test)
+{
+	const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U8("prop-u8", 8),
+		PROPERTY_ENTRY_U16("prop-u16", 16),
+		PROPERTY_ENTRY_U32("prop-u32", 32),
+		PROPERTY_ENTRY_U64("prop-u64", 64),
+		{ }
+	};
+
+	struct fwnode_handle *node;
+	u8 val_u8, array_u8[2];
+	u16 val_u16, array_u16[2];
+	u32 val_u32, array_u32[2];
+	u64 val_u64, array_u64[2];
+	int error;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	error = fwnode_property_read_u8(node, "prop-u8", &val_u8);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)val_u8, 8);
+
+	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 1);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)array_u8[0], 8);
+
+	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 2);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u8(node, "no-prop-u8", &val_u8);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u8_array(node, "no-prop-u8", array_u8, 1);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u16(node, "prop-u16", &val_u16);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)val_u16, 16);
+
+	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 1);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)array_u16[0], 16);
+
+	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 2);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u16(node, "no-prop-u16", &val_u16);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u16_array(node, "no-prop-u16", array_u16, 1);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u32(node, "prop-u32", &val_u32);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)val_u32, 32);
+
+	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 1);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)array_u32[0], 32);
+
+	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 2);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u32(node, "no-prop-u32", &val_u32);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u32_array(node, "no-prop-u32", array_u32, 1);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u64(node, "prop-u64", &val_u64);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)val_u64, 64);
+
+	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 1);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)array_u64[0], 64);
+
+	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 2);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u64(node, "no-prop-u64", &val_u64);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u64_array(node, "no-prop-u64", array_u64, 1);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	fwnode_remove_software_node(node);
+}
+
+static void pe_test_uint_arrays(struct kunit *test)
+{
+	u8 a_u8[16] = { 8, 9 };
+	u16 a_u16[16] = { 16, 17 };
+	u32 a_u32[16] = { 32, 33 };
+	u64 a_u64[16] = { 64, 65 };
+	const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U8_ARRAY("prop-u8", a_u8),
+		PROPERTY_ENTRY_U16_ARRAY("prop-u16", a_u16),
+		PROPERTY_ENTRY_U32_ARRAY("prop-u32", a_u32),
+		PROPERTY_ENTRY_U64_ARRAY("prop-u64", a_u64),
+		{ }
+	};
+
+	struct fwnode_handle *node;
+	u8 val_u8, array_u8[32];
+	u16 val_u16, array_u16[32];
+	u32 val_u32, array_u32[32];
+	u64 val_u64, array_u64[32];
+	int error;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	error = fwnode_property_read_u8(node, "prop-u8", &val_u8);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)val_u8, 8);
+
+	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 1);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)array_u8[0], 8);
+
+	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 2);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)array_u8[0], 8);
+	KUNIT_EXPECT_EQ(test, (int)array_u8[1], 9);
+
+	error = fwnode_property_read_u8_array(node, "prop-u8", array_u8, 17);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u8(node, "no-prop-u8", &val_u8);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u8_array(node, "no-prop-u8", array_u8, 1);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u16(node, "prop-u16", &val_u16);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)val_u16, 16);
+
+	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 1);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)array_u16[0], 16);
+
+	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 2);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)array_u16[0], 16);
+	KUNIT_EXPECT_EQ(test, (int)array_u16[1], 17);
+
+	error = fwnode_property_read_u16_array(node, "prop-u16", array_u16, 17);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u16(node, "no-prop-u16", &val_u16);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u16_array(node, "no-prop-u16", array_u16, 1);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u32(node, "prop-u32", &val_u32);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)val_u32, 32);
+
+	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 1);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)array_u32[0], 32);
+
+	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 2);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)array_u32[0], 32);
+	KUNIT_EXPECT_EQ(test, (int)array_u32[1], 33);
+
+	error = fwnode_property_read_u32_array(node, "prop-u32", array_u32, 17);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u32(node, "no-prop-u32", &val_u32);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u32_array(node, "no-prop-u32", array_u32, 1);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u64(node, "prop-u64", &val_u64);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)val_u64, 64);
+
+	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 1);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)array_u64[0], 64);
+
+	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 2);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_EQ(test, (int)array_u64[0], 64);
+	KUNIT_EXPECT_EQ(test, (int)array_u64[1], 65);
+
+	error = fwnode_property_read_u64_array(node, "prop-u64", array_u64, 17);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u64(node, "no-prop-u64", &val_u64);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_u64_array(node, "no-prop-u64", array_u64, 1);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	fwnode_remove_software_node(node);
+}
+
+static void pe_test_strings(struct kunit *test)
+{
+	const char *strings[] = {
+		"string-a",
+		"string-b",
+	};
+
+	const struct property_entry entries[] = {
+		PROPERTY_ENTRY_STRING("str", "single"),
+		PROPERTY_ENTRY_STRING("empty", ""),
+		PROPERTY_ENTRY_STRING_ARRAY("strs", strings),
+		{ }
+	};
+
+	struct fwnode_handle *node;
+	const char *str;
+	const char *strs[10];
+	int error;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	error = fwnode_property_read_string(node, "str", &str);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_STREQ(test, str, "single");
+
+	error = fwnode_property_read_string_array(node, "str", strs, 1);
+	KUNIT_EXPECT_EQ(test, error, 1);
+	KUNIT_EXPECT_STREQ(test, strs[0], "single");
+
+	/* asking for more data returns what we have */
+	error = fwnode_property_read_string_array(node, "str", strs, 2);
+	KUNIT_EXPECT_EQ(test, error, 1);
+	KUNIT_EXPECT_STREQ(test, strs[0], "single");
+
+	error = fwnode_property_read_string(node, "no-str", &str);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_read_string_array(node, "no-str", strs, 1);
+	KUNIT_EXPECT_LT(test, error, 0);
+
+	error = fwnode_property_read_string(node, "empty", &str);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_STREQ(test, str, "");
+
+	error = fwnode_property_read_string_array(node, "strs", strs, 3);
+	KUNIT_EXPECT_EQ(test, error, 2);
+	KUNIT_EXPECT_STREQ(test, strs[0], "string-a");
+	KUNIT_EXPECT_STREQ(test, strs[1], "string-b");
+
+	error = fwnode_property_read_string_array(node, "strs", strs, 1);
+	KUNIT_EXPECT_EQ(test, error, 1);
+	KUNIT_EXPECT_STREQ(test, strs[0], "string-a");
+
+	/* NULL argument -> returns size */
+	error = fwnode_property_read_string_array(node, "strs", NULL, 0);
+	KUNIT_EXPECT_EQ(test, error, 2);
+
+	/* accessing array as single value */
+	error = fwnode_property_read_string(node, "strs", &str);
+	KUNIT_EXPECT_EQ(test, error, 0);
+	KUNIT_EXPECT_STREQ(test, str, "string-a");
+
+	fwnode_remove_software_node(node);
+}
+
+static void pe_test_bool(struct kunit *test)
+{
+	const struct property_entry entries[] = {
+		PROPERTY_ENTRY_BOOL("prop"),
+		{ }
+	};
+
+	struct fwnode_handle *node;
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	KUNIT_EXPECT_TRUE(test, fwnode_property_read_bool(node, "prop"));
+	KUNIT_EXPECT_FALSE(test, fwnode_property_read_bool(node, "not-prop"));
+
+	fwnode_remove_software_node(node);
+}
+
+/* Verifies that small U8 array is stored inline when property is copied */
+static void pe_test_move_inline_u8(struct kunit *test)
+{
+	u8 u8_array_small[8] = { 1, 2, 3, 4 };
+	u8 u8_array_big[128] = { 5, 6, 7, 8 };
+	struct property_entry entries[] = {
+		PROPERTY_ENTRY_U8_ARRAY("small", u8_array_small),
+		PROPERTY_ENTRY_U8_ARRAY("big", u8_array_big),
+		{ }
+	};
+	struct property_entry *copy;
+	const u8 *data_ptr;
+
+	copy = property_entries_dup(entries);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, copy);
+
+	KUNIT_EXPECT_TRUE(test, copy[0].is_inline);
+	data_ptr = (u8 *)&copy[0].value;
+	KUNIT_EXPECT_EQ(test, (int)data_ptr[0], 1);
+	KUNIT_EXPECT_EQ(test, (int)data_ptr[1], 2);
+
+	KUNIT_EXPECT_FALSE(test, copy[1].is_inline);
+	data_ptr = copy[1].pointer;
+	KUNIT_EXPECT_EQ(test, (int)data_ptr[0], 5);
+	KUNIT_EXPECT_EQ(test, (int)data_ptr[1], 6);
+
+	property_entries_free(copy);
+}
+
+/* Verifies that single string array is stored inline when property is copied */
+static void pe_test_move_inline_str(struct kunit *test)
+{
+	char *str_array_small[] = { "a" };
+	char *str_array_big[] = { "b", "c", "d", "e" };
+	char *str_array_small_empty[] = { "" };
+	struct property_entry entries[] = {
+		PROPERTY_ENTRY_STRING_ARRAY("small", str_array_small),
+		PROPERTY_ENTRY_STRING_ARRAY("big", str_array_big),
+		PROPERTY_ENTRY_STRING_ARRAY("small-empty", str_array_small_empty),
+		{ }
+	};
+	struct property_entry *copy;
+	const char * const *data_ptr;
+
+	copy = property_entries_dup(entries);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, copy);
+
+	KUNIT_EXPECT_TRUE(test, copy[0].is_inline);
+	KUNIT_EXPECT_STREQ(test, copy[0].value.str, "a");
+
+	KUNIT_EXPECT_FALSE(test, copy[1].is_inline);
+	data_ptr = copy[1].pointer;
+	KUNIT_EXPECT_STREQ(test, data_ptr[0], "b");
+	KUNIT_EXPECT_STREQ(test, data_ptr[1], "c");
+
+	KUNIT_EXPECT_TRUE(test, copy[2].is_inline);
+	KUNIT_EXPECT_STREQ(test, copy[2].value.str, "");
+
+	property_entries_free(copy);
+}
+
+/* Handling of reference properties */
+static void pe_test_reference(struct kunit *test)
+{
+	const struct software_node nodes[] = {
+		{ .name = "1", },
+		{ .name = "2", },
+	};
+
+	const struct software_node_ref_args refs[] = {
+		{
+			.node = &nodes[0],
+			.nargs = 0,
+		},
+		{
+			.node = &nodes[1],
+			.nargs = 2,
+			.args = { 3, 4 },
+		},
+	};
+
+	const struct property_entry entries[] = {
+		PROPERTY_ENTRY_REF("ref-1", &nodes[0]),
+		PROPERTY_ENTRY_REF("ref-2", &nodes[1], 1, 2),
+		PROPERTY_ENTRY_REF_ARRAY("ref-3", refs),
+		{ }
+	};
+
+	struct fwnode_handle *node;
+	struct fwnode_reference_args ref;
+	int error;
+
+	error = software_node_register_nodes(nodes);
+	KUNIT_ASSERT_EQ(test, error, 0);
+
+	node = fwnode_create_software_node(entries, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);
+
+	error = fwnode_property_get_reference_args(node, "ref-1", NULL,
+						   0, 0, &ref);
+	KUNIT_ASSERT_EQ(test, error, 0);
+	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[0]);
+	KUNIT_EXPECT_EQ(test, ref.nargs, 0U);
+
+	/* wrong index */
+	error = fwnode_property_get_reference_args(node, "ref-1", NULL,
+						   0, 1, &ref);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	error = fwnode_property_get_reference_args(node, "ref-2", NULL,
+						   1, 0, &ref);
+	KUNIT_ASSERT_EQ(test, error, 0);
+	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[1]);
+	KUNIT_EXPECT_EQ(test, ref.nargs, 1U);
+	KUNIT_EXPECT_EQ(test, ref.args[0], 1LLU);
+
+	/* asking for more args, padded with zero data */
+	error = fwnode_property_get_reference_args(node, "ref-2", NULL,
+						   3, 0, &ref);
+	KUNIT_ASSERT_EQ(test, error, 0);
+	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[1]);
+	KUNIT_EXPECT_EQ(test, ref.nargs, 3U);
+	KUNIT_EXPECT_EQ(test, ref.args[0], 1LLU);
+	KUNIT_EXPECT_EQ(test, ref.args[1], 2LLU);
+	KUNIT_EXPECT_EQ(test, ref.args[2], 0LLU);
+
+	/* wrong index */
+	error = fwnode_property_get_reference_args(node, "ref-2", NULL,
+						   2, 1, &ref);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	/* array of references */
+	error = fwnode_property_get_reference_args(node, "ref-3", NULL,
+						   0, 0, &ref);
+	KUNIT_ASSERT_EQ(test, error, 0);
+	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[0]);
+	KUNIT_EXPECT_EQ(test, ref.nargs, 0U);
+
+	/* second reference in the array */
+	error = fwnode_property_get_reference_args(node, "ref-3", NULL,
+						   2, 1, &ref);
+	KUNIT_ASSERT_EQ(test, error, 0);
+	KUNIT_EXPECT_PTR_EQ(test, to_software_node(ref.fwnode), &nodes[1]);
+	KUNIT_EXPECT_EQ(test, ref.nargs, 2U);
+	KUNIT_EXPECT_EQ(test, ref.args[0], 3LLU);
+	KUNIT_EXPECT_EQ(test, ref.args[1], 4LLU);
+
+	/* wrong index */
+	error = fwnode_property_get_reference_args(node, "ref-1", NULL,
+						   0, 2, &ref);
+	KUNIT_EXPECT_NE(test, error, 0);
+
+	fwnode_remove_software_node(node);
+	software_node_unregister_nodes(nodes);
+}
+
+static struct kunit_case property_entry_test_cases[] = {
+	KUNIT_CASE(pe_test_uints),
+	KUNIT_CASE(pe_test_uint_arrays),
+	KUNIT_CASE(pe_test_strings),
+	KUNIT_CASE(pe_test_bool),
+	KUNIT_CASE(pe_test_move_inline_u8),
+	KUNIT_CASE(pe_test_move_inline_str),
+	KUNIT_CASE(pe_test_reference),
+	{ }
+};
+
+static struct kunit_suite property_entry_test_suite = {
+	.name = "property-entry",
+	.test_cases = property_entry_test_cases,
+};
+
+kunit_test_suite(property_entry_test_suite);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

