Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F12FF90A93
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2019 23:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfHPV6h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Aug 2019 17:58:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:56326 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbfHPV6f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Aug 2019 17:58:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 14:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="206381391"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2019 14:58:33 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 6/9] ACPICA: Fully deploy ACPI_PRINTF_LIKE macro Macro was not being used across all "printf-like" functions. Also, cleanup all calls to such functions now that they are analyzed by the compiler (gcc). Both in 32-bit mode and 64-bit mode.
Date:   Fri, 16 Aug 2019 14:43:25 -0700
Message-Id: <20190816214328.3900-7-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190816214328.3900-1-erik.schmauss@intel.com>
References: <20190816214328.3900-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit d06def132a8852d02c9c7fee60f17b2011066e8e

Link: https://github.com/acpica/acpica/commit/d06def13
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/acutils.h  |  3 ++
 drivers/acpi/acpica/dbinput.c  |  8 +--
 drivers/acpi/acpica/dbstats.c  | 94 +++++++++++++++++-----------------
 drivers/acpi/acpica/nsaccess.c |  2 +-
 drivers/acpi/acpica/utdebug.c  |  4 +-
 include/acpi/acpiosxf.h        |  1 +
 6 files changed, 58 insertions(+), 54 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index bcbc51a92dde..601808be86d1 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -686,18 +686,21 @@ void acpi_ut_delete_address_lists(void);
 /*
  * utxferror - various error/warning output functions
  */
+ACPI_PRINTF_LIKE(5)
 void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_predefined_warning(const char *module_name,
 			   u32 line_number,
 			   char *pathname,
 			   u16 node_flags, const char *format, ...);
 
+ACPI_PRINTF_LIKE(5)
 void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_predefined_info(const char *module_name,
 			u32 line_number,
 			char *pathname,
 			u16 node_flags, const char *format, ...);
 
+ACPI_PRINTF_LIKE(5)
 void ACPI_INTERNAL_VAR_XFACE
 acpi_ut_predefined_bios_error(const char *module_name,
 			      u32 line_number,
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 32e4f0c6b5df..55a7e10998d8 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -853,24 +853,24 @@ acpi_db_command_dispatch(char *input_buffer,
 
 		if (param_count == 0) {
 			acpi_os_printf
-			    ("Current debug level for file output is:    %8.8lX\n",
+			    ("Current debug level for file output is:    %8.8X\n",
 			     acpi_gbl_db_debug_level);
 			acpi_os_printf
-			    ("Current debug level for console output is: %8.8lX\n",
+			    ("Current debug level for console output is: %8.8X\n",
 			     acpi_gbl_db_console_debug_level);
 		} else if (param_count == 2) {
 			temp = acpi_gbl_db_console_debug_level;
 			acpi_gbl_db_console_debug_level =
 			    strtoul(acpi_gbl_db_args[1], NULL, 16);
 			acpi_os_printf
-			    ("Debug Level for console output was %8.8lX, now %8.8lX\n",
+			    ("Debug Level for console output was %8.8X, now %8.8X\n",
 			     temp, acpi_gbl_db_console_debug_level);
 		} else {
 			temp = acpi_gbl_db_debug_level;
 			acpi_gbl_db_debug_level =
 			    strtoul(acpi_gbl_db_args[1], NULL, 16);
 			acpi_os_printf
-			    ("Debug Level for file output was %8.8lX, now %8.8lX\n",
+			    ("Debug Level for file output was %8.8X, now %8.8X\n",
 			     temp, acpi_gbl_db_debug_level);
 		}
 		break;
diff --git a/drivers/acpi/acpica/dbstats.c b/drivers/acpi/acpica/dbstats.c
index 4f00351dcbb1..3af88e70238c 100644
--- a/drivers/acpi/acpica/dbstats.c
+++ b/drivers/acpi/acpica/dbstats.c
@@ -341,17 +341,17 @@ acpi_status acpi_db_display_statistics(char *type_arg)
 			       "ACPI_TYPE", "NODES", "OBJECTS");
 
 		for (i = 0; i < ACPI_TYPE_NS_NODE_MAX; i++) {
-			acpi_os_printf("%16.16s % 10u% 10u\n",
+			acpi_os_printf("%16.16s %10u %10u\n",
 				       acpi_ut_get_type_name(i),
 				       acpi_gbl_node_type_count[i],
 				       acpi_gbl_obj_type_count[i]);
 		}
 
-		acpi_os_printf("%16.16s % 10u% 10u\n", "Misc/Unknown",
+		acpi_os_printf("%16.16s %10u %10u\n", "Misc/Unknown",
 			       acpi_gbl_node_type_count_misc,
 			       acpi_gbl_obj_type_count_misc);
 
-		acpi_os_printf("%16.16s % 10u% 10u\n", "TOTALS:",
+		acpi_os_printf("%16.16s %10u %10u\n", "TOTALS:",
 			       acpi_gbl_num_nodes, acpi_gbl_num_objects);
 		break;
 
@@ -379,16 +379,16 @@ acpi_status acpi_db_display_statistics(char *type_arg)
 	case CMD_STAT_MISC:
 
 		acpi_os_printf("\nMiscellaneous Statistics:\n\n");
-		acpi_os_printf("%-28s:     %7lu\n", "Calls to AcpiPsFind",
-			       (u64)acpi_gbl_ps_find_count);
-		acpi_os_printf("%-28s:     %7lu\n", "Calls to AcpiNsLookup",
-			       (u64)acpi_gbl_ns_lookup_count);
+		acpi_os_printf("%-28s:     %7u\n", "Calls to AcpiPsFind",
+			       acpi_gbl_ps_find_count);
+		acpi_os_printf("%-28s:     %7u\n", "Calls to AcpiNsLookup",
+			       acpi_gbl_ns_lookup_count);
 
 		acpi_os_printf("\nMutex usage:\n\n");
 		for (i = 0; i < ACPI_NUM_MUTEX; i++) {
-			acpi_os_printf("%-28s:     %7lu\n",
+			acpi_os_printf("%-28s:     %7u\n",
 				       acpi_ut_get_mutex_name(i),
-				       (u64)acpi_gbl_mutex_info[i].use_count);
+				       acpi_gbl_mutex_info[i].use_count);
 		}
 		break;
 
@@ -397,87 +397,87 @@ acpi_status acpi_db_display_statistics(char *type_arg)
 		acpi_os_printf("\nInternal object sizes:\n\n");
 
 		acpi_os_printf("Common         %3d\n",
-			       sizeof(struct acpi_object_common));
+			       (u32)sizeof(struct acpi_object_common));
 		acpi_os_printf("Number         %3d\n",
-			       sizeof(struct acpi_object_integer));
+			       (u32)sizeof(struct acpi_object_integer));
 		acpi_os_printf("String         %3d\n",
-			       sizeof(struct acpi_object_string));
+			       (u32)sizeof(struct acpi_object_string));
 		acpi_os_printf("Buffer         %3d\n",
-			       sizeof(struct acpi_object_buffer));
+			       (u32)sizeof(struct acpi_object_buffer));
 		acpi_os_printf("Package        %3d\n",
-			       sizeof(struct acpi_object_package));
+			       (u32)sizeof(struct acpi_object_package));
 		acpi_os_printf("BufferField    %3d\n",
-			       sizeof(struct acpi_object_buffer_field));
+			       (u32)sizeof(struct acpi_object_buffer_field));
 		acpi_os_printf("Device         %3d\n",
-			       sizeof(struct acpi_object_device));
+			       (u32)sizeof(struct acpi_object_device));
 		acpi_os_printf("Event          %3d\n",
-			       sizeof(struct acpi_object_event));
+			       (u32)sizeof(struct acpi_object_event));
 		acpi_os_printf("Method         %3d\n",
-			       sizeof(struct acpi_object_method));
+			       (u32)sizeof(struct acpi_object_method));
 		acpi_os_printf("Mutex          %3d\n",
-			       sizeof(struct acpi_object_mutex));
+			       (u32)sizeof(struct acpi_object_mutex));
 		acpi_os_printf("Region         %3d\n",
-			       sizeof(struct acpi_object_region));
+			       (u32)sizeof(struct acpi_object_region));
 		acpi_os_printf("PowerResource  %3d\n",
-			       sizeof(struct acpi_object_power_resource));
+			       (u32)sizeof(struct acpi_object_power_resource));
 		acpi_os_printf("Processor      %3d\n",
-			       sizeof(struct acpi_object_processor));
+			       (u32)sizeof(struct acpi_object_processor));
 		acpi_os_printf("ThermalZone    %3d\n",
-			       sizeof(struct acpi_object_thermal_zone));
+			       (u32)sizeof(struct acpi_object_thermal_zone));
 		acpi_os_printf("RegionField    %3d\n",
-			       sizeof(struct acpi_object_region_field));
+			       (u32)sizeof(struct acpi_object_region_field));
 		acpi_os_printf("BankField      %3d\n",
-			       sizeof(struct acpi_object_bank_field));
+			       (u32)sizeof(struct acpi_object_bank_field));
 		acpi_os_printf("IndexField     %3d\n",
-			       sizeof(struct acpi_object_index_field));
+			       (u32)sizeof(struct acpi_object_index_field));
 		acpi_os_printf("Reference      %3d\n",
-			       sizeof(struct acpi_object_reference));
+			       (u32)sizeof(struct acpi_object_reference));
 		acpi_os_printf("Notify         %3d\n",
-			       sizeof(struct acpi_object_notify_handler));
+			       (u32)sizeof(struct acpi_object_notify_handler));
 		acpi_os_printf("AddressSpace   %3d\n",
-			       sizeof(struct acpi_object_addr_handler));
+			       (u32)sizeof(struct acpi_object_addr_handler));
 		acpi_os_printf("Extra          %3d\n",
-			       sizeof(struct acpi_object_extra));
+			       (u32)sizeof(struct acpi_object_extra));
 		acpi_os_printf("Data           %3d\n",
-			       sizeof(struct acpi_object_data));
+			       (u32)sizeof(struct acpi_object_data));
 
 		acpi_os_printf("\n");
 
 		acpi_os_printf("ParseObject    %3d\n",
-			       sizeof(struct acpi_parse_obj_common));
+			       (u32)sizeof(struct acpi_parse_obj_common));
 		acpi_os_printf("ParseObjectNamed %3d\n",
-			       sizeof(struct acpi_parse_obj_named));
+			       (u32)sizeof(struct acpi_parse_obj_named));
 		acpi_os_printf("ParseObjectAsl %3d\n",
-			       sizeof(struct acpi_parse_obj_asl));
+			       (u32)sizeof(struct acpi_parse_obj_asl));
 		acpi_os_printf("OperandObject  %3d\n",
-			       sizeof(union acpi_operand_object));
+			       (u32)sizeof(union acpi_operand_object));
 		acpi_os_printf("NamespaceNode  %3d\n",
-			       sizeof(struct acpi_namespace_node));
+			       (u32)sizeof(struct acpi_namespace_node));
 		acpi_os_printf("AcpiObject     %3d\n",
-			       sizeof(union acpi_object));
+			       (u32)sizeof(union acpi_object));
 
 		acpi_os_printf("\n");
 
 		acpi_os_printf("Generic State  %3d\n",
-			       sizeof(union acpi_generic_state));
+			       (u32)sizeof(union acpi_generic_state));
 		acpi_os_printf("Common State   %3d\n",
-			       sizeof(struct acpi_common_state));
+			       (u32)sizeof(struct acpi_common_state));
 		acpi_os_printf("Control State  %3d\n",
-			       sizeof(struct acpi_control_state));
+			       (u32)sizeof(struct acpi_control_state));
 		acpi_os_printf("Update State   %3d\n",
-			       sizeof(struct acpi_update_state));
+			       (u32)sizeof(struct acpi_update_state));
 		acpi_os_printf("Scope State    %3d\n",
-			       sizeof(struct acpi_scope_state));
+			       (u32)sizeof(struct acpi_scope_state));
 		acpi_os_printf("Parse Scope    %3d\n",
-			       sizeof(struct acpi_pscope_state));
+			       (u32)sizeof(struct acpi_pscope_state));
 		acpi_os_printf("Package State  %3d\n",
-			       sizeof(struct acpi_pkg_state));
+			       (u32)sizeof(struct acpi_pkg_state));
 		acpi_os_printf("Thread State   %3d\n",
-			       sizeof(struct acpi_thread_state));
+			       (u32)sizeof(struct acpi_thread_state));
 		acpi_os_printf("Result Values  %3d\n",
-			       sizeof(struct acpi_result_values));
+			       (u32)sizeof(struct acpi_result_values));
 		acpi_os_printf("Notify Info    %3d\n",
-			       sizeof(struct acpi_notify_info));
+			       (u32)sizeof(struct acpi_notify_info));
 		break;
 
 	case CMD_STAT_STACK:
diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 2566e2d4c780..3f045b5953b2 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -598,7 +598,7 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 				if (flags & ACPI_NS_PREFIX_MUST_EXIST) {
 					acpi_os_printf(ACPI_MSG_BIOS_ERROR
 						       "Object does not exist: %4.4s\n",
-						       &simple_name);
+						       (char *)&simple_name);
 				}
 #endif
 				/* Name not found in ACPI namespace */
diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 01b1b36c8a8e..5b169b5f0f1a 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -158,7 +158,7 @@ acpi_debug_print(u32 requested_debug_level,
 	 * Display the module name, current line number, thread ID (if requested),
 	 * current procedure nesting level, and the current procedure name
 	 */
-	acpi_os_printf("%9s-%04ld ", module_name, line_number);
+	acpi_os_printf("%9s-%04d ", module_name, line_number);
 
 #ifdef ACPI_APPLICATION
 	/*
@@ -177,7 +177,7 @@ acpi_debug_print(u32 requested_debug_level,
 		fill_count = 0;
 	}
 
-	acpi_os_printf("[%02ld] %*s",
+	acpi_os_printf("[%02d] %*s",
 		       acpi_gbl_nesting_level, acpi_gbl_nesting_level + 1, " ");
 	acpi_os_printf("%s%*s: ",
 		       acpi_ut_trim_function_name(function_name), fill_count,
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 1b59fb61f67d..2e63b7b390f5 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -330,6 +330,7 @@ acpi_status acpi_os_enter_sleep(u8 sleep_state, u32 rega_value, u32 regb_value);
  * Debug print routines
  */
 #ifndef ACPI_USE_ALTERNATE_PROTOTYPE_acpi_os_printf
+ACPI_PRINTF_LIKE(1)
 void ACPI_INTERNAL_VAR_XFACE acpi_os_printf(const char *format, ...);
 #endif
 
-- 
2.17.2

