Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38094E5633
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 23:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfJYVyw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 17:54:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:27336 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfJYVyw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 17:54:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 14:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="201936036"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 14:54:50 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH v2 03/12] ACPICA: More Clang changes - V8.0.1 Fixed all "dead assignment" warnings.
Date:   Fri, 25 Oct 2019 14:36:51 -0700
Message-Id: <20191025213700.14685-4-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025213700.14685-1-erik.schmauss@intel.com>
References: <20191025213700.14685-1-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 54b3aefb5de860306951c8c3339b1c37dcdf1b39

Link: https://github.com/acpica/acpica/commit/54b3aefb
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/hwxfsleep.c | 3 +++
 drivers/acpi/acpica/nsconvert.c | 2 +-
 drivers/acpi/acpica/nsdump.c    | 2 --
 drivers/acpi/acpica/nsxfname.c  | 4 ++--
 drivers/acpi/acpica/psobject.c  | 6 ++----
 drivers/acpi/acpica/rscreate.c  | 3 +++
 drivers/acpi/acpica/tbdata.c    | 3 +++
 drivers/acpi/acpica/utids.c     | 2 --
 8 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index abbf9702aa7f..2919746c9041 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -166,6 +166,9 @@ acpi_status acpi_enter_sleep_state_s4bios(void)
 
 	status = acpi_hw_write_port(acpi_gbl_FADT.smi_command,
 				    (u32)acpi_gbl_FADT.s4_bios_request, 8);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
 
 	do {
 		acpi_os_stall(ACPI_USEC_PER_MSEC);
diff --git a/drivers/acpi/acpica/nsconvert.c b/drivers/acpi/acpica/nsconvert.c
index 14cbf63f1991..c86d0770ed6e 100644
--- a/drivers/acpi/acpica/nsconvert.c
+++ b/drivers/acpi/acpica/nsconvert.c
@@ -486,5 +486,5 @@ acpi_ns_convert_to_reference(struct acpi_namespace_node *scope,
 error_exit:
 	ACPI_FREE(name);
 	*return_object = new_object;
-	return (AE_OK);
+	return (status);
 }
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 1df6d72ae46b..9ad340f644a1 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -589,8 +589,6 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 
 			goto cleanup;
 		}
-
-		obj_type = ACPI_TYPE_INVALID;	/* Terminate loop after next pass */
 	}
 
 cleanup:
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 55b4a5b3331f..161e60ddfb69 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -425,8 +425,8 @@ acpi_get_object_info(acpi_handle handle,
 	}
 
 	if (cls) {
-		next_id_string = acpi_ns_copy_device_id(&info->class_code,
-							cls, next_id_string);
+		(void)acpi_ns_copy_device_id(&info->class_code,
+					     cls, next_id_string);
 	}
 
 	/* Copy the fixed-length data */
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 9acf5f7453e9..ded2779fc8ea 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -480,7 +480,7 @@ acpi_ps_complete_op(struct acpi_walk_state *walk_state,
 			    acpi_ps_get_opcode_info((*op)->common.aml_opcode);
 			walk_state->opcode = (*op)->common.aml_opcode;
 
-			(void)walk_state->ascending_callback(walk_state);
+			status = walk_state->ascending_callback(walk_state);
 			(void)acpi_ps_next_parse_state(walk_state, *op, status);
 
 			status2 = acpi_ps_complete_this_op(walk_state, *op);
@@ -489,7 +489,6 @@ acpi_ps_complete_op(struct acpi_walk_state *walk_state,
 			}
 		}
 
-		status = AE_OK;
 		break;
 
 	case AE_CTRL_BREAK:
@@ -511,14 +510,13 @@ acpi_ps_complete_op(struct acpi_walk_state *walk_state,
 		walk_state->opcode = (*op)->common.aml_opcode;
 
 		status = walk_state->ascending_callback(walk_state);
-		status = acpi_ps_next_parse_state(walk_state, *op, status);
+		(void)acpi_ps_next_parse_state(walk_state, *op, status);
 
 		status2 = acpi_ps_complete_this_op(walk_state, *op);
 		if (ACPI_FAILURE(status2)) {
 			return_ACPI_STATUS(status2);
 		}
 
-		status = AE_OK;
 		break;
 
 	case AE_CTRL_TERMINATE:
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 570ea0df8a1b..c659b54985a5 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -312,6 +312,9 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 				path_buffer.pointer = user_prt->source;
 
 				status = acpi_ns_handle_to_pathname((acpi_handle)node, &path_buffer, FALSE);
+				if (ACPI_FAILURE(status)) {
+					return_ACPI_STATUS(status);
+				}
 
 				/* +1 to include null terminator */
 
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 309440010ab2..2cf36451e46f 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -933,6 +933,9 @@ acpi_tb_load_table(u32 table_index, struct acpi_namespace_node *parent_node)
 	}
 
 	status = acpi_ns_load_table(table_index, parent_node);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
 
 	/*
 	 * Update GPEs for any new _Lxx/_Exx methods. Ignore errors. The host is
diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index e805abdd95b8..30198c828ab6 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -289,9 +289,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 						  value);
 			length = ACPI_EISAID_STRING_SIZE;
 		} else {	/* ACPI_TYPE_STRING */
-
 			/* Copy the String CID from the returned object */
-
 			strcpy(next_id_string, cid_objects[i]->string.pointer);
 			length = cid_objects[i]->string.length + 1;
 		}
-- 
2.21.0

