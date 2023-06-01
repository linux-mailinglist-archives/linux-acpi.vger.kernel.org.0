Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455CE71F4BC
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 23:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjFAVcG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 17:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjFAVcF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 17:32:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36C19A;
        Thu,  1 Jun 2023 14:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685655120; x=1717191120;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lpZ4n0fhfuIV+oImvyZ7HaKArddS3EZhg6GMiGR0mxI=;
  b=Qi4/SQqWW1XOraybCXGapANIyo6pwE+N+L8X71ME/exnZJ52nWoP/9uO
   Ub89OcCzBOB0UeapbhjqxQAVU2U5NM/J/YrNPL3N5tNoo20z3li/jGu5P
   +0z+v0Czcfq8FdqAkhqq/rUE1GHVpuhcGCIpq/WUP4acQK6nE4Evjnb8u
   OklbZ/xVWS+olIdvkB7BqDHDhhvz8GzJeHkE0bxGVbMbysR/OQqVctWC6
   4amvyWHoinbibIJaBpJXTlCxmDBaXt/NklESx7sxiwiVMlWn7GOVCqBgc
   bjPDEQAJ2l7h5tYqJwH4gpn4ho+ALuQZsa4BOa1+Uw5oqF+B2TsxTf7hR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421507444"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421507444"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="685016422"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="685016422"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.26.132])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 14:31:59 -0700
Subject: [PATCH v3 2/4] lib/firmware_table: tables: Add CDAT table parsing
 support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Thu, 01 Jun 2023 14:31:58 -0700
Message-ID: <168565511896.1098279.8010082917678621299.stgit@djiang5-mobl3>
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

The CDAT table is very similar to ACPI tables when it comes to sub-table
and entry structures. The helper functions can be also used to parse the
CDAT table. Add support to the helper functions to deal with an external
CDAT table, and also handle the endieness since CDAT can be processed by a
BE host. Export a function cdat_table_parse() for CXL driver to parse
a CDAT table.

In order to minimize ACPICA code changes, __force is being utilized to deal
with the case of a big endian (BE) host parsing a CDAT. All CDAT data
structure variables are being force casted to __leX as appropriate.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
Rafael,
Attempted to rename acpi_ prefix to something common but that ended up
causing a significant amount of ACPI code changes. I'll leave that alone
unless you'd like me to go that direction.

v2:
- Make acpi_table_header and acpi_table_cdat a union. (Jonathan)
- Use local var to make acpi_table_get_length() more readable. (Jonathan)
- Remove ACPI_SIG_CDAT define, already defined.
---
 drivers/acpi/tables.c    |    5 +++-
 include/linux/fw_table.h |   11 +++++++++-
 lib/fw_table.c           |   53 +++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index cfc76efd8788..d4c7a76a0fce 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -241,8 +241,9 @@ int __init_or_acpilib acpi_table_parse_entries_array(
 		return -ENODEV;
 	}
 
-	count = acpi_parse_entries_array(id, table_size, table_header,
-			proc, proc_num, max_entries);
+	count = acpi_parse_entries_array(id, table_size,
+					 (union fw_table_header *)table_header,
+					 proc, proc_num, max_entries);
 
 	acpi_put_table(table_header);
 	return count;
diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
index ff8fa58d5818..a97d368df520 100644
--- a/include/linux/fw_table.h
+++ b/include/linux/fw_table.h
@@ -28,16 +28,25 @@ struct acpi_subtable_proc {
 #include <linux/acpi.h>
 #include <acpi/acpi.h>
 
+union fw_table_header {
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
 
 int acpi_parse_entries_array(char *id, unsigned long table_size,
-			     struct acpi_table_header *table_header,
+			     union fw_table_header *table_header,
 			     struct acpi_subtable_proc *proc,
 			     int proc_num, unsigned int max_entries);
 
+int cdat_table_parse(enum acpi_cdat_type type,
+		     acpi_tbl_entry_handler_arg handler_arg, void *arg,
+		     struct acpi_table_cdat *table_header);
 #endif
diff --git a/lib/fw_table.c b/lib/fw_table.c
index e84bd0866e10..abf71bdb109a 100644
--- a/lib/fw_table.c
+++ b/lib/fw_table.c
@@ -18,6 +18,7 @@ enum acpi_subtable_type {
 	ACPI_SUBTABLE_HMAT,
 	ACPI_SUBTABLE_PRMT,
 	ACPI_SUBTABLE_CEDT,
+	CDAT_SUBTABLE,
 };
 
 struct acpi_subtable_entry {
@@ -37,6 +38,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
 		return 0;
 	case ACPI_SUBTABLE_CEDT:
 		return entry->hdr->cedt.type;
+	case CDAT_SUBTABLE:
+		return entry->hdr->cdat.type;
 	}
 	return 0;
 }
@@ -53,6 +56,10 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
 		return entry->hdr->prmt.length;
 	case ACPI_SUBTABLE_CEDT:
 		return entry->hdr->cedt.length;
+	case CDAT_SUBTABLE:
+		__le16 length = (__force __le16)entry->hdr->cdat.length;
+
+		return le16_to_cpu(length);
 	}
 	return 0;
 }
@@ -69,6 +76,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 		return sizeof(entry->hdr->prmt);
 	case ACPI_SUBTABLE_CEDT:
 		return sizeof(entry->hdr->cedt);
+	case CDAT_SUBTABLE:
+		return sizeof(entry->hdr->cdat);
 	}
 	return 0;
 }
@@ -82,9 +91,24 @@ acpi_get_subtable_type(char *id)
 		return ACPI_SUBTABLE_PRMT;
 	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
 		return ACPI_SUBTABLE_CEDT;
+	if (strncmp(id, ACPI_SIG_CDAT, 4) == 0)
+		return CDAT_SUBTABLE;
 	return ACPI_SUBTABLE_COMMON;
 }
 
+static unsigned long __init_or_acpilib
+acpi_table_get_length(enum acpi_subtable_type type,
+		      union fw_table_header *header)
+{
+	if (type == CDAT_SUBTABLE) {
+		__le32 length = (__force __le32)header->cdat.length;
+
+		return le32_to_cpu(length);
+	}
+
+	return header->acpi.length;
+}
+
 static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
 {
 	return proc->handler || proc->handler_arg;
@@ -126,21 +150,24 @@ static __init_or_acpilib int call_handler(struct acpi_subtable_proc *proc,
  */
 int __init_or_acpilib
 acpi_parse_entries_array(char *id, unsigned long table_size,
-			 struct acpi_table_header *table_header,
+			 union fw_table_header *table_header,
 			 struct acpi_subtable_proc *proc,
 			 int proc_num, unsigned int max_entries)
 {
 	unsigned long table_end, subtable_len, entry_len;
 	struct acpi_subtable_entry entry;
+	enum acpi_subtable_type type;
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
@@ -187,3 +214,23 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
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
+					sizeof(struct acpi_table_cdat),
+					(union fw_table_header *)table_header,
+					&proc, 1, 0);
+}
+EXPORT_SYMBOL_NS_GPL(cdat_table_parse, CXL);


