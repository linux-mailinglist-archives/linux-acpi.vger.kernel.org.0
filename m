Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54700286D21
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 05:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgJHDWE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 23:22:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:29857 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbgJHDWD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Oct 2020 23:22:03 -0400
IronPort-SDR: cprx7rVmqMdPy6M5AvJZx7toxUtNWqr05HyB0eWwcVhQ9UXAxqfsvdmZ1VOwLNdii8dbOqirnf
 50GmKSgb2+Uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="162613653"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="162613653"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 20:22:02 -0700
IronPort-SDR: X6OcPgqoq3AnvIblU9PQYphKHQ2HoDsZQcrJWM+VBwLiV+EHcrj9mY8UcC4vAjHzyaF1BMfaYU
 Jz81G8bS+Q1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="355229352"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 20:22:02 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 7/9] ACPICA: Debugger: Add a new command: "ALL <NameSeg>"
Date:   Wed,  7 Oct 2020 19:54:01 -0700
Message-Id: <20201008025403.2401736-8-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008025403.2401736-1-erik.kaneda@intel.com>
References: <20201008025403.2401736-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This command will execute/evaluate all objects with a match to the
<NameSeg> argument.

ACPICA commit a1a32ec054f067d1617067e2bafb0a27a8728e07

Link: https://github.com/acpica/acpica/commit/a1a32ec0
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/acdebug.h  |   4 +
 drivers/acpi/acpica/dbexec.c   |  39 ++++++--
 drivers/acpi/acpica/dbinput.c  |  12 +++
 drivers/acpi/acpica/dbmethod.c | 167 ++++++++++++++++++++++++++++-----
 4 files changed, 188 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index a676daaa2da5..f8a3abdfe250 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -37,12 +37,14 @@ struct acpi_db_argument_info {
 struct acpi_db_execute_walk {
 	u32 count;
 	u32 max_count;
+	char name_seg[ACPI_NAMESEG_SIZE + 1];
 };
 
 #define PARAM_LIST(pl)                  pl
 
 #define EX_NO_SINGLE_STEP               1
 #define EX_SINGLE_STEP                  2
+#define EX_ALL                          4
 
 /*
  * dbxface - external debugger interfaces
@@ -124,6 +126,8 @@ void acpi_db_disassemble_aml(char *statements, union acpi_parse_object *op);
 
 void acpi_db_evaluate_predefined_names(void);
 
+void acpi_db_evaluate_all(char *name_seg);
+
 /*
  * dbnames - namespace commands
  */
diff --git a/drivers/acpi/acpica/dbexec.c b/drivers/acpi/acpica/dbexec.c
index 4027eaab18a4..d3a9521e2dc8 100644
--- a/drivers/acpi/acpica/dbexec.c
+++ b/drivers/acpi/acpica/dbexec.c
@@ -86,7 +86,8 @@ void acpi_db_delete_objects(u32 count, union acpi_object *objects)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Execute a control method.
+ * DESCRIPTION: Execute a control method. Used to evaluate objects via the
+ *              "EXECUTE" or "EVALUATE" commands.
  *
  ******************************************************************************/
 
@@ -314,11 +315,12 @@ acpi_db_execution_walk(acpi_handle obj_handle,
 
 	status = acpi_evaluate_object(node, NULL, NULL, &return_obj);
 
+	acpi_gbl_method_executing = FALSE;
+
 	acpi_os_printf("Evaluation of [%4.4s] returned %s\n",
 		       acpi_ut_get_node_name(node),
 		       acpi_format_exception(status));
 
-	acpi_gbl_method_executing = FALSE;
 	return (AE_OK);
 }
 
@@ -334,7 +336,8 @@ acpi_db_execution_walk(acpi_handle obj_handle,
  * RETURN:      None
  *
  * DESCRIPTION: Execute a control method. Name is relative to the current
- *              scope.
+ *              scope. Function used for the "EXECUTE", "EVALUATE", and
+ *              "ALL" commands
  *
  ******************************************************************************/
 
@@ -372,6 +375,12 @@ acpi_db_execute(char *name, char **args, acpi_object_type *types, u32 flags)
 		return;
 	}
 
+	if ((flags & EX_ALL) && (strlen(name) > 4)) {
+		acpi_os_printf("Input name (%s) must be a 4-char NameSeg\n",
+			       name);
+		return;
+	}
+
 	name_string = ACPI_ALLOCATE(strlen(name) + 1);
 	if (!name_string) {
 		return;
@@ -389,13 +398,24 @@ acpi_db_execute(char *name, char **args, acpi_object_type *types, u32 flags)
 		return;
 	}
 
-	acpi_gbl_db_method_info.name = name_string;
-	acpi_gbl_db_method_info.args = args;
-	acpi_gbl_db_method_info.types = types;
-	acpi_gbl_db_method_info.flags = flags;
+	/* Command (ALL <nameseg>) to execute all methods of a particular name */
 
-	return_obj.pointer = NULL;
-	return_obj.length = ACPI_ALLOCATE_BUFFER;
+	else if (flags & EX_ALL) {
+		acpi_gbl_db_method_info.name = name_string;
+		return_obj.pointer = NULL;
+		return_obj.length = ACPI_ALLOCATE_BUFFER;
+		acpi_db_evaluate_all(name_string);
+		ACPI_FREE(name_string);
+		return;
+	} else {
+		acpi_gbl_db_method_info.name = name_string;
+		acpi_gbl_db_method_info.args = args;
+		acpi_gbl_db_method_info.types = types;
+		acpi_gbl_db_method_info.flags = flags;
+
+		return_obj.pointer = NULL;
+		return_obj.length = ACPI_ALLOCATE_BUFFER;
+	}
 
 	status = acpi_db_execute_setup(&acpi_gbl_db_method_info);
 	if (ACPI_FAILURE(status)) {
@@ -450,6 +470,7 @@ acpi_db_execute(char *name, char **args, acpi_object_type *types, u32 flags)
 				       (u32)return_obj.length);
 
 			acpi_db_dump_external_object(return_obj.pointer, 1);
+			acpi_os_printf("\n");
 
 			/* Dump a _PLD buffer if present */
 
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 568d1b0b1f5d..2952856b8a67 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -37,6 +37,7 @@ acpi_db_match_command_help(const char *command,
 enum acpi_ex_debugger_commands {
 	CMD_NOT_FOUND = 0,
 	CMD_NULL,
+	CMD_ALL,
 	CMD_ALLOCATIONS,
 	CMD_ARGS,
 	CMD_ARGUMENTS,
@@ -115,6 +116,7 @@ enum acpi_ex_debugger_commands {
 static const struct acpi_db_command_info acpi_gbl_db_commands[] = {
 	{"<NOT FOUND>", 0},
 	{"<NULL>", 0},
+	{"ALL", 1},
 	{"ALLOCATIONS", 0},
 	{"ARGS", 0},
 	{"ARGUMENTS", 0},
@@ -222,6 +224,7 @@ static const struct acpi_db_command_help acpi_gbl_db_command_help[] = {
 	{1, "  Type <Object>", "Display object type\n"},
 
 	{0, "\nControl Method Execution:", "\n"},
+	{1, "  All <NameSeg>", "Evaluate all objects named NameSeg\n"},
 	{1, "  Evaluate <Namepath> [Arguments]",
 	 "Evaluate object or control method\n"},
 	{1, "  Execute <Namepath> [Arguments]", "Synonym for Evaluate\n"},
@@ -740,6 +743,15 @@ acpi_db_command_dispatch(char *input_buffer,
 		}
 		break;
 
+	case CMD_ALL:
+
+		acpi_os_printf("Executing all objects with NameSeg: %s\n",
+			       acpi_gbl_db_args[1]);
+		acpi_db_execute(acpi_gbl_db_args[1], &acpi_gbl_db_args[2],
+				&acpi_gbl_db_arg_types[2],
+				EX_NO_SINGLE_STEP | EX_ALL);
+		break;
+
 	case CMD_ALLOCATIONS:
 
 #ifdef ACPI_DBG_TRACK_ALLOCATIONS
diff --git a/drivers/acpi/acpica/dbmethod.c b/drivers/acpi/acpica/dbmethod.c
index 4e48a7de7413..889d13828e49 100644
--- a/drivers/acpi/acpica/dbmethod.c
+++ b/drivers/acpi/acpica/dbmethod.c
@@ -21,6 +21,8 @@ static acpi_status
 acpi_db_walk_for_execute(acpi_handle obj_handle,
 			 u32 nesting_level, void *context, void **return_value);
 
+static acpi_status acpi_db_evaluate_object(struct acpi_namespace_node *node);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_db_set_method_breakpoint
@@ -346,42 +348,26 @@ acpi_status acpi_db_disassemble_method(char *name)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_db_walk_for_execute
+ * FUNCTION:    acpi_db_evaluate_object
  *
- * PARAMETERS:  Callback from walk_namespace
+ * PARAMETERS:  node                - Namespace node for the object
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Batch execution module. Currently only executes predefined
- *              ACPI names.
+ * DESCRIPTION: Main execution function for the Evaluate/Execute/All debugger
+ *              commands.
  *
  ******************************************************************************/
 
-static acpi_status
-acpi_db_walk_for_execute(acpi_handle obj_handle,
-			 u32 nesting_level, void *context, void **return_value)
+static acpi_status acpi_db_evaluate_object(struct acpi_namespace_node *node)
 {
-	struct acpi_namespace_node *node =
-	    (struct acpi_namespace_node *)obj_handle;
-	struct acpi_db_execute_walk *info =
-	    (struct acpi_db_execute_walk *)context;
-	struct acpi_buffer return_obj;
-	acpi_status status;
 	char *pathname;
 	u32 i;
 	struct acpi_device_info *obj_info;
 	struct acpi_object_list param_objects;
 	union acpi_object params[ACPI_METHOD_NUM_ARGS];
-	const union acpi_predefined_info *predefined;
-
-	predefined = acpi_ut_match_predefined_method(node->name.ascii);
-	if (!predefined) {
-		return (AE_OK);
-	}
-
-	if (node->type == ACPI_TYPE_LOCAL_SCOPE) {
-		return (AE_OK);
-	}
+	struct acpi_buffer return_obj;
+	acpi_status status;
 
 	pathname = acpi_ns_get_external_pathname(node);
 	if (!pathname) {
@@ -390,7 +376,7 @@ acpi_db_walk_for_execute(acpi_handle obj_handle,
 
 	/* Get the object info for number of method parameters */
 
-	status = acpi_get_object_info(obj_handle, &obj_info);
+	status = acpi_get_object_info(node, &obj_info);
 	if (ACPI_FAILURE(status)) {
 		ACPI_FREE(pathname);
 		return (status);
@@ -421,14 +407,67 @@ acpi_db_walk_for_execute(acpi_handle obj_handle,
 	acpi_gbl_method_executing = TRUE;
 
 	status = acpi_evaluate_object(node, NULL, &param_objects, &return_obj);
+	acpi_gbl_method_executing = FALSE;
 
 	acpi_os_printf("%-32s returned %s\n", pathname,
 		       acpi_format_exception(status));
-	acpi_gbl_method_executing = FALSE;
+	if (return_obj.length) {
+		acpi_os_printf("Evaluation of %s returned object %p, "
+			       "external buffer length %X\n",
+			       pathname, return_obj.pointer,
+			       (u32)return_obj.length);
+
+		acpi_db_dump_external_object(return_obj.pointer, 1);
+		acpi_os_printf("\n");
+	}
+
 	ACPI_FREE(pathname);
 
 	/* Ignore status from method execution */
 
+	return (AE_OK);
+
+	/* Update count, check if we have executed enough methods */
+
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_walk_for_execute
+ *
+ * PARAMETERS:  Callback from walk_namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Batch execution function. Evaluates all "predefined" objects --
+ *              the nameseg begins with an underscore.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_walk_for_execute(acpi_handle obj_handle,
+			 u32 nesting_level, void *context, void **return_value)
+{
+	struct acpi_namespace_node *node =
+	    (struct acpi_namespace_node *)obj_handle;
+	struct acpi_db_execute_walk *info =
+	    (struct acpi_db_execute_walk *)context;
+	acpi_status status;
+	const union acpi_predefined_info *predefined;
+
+	predefined = acpi_ut_match_predefined_method(node->name.ascii);
+	if (!predefined) {
+		return (AE_OK);
+	}
+
+	if (node->type == ACPI_TYPE_LOCAL_SCOPE) {
+		return (AE_OK);
+	}
+
+	acpi_db_evaluate_object(node);
+
+	/* Ignore status from object evaluation */
+
 	status = AE_OK;
 
 	/* Update count, check if we have executed enough methods */
@@ -441,6 +480,52 @@ acpi_db_walk_for_execute(acpi_handle obj_handle,
 	return (status);
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_walk_for_execute_all
+ *
+ * PARAMETERS:  Callback from walk_namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Batch execution function. Evaluates all objects whose path ends
+ *              with the nameseg "Info->NameSeg". Used for the "ALL" command.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_walk_for_execute_all(acpi_handle obj_handle,
+			     u32 nesting_level,
+			     void *context, void **return_value)
+{
+	struct acpi_namespace_node *node =
+	    (struct acpi_namespace_node *)obj_handle;
+	struct acpi_db_execute_walk *info =
+	    (struct acpi_db_execute_walk *)context;
+	acpi_status status;
+
+	if (!ACPI_COMPARE_NAMESEG(node->name.ascii, info->name_seg)) {
+		return (AE_OK);
+	}
+
+	if (node->type == ACPI_TYPE_LOCAL_SCOPE) {
+		return (AE_OK);
+	}
+
+	/* Now evaluate the input object (node) */
+
+	acpi_db_evaluate_object(node);
+
+	/* Ignore status from method execution */
+
+	status = AE_OK;
+
+	/* Update count of executed methods/objects */
+
+	info->count++;
+	return (status);
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_db_evaluate_predefined_names
@@ -470,3 +555,35 @@ void acpi_db_evaluate_predefined_names(void)
 	acpi_os_printf("Evaluated %u predefined names in the namespace\n",
 		       info.count);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_evaluate_all
+ *
+ * PARAMETERS:  none_acpi_gbl_db_method_info
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Namespace batch execution. Implements the "ALL" command.
+ *              Execute all namepaths whose final nameseg matches the
+ *              input nameseg.
+ *
+ ******************************************************************************/
+
+void acpi_db_evaluate_all(char *name_seg)
+{
+	struct acpi_db_execute_walk info;
+
+	info.count = 0;
+	info.max_count = ACPI_UINT32_MAX;
+	ACPI_COPY_NAMESEG(info.name_seg, name_seg);
+	info.name_seg[ACPI_NAMESEG_SIZE] = 0;
+
+	/* Search all nodes in namespace */
+
+	(void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
+				  ACPI_UINT32_MAX, acpi_db_walk_for_execute_all,
+				  NULL, (void *)&info, NULL);
+
+	acpi_os_printf("Evaluated %u names in the namespace\n", info.count);
+}
-- 
2.25.1

