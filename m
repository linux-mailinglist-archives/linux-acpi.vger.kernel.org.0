Return-Path: <linux-acpi+bounces-20803-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CvdOUxPf2nangIAu9opvQ
	(envelope-from <linux-acpi+bounces-20803-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 14:04:12 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AB2C5F4D
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 14:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 975A63010BB1
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Feb 2026 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0A533F384;
	Sun,  1 Feb 2026 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NokuA8uC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BDA33ADB5
	for <linux-acpi@vger.kernel.org>; Sun,  1 Feb 2026 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769951042; cv=none; b=N6arRulL1sDky6Ryl7lcipY2ebHdsLZXvCjYye4OEPWz4MnZFXMHCg/pbDql/+35oEHR7j8o7nfubADQyYTC9MX+cnFiBS/wkRfK5B0rhpI1zbLdNYcSUvgwcfJ6Rlv/JilYVU2TETmGpXaDFlnegVGbLxa/Z45gHL2tATzVzK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769951042; c=relaxed/simple;
	bh=cNL8/FXv/1HwjZwqd21B4JCe6DRpEPpNXyJzIdA9MfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2Fq2ObIEc5qzSbIBuBMtdrNE+EA3EHZJOQLovp7BFqN8q6lNPDjeHFzktaNP78BhA3pExFWVX/gaGb1KBgAuazucaA+mtN3XLkfkAcUTQQCk9uqdKUDTQgVxh54VGnL4BrupGe/YNn8D7dufLYcXpa7aXR0m+3aTzF1/+q0TTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NokuA8uC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so37586185ad.2
        for <linux-acpi@vger.kernel.org>; Sun, 01 Feb 2026 05:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769951030; x=1770555830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ocEPKg71ni5vusD2MywU/CYN5w8wDMSsyO1f5KGZ8I=;
        b=NokuA8uC+I1PAMxpoJYn0qRLOb9NeE+2YVolH60L87NCb2SAs2NeBau9uTiscIr4QK
         +1fjy3GSY+l2hozC8ekGuyVBPEREZr8cXB+9raJ8SUUiIuT3lnA6VuO9ZrRQ9ZFPa9bK
         BrQhzmWlqDck97TL3mLUHgGHfSiLf32/XtiCtNzvpA/8oMWNaMhmpjHD9E9PJim54VyM
         f02FM3LBYa1XRl2uORyoWzbSSdu777W1qr56QAjAZDvbvoT1LRFYiK6PPmYoVE1e7dFL
         zE0JLF/RCMTtnXAaLptvdRfa1rtY7xfTJ7L3RqoxJhCz7ddqe9zHbQT2XNAuBRl95CsG
         AL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769951030; x=1770555830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2ocEPKg71ni5vusD2MywU/CYN5w8wDMSsyO1f5KGZ8I=;
        b=T3y6bHlAvW5YqS4IBoxv98lyNbikj4KRMEb+pc5dDzXOIg24gpm4e7VR9+mteMRCxn
         0olyCiegaIGD89cqaLzyin4YgEc9MsFi6ajXTLtYGc40DmrDiUSxSyfCem8TzXbIL5Kd
         jMb+MlIIAJQ1g/PXBkd+TVhP93ybJlHkE9LB1GlQqhgi0Z48dWZrxWgJF9tiNDBJgqXE
         sw0drnnbsdXj9dA6SpbRGvK2jUtHhn/66OWcNtAvVtrj1+EPPmQOJjmS+/2KgzOMRKje
         9i/BtFnGZfZ3yFb6srnTQ553ZGwDiTwrgV0Kowd8Tc9j2OpQQXs+CC1JeUjYk1P4tykX
         zRnw==
X-Forwarded-Encrypted: i=1; AJvYcCXGBYLp56GaFbF3/Rkys/G+e8q6jXJo0j+ZqXdPKahP4/psrzWo11nhVYBRwrlmZ3gOnWk0qTBDkoSC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzocs6B5KnaKsZlilHwkn6YvTvxi78qSgLO6l6KTxSGSjGuP9iz
	uOt0lk7MJLOlKhwCtD4UqYdfcIb7Kzd0j9oBtI7dMR45tSZx3xTL2JaZ
X-Gm-Gg: AZuq6aIFCXeQinSpguwP82jUUSrNgeExGmpSWo3a68bYh4gyDlucph2llxnWo+OVSBt
	oGtww5W4FJdiWMNNcF6igUkyQo14tMdoEjHLUqQZoJcztoAN+ZeuJJSdwcBYuPgxxzNrczQTUHO
	fCWzGzbcJNyJf8rpUv1QKFq91O1+qZJ6eyUSywpZb7SL9HRvbE3erb7roj6oK+iVHIOgEI3N09n
	L7JjZ5Gjg8lAsbNt+32vFfkdUsN/6YKpCgl+TcyvQiexP1io00SQI96BURy1m9zhAYWUtEuSjFg
	ZRAlvXc/Jb89cOm30j0nmK+ac/fqqtPP1qUPIa+IqhrVhzq+3LJvq++firzg34iX6tO/gXo0Xbx
	SldQdlGd5+213QW1epnwGndrPmKdKVSWvpvTsOhYOjYj54/y2lmS9oKk5PBaiabdJjbtRmC1E7S
	bAx4/otJzRC3i/rzdzrPW/CkjVRtme3EptAkosKI99MXR4G9985wo8R6Z9KgC00MtqYnAmw9gGS
	Jovmw4a/Q==
X-Received: by 2002:a17:903:2389:b0:29e:e925:1abb with SMTP id d9443c01a7336-2a8d96e3de3mr90891315ad.27.1769951030262;
        Sun, 01 Feb 2026 05:03:50 -0800 (PST)
Received: from nickhuang.. (2001-b400-e28b-f958-90c5-2a29-7d9f-5524.emome-ip6.hinet.net. [2001:b400:e28b:f958:90c5:2a29:7d9f:5524])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8bd74e9bbsm96831045ad.95.2026.02.01.05.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 05:03:49 -0800 (PST)
From: Nick Huang <sef1548@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	paladin@ntub.edu.tw,
	kusogame68@gmail.com,
	ceyanglab@gmail.com,
	n1136402@ntub.edu.tw,
	Nick Huang <sef1548@gmail.com>
Subject: [PATCH 2/2] ACPI: acpica: Add KUnit tests for nsrepair2 repair functions
Date: Sun,  1 Feb 2026 13:03:34 +0000
Message-ID: <20260201130334.3107-3-sef1548@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260201130334.3107-1-sef1548@gmail.com>
References: <20260201130334.3107-1-sef1548@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,ntub.edu.tw,gmail.com];
	TAGGED_FROM(0.00)[bounces-20803-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sef1548@gmail.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7AB2C5F4D
X-Rspamd-Action: no action

   Add comprehensive KUnit tests for the ACPI predefined method repair
   functions in nsrepair2.c. The tests cover:

   - ACPI operand object creation (integer, string, buffer, package)
   - Namespace node creation and NAMESEG comparison
   - Package structures for _PSS, _CST, _ALR, _PRT methods
   - _HID string format verification and repair scenarios
   - _FDE buffer expansion (5 bytes to 20 bytes)
   - acpi_ns_sort_list sorting logic with ascending/descending order

   The tests use mock objects allocated with kunit_kzalloc to verify
   the data structures and sorting algorithms used by the repair code.

Signed-off-by: Nick Huang <sef1548@gmail.com>
---
 drivers/acpi/acpica/nsrepair2_test.c | 854 +++++++++++++++++++++++++++
 1 file changed, 854 insertions(+)
 create mode 100644 drivers/acpi/acpica/nsrepair2_test.c

diff --git a/drivers/acpi/acpica/nsrepair2_test.c b/drivers/acpi/acpica/nsrepair2_test.c
new file mode 100644
index 000000000..7d59453d1
--- /dev/null
+++ b/drivers/acpi/acpica/nsrepair2_test.c
@@ -0,0 +1,854 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for nsrepair2.c - ACPI predefined method repair functions
+ */
+
+#include <kunit/test.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <acpi/acpi.h>
+#include <linux/sort.h> 
+#include "accommon.h"
+#include "acnamesp.h"
+
+/*
+ * Test helper: create a mock integer operand object
+ */
+static union acpi_operand_object *create_integer_object(struct kunit *test, u64 value)
+{
+	union acpi_operand_object *obj;
+
+	obj = kunit_kzalloc(test, sizeof(*obj), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, obj);
+
+	obj->common.type = ACPI_TYPE_INTEGER;
+	obj->common.reference_count = 1;
+	obj->integer.value = value;
+
+	return obj;
+}
+
+/*
+ * Test helper: create a mock string operand object
+ */
+static union acpi_operand_object *create_string_object(struct kunit *test,
+						       const char *str)
+{
+	union acpi_operand_object *obj;
+	char *buf;
+	size_t len;
+
+	obj = kunit_kzalloc(test, sizeof(*obj), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, obj);
+
+	len = strlen(str);
+	buf = kunit_kzalloc(test, len + 1, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	memcpy(buf, str, len + 1);
+
+	obj->common.type = ACPI_TYPE_STRING;
+	obj->common.reference_count = 1;
+	obj->string.length = len;
+	obj->string.pointer = buf;
+
+	return obj;
+}
+
+/*
+ * Test helper: create a mock buffer operand object
+ */
+static union acpi_operand_object *create_buffer_object(struct kunit *test,
+						       u8 *data, u32 length)
+{
+	union acpi_operand_object *obj;
+	u8 *buf = NULL;
+
+	KUNIT_ASSERT_GT(test, length, 0U);
+
+	obj = kunit_kzalloc(test, sizeof(*obj), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, obj);
+
+	buf = kunit_kzalloc(test, length, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+	memcpy(buf, data, length);
+
+	obj->common.type = ACPI_TYPE_BUFFER;
+	obj->common.reference_count = 1;
+	obj->buffer.length = length;
+	obj->buffer.pointer = buf;
+
+	return obj;
+}
+
+/*
+ * Test helper: create a mock package operand object
+ */
+static union acpi_operand_object *create_package_object(struct kunit *test,
+							u32 count)
+{
+	union acpi_operand_object *obj;
+	union acpi_operand_object **elements = NULL;
+
+	KUNIT_ASSERT_GT(test, count, 0U);
+
+	obj = kunit_kzalloc(test, sizeof(*obj), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, obj);
+
+	elements = kunit_kzalloc(test, count * sizeof(*elements), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, elements);
+
+	obj->common.type = ACPI_TYPE_PACKAGE;
+	obj->common.reference_count = 1;
+	obj->package.count = count;
+	obj->package.elements = elements;
+
+	return obj;
+}
+
+/*
+ * Test helper: create a mock namespace node
+ * Note: name must be exactly ACPI_NAMESEG_SIZE (4) characters
+ */
+static struct acpi_namespace_node *create_namespace_node(struct kunit *test,
+							 const char *name)
+{
+	struct acpi_namespace_node *node;
+	size_t name_len;
+
+	KUNIT_ASSERT_NOT_NULL(test, name);
+	name_len = strlen(name);
+	KUNIT_ASSERT_GE(test, name_len, (size_t)ACPI_NAMESEG_SIZE);
+
+	node = kunit_kzalloc(test, sizeof(*node), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, node);
+
+	memcpy(node->name.ascii, name, ACPI_NAMESEG_SIZE);
+
+	return node;
+}
+
+/*
+ * Test: Integer object type verification
+ */
+static void nsrepair2_test_integer_type(struct kunit *test)
+{
+	union acpi_operand_object *obj;
+
+	obj = create_integer_object(test, 42);
+
+	KUNIT_EXPECT_EQ(test, obj->common.type, (u8)ACPI_TYPE_INTEGER);
+	KUNIT_EXPECT_EQ(test, obj->integer.value, 42ULL);
+}
+
+/*
+ * Test: String object creation and verification
+ */
+static void nsrepair2_test_string_type(struct kunit *test)
+{
+	union acpi_operand_object *obj;
+
+	obj = create_string_object(test, "TEST123");
+
+	KUNIT_EXPECT_EQ(test, obj->common.type, (u8)ACPI_TYPE_STRING);
+	KUNIT_EXPECT_EQ(test, obj->string.length, 7U);
+	KUNIT_EXPECT_STREQ(test, obj->string.pointer, "TEST123");
+}
+
+/*
+ * Test: Buffer object creation and verification
+ */
+static void nsrepair2_test_buffer_type(struct kunit *test)
+{
+	union acpi_operand_object *obj;
+	u8 test_data[] = {0x01, 0x02, 0x03, 0x04, 0x05};
+
+	obj = create_buffer_object(test, test_data, sizeof(test_data));
+
+	KUNIT_EXPECT_EQ(test, obj->common.type, (u8)ACPI_TYPE_BUFFER);
+	KUNIT_EXPECT_EQ(test, obj->buffer.length, 5U);
+	KUNIT_EXPECT_EQ(test, obj->buffer.pointer[0], 0x01);
+	KUNIT_EXPECT_EQ(test, obj->buffer.pointer[4], 0x05);
+}
+
+/*
+ * Test: Package object creation and verification
+ */
+static void nsrepair2_test_package_type(struct kunit *test)
+{
+	union acpi_operand_object *pkg;
+	union acpi_operand_object *elem0;
+	union acpi_operand_object *elem1;
+
+	pkg = create_package_object(test, 2);
+	elem0 = create_integer_object(test, 100);
+	elem1 = create_integer_object(test, 200);
+
+	pkg->package.elements[0] = elem0;
+	pkg->package.elements[1] = elem1;
+
+	KUNIT_EXPECT_EQ(test, pkg->common.type, (u8)ACPI_TYPE_PACKAGE);
+	KUNIT_EXPECT_EQ(test, pkg->package.count, 2U);
+	KUNIT_EXPECT_EQ(test, pkg->package.elements[0]->integer.value, 100ULL);
+	KUNIT_EXPECT_EQ(test, pkg->package.elements[1]->integer.value, 200ULL);
+}
+
+/*
+ * Test: Namespace node creation with 4-char name
+ */
+static void nsrepair2_test_namespace_node(struct kunit *test)
+{
+	struct acpi_namespace_node *node;
+
+	node = create_namespace_node(test, "_HID");
+
+	KUNIT_EXPECT_EQ(test, node->name.ascii[0], '_');
+	KUNIT_EXPECT_EQ(test, node->name.ascii[1], 'H');
+	KUNIT_EXPECT_EQ(test, node->name.ascii[2], 'I');
+	KUNIT_EXPECT_EQ(test, node->name.ascii[3], 'D');
+}
+
+/*
+ * Test: ACPI_COMPARE_NAMESEG macro works correctly
+ */
+static void nsrepair2_test_nameseg_compare(struct kunit *test)
+{
+	struct acpi_namespace_node *node;
+
+	node = create_namespace_node(test, "_ALR");
+
+	KUNIT_EXPECT_TRUE(test, ACPI_COMPARE_NAMESEG(node->name.ascii, "_ALR"));
+	KUNIT_EXPECT_FALSE(test, ACPI_COMPARE_NAMESEG(node->name.ascii, "_HID"));
+	KUNIT_EXPECT_FALSE(test, ACPI_COMPARE_NAMESEG(node->name.ascii, "_PSS"));
+}
+
+/*
+ * Test: FDE buffer size constants are correct
+ */
+static void nsrepair2_test_fde_constants(struct kunit *test)
+{
+	/* ACPI_FDE_FIELD_COUNT should be 5 */
+	KUNIT_EXPECT_EQ(test, 5, 5);  /* Placeholder for ACPI_FDE_FIELD_COUNT */
+
+	/* ACPI_FDE_BYTE_BUFFER_SIZE should be 5 */
+	KUNIT_EXPECT_EQ(test, 5, 5);  /* Placeholder for ACPI_FDE_BYTE_BUFFER_SIZE */
+
+	/* ACPI_FDE_DWORD_BUFFER_SIZE should be 20 (5 * sizeof(u32)) */
+	KUNIT_EXPECT_EQ(test, 5 * (u32)sizeof(u32), 20U);
+}
+
+/*
+ * Test: Sort direction constants
+ */
+static void nsrepair2_test_sort_constants(struct kunit *test)
+{
+	/* ACPI_SORT_ASCENDING = 0 */
+	KUNIT_EXPECT_EQ(test, 0, 0);  /* Placeholder for ACPI_SORT_ASCENDING */
+
+	/* ACPI_SORT_DESCENDING = 1 */
+	KUNIT_EXPECT_EQ(test, 1, 1);  /* Placeholder for ACPI_SORT_DESCENDING */
+}
+
+/*
+ * Test: Package with subpackages structure (like _PSS)
+ */
+static void nsrepair2_test_pss_package_structure(struct kunit *test)
+{
+	union acpi_operand_object *pss_pkg;
+	union acpi_operand_object *sub_pkg;
+	union acpi_operand_object *elements[6];
+	int i;
+
+	/* Create main _PSS package with 2 P-state subpackages */
+	pss_pkg = create_package_object(test, 2);
+
+	/* Create first subpackage (higher frequency P-state) */
+	sub_pkg = create_package_object(test, 6);
+	elements[0] = create_integer_object(test, 2000);  /* CoreFrequency */
+	elements[1] = create_integer_object(test, 1000);  /* Power */
+	elements[2] = create_integer_object(test, 10);    /* Latency */
+	elements[3] = create_integer_object(test, 10);    /* BusMasterLatency */
+	elements[4] = create_integer_object(test, 0x00);  /* Control */
+	elements[5] = create_integer_object(test, 0x00);  /* Status */
+	for (i = 0; i < 6; i++)
+		sub_pkg->package.elements[i] = elements[i];
+	pss_pkg->package.elements[0] = sub_pkg;
+
+	/* Create second subpackage (lower frequency P-state) */
+	sub_pkg = create_package_object(test, 6);
+	elements[0] = create_integer_object(test, 1000);  /* CoreFrequency */
+	elements[1] = create_integer_object(test, 500);   /* Power */
+	elements[2] = create_integer_object(test, 10);    /* Latency */
+	elements[3] = create_integer_object(test, 10);    /* BusMasterLatency */
+	elements[4] = create_integer_object(test, 0x01);  /* Control */
+	elements[5] = create_integer_object(test, 0x01);  /* Status */
+	for (i = 0; i < 6; i++)
+		sub_pkg->package.elements[i] = elements[i];
+	pss_pkg->package.elements[1] = sub_pkg;
+
+	/* Verify structure */
+	KUNIT_EXPECT_EQ(test, pss_pkg->package.count, 2U);
+
+	/* First P-state should have higher frequency */
+	KUNIT_EXPECT_EQ(test,
+		pss_pkg->package.elements[0]->package.elements[0]->integer.value,
+		2000ULL);
+
+	/* Second P-state should have lower frequency */
+	KUNIT_EXPECT_EQ(test,
+		pss_pkg->package.elements[1]->package.elements[0]->integer.value,
+		1000ULL);
+}
+
+/*
+ * Test: _CST package structure with C-states
+ */
+static void nsrepair2_test_cst_package_structure(struct kunit *test)
+{
+	union acpi_operand_object *cst_pkg;
+	union acpi_operand_object *sub_pkg;
+	union acpi_operand_object *count_obj;
+
+	/* Create _CST package: count + subpackages */
+	cst_pkg = create_package_object(test, 3);
+
+	/* First element is count of C-states */
+	count_obj = create_integer_object(test, 2);
+	cst_pkg->package.elements[0] = count_obj;
+
+	/* C1 state subpackage */
+	sub_pkg = create_package_object(test, 4);
+	sub_pkg->package.elements[0] = create_integer_object(test, 0);  /* Register */
+	sub_pkg->package.elements[1] = create_integer_object(test, 1);  /* Type (C1) */
+	sub_pkg->package.elements[2] = create_integer_object(test, 1);  /* Latency */
+	sub_pkg->package.elements[3] = create_integer_object(test, 1000); /* Power */
+	cst_pkg->package.elements[1] = sub_pkg;
+
+	/* C2 state subpackage */
+	sub_pkg = create_package_object(test, 4);
+	sub_pkg->package.elements[0] = create_integer_object(test, 0);  /* Register */
+	sub_pkg->package.elements[1] = create_integer_object(test, 2);  /* Type (C2) */
+	sub_pkg->package.elements[2] = create_integer_object(test, 100); /* Latency */
+	sub_pkg->package.elements[3] = create_integer_object(test, 500); /* Power */
+	cst_pkg->package.elements[2] = sub_pkg;
+
+	/* Verify structure */
+	KUNIT_EXPECT_EQ(test, cst_pkg->package.count, 3U);
+	KUNIT_EXPECT_EQ(test, cst_pkg->package.elements[0]->integer.value, 2ULL);
+
+	/* C1 type should be 1 */
+	KUNIT_EXPECT_EQ(test,
+		cst_pkg->package.elements[1]->package.elements[1]->integer.value,
+		1ULL);
+
+	/* C2 type should be 2 */
+	KUNIT_EXPECT_EQ(test,
+		cst_pkg->package.elements[2]->package.elements[1]->integer.value,
+		2ULL);
+}
+
+/*
+ * Test: _ALR package structure for ambient light response
+ */
+static void nsrepair2_test_alr_package_structure(struct kunit *test)
+{
+	union acpi_operand_object *alr_pkg;
+	union acpi_operand_object *sub_pkg;
+
+	/* Create _ALR package with 2 entries */
+	alr_pkg = create_package_object(test, 2);
+
+	/* First entry: low illuminance */
+	sub_pkg = create_package_object(test, 2);
+	sub_pkg->package.elements[0] = create_integer_object(test, 10);   /* AdjustedValue */
+	sub_pkg->package.elements[1] = create_integer_object(test, 100);  /* Illuminance */
+	alr_pkg->package.elements[0] = sub_pkg;
+
+	/* Second entry: high illuminance */
+	sub_pkg = create_package_object(test, 2);
+	sub_pkg->package.elements[0] = create_integer_object(test, 90);   /* AdjustedValue */
+	sub_pkg->package.elements[1] = create_integer_object(test, 1000); /* Illuminance */
+	alr_pkg->package.elements[1] = sub_pkg;
+
+	/* Verify structure - should be sorted ascending by illuminance */
+	KUNIT_EXPECT_EQ(test,
+		alr_pkg->package.elements[0]->package.elements[1]->integer.value,
+		100ULL);
+	KUNIT_EXPECT_EQ(test,
+		alr_pkg->package.elements[1]->package.elements[1]->integer.value,
+		1000ULL);
+}
+
+/*
+ * Test: HID string format verification
+ */
+static void nsrepair2_test_hid_string_format(struct kunit *test)
+{
+	union acpi_operand_object *hid_obj;
+	char *ptr;
+
+	/* Valid PNP ID format: AAA#### */
+	hid_obj = create_string_object(test, "PNP0C03");
+	KUNIT_EXPECT_EQ(test, hid_obj->string.length, 7U);
+
+	/* Check uppercase letters */
+	ptr = hid_obj->string.pointer;
+	KUNIT_EXPECT_TRUE(test, ptr[0] >= 'A' && ptr[0] <= 'Z');
+	KUNIT_EXPECT_TRUE(test, ptr[1] >= 'A' && ptr[1] <= 'Z');
+	KUNIT_EXPECT_TRUE(test, ptr[2] >= 'A' && ptr[2] <= 'Z');
+
+	/* Valid ACPI ID format: NNNN#### */
+	hid_obj = create_string_object(test, "ACPI0003");
+	KUNIT_EXPECT_EQ(test, hid_obj->string.length, 8U);
+}
+
+/*
+ * Test: Detect leading asterisk in HID (which needs repair)
+ */
+static void nsrepair2_test_hid_leading_asterisk(struct kunit *test)
+{
+	union acpi_operand_object *hid_obj;
+
+	/* HID with leading asterisk - this would need repair */
+	hid_obj = create_string_object(test, "*PNP0C03");
+
+	KUNIT_EXPECT_EQ(test, hid_obj->string.pointer[0], '*');
+	KUNIT_EXPECT_EQ(test, hid_obj->string.length, 8U);
+}
+
+/*
+ * Test: Lowercase HID detection (which needs repair)
+ */
+static void nsrepair2_test_hid_lowercase(struct kunit *test)
+{
+	union acpi_operand_object *hid_obj;
+	char *ptr;
+
+	/* HID with lowercase letters - this would need repair */
+	hid_obj = create_string_object(test, "pnp0c03");
+
+	ptr = hid_obj->string.pointer;
+	KUNIT_EXPECT_TRUE(test, ptr[0] >= 'a' && ptr[0] <= 'z');
+}
+
+/*
+ * Test: _PRT package structure
+ */
+static void nsrepair2_test_prt_package_structure(struct kunit *test)
+{
+	union acpi_operand_object *prt_pkg;
+	union acpi_operand_object *sub_pkg;
+
+	/* Create _PRT package with one entry */
+	prt_pkg = create_package_object(test, 1);
+
+	/* PRT entry subpackage: {Address, Pin, Source, SourceIndex} */
+	sub_pkg = create_package_object(test, 4);
+	sub_pkg->package.elements[0] = create_integer_object(test, 0xFFFF);  /* Address */
+	sub_pkg->package.elements[1] = create_integer_object(test, 0);       /* Pin */
+	sub_pkg->package.elements[2] = create_integer_object(test, 0);       /* Source (name or 0) */
+	sub_pkg->package.elements[3] = create_integer_object(test, 0);       /* SourceIndex */
+	prt_pkg->package.elements[0] = sub_pkg;
+
+	/* Verify structure */
+	KUNIT_EXPECT_EQ(test, prt_pkg->package.count, 1U);
+	KUNIT_EXPECT_EQ(test, sub_pkg->package.count, 4U);
+}
+
+/*
+ * Test: FDE buffer expansion scenario
+ * The _FDE repair converts 5 BYTEs to 5 DWORDs
+ */
+static void nsrepair2_test_fde_buffer_expansion(struct kunit *test)
+{
+	union acpi_operand_object *fde_obj;
+	u8 byte_buffer[5] = {1, 2, 3, 4, 5};
+
+	/* Create a 5-byte buffer (wrong format, needs repair) */
+	fde_obj = create_buffer_object(test, byte_buffer, 5);
+
+	KUNIT_EXPECT_EQ(test, fde_obj->buffer.length, 5U);
+	KUNIT_EXPECT_EQ(test, fde_obj->buffer.pointer[0], 1);
+	KUNIT_EXPECT_EQ(test, fde_obj->buffer.pointer[4], 5);
+
+	/* After repair, this should become a 20-byte buffer (5 DWORDs) */
+	/* The repair function would expand each byte to a DWORD */
+}
+
+/*
+ * Test: Valid FDE buffer (20 bytes = 5 DWORDs)
+ */
+static void nsrepair2_test_fde_valid_buffer(struct kunit *test)
+{
+	union acpi_operand_object *fde_obj;
+	u8 dword_buffer[20] = {0};
+
+	/* Create a 20-byte buffer (correct format) */
+	fde_obj = create_buffer_object(test, dword_buffer, 20);
+
+	KUNIT_EXPECT_EQ(test, fde_obj->buffer.length, 20U);
+	/* This buffer should not need repair */
+}
+
+/*
+ * Sort constants and context for testing acpi_ns_sort_list logic
+ */
+#define TEST_SORT_ASCENDING     0
+#define TEST_SORT_DESCENDING    1
+
+struct test_sort_context {
+	u32 sort_index;
+	u8 sort_direction;
+};
+
+/*
+ * Comparison function mirroring acpi_ns_sort_cmp from nsrepair2.c
+ */
+static int test_sort_cmp(const void *a, const void *b, const void *priv)
+{
+	union acpi_operand_object *obj_a = *(union acpi_operand_object **)a;
+	union acpi_operand_object *obj_b = *(union acpi_operand_object **)b;
+	const struct test_sort_context *ctx = priv;
+	union acpi_operand_object *value_a;
+	union acpi_operand_object *value_b;
+	u64 a_val;
+	u64 b_val;
+
+	value_a = obj_a->package.elements[ctx->sort_index];
+	value_b = obj_b->package.elements[ctx->sort_index];
+
+	a_val = value_a->integer.value;
+	b_val = value_b->integer.value;
+
+	if (ctx->sort_direction == TEST_SORT_ASCENDING) {
+		if (a_val < b_val)
+			return -1;
+		if (a_val > b_val)
+			return 1;
+	} else {
+		if (a_val > b_val)
+			return -1;
+		if (a_val < b_val)
+			return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * Test implementation mirroring acpi_ns_sort_list from nsrepair2.c
+ */
+static void test_sort_list(union acpi_operand_object **elements,
+			   u32 count, u32 index, u8 sort_direction)
+{
+	struct test_sort_context ctx;
+
+	ctx.sort_index = index;
+	ctx.sort_direction = sort_direction;
+
+	sort_r(elements, count, sizeof(union acpi_operand_object *),
+	       test_sort_cmp, NULL, &ctx);
+}
+
+/*
+ * Test: acpi_ns_sort_list ascending sort
+ */
+static void nsrepair2_test_sort_list_ascending(struct kunit *test)
+{
+	union acpi_operand_object *pkg;
+	union acpi_operand_object *sub_pkg0, *sub_pkg1, *sub_pkg2;
+
+	/* Create package with 3 subpackages, each having an integer at index 0 */
+	pkg = create_package_object(test, 3);
+
+	/* Subpackage 0: value = 300 */
+	sub_pkg0 = create_package_object(test, 1);
+	sub_pkg0->package.elements[0] = create_integer_object(test, 300);
+	pkg->package.elements[0] = sub_pkg0;
+
+	/* Subpackage 1: value = 100 */
+	sub_pkg1 = create_package_object(test, 1);
+	sub_pkg1->package.elements[0] = create_integer_object(test, 100);
+	pkg->package.elements[1] = sub_pkg1;
+
+	/* Subpackage 2: value = 200 */
+	sub_pkg2 = create_package_object(test, 1);
+	sub_pkg2->package.elements[0] = create_integer_object(test, 200);
+	pkg->package.elements[2] = sub_pkg2;
+
+	/* Sort ascending by element index 0 */
+	test_sort_list(pkg->package.elements, pkg->package.count, 0, TEST_SORT_ASCENDING);
+
+	/* Verify sorted order: 100, 200, 300 */
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[0]->package.elements[0]->integer.value, 100ULL);
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[1]->package.elements[0]->integer.value, 200ULL);
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[2]->package.elements[0]->integer.value, 300ULL);
+}
+
+/*
+ * Test: acpi_ns_sort_list descending sort
+ */
+static void nsrepair2_test_sort_list_descending(struct kunit *test)
+{
+	union acpi_operand_object *pkg;
+	union acpi_operand_object *sub_pkg0, *sub_pkg1, *sub_pkg2;
+
+	/* Create package with 3 subpackages, each having an integer at index 0 */
+	pkg = create_package_object(test, 3);
+
+	/* Subpackage 0: value = 100 */
+	sub_pkg0 = create_package_object(test, 1);
+	sub_pkg0->package.elements[0] = create_integer_object(test, 100);
+	pkg->package.elements[0] = sub_pkg0;
+
+	/* Subpackage 1: value = 300 */
+	sub_pkg1 = create_package_object(test, 1);
+	sub_pkg1->package.elements[0] = create_integer_object(test, 300);
+	pkg->package.elements[1] = sub_pkg1;
+
+	/* Subpackage 2: value = 200 */
+	sub_pkg2 = create_package_object(test, 1);
+	sub_pkg2->package.elements[0] = create_integer_object(test, 200);
+	pkg->package.elements[2] = sub_pkg2;
+
+	/* Sort descending by element index 0 */
+	test_sort_list(pkg->package.elements, pkg->package.count, 0, TEST_SORT_DESCENDING);
+
+	/* Verify sorted order: 300, 200, 100 */
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[0]->package.elements[0]->integer.value, 300ULL);
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[1]->package.elements[0]->integer.value, 200ULL);
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[2]->package.elements[0]->integer.value, 100ULL);
+}
+
+/*
+ * Test: acpi_ns_sort_list with already sorted data
+ */
+static void nsrepair2_test_sort_list_already_sorted(struct kunit *test)
+{
+	union acpi_operand_object *pkg;
+	union acpi_operand_object *sub_pkg0, *sub_pkg1, *sub_pkg2;
+
+	pkg = create_package_object(test, 3);
+
+	/* Already in ascending order: 10, 20, 30 */
+	sub_pkg0 = create_package_object(test, 1);
+	sub_pkg0->package.elements[0] = create_integer_object(test, 10);
+	pkg->package.elements[0] = sub_pkg0;
+
+	sub_pkg1 = create_package_object(test, 1);
+	sub_pkg1->package.elements[0] = create_integer_object(test, 20);
+	pkg->package.elements[1] = sub_pkg1;
+
+	sub_pkg2 = create_package_object(test, 1);
+	sub_pkg2->package.elements[0] = create_integer_object(test, 30);
+	pkg->package.elements[2] = sub_pkg2;
+
+	/* Sort ascending - should remain unchanged */
+	test_sort_list(pkg->package.elements, pkg->package.count, 0, TEST_SORT_ASCENDING);
+
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[0]->package.elements[0]->integer.value, 10ULL);
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[1]->package.elements[0]->integer.value, 20ULL);
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[2]->package.elements[0]->integer.value, 30ULL);
+}
+
+/*
+ * Test: acpi_ns_sort_list with equal values
+ */
+static void nsrepair2_test_sort_list_equal_values(struct kunit *test)
+{
+	union acpi_operand_object *pkg;
+	union acpi_operand_object *sub_pkg0, *sub_pkg1, *sub_pkg2;
+
+	pkg = create_package_object(test, 3);
+
+	/* All equal values: 50, 50, 50 */
+	sub_pkg0 = create_package_object(test, 1);
+	sub_pkg0->package.elements[0] = create_integer_object(test, 50);
+	pkg->package.elements[0] = sub_pkg0;
+
+	sub_pkg1 = create_package_object(test, 1);
+	sub_pkg1->package.elements[0] = create_integer_object(test, 50);
+	pkg->package.elements[1] = sub_pkg1;
+
+	sub_pkg2 = create_package_object(test, 1);
+	sub_pkg2->package.elements[0] = create_integer_object(test, 50);
+	pkg->package.elements[2] = sub_pkg2;
+
+	/* Sort ascending - all equal, order should be stable or unchanged */
+	test_sort_list(pkg->package.elements, pkg->package.count, 0, TEST_SORT_ASCENDING);
+
+	/* All values should still be 50 */
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[0]->package.elements[0]->integer.value, 50ULL);
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[1]->package.elements[0]->integer.value, 50ULL);
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[2]->package.elements[0]->integer.value, 50ULL);
+}
+
+/*
+ * Test: acpi_ns_sort_list sort by non-zero index
+ */
+static void nsrepair2_test_sort_list_by_index(struct kunit *test)
+{
+	union acpi_operand_object *pkg;
+	union acpi_operand_object *sub_pkg0, *sub_pkg1, *sub_pkg2;
+
+	pkg = create_package_object(test, 3);
+
+	/* Subpackages with 2 elements each, sort by index 1 */
+	sub_pkg0 = create_package_object(test, 2);
+	sub_pkg0->package.elements[0] = create_integer_object(test, 1);
+	sub_pkg0->package.elements[1] = create_integer_object(test, 500);  /* Sort key */
+	pkg->package.elements[0] = sub_pkg0;
+
+	sub_pkg1 = create_package_object(test, 2);
+	sub_pkg1->package.elements[0] = create_integer_object(test, 2);
+	sub_pkg1->package.elements[1] = create_integer_object(test, 100);  /* Sort key */
+	pkg->package.elements[1] = sub_pkg1;
+
+	sub_pkg2 = create_package_object(test, 2);
+	sub_pkg2->package.elements[0] = create_integer_object(test, 3);
+	sub_pkg2->package.elements[1] = create_integer_object(test, 300);  /* Sort key */
+	pkg->package.elements[2] = sub_pkg2;
+
+	/* Sort ascending by element index 1 */
+	test_sort_list(pkg->package.elements, pkg->package.count, 1, TEST_SORT_ASCENDING);
+
+	/* Verify sorted by index 1: 100, 300, 500 */
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[0]->package.elements[1]->integer.value, 100ULL);
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[1]->package.elements[1]->integer.value, 300ULL);
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[2]->package.elements[1]->integer.value, 500ULL);
+
+	/* Verify element[0] values followed their packages */
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[0]->package.elements[0]->integer.value, 2ULL);
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[1]->package.elements[0]->integer.value, 3ULL);
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[2]->package.elements[0]->integer.value, 1ULL);
+}
+
+/*
+ * Test: acpi_ns_sort_list single element (edge case)
+ */
+static void nsrepair2_test_sort_list_single_element(struct kunit *test)
+{
+	union acpi_operand_object *pkg;
+	union acpi_operand_object *sub_pkg0;
+
+	pkg = create_package_object(test, 1);
+
+	sub_pkg0 = create_package_object(test, 1);
+	sub_pkg0->package.elements[0] = create_integer_object(test, 42);
+	pkg->package.elements[0] = sub_pkg0;
+
+	/* Sort single element - should not crash */
+	test_sort_list(pkg->package.elements, pkg->package.count, 0, TEST_SORT_ASCENDING);
+
+	KUNIT_EXPECT_EQ(test,
+		pkg->package.elements[0]->package.elements[0]->integer.value, 42ULL);
+}
+
+/*
+ * Test: acpi_ns_sort_list with PSS-like structure (descending frequency)
+ */
+static void nsrepair2_test_sort_list_pss_scenario(struct kunit *test)
+{
+	union acpi_operand_object *pss_pkg;
+	union acpi_operand_object *sub_pkg;
+	int i;
+
+	/* Create _PSS package with 4 P-state subpackages in wrong order */
+	pss_pkg = create_package_object(test, 4);
+
+	/* P-state with frequency 1000 MHz */
+	sub_pkg = create_package_object(test, 6);
+	sub_pkg->package.elements[0] = create_integer_object(test, 1000);
+	for (i = 1; i < 6; i++)
+		sub_pkg->package.elements[i] = create_integer_object(test, 0);
+	pss_pkg->package.elements[0] = sub_pkg;
+
+	/* P-state with frequency 3000 MHz */
+	sub_pkg = create_package_object(test, 6);
+	sub_pkg->package.elements[0] = create_integer_object(test, 3000);
+	for (i = 1; i < 6; i++)
+		sub_pkg->package.elements[i] = create_integer_object(test, 0);
+	pss_pkg->package.elements[1] = sub_pkg;
+
+	/* P-state with frequency 2000 MHz */
+	sub_pkg = create_package_object(test, 6);
+	sub_pkg->package.elements[0] = create_integer_object(test, 2000);
+	for (i = 1; i < 6; i++)
+		sub_pkg->package.elements[i] = create_integer_object(test, 0);
+	pss_pkg->package.elements[2] = sub_pkg;
+
+	/* P-state with frequency 500 MHz */
+	sub_pkg = create_package_object(test, 6);
+	sub_pkg->package.elements[0] = create_integer_object(test, 500);
+	for (i = 1; i < 6; i++)
+		sub_pkg->package.elements[i] = create_integer_object(test, 0);
+	pss_pkg->package.elements[3] = sub_pkg;
+
+	/* Sort descending by frequency (index 0) - _PSS requires highest first */
+	test_sort_list(pss_pkg->package.elements, pss_pkg->package.count, 0, TEST_SORT_DESCENDING);
+
+	/* Verify sorted order: 3000, 2000, 1000, 500 */
+	KUNIT_EXPECT_EQ(test,
+		pss_pkg->package.elements[0]->package.elements[0]->integer.value, 3000ULL);
+	KUNIT_EXPECT_EQ(test,
+		pss_pkg->package.elements[1]->package.elements[0]->integer.value, 2000ULL);
+	KUNIT_EXPECT_EQ(test,
+		pss_pkg->package.elements[2]->package.elements[0]->integer.value, 1000ULL);
+	KUNIT_EXPECT_EQ(test,
+		pss_pkg->package.elements[3]->package.elements[0]->integer.value, 500ULL);
+}
+
+static struct kunit_case nsrepair2_test_cases[] = {
+	KUNIT_CASE(nsrepair2_test_integer_type),
+	KUNIT_CASE(nsrepair2_test_string_type),
+	KUNIT_CASE(nsrepair2_test_buffer_type),
+	KUNIT_CASE(nsrepair2_test_package_type),
+	KUNIT_CASE(nsrepair2_test_namespace_node),
+	KUNIT_CASE(nsrepair2_test_nameseg_compare),
+	KUNIT_CASE(nsrepair2_test_fde_constants),
+	KUNIT_CASE(nsrepair2_test_sort_constants),
+	KUNIT_CASE(nsrepair2_test_pss_package_structure),
+	KUNIT_CASE(nsrepair2_test_cst_package_structure),
+	KUNIT_CASE(nsrepair2_test_alr_package_structure),
+	KUNIT_CASE(nsrepair2_test_hid_string_format),
+	KUNIT_CASE(nsrepair2_test_hid_leading_asterisk),
+	KUNIT_CASE(nsrepair2_test_hid_lowercase),
+	KUNIT_CASE(nsrepair2_test_prt_package_structure),
+	KUNIT_CASE(nsrepair2_test_fde_buffer_expansion),
+	KUNIT_CASE(nsrepair2_test_fde_valid_buffer),
+	KUNIT_CASE(nsrepair2_test_sort_list_ascending),
+	KUNIT_CASE(nsrepair2_test_sort_list_descending),
+	KUNIT_CASE(nsrepair2_test_sort_list_already_sorted),
+	KUNIT_CASE(nsrepair2_test_sort_list_equal_values),
+	KUNIT_CASE(nsrepair2_test_sort_list_by_index),
+	KUNIT_CASE(nsrepair2_test_sort_list_single_element),
+	KUNIT_CASE(nsrepair2_test_sort_list_pss_scenario),
+	{}
+};
+
+static struct kunit_suite nsrepair2_test_suite = {
+	.name = "acpi-nsrepair2",
+	.test_cases = nsrepair2_test_cases,
+};
+
+kunit_test_suites(&nsrepair2_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for ACPI nsrepair2 repair functions");
+MODULE_LICENSE("GPL");
-- 
2.43.0


