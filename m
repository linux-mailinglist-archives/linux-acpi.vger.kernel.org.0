Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0521D440391
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ2TyC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Oct 2021 15:54:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:54417 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhJ2TyB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Oct 2021 15:54:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="230689470"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="230689470"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:51:32 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="448225519"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:51:32 -0700
Subject: [PATCH 1/6] ACPI: Keep sub-table parsing infrastructure available
 for modules
From:   Dan Williams <dan.j.williams@intel.com>
To:     rafael.j.wysocki@intel.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Fri, 29 Oct 2021 12:51:32 -0700
Message-ID: <163553709227.2509508.8215196520233473814.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The NFIT driver and now the CXL ACPI driver have both open-coded ACPI
table parsing. Before another instance is added arrange for the core
ACPI sub-table parsing to be optionally available to drivers via the
CONFIG_ACPI_TABLE_LIB symbol. If no drivers select the symbol then the
infrastructure reverts back to being tagged __init via the
__init_or_acpilib annotation.

For now, only tag the core sub-table routines and data that the CEDT parsing in
the cxl_acpi driver would want to reuse, a CEDT parsing helper is added
in a later change.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/Kconfig  |    3 +++
 drivers/acpi/tables.c |   27 +++++++++++++--------------
 include/linux/acpi.h  |   22 +++++++++++++++-------
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1da360c51d66..13ed24414956 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -59,6 +59,9 @@ config ACPI_SYSTEM_POWER_STATES_SUPPORT
 config ACPI_CCA_REQUIRED
 	bool
 
+config ACPI_TABLE_LIB
+	bool
+
 config ACPI_DEBUGGER
 	bool "AML debugger interface"
 	select ACPI_DEBUG
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index f9383736fa0f..29d44fe19ef0 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -34,7 +34,7 @@ static char *mps_inti_flags_trigger[] = { "dfl", "edge", "res", "level" };
 
 static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
-static int acpi_apic_instance __initdata;
+static int acpi_apic_instance __initdata_or_acpilib;
 
 enum acpi_subtable_type {
 	ACPI_SUBTABLE_COMMON,
@@ -51,7 +51,7 @@ struct acpi_subtable_entry {
  * Disable table checksum verification for the early stage due to the size
  * limitation of the current x86 early mapping implementation.
  */
-static bool acpi_verify_table_checksum __initdata = false;
+static bool acpi_verify_table_checksum __initdata_or_acpilib = false;
 
 void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 {
@@ -215,7 +215,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 	}
 }
 
-static unsigned long __init
+static unsigned long __init_or_acpilib
 acpi_get_entry_type(struct acpi_subtable_entry *entry)
 {
 	switch (entry->type) {
@@ -229,7 +229,7 @@ acpi_get_entry_type(struct acpi_subtable_entry *entry)
 	return 0;
 }
 
-static unsigned long __init
+static unsigned long __init_or_acpilib
 acpi_get_entry_length(struct acpi_subtable_entry *entry)
 {
 	switch (entry->type) {
@@ -243,7 +243,7 @@ acpi_get_entry_length(struct acpi_subtable_entry *entry)
 	return 0;
 }
 
-static unsigned long __init
+static unsigned long __init_or_acpilib
 acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 {
 	switch (entry->type) {
@@ -257,7 +257,7 @@ acpi_get_subtable_header_length(struct acpi_subtable_entry *entry)
 	return 0;
 }
 
-static enum acpi_subtable_type __init
+static enum acpi_subtable_type __init_or_acpilib
 acpi_get_subtable_type(char *id)
 {
 	if (strncmp(id, ACPI_SIG_HMAT, 4) == 0)
@@ -290,10 +290,10 @@ acpi_get_subtable_type(char *id)
  * On success returns sum of all matching entries for all proc handlers.
  * Otherwise, -ENODEV or -EINVAL is returned.
  */
-static int __init acpi_parse_entries_array(char *id, unsigned long table_size,
-		struct acpi_table_header *table_header,
-		struct acpi_subtable_proc *proc, int proc_num,
-		unsigned int max_entries)
+static int __init_or_acpilib acpi_parse_entries_array(
+	char *id, unsigned long table_size,
+	struct acpi_table_header *table_header, struct acpi_subtable_proc *proc,
+	int proc_num, unsigned int max_entries)
 {
 	struct acpi_subtable_entry entry;
 	unsigned long table_end, subtable_len, entry_len;
@@ -351,10 +351,9 @@ static int __init acpi_parse_entries_array(char *id, unsigned long table_size,
 	return errs ? -EINVAL : count;
 }
 
-int __init acpi_table_parse_entries_array(char *id,
-			 unsigned long table_size,
-			 struct acpi_subtable_proc *proc, int proc_num,
-			 unsigned int max_entries)
+int __init_or_acpilib acpi_table_parse_entries_array(
+	char *id, unsigned long table_size, struct acpi_subtable_proc *proc,
+	int proc_num, unsigned int max_entries)
 {
 	struct acpi_table_header *table_header = NULL;
 	int count;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 974d497a897d..509b72676e2e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -232,14 +232,22 @@ int acpi_locate_initial_tables (void);
 void acpi_reserve_initial_tables (void);
 void acpi_table_init_complete (void);
 int acpi_table_init (void);
+
+#ifdef CONFIG_ACPI_TABLE_LIB
+#define __init_or_acpilib
+#define __initdata_or_acpilib
+#else
+#define __init_or_acpilib __init
+#define __initdata_or_acpilib __initdata
+#endif
+
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
-int __init acpi_table_parse_entries(char *id, unsigned long table_size,
-			      int entry_id,
-			      acpi_tbl_entry_handler handler,
-			      unsigned int max_entries);
-int __init acpi_table_parse_entries_array(char *id, unsigned long table_size,
-			      struct acpi_subtable_proc *proc, int proc_num,
-			      unsigned int max_entries);
+int __init_or_acpilib acpi_table_parse_entries(char *id,
+		unsigned long table_size, int entry_id,
+		acpi_tbl_entry_handler handler, unsigned int max_entries);
+int __init_or_acpilib acpi_table_parse_entries_array(char *id,
+		unsigned long table_size, struct acpi_subtable_proc *proc,
+		int proc_num, unsigned int max_entries);
 int acpi_table_parse_madt(enum acpi_madt_type id,
 			  acpi_tbl_entry_handler handler,
 			  unsigned int max_entries);

