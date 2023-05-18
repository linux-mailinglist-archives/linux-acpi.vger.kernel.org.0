Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CCC7087DA
	for <lists+linux-acpi@lfdr.de>; Thu, 18 May 2023 20:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjERSdU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 May 2023 14:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjERSdT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 May 2023 14:33:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED7BE5E;
        Thu, 18 May 2023 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684434784; x=1715970784;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ym1vv7zPqo8/CdI9upk2Hh8lxDICoH9AjB/IR2QKk64=;
  b=hR51GZnr5/U0wTdihfHFxZx9fnwfGT2aO8NAFVAxYCQB2nRqyvaEdqkg
   qeVQQIZcfFW/x8d2zniWkjbVGWPauxJlnWdFdmEPURmSiMvrJyC5x5p7Y
   VBr46txtVHHgl2LTA6Klb900XvybE0qyAEcF/vBUg1+wB+akDv1b9VC/N
   Geya9zvpMuhpbolYsJ/+3xG+yn4gljBCAwmChBvn++f+BvossicSoyR4S
   1wcNSeVol9JoSH1/0ZlicmTDs5K4m5BkUhjc4JehcalYe1/KfXCD03dXf
   IaicKAhHjtFjvFJBCytAEzTRU2SNV1MV7hqMoqRryuwUr8Bg2C76Bmgcr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="341588700"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="341588700"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 11:33:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="814420260"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="814420260"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.136])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 11:33:02 -0700
Subject: [PATCH v2 1/4] acpi: Move common tables helper functions to common
 lib
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Thu, 18 May 2023 11:33:02 -0700
Message-ID: <168443478260.2966470.6881416930240756285.stgit@djiang5-mobl3>
In-Reply-To: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some of the routines in ACPI tables.c can be shared with parsing CDAT.
However, CDAT is used by CXL and can exist on platforms that do not use
ACPI. Split out the common routine from ACPI to accomodate platforms that
do not support ACPI. The common routines can be built outside of ACPI if
ACPI_TABLES_LIB is selected.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/Makefile          |    2 
 drivers/acpi/Kconfig      |    4 +
 drivers/acpi/Makefile     |    3 +
 drivers/acpi/tables.c     |  173 ----------------------------------------
 drivers/acpi/tables_lib.c |  194 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h      |   63 +++++++++------
 6 files changed, 241 insertions(+), 198 deletions(-)
 create mode 100644 drivers/acpi/tables_lib.c

diff --git a/drivers/Makefile b/drivers/Makefile
index 20b118dca999..1824797f7dfe 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -31,7 +31,7 @@ obj-y				+= idle/
 # IPMI must come before ACPI in order to provide IPMI opregion support
 obj-y				+= char/ipmi/
 
-obj-$(CONFIG_ACPI)		+= acpi/
+obj-y				+= acpi/
 
 # PnP must come after ACPI since it will eventually need to check if acpi
 # was used and do nothing if so
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ccbeab9500ec..ce74a20dc42f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -6,12 +6,16 @@
 config ARCH_SUPPORTS_ACPI
 	bool
 
+config ACPI_TABLES_LIB
+	bool
+
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on ARCH_SUPPORTS_ACPI
 	select PNP
 	select NLS
 	select CRC32
+	select ACPI_TABLES_LIB
 	default y if X86
 	help
 	  Advanced Configuration and Power Interface (ACPI) support for 
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index feb36c0b9446..4558e2876823 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -13,6 +13,9 @@ tables.o: $(src)/../../include/$(CONFIG_ACPI_CUSTOM_DSDT_FILE) ;
 
 endif
 
+obj-$(CONFIG_ACPI_TABLES_LIB)	+= acpi_tables_lib.o
+acpi_tables_lib-y := tables_lib.o
+
 obj-$(CONFIG_ACPI)		+= tables.o
 obj-$(CONFIG_X86)		+= blacklist.o
 
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
diff --git a/drivers/acpi/tables_lib.c b/drivers/acpi/tables_lib.c
new file mode 100644
index 000000000000..701001610fa9
--- /dev/null
+++ b/drivers/acpi/tables_lib.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  acpi_tables.c - ACPI Boot-Time Table Parsing
+ *
+ *  Copyright (C) 2001 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ */
+
+/* Uncomment next line to get verbose printout */
+/* #define DEBUG */
+#define pr_fmt(fmt) "ACPI: " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/irq.h>
+#include <linux/errno.h>
+#include <linux/acpi.h>
+#include <linux/memblock.h>
+#include <linux/earlycpio.h>
+#include <linux/initrd.h>
+#include <linux/security.h>
+#include <linux/kmemleak.h>
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
+static unsigned long acpi_get_entry_type(struct acpi_subtable_entry *entry)
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
+static unsigned long acpi_get_entry_length(struct acpi_subtable_entry *entry)
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
+static unsigned long
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
+static enum acpi_subtable_type acpi_get_subtable_type(char *id)
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
+static bool has_handler(struct acpi_subtable_proc *proc)
+{
+	return proc->handler || proc->handler_arg;
+}
+
+static int call_handler(struct acpi_subtable_proc *proc,
+			union acpi_subtable_headers *hdr, unsigned long end)
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
+int acpi_parse_entries_array(char *id, unsigned long table_size,
+			     struct acpi_table_header *table_header,
+			     struct acpi_subtable_proc *proc,
+			     int proc_num, unsigned int max_entries)
+{
+	struct acpi_subtable_entry entry;
+	unsigned long table_end, subtable_len, entry_len;
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
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index efff750f326d..57ffba91bfb5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -21,6 +21,30 @@
 #endif
 #include <acpi/acpi.h>
 
+/* Table Handlers */
+union acpi_subtable_headers {
+	struct acpi_subtable_header common;
+	struct acpi_hmat_structure hmat;
+	struct acpi_prmt_module_header prmt;
+	struct acpi_cedt_header cedt;
+};
+
+typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
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
 #ifdef	CONFIG_ACPI
 
 #include <linux/list.h>
@@ -129,22 +153,6 @@ enum acpi_address_range_id {
 };
 
 
-/* Table Handlers */
-union acpi_subtable_headers {
-	struct acpi_subtable_header common;
-	struct acpi_hmat_structure hmat;
-	struct acpi_prmt_module_header prmt;
-	struct acpi_cedt_header cedt;
-};
-
-typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
-
-typedef int (*acpi_tbl_entry_handler)(union acpi_subtable_headers *header,
-				      const unsigned long end);
-
-typedef int (*acpi_tbl_entry_handler_arg)(union acpi_subtable_headers *header,
-					  void *arg, const unsigned long end);
-
 /* Debugger support */
 
 struct acpi_debugger_ops {
@@ -218,14 +226,6 @@ static inline int acpi_debugger_notify_command_complete(void)
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
@@ -1524,4 +1524,19 @@ static inline void acpi_device_notify(struct device *dev) { }
 static inline void acpi_device_notify_remove(struct device *dev) { }
 #endif
 
+#ifdef CONFIG_ACPI_TABLES_LIB
+int acpi_parse_entries_array(char *id, unsigned long table_size,
+			     struct acpi_table_header *table_header,
+			     struct acpi_subtable_proc *proc,
+			     int proc_num, unsigned int max_entries);
+#else
+static inline int acpi_parse_entries_array(
+	char *id, unsigned long table_size,
+	struct acpi_table_header *table_header, struct acpi_subtable_proc *proc,
+	int proc_num, unsigned int max_entries)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #endif	/*_LINUX_ACPI_H*/


