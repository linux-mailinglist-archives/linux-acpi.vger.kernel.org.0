Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39FFBE562F
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 23:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfJYVyw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 17:54:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:27336 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJYVyw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 17:54:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 14:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="201936031"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 14:54:50 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH v2 01/12] ACPICA: Results from Clang changes/fixes From Clang V5.0.1. Mostly "set but never read" warnings.
Date:   Fri, 25 Oct 2019 14:36:49 -0700
Message-Id: <20191025213700.14685-2-erik.schmauss@intel.com>
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

ACPICA commit 1f08279b3eb13f17004159c28c391a390cd68feb

Link: https://github.com/acpica/acpica/commit/1f08279b
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/dbdisply.c  |  2 --
 drivers/acpi/acpica/dbinput.c   |  1 -
 drivers/acpi/acpica/dbmethod.c  |  4 ++++
 drivers/acpi/acpica/dbobject.c  |  1 -
 drivers/acpi/acpica/dsfield.c   |  3 ---
 drivers/acpi/acpica/evgpeblk.c  | 11 +++++++----
 drivers/acpi/acpica/evgpeinit.c |  3 ---
 drivers/acpi/acpica/evmisc.c    | 12 ++++++++++--
 drivers/acpi/acpica/evregion.c  |  4 ++--
 drivers/acpi/acpica/evrgnini.c  |  1 -
 drivers/acpi/acpica/nsdump.c    |  4 ++--
 drivers/acpi/acpica/psobject.c  |  5 ++---
 drivers/acpi/acpica/uttrack.c   |  2 +-
 13 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/acpica/dbdisply.c b/drivers/acpi/acpica/dbdisply.c
index 30ab62b0fec8..f2df416d0d2d 100644
--- a/drivers/acpi/acpica/dbdisply.c
+++ b/drivers/acpi/acpica/dbdisply.c
@@ -513,7 +513,6 @@ void acpi_db_display_results(void)
 		return;
 	}
 
-	obj_desc = walk_state->method_desc;
 	node = walk_state->method_node;
 
 	if (walk_state->results) {
@@ -565,7 +564,6 @@ void acpi_db_display_calling_tree(void)
 		return;
 	}
 
-	node = walk_state->method_node;
 	acpi_os_printf("Current Control Method Call Tree\n");
 
 	while (walk_state) {
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 55a7e10998d8..95738313916b 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -689,7 +689,6 @@ acpi_db_command_dispatch(char *input_buffer,
 
 	param_count = acpi_db_get_line(input_buffer);
 	command_index = acpi_db_match_command(acpi_gbl_db_args[0]);
-	temp = 0;
 
 	/*
 	 * We don't want to add the !! command to the history buffer. It
diff --git a/drivers/acpi/acpica/dbmethod.c b/drivers/acpi/acpica/dbmethod.c
index 76a15b6ffc5d..4e48a7de7413 100644
--- a/drivers/acpi/acpica/dbmethod.c
+++ b/drivers/acpi/acpica/dbmethod.c
@@ -321,6 +321,10 @@ acpi_status acpi_db_disassemble_method(char *name)
 	walk_state->parse_flags |= ACPI_PARSE_DISASSEMBLE;
 
 	status = acpi_ps_parse_aml(walk_state);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
 	(void)acpi_dm_parse_deferred_ops(op);
 
 	/* Now we can disassemble the method */
diff --git a/drivers/acpi/acpica/dbobject.c b/drivers/acpi/acpica/dbobject.c
index f9fc84bc3e84..4b4c530a0654 100644
--- a/drivers/acpi/acpica/dbobject.c
+++ b/drivers/acpi/acpica/dbobject.c
@@ -464,7 +464,6 @@ void acpi_db_decode_arguments(struct acpi_walk_state *walk_state)
 	u8 display_args = FALSE;
 
 	node = walk_state->method_node;
-	obj_desc = walk_state->method_desc;
 
 	/* There are no arguments for the module-level code case */
 
diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index cf4e061bb0f0..9151f00dfbdc 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -149,7 +149,6 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
 
 	if (walk_state->deferred_node) {
 		node = walk_state->deferred_node;
-		status = AE_OK;
 	} else {
 		/* Execute flag should always be set when this function is entered */
 
@@ -636,8 +635,6 @@ acpi_ds_init_field_objects(union acpi_parse_object *op,
 				}
 
 				/* Name already exists, just ignore this error */
-
-				status = AE_OK;
 			}
 
 			arg->common.node = node;
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index fb15e9e2373b..9c7adaa7b582 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -110,6 +110,9 @@ acpi_status acpi_ev_delete_gpe_block(struct acpi_gpe_block_info *gpe_block)
 
 	status =
 	    acpi_hw_disable_gpe_block(gpe_block->xrupt_block, gpe_block, NULL);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
 
 	if (!gpe_block->previous && !gpe_block->next) {
 
@@ -359,10 +362,10 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 	walk_info.gpe_device = gpe_device;
 	walk_info.execute_by_owner_id = FALSE;
 
-	status = acpi_ns_walk_namespace(ACPI_TYPE_METHOD, gpe_device,
-					ACPI_UINT32_MAX, ACPI_NS_WALK_NO_UNLOCK,
-					acpi_ev_match_gpe_method, NULL,
-					&walk_info, NULL);
+	(void)acpi_ns_walk_namespace(ACPI_TYPE_METHOD, gpe_device,
+				     ACPI_UINT32_MAX, ACPI_NS_WALK_NO_UNLOCK,
+				     acpi_ev_match_gpe_method, NULL, &walk_info,
+				     NULL);
 
 	/* Return the new block */
 
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index b04f982e59fa..70d21d5ec5f3 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -156,8 +156,6 @@ acpi_status acpi_ev_gpe_initialize(void)
 			 * GPE0 and GPE1 do not have to be contiguous in the GPE number
 			 * space. However, GPE0 always starts at GPE number zero.
 			 */
-			gpe_number_max = acpi_gbl_FADT.gpe1_base +
-			    ((register_count1 * ACPI_GPE_REGISTER_WIDTH) - 1);
 		}
 	}
 
@@ -169,7 +167,6 @@ acpi_status acpi_ev_gpe_initialize(void)
 
 		ACPI_DEBUG_PRINT((ACPI_DB_INIT,
 				  "There are no GPE blocks defined in the FADT\n"));
-		status = AE_OK;
 		goto cleanup;
 	}
 
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index d45f7639f7ee..aa98fe07cd1b 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -230,11 +230,15 @@ void acpi_ev_terminate(void)
 		/* Disable all GPEs in all GPE blocks */
 
 		status = acpi_ev_walk_gpe_list(acpi_hw_disable_gpe_block, NULL);
+		if (ACPI_FAILURE(status)) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"Could not disable GPEs in GPE block"));
+		}
 
 		status = acpi_ev_remove_global_lock_handler();
 		if (ACPI_FAILURE(status)) {
-			ACPI_ERROR((AE_INFO,
-				    "Could not remove Global Lock handler"));
+			ACPI_EXCEPTION((AE_INFO, status,
+					"Could not remove Global Lock handler"));
 		}
 
 		acpi_gbl_events_initialized = FALSE;
@@ -250,6 +254,10 @@ void acpi_ev_terminate(void)
 	/* Deallocate all handler objects installed within GPE info structs */
 
 	status = acpi_ev_walk_gpe_list(acpi_ev_delete_gpe_handlers, NULL);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Could not delete GPE handlers"));
+	}
 
 	/* Return to original mode if necessary */
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 45dc797df05d..1ff126460007 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -836,11 +836,11 @@ acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node *ec_device_node)
 	objects[1].type = ACPI_TYPE_INTEGER;
 	objects[1].integer.value = ACPI_REG_CONNECT;
 
-	status = acpi_evaluate_object(reg_method, NULL, &args, NULL);
+	(void)acpi_evaluate_object(reg_method, NULL, &args, NULL);
 
 exit:
 	/* We ignore all errors from above, don't care */
 
-	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+	(void)acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 	return_VOID;
 }
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
index 0b47bbcd2a23..aee09640d710 100644
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@ -198,7 +198,6 @@ acpi_ev_pci_config_region_setup(acpi_handle handle,
 						 * root bridge. Still need to return a context object
 						 * for the new PCI_Config operation region, however.
 						 */
-						status = AE_OK;
 					} else {
 						ACPI_EXCEPTION((AE_INFO, status,
 								"Could not install PciConfig handler "
diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 9731d7cf1b83..1df6d72ae46b 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -291,7 +291,7 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 					for (i = 0;
 					     (i < obj_desc->buffer.length
 					      && i < 12); i++) {
-						acpi_os_printf(" %.2hX",
+						acpi_os_printf(" %2.2X",
 							       obj_desc->buffer.
 							       pointer[i]);
 					}
@@ -404,7 +404,7 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 		case ACPI_TYPE_LOCAL_BANK_FIELD:
 		case ACPI_TYPE_LOCAL_INDEX_FIELD:
 
-			acpi_os_printf(" Off %.3X Len %.2X Acc %.2hd\n",
+			acpi_os_printf(" Off %.3X Len %.2X Acc %.2X\n",
 				       (obj_desc->common_field.
 					base_byte_offset * 8)
 				       +
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 98e5c7400e54..9acf5f7453e9 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -480,9 +480,8 @@ acpi_ps_complete_op(struct acpi_walk_state *walk_state,
 			    acpi_ps_get_opcode_info((*op)->common.aml_opcode);
 			walk_state->opcode = (*op)->common.aml_opcode;
 
-			status = walk_state->ascending_callback(walk_state);
-			status =
-			    acpi_ps_next_parse_state(walk_state, *op, status);
+			(void)walk_state->ascending_callback(walk_state);
+			(void)acpi_ps_next_parse_state(walk_state, *op, status);
 
 			status2 = acpi_ps_complete_this_op(walk_state, *op);
 			if (ACPI_FAILURE(status2)) {
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index 8052f7ef5025..14de4d15e618 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -660,7 +660,7 @@ void acpi_ut_dump_allocations(u32 component, const char *module)
 					case ACPI_DESC_TYPE_PARSER:
 
 						acpi_os_printf
-						    ("AmlOpcode 0x%04hX\n",
+						    ("AmlOpcode 0x%04X\n",
 						     descriptor->op.asl.
 						     aml_opcode);
 						break;
-- 
2.21.0

