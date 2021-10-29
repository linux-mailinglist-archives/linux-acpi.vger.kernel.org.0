Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E12440394
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 21:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhJ2TyV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Oct 2021 15:54:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:57954 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230271AbhJ2TyV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Oct 2021 15:54:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="217922058"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="217922058"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:51:43 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="726277904"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:51:42 -0700
Subject: [PATCH 3/6] ACPI: Add a context argument for table parsing handlers
From:   Dan Williams <dan.j.williams@intel.com>
To:     rafael.j.wysocki@intel.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Fri, 29 Oct 2021 12:51:42 -0700
Message-ID: <163553710257.2509508.14310494417463866020.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation for drivers reusing the core table parsing
infrastructure, arrange for handlers to take a context argument. This
allows driver table parsing to wrap ACPI table entries in
driver-specific data.

The first consumer of this infrastructure is the CEDT parsing that
happens in the cxl_acpi driver, add a conditional
(CONFIG_ACPI_TABLE_LIB=y) export of a acpi_table_parse_cedt() helper for
this case.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/tables.c |   51 ++++++++++++++++++++++++++++++++++++++++++-------
 include/linux/acpi.h  |   11 +++++++++++
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b1514fde11bc..0a7be92a4f37 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -276,6 +276,22 @@ acpi_get_subtable_type(char *id)
 	return ACPI_SUBTABLE_COMMON;
 }
 
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
 /**
  * acpi_parse_entries_array - for each proc_num find a suitable subtable
  *
@@ -326,8 +342,9 @@ static int __init_or_acpilib acpi_parse_entries_array(
 		for (i = 0; i < proc_num; i++) {
 			if (acpi_get_entry_type(&entry) != proc[i].id)
 				continue;
-			if (!proc[i].handler ||
-			     (!errs && proc[i].handler(entry.hdr, table_end))) {
+			if (!has_handler(&proc[i]) ||
+			    (!errs &&
+			     call_handler(&proc[i], entry.hdr, table_end))) {
 				errs++;
 				continue;
 			}
@@ -393,21 +410,41 @@ int __init_or_acpilib acpi_table_parse_entries_array(
 	return count;
 }
 
-int __init acpi_table_parse_entries(char *id,
-			unsigned long table_size,
-			int entry_id,
-			acpi_tbl_entry_handler handler,
-			unsigned int max_entries)
+static int __init_or_acpilib __acpi_table_parse_entries(
+	char *id, unsigned long table_size, int entry_id,
+	acpi_tbl_entry_handler handler, acpi_tbl_entry_handler_arg handler_arg,
+	void *arg, unsigned int max_entries)
 {
 	struct acpi_subtable_proc proc = {
 		.id		= entry_id,
 		.handler	= handler,
+		.handler_arg	= handler_arg,
+		.arg		= arg,
 	};
 
 	return acpi_table_parse_entries_array(id, table_size, &proc, 1,
 						max_entries);
 }
 
+int __init_or_acpilib
+acpi_table_parse_cedt(enum acpi_cedt_type id,
+		      acpi_tbl_entry_handler_arg handler_arg, void *arg)
+{
+	return __acpi_table_parse_entries(ACPI_SIG_CEDT,
+					  sizeof(struct acpi_table_cedt), id,
+					  NULL, handler_arg, arg, 0);
+}
+EXPORT_SYMBOL_ACPI_LIB(acpi_table_parse_cedt);
+
+int __init acpi_table_parse_entries(char *id, unsigned long table_size,
+				    int entry_id,
+				    acpi_tbl_entry_handler handler,
+				    unsigned int max_entries)
+{
+	return __acpi_table_parse_entries(id, table_size, entry_id, handler,
+					  NULL, NULL, max_entries);
+}
+
 int __init acpi_table_parse_madt(enum acpi_madt_type id,
 		      acpi_tbl_entry_handler handler, unsigned int max_entries)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index cbee050f4b1d..a077bd91ba4a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -141,6 +141,9 @@ typedef int (*acpi_tbl_table_handler)(struct acpi_table_header *table);
 typedef int (*acpi_tbl_entry_handler)(union acpi_subtable_headers *header,
 				      const unsigned long end);
 
+typedef int (*acpi_tbl_entry_handler_arg)(union acpi_subtable_headers *header,
+					  void *arg, const unsigned long end);
+
 /* Debugger support */
 
 struct acpi_debugger_ops {
@@ -217,6 +220,8 @@ static inline int acpi_debugger_notify_command_complete(void)
 struct acpi_subtable_proc {
 	int id;
 	acpi_tbl_entry_handler handler;
+	acpi_tbl_entry_handler_arg handler_arg;
+	void *arg;
 	int count;
 };
 
@@ -235,9 +240,11 @@ void acpi_table_init_complete (void);
 int acpi_table_init (void);
 
 #ifdef CONFIG_ACPI_TABLE_LIB
+#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
 #define __init_or_acpilib
 #define __initdata_or_acpilib
 #else
+#define EXPORT_SYMBOL_ACPI_LIB(x)
 #define __init_or_acpilib __init
 #define __initdata_or_acpilib __initdata
 #endif
@@ -252,6 +259,10 @@ int __init_or_acpilib acpi_table_parse_entries_array(char *id,
 int acpi_table_parse_madt(enum acpi_madt_type id,
 			  acpi_tbl_entry_handler handler,
 			  unsigned int max_entries);
+int __init_or_acpilib
+acpi_table_parse_cedt(enum acpi_cedt_type id,
+		      acpi_tbl_entry_handler_arg handler_arg, void *arg);
+
 int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 

