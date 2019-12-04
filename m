Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE8F3113537
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2019 19:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfLDSxU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Dec 2019 13:53:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37607 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbfLDSxT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2019 13:53:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id bb5so102367plb.4;
        Wed, 04 Dec 2019 10:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Po76AoNWrbgIrG3+om+uizQjbxbVSsHyU3gBTRqZNEI=;
        b=nF3B5YYGu88fCEo+4eTpIUR2SANXvxG6ncdWx23kf/Pb9x6EAKH9BVRirzQ2p9AGkH
         RCc4dIacV5cIsPgagJUl4ZmlHy1xdJ31PXNoivV78F0//9vpHUztNySRxow4nSczq/2T
         2h+UxaK0LiCFC4TnroelFxTndbE6lwyOjwk0tJ20A3PFGjMI7WfGEVqA83farnl6aJ5W
         jStkCNazGYChfXWHKbNR2BiUWbd57bnzmTuPhzyLk83VGzEojqzuqCjd970xUG3KFCO0
         +Du88XOaH+u4ZV/v1vyxmnBiUKCGaPcRTXuTHLcO9wnkXL7Pwfl9YFpMfZhJK3fcHP0f
         p2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Po76AoNWrbgIrG3+om+uizQjbxbVSsHyU3gBTRqZNEI=;
        b=LSnZ+yjgYSiN9wRAvReV89miEx97Ctssjfu/zXbdxuNTlcCOhUqZs+MrFlk9ekvxvJ
         jJ2tTGtqgsy0FtBtQiWdERgqhY7gFQ3bE+qaR/XOwPRZQBbKgRkKS/zLqBsCtvFVYiX3
         hSU1nVZk8lhgrQazqQ58CBHvxuaJBfjp4kVvbc2E/rSmqvd871ZCd7HRJIg06DWx1AGW
         NsCsfsYiGko8c3FQNQgPaR24si+THpyangHJqXTp++EiIYBu08GnOYr4j+7t8uhCkdai
         U8INcf0d6KZSbmIhtD8Ryj7r0H4ghU3a21EGrYrpmyBFq5M3qA1sy2X9w+16Bn9HNolV
         A6rA==
X-Gm-Message-State: APjAAAW1/9diZJU67Dw3+U2xtdZiNdUiF8Ju2yDjl6lWE151HzfNEKO4
        uYwcAPwFrvukaQC9ndNnlZ4=
X-Google-Smtp-Source: APXvYqwxJR5TKpzeuTlnwPNJPzdDCXEa9UscPOWVRxPj7odV9jr5qVm48fkIwmNgztgbURBH6ZqXUw==
X-Received: by 2002:a17:902:b184:: with SMTP id s4mr4987442plr.236.1575485597985;
        Wed, 04 Dec 2019 10:53:17 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h7sm8716156pfn.43.2019.12.04.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 10:53:17 -0800 (PST)
Date:   Wed, 4 Dec 2019 10:53:15 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kbuild-all@lists.01.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v9] software node: add basic tests for property entries
Message-ID: <20191204185315.GM50317@dtor-ws>
References: <201912040922.hUcG8uqP%lkp@intel.com>
 <CAJZ5v0hO7TUado+foOX7QN7nGKKk5Ha7JV8QBYLk3594ky5kMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hO7TUado+foOX7QN7nGKKk5Ha7JV8QBYLk3594ky5kMg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

- updated to reduce stack size below 2048 by declaring properties as
  static const.

 drivers/base/test/Makefile              |   2 +
 drivers/base/test/property-entry-test.c | 474 ++++++++++++++++++++++++
 2 files changed, 476 insertions(+)
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
index 0000000000000..da812834b6316
--- /dev/null
+++ b/drivers/base/test/property-entry-test.c
@@ -0,0 +1,474 @@
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
+	static const struct property_entry entries[] = {
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
+	static const u8 a_u8[16] = { 8, 9 };
+	static const u16 a_u16[16] = { 16, 17 };
+	static const u32 a_u32[16] = { 32, 33 };
+	static const u64 a_u64[16] = { 64, 65 };
+	static const struct property_entry entries[] = {
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
+	static const char *strings[] = {
+		"string-a",
+		"string-b",
+	};
+
+	static const struct property_entry entries[] = {
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
+	static const struct property_entry entries[] = {
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
+	static const u8 u8_array_small[8] = { 1, 2, 3, 4 };
+	static const u8 u8_array_big[128] = { 5, 6, 7, 8 };
+	static const struct property_entry entries[] = {
+		PROPERTY_ENTRY_U8_ARRAY("small", u8_array_small),
+		PROPERTY_ENTRY_U8_ARRAY("big", u8_array_big),
+		{ }
+	};
+
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
+	static char *str_array_small[] = { "a" };
+	static char *str_array_big[] = { "b", "c", "d", "e" };
+	static char *str_array_small_empty[] = { "" };
+	static struct property_entry entries[] = {
+		PROPERTY_ENTRY_STRING_ARRAY("small", str_array_small),
+		PROPERTY_ENTRY_STRING_ARRAY("big", str_array_big),
+		PROPERTY_ENTRY_STRING_ARRAY("small-empty", str_array_small_empty),
+		{ }
+	};
+
+	struct property_entry *copy;
+	const char * const *data_ptr;
+
+	copy = property_entries_dup(entries);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, copy);
+
+	KUNIT_EXPECT_TRUE(test, copy[0].is_inline);
+	KUNIT_EXPECT_STREQ(test, copy[0].value.str[0], "a");
+
+	KUNIT_EXPECT_FALSE(test, copy[1].is_inline);
+	data_ptr = copy[1].pointer;
+	KUNIT_EXPECT_STREQ(test, data_ptr[0], "b");
+	KUNIT_EXPECT_STREQ(test, data_ptr[1], "c");
+
+	KUNIT_EXPECT_TRUE(test, copy[2].is_inline);
+	KUNIT_EXPECT_STREQ(test, copy[2].value.str[0], "");
+
+	property_entries_free(copy);
+}
+
+/* Handling of reference properties */
+static void pe_test_reference(struct kunit *test)
+{
+	static const struct software_node nodes[] = {
+		{ .name = "1", },
+		{ .name = "2", },
+	};
+
+	static const struct software_node_ref_args refs[] = {
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
2.24.0.393.g34dc348eaf-goog

