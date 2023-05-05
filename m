Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BB56F87A5
	for <lists+linux-acpi@lfdr.de>; Fri,  5 May 2023 19:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjEERda (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 May 2023 13:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjEERdH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 May 2023 13:33:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6A22722;
        Fri,  5 May 2023 10:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683307978; x=1714843978;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FD/FDXX8oEQ3rexE82FfQ+JHlAlbXlbkJwbvnDyY0Bo=;
  b=c+VH92R9hcFYgtETcQzOCZbNEOQmHsRLqSoZElx+VSmaIzJURzUsumJ6
   AONTK+aoFl0RB5okPpNIIHQd41dDgUrVe/GF953WODKS+WE/0K2CWYs/N
   1B8zi1FyFH4i1x87CPpXNB6rzh0N3Y+j4MdmysndylJ6BKapC1yB0A9ot
   jKnqmGgPFYKwse9LCjMKOf3ZS+TtVC/RvX1maXcpH3QHlqKDW/OBnvBu4
   6ext6mPzMTZn9cwQhwwFbzMtPrHoJQf78jJCpxvC4lAjLiOCSnVYi7jqL
   mNGZNFmHC5ViYuupGabjS6OmnT7mPEDfjHQXxLyEc7N52TJ8Ou76QSXOu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="349301198"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="349301198"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 10:32:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="700531219"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="700531219"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 10:32:57 -0700
Subject: [PATCH 1/4] acpi: tables: Add CDAT table parsing support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Fri, 05 May 2023 10:32:56 -0700
Message-ID: <168330797672.2042604.12339416734589446371.stgit@djiang5-mobl3>
In-Reply-To: <168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3>
References: <168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3>
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
BE host. Export a function acpi_table_parse_cdat() for CXL driver to parse
a CDAT table.

In order to minimize ACPI code changes, __force is being utilized to deal
with the case of a big endien (BE) host parsing a CDAT. All CDAT data
structure variables are being force casted to __leX as appropriate.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/tables.c |   47 +++++++++++++++++++++++++++++++++++++++++++++--
 include/acpi/actbl1.h |    3 +++
 include/linux/acpi.h  |    4 ++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 7b4680da57d7..08486f6df442 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -42,6 +42,7 @@ enum acpi_subtable_type {
 	ACPI_SUBTABLE_HMAT,
 	ACPI_SUBTABLE_PRMT,
 	ACPI_SUBTABLE_CEDT,
+	ACPI_SUBTABLE_CDAT,
 };
 
 struct acpi_subtable_entry {
@@ -239,6 +240,8 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
 		return 0;
 	case ACPI_SUBTABLE_CEDT:
 		return entry->hdr->cedt.type;
+	case ACPI_SUBTABLE_CDAT:
+		return entry->hdr->cdat.type;
 	}
 	return 0;
 }
@@ -255,6 +258,8 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
 		return entry->hdr->prmt.length;
 	case ACPI_SUBTABLE_CEDT:
 		return entry->hdr->cedt.length;
+	case ACPI_SUBTABLE_CDAT:
+		return le16_to_cpu((__force __le16)entry->hdr->cdat.length);
 	}
 	return 0;
 }
@@ -271,6 +276,8 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 		return sizeof(entry->hdr->prmt);
 	case ACPI_SUBTABLE_CEDT:
 		return sizeof(entry->hdr->cedt);
+	case ACPI_SUBTABLE_CDAT:
+		return sizeof(entry->hdr->cdat);
 	}
 	return 0;
 }
@@ -284,9 +291,22 @@ acpi_get_subtable_type(char *id)
 		return ACPI_SUBTABLE_PRMT;
 	if (strncmp(id, ACPI_SIG_CEDT, 4) == 0)
 		return ACPI_SUBTABLE_CEDT;
+	if (strncmp(id, ACPI_SIG_CDAT, 4) == 0)
+		return ACPI_SUBTABLE_CDAT;
 	return ACPI_SUBTABLE_COMMON;
 }
 
+static unsigned long __init_or_acpilib
+acpi_table_get_length(enum acpi_subtable_type type,
+		      struct acpi_table_header *hdr)
+{
+	if (type == ACPI_SUBTABLE_CDAT)
+		return le32_to_cpu(
+			(__force __le32)((struct acpi_table_cdat *)hdr)->length);
+
+	return hdr->length;
+}
+
 static __init_or_acpilib bool has_handler(struct acpi_subtable_proc *proc)
 {
 	return proc->handler || proc->handler_arg;
@@ -332,16 +352,19 @@ static int __init_or_acpilib acpi_parse_entries_array(
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
@@ -464,6 +487,26 @@ int __init acpi_table_parse_madt(enum acpi_madt_type id,
 					    handler, max_entries);
 }
 
+int acpi_table_parse_cdat(enum acpi_cdat_type type,
+			  acpi_tbl_entry_handler_arg handler_arg, void *arg,
+			  struct acpi_table_cdat *table_header)
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
+			(struct acpi_table_header *)table_header,
+			&proc, 1, 0);
+}
+EXPORT_SYMBOL_NS_GPL(acpi_table_parse_cdat, CXL);
+
 /**
  * acpi_table_parse - find table with @id, run @handler on it
  * @id: table id to find
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 81b9e794424d..3119be093cfe 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -66,6 +66,9 @@
 #define ACPI_SIG_IEIT           "IEIT"
 #endif
 
+/* External to ACPI */
+#define ACPI_SIG_CDAT		"CDAT" /* Coherent Device Attribute Table */
+
 /*
  * All tables must be byte-packed to match the ACPI specification, since
  * the tables are provided by the system BIOS.
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index efff750f326d..4c3dfe7587e9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -135,6 +135,7 @@ union acpi_subtable_headers {
 	struct acpi_hmat_structure hmat;
 	struct acpi_prmt_module_header prmt;
 	struct acpi_cedt_header cedt;
+	struct acpi_cdat_header cdat;
 };
 
 typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
@@ -266,6 +267,9 @@ acpi_table_parse_cedt(enum acpi_cedt_type id,
 
 int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
+int acpi_table_parse_cdat(enum acpi_cdat_type type,
+			  acpi_tbl_entry_handler_arg handler, void *arg,
+			  struct acpi_table_cdat *table_header);
 
 /* the following numa functions are architecture-dependent */
 void acpi_numa_slit_init (struct acpi_table_slit *slit);


