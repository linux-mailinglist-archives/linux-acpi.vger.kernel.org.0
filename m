Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C80DB90A92
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2019 23:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfHPV6h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Aug 2019 17:58:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:56320 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfHPV6d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Aug 2019 17:58:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 14:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="206381382"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2019 14:58:32 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 4/9] ACPICA: Fix issues with arg types within printf format strings
Date:   Fri, 16 Aug 2019 14:43:23 -0700
Message-Id: <20190816214328.3900-5-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190816214328.3900-1-erik.schmauss@intel.com>
References: <20190816214328.3900-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit db2638ccaac84b61e92f34d60c3630ff5217f852

Link: https://github.com/acpica/acpica/commit/db2638cc
Link: https://github.com/acpica/acpica/commit/634c3085
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/dbhistry.c  |  2 +-
 drivers/acpi/acpica/dbinput.c   |  2 +-
 drivers/acpi/acpica/dbstats.c   | 22 ++++++++++------------
 drivers/acpi/acpica/nsrepair2.c |  2 +-
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
index 7809bd94a18d..47d2e5059849 100644
--- a/drivers/acpi/acpica/dbhistry.c
+++ b/drivers/acpi/acpica/dbhistry.c
@@ -121,7 +121,7 @@ void acpi_db_display_history(void)
 
 	for (i = 0; i < acpi_gbl_num_history; i++) {
 		if (acpi_gbl_history_buffer[history_index].command) {
-			acpi_os_printf("%3ld %s\n",
+			acpi_os_printf("%3u %s\n",
 				       acpi_gbl_history_buffer[history_index].
 				       cmd_num,
 				       acpi_gbl_history_buffer[history_index].
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 3e5f95390f0d..32e4f0c6b5df 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -593,7 +593,7 @@ static u32 acpi_db_get_line(char *input_buffer)
 	     input_buffer)) {
 		acpi_os_printf
 		    ("Buffer overflow while parsing input line (max %u characters)\n",
-		     sizeof(acpi_gbl_db_parsed_buf));
+		     (u32)sizeof(acpi_gbl_db_parsed_buf));
 		return (0);
 	}
 
diff --git a/drivers/acpi/acpica/dbstats.c b/drivers/acpi/acpica/dbstats.c
index bf620937c79b..4f00351dcbb1 100644
--- a/drivers/acpi/acpica/dbstats.c
+++ b/drivers/acpi/acpica/dbstats.c
@@ -341,17 +341,17 @@ acpi_status acpi_db_display_statistics(char *type_arg)
 			       "ACPI_TYPE", "NODES", "OBJECTS");
 
 		for (i = 0; i < ACPI_TYPE_NS_NODE_MAX; i++) {
-			acpi_os_printf("%16.16s % 10ld% 10ld\n",
+			acpi_os_printf("%16.16s % 10u% 10u\n",
 				       acpi_ut_get_type_name(i),
 				       acpi_gbl_node_type_count[i],
 				       acpi_gbl_obj_type_count[i]);
 		}
 
-		acpi_os_printf("%16.16s % 10ld% 10ld\n", "Misc/Unknown",
+		acpi_os_printf("%16.16s % 10u% 10u\n", "Misc/Unknown",
 			       acpi_gbl_node_type_count_misc,
 			       acpi_gbl_obj_type_count_misc);
 
-		acpi_os_printf("%16.16s % 10ld% 10ld\n", "TOTALS:",
+		acpi_os_printf("%16.16s % 10u% 10u\n", "TOTALS:",
 			       acpi_gbl_num_nodes, acpi_gbl_num_objects);
 		break;
 
@@ -379,18 +379,16 @@ acpi_status acpi_db_display_statistics(char *type_arg)
 	case CMD_STAT_MISC:
 
 		acpi_os_printf("\nMiscellaneous Statistics:\n\n");
-		acpi_os_printf("Calls to AcpiPsFind:.. ........% 7ld\n",
-			       acpi_gbl_ps_find_count);
-		acpi_os_printf("Calls to AcpiNsLookup:..........% 7ld\n",
-			       acpi_gbl_ns_lookup_count);
+		acpi_os_printf("%-28s:     %7lu\n", "Calls to AcpiPsFind",
+			       (u64)acpi_gbl_ps_find_count);
+		acpi_os_printf("%-28s:     %7lu\n", "Calls to AcpiNsLookup",
+			       (u64)acpi_gbl_ns_lookup_count);
 
-		acpi_os_printf("\n");
-
-		acpi_os_printf("Mutex usage:\n\n");
+		acpi_os_printf("\nMutex usage:\n\n");
 		for (i = 0; i < ACPI_NUM_MUTEX; i++) {
-			acpi_os_printf("%-28s:     % 7ld\n",
+			acpi_os_printf("%-28s:     %7lu\n",
 				       acpi_ut_get_mutex_name(i),
-				       acpi_gbl_mutex_info[i].use_count);
+				       (u64)acpi_gbl_mutex_info[i].use_count);
 		}
 		break;
 
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 8d776256b213..663d85e0adba 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -126,7 +126,7 @@ static const struct acpi_repair_info acpi_ns_repairable_names[] = {
 
 #define ACPI_FDE_FIELD_COUNT        5
 #define ACPI_FDE_BYTE_BUFFER_SIZE   5
-#define ACPI_FDE_DWORD_BUFFER_SIZE  (ACPI_FDE_FIELD_COUNT * sizeof (u32))
+#define ACPI_FDE_DWORD_BUFFER_SIZE  (ACPI_FDE_FIELD_COUNT * (u32) sizeof (u32))
 
 /******************************************************************************
  *
-- 
2.17.2

