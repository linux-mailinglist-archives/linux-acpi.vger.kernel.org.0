Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C5D7087DC
	for <lists+linux-acpi@lfdr.de>; Thu, 18 May 2023 20:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjERSd3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 May 2023 14:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjERSdW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 May 2023 14:33:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E25BE4F;
        Thu, 18 May 2023 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684434790; x=1715970790;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E0iekXhDQiXRad0eHsJzH45+eKLx4A3ZMETtRelLzEQ=;
  b=QRxT/cudMGB2RKl+e87iSrDYj+oM3CqqAUQHDIgaUI6P6KgzCY9AOH5L
   Ig1LId4HmnFKGnMB/lQsyDkecaJcAEfm8XAo3BAc5gry6p7JDGMr5p4a5
   Je6tpFK3+z7vA3OC30kUFZEoCsk1YKtyEgpx64qfUjsSs2LGEphENPM6A
   eTXI8AN4HQQigtdsHOvBY+CeKmbXEkRM2sDS9rCZ3b21uWt7r74AN/G4Q
   x1TQ8D4kIrAQPmY3LGaLOhn1NeOMWOW+KcM3POP32nSSr9WIY3fV3Ue8u
   pVXhf0dXy0e9WyIz+1rdOQtSu5Yn9EG1+anBn9cees8eno5Bxq2kW0cDs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="341588748"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="341588748"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 11:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="814420308"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="814420308"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.136])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 11:33:08 -0700
Subject: [PATCH v2 2/4] acpi: tables: Add CDAT table parsing support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Thu, 18 May 2023 11:33:08 -0700
Message-ID: <168443478863.2966470.17477171378435115702.stgit@djiang5-mobl3>
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

The CDAT table is very similar to ACPI tables when it comes to sub-table
and entry structures. The helper functions can be also used to parse the
CDAT table. Add support to the helper functions to deal with an external
CDAT table, and also handle the endieness since CDAT can be processed by a
BE host. Export a function cdat_table_parse() for CXL driver to parse
a CDAT table.

In order to minimize ACPICA code changes, __force is being utilized to deal
with the case of a big endien (BE) host parsing a CDAT. All CDAT data
structure variables are being force casted to __leX as appropriate.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Make acpi_table_header and acpi_table_cdat a union. (Jonathan)
- Use local var to make acpi_table_get_length() more readable. (Jonathan)
- Remove ACPI_SIG_CDAT define, already defined.
---
 drivers/acpi/tables.c     |    5 +++-
 drivers/acpi/tables_lib.c |   52 ++++++++++++++++++++++++++++++++++++++++++---
 include/linux/acpi.h      |   22 +++++++++++++++++--
 3 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index cfc76efd8788..f7e1ea192576 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -241,8 +241,9 @@ int __init_or_acpilib acpi_table_parse_entries_array(
 		return -ENODEV;
 	}
 
-	count = acpi_parse_entries_array(id, table_size, table_header,
-			proc, proc_num, max_entries);
+	count = acpi_parse_entries_array(id, table_size,
+					 (union table_header *)table_header,
+					 proc, proc_num, max_entries);
 
 	acpi_put_table(table_header);
 	return count;
diff --git a/drivers/acpi/tables_lib.c b/drivers/acpi/tables_lib.c
index 701001610fa9..71e2fb1735e5 100644
--- a/drivers/acpi/tables_lib.c
+++ b/drivers/acpi/tables_lib.c
@@ -28,6 +28,7 @@ enum acpi_subtable_type {
 	ACPI_SUBTABLE_HMAT,
 	ACPI_SUBTABLE_PRMT,
 	ACPI_SUBTABLE_CEDT,
+	CDAT_SUBTABLE,
 };
 
 struct acpi_subtable_entry {
@@ -46,6 +47,8 @@ static unsigned long acpi_get_entry_type(struct acpi_subtable_entry *entry)
 		return 0;
 	case ACPI_SUBTABLE_CEDT:
 		return entry->hdr->cedt.type;
+	case CDAT_SUBTABLE:
+		return entry->hdr->cdat.type;
 	}
 	return 0;
 }
@@ -61,6 +64,11 @@ static unsigned long acpi_get_entry_length(struct acpi_subtable_entry *entry)
 		return entry->hdr->prmt.length;
 	case ACPI_SUBTABLE_CEDT:
 		return entry->hdr->cedt.length;
+	case CDAT_SUBTABLE: {
+		__le16 length = (__force __le16)entry->hdr->cdat.length;
+
+		return le16_to_cpu(length);
+	}
 	}
 	return 0;
 }
@@ -77,6 +85,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 		return sizeof(entry->hdr->prmt);
 	case ACPI_SUBTABLE_CEDT:
 		return sizeof(entry->hdr->cedt);
+	case CDAT_SUBTABLE:
+		return sizeof(entry->hdr->cdat);
 	}
 	return 0;
 }
@@ -89,9 +99,23 @@ static enum acpi_subtable_type acpi_get_subtable_type(char *id)
 		return ACPI_SUBTABLE_PRMT;
 	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
 		return ACPI_SUBTABLE_CEDT;
+	if (strncmp(id, ACPI_SIG_CDAT, 4) == 0)
+		return CDAT_SUBTABLE;
 	return ACPI_SUBTABLE_COMMON;
 }
 
+static unsigned long acpi_table_get_length(enum acpi_subtable_type type,
+					   union table_header *hdr)
+{
+	if (type == CDAT_SUBTABLE) {
+		__le32 length = (__force __le32)hdr->cdat.length;
+
+		return le32_to_cpu(length);
+	}
+
+	return hdr->acpi.length;
+}
+
 static bool has_handler(struct acpi_subtable_proc *proc)
 {
 	return proc->handler || proc->handler_arg;
@@ -131,21 +155,24 @@ static int call_handler(struct acpi_subtable_proc *proc,
  * Otherwise, -ENODEV or -EINVAL is returned.
  */
 int acpi_parse_entries_array(char *id, unsigned long table_size,
-			     struct acpi_table_header *table_header,
+			     union table_header *table_header,
 			     struct acpi_subtable_proc *proc,
 			     int proc_num, unsigned int max_entries)
 {
 	struct acpi_subtable_entry entry;
+	enum acpi_subtable_type type;
 	unsigned long table_end, subtable_len, entry_len;
 	int count = 0;
 	int errs = 0;
 	int i;
 
-	table_end = (unsigned long)table_header + table_header->length;
+	type = acpi_get_subtable_type(id);
+	table_end = (unsigned long)table_header +
+		    acpi_table_get_length(type, table_header);
 
 	/* Parse all entries looking for a match. */
 
-	entry.type = acpi_get_subtable_type(id);
+	entry.type = type;
 	entry.hdr = (union acpi_subtable_headers *)
 	    ((unsigned long)table_header + table_size);
 	subtable_len = acpi_get_subtable_header_length(&entry);
@@ -192,3 +219,22 @@ int acpi_parse_entries_array(char *id, unsigned long table_size,
 	return errs ? -EINVAL : count;
 }
 EXPORT_SYMBOL_GPL(acpi_parse_entries_array);
+
+int cdat_table_parse(enum acpi_cdat_type type,
+		     acpi_tbl_entry_handler_arg handler_arg, void *arg,
+		     struct acpi_table_cdat *table_header)
+{
+	struct acpi_subtable_proc proc = {
+		.id		= type,
+		.handler_arg	= handler_arg,
+		.arg		= arg,
+	};
+
+	if (!table_header)
+		return -EINVAL;
+
+	return acpi_parse_entries_array(ACPI_SIG_CDAT,
+			sizeof(struct acpi_table_cdat),
+			(union table_header *)table_header, &proc, 1, 0);
+}
+EXPORT_SYMBOL_NS_GPL(cdat_table_parse, CXL);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 57ffba91bfb5..4a5b40463048 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -22,11 +22,17 @@
 #include <acpi/acpi.h>
 
 /* Table Handlers */
+union table_header {
+	struct acpi_table_header acpi;
+	struct acpi_table_cdat cdat;
+};
+
 union acpi_subtable_headers {
 	struct acpi_subtable_header common;
 	struct acpi_hmat_structure hmat;
 	struct acpi_prmt_module_header prmt;
 	struct acpi_cedt_header cedt;
+	struct acpi_cdat_header cdat;
 };
 
 typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
@@ -1526,17 +1532,29 @@ static inline void acpi_device_notify_remove(struct device *dev) { }
 
 #ifdef CONFIG_ACPI_TABLES_LIB
 int acpi_parse_entries_array(char *id, unsigned long table_size,
-			     struct acpi_table_header *table_header,
+			     union table_header *table_header,
 			     struct acpi_subtable_proc *proc,
 			     int proc_num, unsigned int max_entries);
+
+int cdat_table_parse(enum acpi_cdat_type type,
+		     acpi_tbl_entry_handler_arg handler, void *arg,
+		     struct acpi_table_cdat *table_header);
 #else
 static inline int acpi_parse_entries_array(
 	char *id, unsigned long table_size,
-	struct acpi_table_header *table_header, struct acpi_subtable_proc *proc,
+	union table_header *table_header, struct acpi_subtable_proc *proc,
 	int proc_num, unsigned int max_entries)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int cdat_table_parse(
+		enum acpi_cdat_type type,
+		acpi_tbl_entry_handler_arg handler, void *arg,
+		struct acpi_table_cdat *table_header)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #endif	/*_LINUX_ACPI_H*/


