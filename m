Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF6435ED71
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfGCU0h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 16:26:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:5192 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGCU0g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jul 2019 16:26:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="158088366"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2019 13:26:34 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 2/5] ACPICA: remove legacy module-level code due to deprecation
Date:   Wed,  3 Jul 2019 13:15:37 -0700
Message-Id: <20190703201540.26054-3-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190703201540.26054-1-erik.schmauss@intel.com>
References: <20190703201540.26054-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 1ca34b1a7b960ef321eae5dcddfff77707c88aef

There have been several places that has been calling functions
regarding module level code blocks. This change removes all old
vestiges in the codebase. This is dead code.

Link: https://github.com/acpica/acpica/commit/1ca34b1a
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h |   1 -
 drivers/acpi/acpica/acnamesp.h |   2 -
 drivers/acpi/acpica/nseval.c   | 190 ---------------------------------
 drivers/acpi/acpica/nsload.c   |  12 ---
 drivers/acpi/acpica/nsutils.c  |  12 ---
 drivers/acpi/acpica/tbdata.c   |  13 ---
 drivers/acpi/acpica/utinit.c   |   1 -
 drivers/acpi/acpica/utxfinit.c |  13 ---
 8 files changed, 244 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index d056a1845613..fd3beea93421 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -178,7 +178,6 @@ ACPI_GLOBAL(u8, acpi_gbl_verbose_leak_dump);
 ACPI_GLOBAL(struct acpi_namespace_node, acpi_gbl_root_node_struct);
 ACPI_GLOBAL(struct acpi_namespace_node *, acpi_gbl_root_node);
 ACPI_GLOBAL(struct acpi_namespace_node *, acpi_gbl_fadt_gpe_device);
-ACPI_GLOBAL(union acpi_operand_object *, acpi_gbl_module_code_list);
 
 extern const u8 acpi_gbl_ns_properties[ACPI_NUM_NS_TYPES];
 extern const struct acpi_predefined_names
diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index 39812fc4386a..7da1864798a0 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -207,8 +207,6 @@ acpi_ns_dump_object_paths(acpi_object_type type,
  */
 acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info);
 
-void acpi_ns_exec_module_code_list(void);
-
 /*
  * nsarguments - Argument count/type checking for predefined/reserved names
  */
diff --git a/drivers/acpi/acpica/nseval.c b/drivers/acpi/acpica/nseval.c
index 6390b7951ebf..63748ac699f7 100644
--- a/drivers/acpi/acpica/nseval.c
+++ b/drivers/acpi/acpica/nseval.c
@@ -14,11 +14,6 @@
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nseval")
 
-/* Local prototypes */
-static void
-acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
-			 struct acpi_evaluate_info *info);
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_evaluate
@@ -44,7 +39,6 @@ acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
  * MUTEX:       Locks interpreter
  *
  ******************************************************************************/
-
 acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info)
 {
 	acpi_status status;
@@ -310,187 +304,3 @@ acpi_status acpi_ns_evaluate(struct acpi_evaluate_info *info)
 	info->full_pathname = NULL;
 	return_ACPI_STATUS(status);
 }
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_exec_module_code_list
- *
- * PARAMETERS:  None
- *
- * RETURN:      None. Exceptions during method execution are ignored, since
- *              we cannot abort a table load.
- *
- * DESCRIPTION: Execute all elements of the global module-level code list.
- *              Each element is executed as a single control method.
- *
- * NOTE: With this option enabled, each block of detected executable AML
- * code that is outside of any control method is wrapped with a temporary
- * control method object and placed on a global list. The methods on this
- * list are executed below.
- *
- * This function executes the module-level code for all tables only after
- * all of the tables have been loaded. It is a legacy option and is
- * not compatible with other ACPI implementations. See acpi_ns_load_table.
- *
- * This function will be removed when the legacy option is removed.
- *
- ******************************************************************************/
-
-void acpi_ns_exec_module_code_list(void)
-{
-	union acpi_operand_object *prev;
-	union acpi_operand_object *next;
-	struct acpi_evaluate_info *info;
-	u32 method_count = 0;
-
-	ACPI_FUNCTION_TRACE(ns_exec_module_code_list);
-
-	/* Exit now if the list is empty */
-
-	next = acpi_gbl_module_code_list;
-	if (!next) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INIT_NAMES,
-				  "Legacy MLC block list is empty\n"));
-
-		return_VOID;
-	}
-
-	/* Allocate the evaluation information block */
-
-	info = ACPI_ALLOCATE(sizeof(struct acpi_evaluate_info));
-	if (!info) {
-		return_VOID;
-	}
-
-	/* Walk the list, executing each "method" */
-
-	while (next) {
-		prev = next;
-		next = next->method.mutex;
-
-		/* Clear the link field and execute the method */
-
-		prev->method.mutex = NULL;
-		acpi_ns_exec_module_code(prev, info);
-		method_count++;
-
-		/* Delete the (temporary) method object */
-
-		acpi_ut_remove_reference(prev);
-	}
-
-	ACPI_INFO(("Executed %u blocks of module-level executable AML code",
-		   method_count));
-
-	ACPI_FREE(info);
-	acpi_gbl_module_code_list = NULL;
-	return_VOID;
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ns_exec_module_code
- *
- * PARAMETERS:  method_obj          - Object container for the module-level code
- *              info                - Info block for method evaluation
- *
- * RETURN:      None. Exceptions during method execution are ignored, since
- *              we cannot abort a table load.
- *
- * DESCRIPTION: Execute a control method containing a block of module-level
- *              executable AML code. The control method is temporarily
- *              installed to the root node, then evaluated.
- *
- ******************************************************************************/
-
-static void
-acpi_ns_exec_module_code(union acpi_operand_object *method_obj,
-			 struct acpi_evaluate_info *info)
-{
-	union acpi_operand_object *parent_obj;
-	struct acpi_namespace_node *parent_node;
-	acpi_object_type type;
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ns_exec_module_code);
-
-	/*
-	 * Get the parent node. We cheat by using the next_object field
-	 * of the method object descriptor.
-	 */
-	parent_node =
-	    ACPI_CAST_PTR(struct acpi_namespace_node,
-				    method_obj->method.next_object);
-	type = acpi_ns_get_type(parent_node);
-
-	/*
-	 * Get the region handler and save it in the method object. We may need
-	 * this if an operation region declaration causes a _REG method to be run.
-	 *
-	 * We can't do this in acpi_ps_link_module_code because
-	 * acpi_gbl_root_node->Object is NULL at PASS1.
-	 */
-	if ((type == ACPI_TYPE_DEVICE) && parent_node->object) {
-		method_obj->method.dispatch.handler =
-		    parent_node->object->device.handler;
-	}
-
-	/* Must clear next_object (acpi_ns_attach_object needs the field) */
-
-	method_obj->method.next_object = NULL;
-
-	/* Initialize the evaluation information block */
-
-	memset(info, 0, sizeof(struct acpi_evaluate_info));
-	info->prefix_node = parent_node;
-
-	/*
-	 * Get the currently attached parent object. Add a reference,
-	 * because the ref count will be decreased when the method object
-	 * is installed to the parent node.
-	 */
-	parent_obj = acpi_ns_get_attached_object(parent_node);
-	if (parent_obj) {
-		acpi_ut_add_reference(parent_obj);
-	}
-
-	/* Install the method (module-level code) in the parent node */
-
-	status =
-	    acpi_ns_attach_object(parent_node, method_obj, ACPI_TYPE_METHOD);
-	if (ACPI_FAILURE(status)) {
-		goto exit;
-	}
-
-	/* Execute the parent node as a control method */
-
-	status = acpi_ns_evaluate(info);
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INIT_NAMES,
-			  "Executed module-level code at %p\n",
-			  method_obj->method.aml_start));
-
-	/* Delete a possible implicit return value (in slack mode) */
-
-	if (info->return_object) {
-		acpi_ut_remove_reference(info->return_object);
-	}
-
-	/* Detach the temporary method object */
-
-	acpi_ns_detach_object(parent_node);
-
-	/* Restore the original parent object */
-
-	if (parent_obj) {
-		status = acpi_ns_attach_object(parent_node, parent_obj, type);
-	} else {
-		parent_node->type = (u8)type;
-	}
-
-exit:
-	if (parent_obj) {
-		acpi_ut_remove_reference(parent_obj);
-	}
-	return_VOID;
-}
diff --git a/drivers/acpi/acpica/nsload.c b/drivers/acpi/acpica/nsload.c
index 35fff5c75da1..d7c4d6e8e21e 100644
--- a/drivers/acpi/acpica/nsload.c
+++ b/drivers/acpi/acpica/nsload.c
@@ -109,18 +109,6 @@ acpi_ns_load_table(u32 table_index, struct acpi_namespace_node *node)
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "**** Completed Table Object Initialization\n"));
 
-	/*
-	 * This case handles the legacy option that groups all module-level
-	 * code blocks together and defers execution until all of the tables
-	 * are loaded. Execute all of these blocks at this time.
-	 * Execute any module-level code that was detected during the table
-	 * load phase.
-	 *
-	 * Note: this option is deprecated and will be eliminated in the
-	 * future. Use of this option can cause problems with AML code that
-	 * depends upon in-order immediate execution of module-level code.
-	 */
-	acpi_ns_exec_module_code_list();
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 6bc90d46db5c..b8d007c84d32 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -560,21 +560,9 @@ struct acpi_namespace_node *acpi_ns_validate_handle(acpi_handle handle)
 void acpi_ns_terminate(void)
 {
 	acpi_status status;
-	union acpi_operand_object *prev;
-	union acpi_operand_object *next;
 
 	ACPI_FUNCTION_TRACE(ns_terminate);
 
-	/* Delete any module-level code blocks */
-
-	next = acpi_gbl_module_code_list;
-	while (next) {
-		prev = next;
-		next = next->method.mutex;
-		prev->method.mutex = NULL;	/* Clear the Mutex (cheated) field */
-		acpi_ut_remove_reference(prev);
-	}
-
 	/*
 	 * Free the entire namespace -- all nodes and all objects
 	 * attached to the nodes
diff --git a/drivers/acpi/acpica/tbdata.c b/drivers/acpi/acpica/tbdata.c
index 933f81316ad2..91a4b984f224 100644
--- a/drivers/acpi/acpica/tbdata.c
+++ b/drivers/acpi/acpica/tbdata.c
@@ -933,19 +933,6 @@ acpi_tb_load_table(u32 table_index, struct acpi_namespace_node *parent_node)
 
 	status = acpi_ns_load_table(table_index, parent_node);
 
-	/*
-	 * This case handles the legacy option that groups all module-level
-	 * code blocks together and defers execution until all of the tables
-	 * are loaded. Execute all of these blocks at this time.
-	 * Execute any module-level code that was detected during the table
-	 * load phase.
-	 *
-	 * Note: this option is deprecated and will be eliminated in the
-	 * future. Use of this option can cause problems with AML code that
-	 * depends upon in-order immediate execution of module-level code.
-	 */
-	acpi_ns_exec_module_code_list();
-
 	/*
 	 * Update GPEs for any new _Lxx/_Exx methods. Ignore errors. The host is
 	 * responsible for discovering any new wake GPEs by running _PRW methods
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index bc124591320e..6f33e7c72327 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -180,7 +180,6 @@ acpi_status acpi_ut_init_globals(void)
 
 	/* Namespace */
 
-	acpi_gbl_module_code_list = NULL;
 	acpi_gbl_root_node = NULL;
 	acpi_gbl_root_node_struct.name.integer = ACPI_ROOT_NAME;
 	acpi_gbl_root_node_struct.descriptor_type = ACPI_DESC_TYPE_NAMED;
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 9f3b1e3a09de..077b1af03283 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -211,19 +211,6 @@ acpi_status ACPI_INIT_FUNCTION acpi_initialize_objects(u32 flags)
 
 	ACPI_FUNCTION_TRACE(acpi_initialize_objects);
 
-	/*
-	 * This case handles the legacy option that groups all module-level
-	 * code blocks together and defers execution until all of the tables
-	 * are loaded. Execute all of these blocks at this time.
-	 * Execute any module-level code that was detected during the table
-	 * load phase.
-	 *
-	 * Note: this option is deprecated and will be eliminated in the
-	 * future. Use of this option can cause problems with AML code that
-	 * depends upon in-order immediate execution of module-level code.
-	 */
-	acpi_ns_exec_module_code_list();
-
 	/*
 	 * Initialize the objects that remain uninitialized. This
 	 * runs the executable AML that may be part of the
-- 
2.17.2

