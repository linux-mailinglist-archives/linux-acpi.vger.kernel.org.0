Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E5371F4BA
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 23:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjFAVb5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 17:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjFAVb5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 17:31:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B07195;
        Thu,  1 Jun 2023 14:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685655114; x=1717191114;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=whlfnvWzu1+2Vn7v2lrRRkGzH81UIdjR6iFEKRCIzLs=;
  b=YvxqJDoAoSjWlhUcJE3lKwU/EvOByIiRW375sJr4BbU/abU+xWFd5cLV
   NZ2/CUw/fWO4lFfrtyBltQs7NBr0WezgDfrI8GY12RlEWvO96SL5WnywD
   f4eMRNI88lcxwPA0Su8sUN/qciwjL4QTlb00ELqOhaB3jBXZOdQTcYGI1
   n9N5oI15jGpXnymUs2kXy+nbPnmmvE+5Dydhd2/khbgT+PQ7PVo8foav2
   2OUrljPp09Yqie4tpG7IqUunvF18xyH7UPkJfSnnqKPNOQy8dxtNWX9mD
   J25lAh9E0d0FSE+jyjwV8D0fR2CpQVl4fDYh+KeR5uJaxp7tf+QTd49pN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421507411"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421507411"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="685016411"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="685016411"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.26.132])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:31:53 -0700
Subject: [PATCH v3 1/4] acpi: Move common tables helper functions to common
 lib
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Thu, 01 Jun 2023 14:31:52 -0700
Message-ID: <168565511236.1098279.11767193165079131197.stgit@djiang5-mobl3>
In-Reply-To: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
References: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some of the routines in ACPI driver/acpi/tables.c can be shared with
parsing CDAT. CDAT is a device-provided data structure that is formatted
similar to a platform provided ACPI table. CDAT is used by CXL and can
exist on platforms that do not use ACPI. Split out the common routine
from ACPI to accommodate platforms that do not support ACPI and move that
to /lib. The common routines can be built outside of ACPI if
FIRMWARE_TABLES is selected.

Link: https://lore.kernel.org/linux-cxl/CAJZ5v0jipbtTNnsA0-o5ozOk8ZgWnOg34m34a9pPenTyRLj=6A@mail.gmail.com/
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
---
 drivers/acpi/Kconfig     |    1 
 drivers/acpi/tables.c    |  173 ------------------------------------------
 include/linux/acpi.h     |   22 -----
 include/linux/fw_table.h |   43 ++++++++++
 lib/Kconfig              |    3 +
 lib/Makefile             |    2 
 lib/fw_table.c           |  189 ++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 239 insertions(+), 194 deletions(-)
 create mode 100644 include/linux/fw_table.h
 create mode 100644 lib/fw_table.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ccbeab9500ec..320d36b2ec78 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -12,6 +12,7 @@ menuconfig ACPI
 	select PNP
 	select NLS
 	select CRC32
+	select FIRMWARE_TABLE
 	default y if X86
 	help
 	  Advanced Configuration and Power Interface (ACPI) support for 
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 7b4680da57d7..cfc76efd8788 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -37,18 +37,6 @@ static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
 static int acpi_apic_instance __initdata_or_acpilib;
 
-enum acpi_subtable_type {
-	ACPI_SUBTABLE_COMMON,
-	ACPI_SUBTABLE_HMAT,
-	ACPI_SUBTABLE_PRMT,
-	ACPI_SUBTABLE_CEDT,
-};
-
-struct acpi_subtable_entry {
-	union acpi_subtable_headers *hdr;
-	enum acpi_subtable_type type;
-};
-
 /*
  * Disable table checksum verification for the early stage due to the size
  * limitation of the current x86 early mapping implementation.
@@ -227,167 +215,6 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	}
 }
 
-static unsigned long __init_or_acpilib
-acpi_get_entry_type(struct acpi_subtable_entry *entry)
-{
-	switch (entry->type) {
-	case ACPI_SUBTABLE_COMMON:
-		return entry->hdr->common.type;
-	case ACPI_SUBTABLE_HMAT:
-		return entry->hdr->hmat.type;
-	case ACPI_SUBTABLE_PRMT:
-		return 0;
-	case ACPI_SUBTABLE_CEDT:
-		return entry->hdr->cedt.type;
-	}
-	return 0;
-}
-
-static unsigned long __init_or_acpilib
-acpi_get_entry_length(struct acpi_subtable_entry *entry)
-{
-	switch (entry->type) {
-	case ACPI_SUBTABLE_COMMON:
-		return entry->hdr->common.length;
-	case ACPI_SUBTABLE_HMAT:
-		return entry->hdr->hmat.length;
-	case ACPI_SUBTABLE_PRMT:
-		return entry->hdr->prmt.length;
-	case ACPI_SUBTABLE_CEDT:
-		return entry->hdr->cedt.length;
-	}
-	return 0;
-}
-
-static unsigned long __init_or_acpilib
-acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
-{
-	switch (entry->type) {
-	case ACPI_SUBTABLE_COMMON:
-		return sizeof(entry->hdr->common);
-	case ACPI_SUBTABLE_HMAT:
-		return sizeof(entry->hdr->hmat);
-	case ACPI_SUBTABLE_PRMT:
-		return sizeof(entry->hdr->prmt);
-	case ACPI_SUBTABLE_CEDT:
-		return sizeof(entry->hdr->cedt);
-	}
-	return 0;
-}
-
-static enum acpi_subtable_type __init_or_acpilib
-acpi_get_subtable_type(char *id)
-{
-	if (strncmp(id, ACPI_SIG_HMAT, 4) == 0)
-		return ACPI_SUBTABLE_HMAT;
-	if (strncmp(id, ACPI_SIG_PRMT, 4) == 0)
-		return ACPI_SUBTABLE_PRMT;
-	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
-		return ACPI_SUBTABLE_CEDT;
-	return ACPI_SUBTABLE_COMMON;
-}
-
-static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
-{
-	return proc->handler || proc->handler_arg;
-}
-
-static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
-					  union acpi_subtable_headers *hdr,
-					  unsigned long end)
-{
-	if (proc->handler)
-		return proc->handler(hdr, end);
-	if (proc->handler_arg)
-		return proc->handler_arg(hdr, proc->arg, end);
-	return -EINVAL;
-}
-
-/**
- * acpi_parse_entries_array - for each proc_num find a suitable subtable
- *
- * @id: table id (for debugging purposes)
- * @table_size: size of the root table
- * @table_header: where does the table start?
- * @proc: array of acpi_subtable_proc struct containing entry id
- *        and associated handler with it
- * @proc_num: how big proc is?
- * @max_entries: how many entries can we process?
- *
- * For each proc_num find a subtable with proc->id and run proc->handler
- * on it. Assumption is that there's only single handler for particular
- * entry id.
- *
- * The table_size is not the size of the complete ACPI table (the length
- * field in the header struct), but only the size of the root table; i.e.,
- * the offset from the very first byte of the complete ACPI table, to the
- * first byte of the very first subtable.
- *
- * On success returns sum of all matching entries for all proc handlers.
- * Otherwise, -ENODEV or -EINVAL is returned.
- */
-static int __init_or_acpilib acpi_parse_entries_array(
-	char *id, unsigned long table_size,
-	struct acpi_table_header *table_header, struct acpi_subtable_proc *proc,
-	int proc_num, unsigned int max_entries)
-{
-	struct acpi_subtable_entry entry;
-	unsigned long table_end, subtable_len, entry_len;
-	int count = 0;
-	int errs = 0;
-	int i;
-
-	table_end = (unsigned long)table_header + table_header->length;
-
-	/* Parse all entries looking for a match. */
-
-	entry.type = acpi_get_subtable_type(id);
-	entry.hdr = (union acpi_subtable_headers *)
-	    ((unsigned long)table_header + table_size);
-	subtable_len = acpi_get_subtable_header_length(&entry);
-
-	while (((unsigned long)entry.hdr) + subtable_len  < table_end) {
-		if (max_entries && count >= max_entries)
-			break;
-
-		for (i = 0; i < proc_num; i++) {
-			if (acpi_get_entry_type(&entry) != proc[i].id)
-				continue;
-			if (!has_handler(&proc[i]) ||
-			    (!errs &&
-			     call_handler(&proc[i], entry.hdr, table_end))) {
-				errs++;
-				continue;
-			}
-
-			proc[i].count++;
-			break;
-		}
-		if (i != proc_num)
-			count++;
-
-		/*
-		 * If entry->length is 0, break from this loop to avoid
-		 * infinite loop.
-		 */
-		entry_len = acpi_get_entry_length(&entry);
-		if (entry_len == 0) {
-			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
-			return -EINVAL;
-		}
-
-		entry.hdr = (union acpi_subtable_headers *)
-		    ((unsigned long)entry.hdr + entry_len);
-	}
-
-	if (max_entries && count > max_entries) {
-		pr_warn("[%4.4s:0x%02x] found the maximum %i entries\n",
-			id, proc->id, count);
-	}
-
-	return errs ? -EINVAL : count;
-}
-
 int __init_or_acpilib acpi_table_parse_entries_array(
 	char *id, unsigned long table_size, struct acpi_subtable_proc *proc,
 	int proc_num, unsigned int max_entries)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7b71dd74baeb..57004cd0a7a3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -15,6 +15,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/uuid.h>
+#include <linux/fw_table.h>
 
 struct irq_domain;
 struct irq_domain_ops;
@@ -132,21 +133,8 @@ enum acpi_address_range_id {
 
 
 /* Table Handlers */
-union acpi_subtable_headers {
-	struct acpi_subtable_header common;
-	struct acpi_hmat_structure hmat;
-	struct acpi_prmt_module_header prmt;
-	struct acpi_cedt_header cedt;
-};
-
 typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
 
-typedef int (*acpi_tbl_entry_handler)(union acpi_subtable_headers *header,
-				      const unsigned long end);
-
-typedef int (*acpi_tbl_entry_handler_arg)(union acpi_subtable_headers *header,
-					  void *arg, const unsigned long end);
-
 /* Debugger support */
 
 struct acpi_debugger_ops {
@@ -220,14 +208,6 @@ static inline int acpi_debugger_notify_command_complete(void)
 		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
 		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
 
-struct acpi_subtable_proc {
-	int id;
-	acpi_tbl_entry_handler handler;
-	acpi_tbl_entry_handler_arg handler_arg;
-	void *arg;
-	int count;
-};
-
 void __iomem *__acpi_map_table(unsigned long phys, unsigned long size);
 void __acpi_unmap_table(void __iomem *map, unsigned long size);
 int early_acpi_boot_init(void);
diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
new file mode 100644
index 000000000000..ff8fa58d5818
--- /dev/null
+++ b/include/linux/fw_table.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  fw_tables.h - Parsing support for ACPI and ACPI-like tables provided by
+ *                platform or device firmware
+ *
+ *  Copyright (C) 2001 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ *  Copyright (C) 2023 Intel Corp.
+ */
+#ifndef _FW_TABLE_H_
+#define _FW_TABLE_H_
+
+union acpi_subtable_headers;
+
+typedef int (*acpi_tbl_entry_handler)(union acpi_subtable_headers *header,
+				      const unsigned long end);
+
+typedef int (*acpi_tbl_entry_handler_arg)(union acpi_subtable_headers *header,
+					  void *arg, const unsigned long end);
+
+struct acpi_subtable_proc {
+	int id;
+	acpi_tbl_entry_handler handler;
+	acpi_tbl_entry_handler_arg handler_arg;
+	void *arg;
+	int count;
+};
+
+#include <linux/acpi.h>
+#include <acpi/acpi.h>
+
+union acpi_subtable_headers {
+	struct acpi_subtable_header common;
+	struct acpi_hmat_structure hmat;
+	struct acpi_prmt_module_header prmt;
+	struct acpi_cedt_header cedt;
+};
+
+int acpi_parse_entries_array(char *id, unsigned long table_size,
+			     struct acpi_table_header *table_header,
+			     struct acpi_subtable_proc *proc,
+			     int proc_num, unsigned int max_entries);
+
+#endif
diff --git a/lib/Kconfig b/lib/Kconfig
index 5c2da561c516..b03714d45444 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -763,3 +763,6 @@ config ASN1_ENCODER
 
 config POLYNOMIAL
        tristate
+
+config FIRMWARE_TABLE
+	bool
diff --git a/lib/Makefile b/lib/Makefile
index 876fcdeae34e..16e238baef4b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -397,6 +397,8 @@ obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
+obj-$(CONFIG_FIRMWARE_TABLE) += fw_table.o
+
 # FORTIFY_SOURCE compile-time behavior tests
 TEST_FORTIFY_SRCS = $(wildcard $(srctree)/$(src)/test_fortify/*-*.c)
 TEST_FORTIFY_LOGS = $(patsubst $(srctree)/$(src)/%.c, %.log, $(TEST_FORTIFY_SRCS))
diff --git a/lib/fw_table.c b/lib/fw_table.c
new file mode 100644
index 000000000000..e84bd0866e10
--- /dev/null
+++ b/lib/fw_table.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  fw_tables.c - Parsing support for ACPI and ACPI-like tables provided by
+ *                platform or device firmware
+ *
+ *  Copyright (C) 2001 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ *  Copyright (C) 2023 Intel Corp.
+ */
+#include <linux/errno.h>
+#include <linux/fw_table.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+enum acpi_subtable_type {
+	ACPI_SUBTABLE_COMMON,
+	ACPI_SUBTABLE_HMAT,
+	ACPI_SUBTABLE_PRMT,
+	ACPI_SUBTABLE_CEDT,
+};
+
+struct acpi_subtable_entry {
+	union acpi_subtable_headers *hdr;
+	enum acpi_subtable_type type;
+};
+
+static unsigned long __init_or_acpilib
+acpi_get_entry_type(struct acpi_subtable_entry *entry)
+{
+	switch (entry->type) {
+	case ACPI_SUBTABLE_COMMON:
+		return entry->hdr->common.type;
+	case ACPI_SUBTABLE_HMAT:
+		return entry->hdr->hmat.type;
+	case ACPI_SUBTABLE_PRMT:
+		return 0;
+	case ACPI_SUBTABLE_CEDT:
+		return entry->hdr->cedt.type;
+	}
+	return 0;
+}
+
+static unsigned long __init_or_acpilib
+acpi_get_entry_length(struct acpi_subtable_entry *entry)
+{
+	switch (entry->type) {
+	case ACPI_SUBTABLE_COMMON:
+		return entry->hdr->common.length;
+	case ACPI_SUBTABLE_HMAT:
+		return entry->hdr->hmat.length;
+	case ACPI_SUBTABLE_PRMT:
+		return entry->hdr->prmt.length;
+	case ACPI_SUBTABLE_CEDT:
+		return entry->hdr->cedt.length;
+	}
+	return 0;
+}
+
+static unsigned long __init_or_acpilib
+acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
+{
+	switch (entry->type) {
+	case ACPI_SUBTABLE_COMMON:
+		return sizeof(entry->hdr->common);
+	case ACPI_SUBTABLE_HMAT:
+		return sizeof(entry->hdr->hmat);
+	case ACPI_SUBTABLE_PRMT:
+		return sizeof(entry->hdr->prmt);
+	case ACPI_SUBTABLE_CEDT:
+		return sizeof(entry->hdr->cedt);
+	}
+	return 0;
+}
+
+static enum acpi_subtable_type __init_or_acpilib
+acpi_get_subtable_type(char *id)
+{
+	if (strncmp(id, ACPI_SIG_HMAT, 4) == 0)
+		return ACPI_SUBTABLE_HMAT;
+	if (strncmp(id, ACPI_SIG_PRMT, 4) == 0)
+		return ACPI_SUBTABLE_PRMT;
+	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
+		return ACPI_SUBTABLE_CEDT;
+	return ACPI_SUBTABLE_COMMON;
+}
+
+static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
+{
+	return proc->handler || proc->handler_arg;
+}
+
+static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
+					  union acpi_subtable_headers *hdr,
+					  unsigned long end)
+{
+	if (proc->handler)
+		return proc->handler(hdr, end);
+	if (proc->handler_arg)
+		return proc->handler_arg(hdr, proc->arg, end);
+	return -EINVAL;
+}
+
+/**
+ * acpi_parse_entries_array - for each proc_num find a suitable subtable
+ *
+ * @id: table id (for debugging purposes)
+ * @table_size: size of the root table
+ * @table_header: where does the table start?
+ * @proc: array of acpi_subtable_proc struct containing entry id
+ *        and associated handler with it
+ * @proc_num: how big proc is?
+ * @max_entries: how many entries can we process?
+ *
+ * For each proc_num find a subtable with proc->id and run proc->handler
+ * on it. Assumption is that there's only single handler for particular
+ * entry id.
+ *
+ * The table_size is not the size of the complete ACPI table (the length
+ * field in the header struct), but only the size of the root table; i.e.,
+ * the offset from the very first byte of the complete ACPI table, to the
+ * first byte of the very first subtable.
+ *
+ * On success returns sum of all matching entries for all proc handlers.
+ * Otherwise, -ENODEV or -EINVAL is returned.
+ */
+int __init_or_acpilib
+acpi_parse_entries_array(char *id, unsigned long table_size,
+			 struct acpi_table_header *table_header,
+			 struct acpi_subtable_proc *proc,
+			 int proc_num, unsigned int max_entries)
+{
+	unsigned long table_end, subtable_len, entry_len;
+	struct acpi_subtable_entry entry;
+	int count = 0;
+	int errs = 0;
+	int i;
+
+	table_end = (unsigned long)table_header + table_header->length;
+
+	/* Parse all entries looking for a match. */
+
+	entry.type = acpi_get_subtable_type(id);
+	entry.hdr = (union acpi_subtable_headers *)
+	    ((unsigned long)table_header + table_size);
+	subtable_len = acpi_get_subtable_header_length(&entry);
+
+	while (((unsigned long)entry.hdr) + subtable_len  < table_end) {
+		if (max_entries && count >= max_entries)
+			break;
+
+		for (i = 0; i < proc_num; i++) {
+			if (acpi_get_entry_type(&entry) != proc[i].id)
+				continue;
+			if (!has_handler(&proc[i]) ||
+			    (!errs &&
+			     call_handler(&proc[i], entry.hdr, table_end))) {
+				errs++;
+				continue;
+			}
+
+			proc[i].count++;
+			break;
+		}
+		if (i != proc_num)
+			count++;
+
+		/*
+		 * If entry->length is 0, break from this loop to avoid
+		 * infinite loop.
+		 */
+		entry_len = acpi_get_entry_length(&entry);
+		if (entry_len == 0) {
+			pr_err("[%4.4s:0x%02x] Invalid zero length\n", id, proc->id);
+			return -EINVAL;
+		}
+
+		entry.hdr = (union acpi_subtable_headers *)
+		    ((unsigned long)entry.hdr + entry_len);
+	}
+
+	if (max_entries && count > max_entries) {
+		pr_warn("[%4.4s:0x%02x] found the maximum %i entries\n",
+			id, proc->id, count);
+	}
+
+	return errs ? -EINVAL : count;
+}
+EXPORT_SYMBOL_GPL(acpi_parse_entries_array);


