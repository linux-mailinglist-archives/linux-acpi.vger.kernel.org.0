Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0BE19616A
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 23:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgC0WnO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Mar 2020 18:43:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:52441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgC0WnO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 18:43:14 -0400
IronPort-SDR: DYu7hTRVZsNtJCXnqBVIFHVd6n0vhiGVdXglSaHqxvwOX3zlcT0Fw6d4HNEwd2PCIfdSbMFq/V
 6Q0/vA4gTNhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 15:43:13 -0700
IronPort-SDR: /Je4+IqXNY91Y18EshDqlnyl9THgRqm8juqgQP5JX4Wn6ULMhS7CI2TWKO7O/FebkUciqxcDP4
 ew4GBvGd78Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="294051991"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2020 15:43:12 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 09/10] ACPICA: Fixes for acpiExec namespace init file
Date:   Fri, 27 Mar 2020 15:21:09 -0700
Message-Id: <20200327222110.1204634-10-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327222110.1204634-1-erik.kaneda@intel.com>
References: <20200327222110.1204634-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

This commit is the result of squashing the following ACPICA commit
ID's:
6803997e5b4f3635cea6610b51ff69e29d251de3
f31cdf8bfda22fe265c1a176d0e33d311c82a7f7

This change fixes several problems with the support for the
acpi_exec namespace init file (-fi option). Specifically, it
fixes AE_ALREADY_EXISTS errors, as well as various seg faults.

Link: https://github.com/acpica/acpica/commit/f31cdf8b
Link: https://github.com/acpica/acpica/commit/6803997e
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/acnamesp.h |  2 ++
 drivers/acpi/acpica/dbinput.c  | 16 +++++++--------
 drivers/acpi/acpica/dswexec.c  | 33 +++++++++++++++++++++++++++++++
 drivers/acpi/acpica/dswload.c  |  2 --
 drivers/acpi/acpica/dswload2.c | 36 ++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/nsnames.c  |  6 +-----
 drivers/acpi/acpica/utdelete.c |  9 +++++----
 7 files changed, 84 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpica/acnamesp.h b/drivers/acpi/acpica/acnamesp.h
index e618ddfab2fd..40f6a3c33a15 100644
--- a/drivers/acpi/acpica/acnamesp.h
+++ b/drivers/acpi/acpica/acnamesp.h
@@ -256,6 +256,8 @@ u32
 acpi_ns_build_normalized_path(struct acpi_namespace_node *node,
 			      char *full_path, u32 path_size, u8 no_trailing);
 
+void acpi_ns_normalize_pathname(char *original_path);
+
 char *acpi_ns_get_normalized_pathname(struct acpi_namespace_node *node,
 				      u8 no_trailing);
 
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index aa71f65395d2..ee6a1b77af3f 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -468,16 +468,14 @@ char *acpi_db_get_next_token(char *string,
 		return (NULL);
 	}
 
-	/* Remove any spaces at the beginning */
+	/* Remove any spaces at the beginning, ignore blank lines */
 
-	if (*string == ' ') {
-		while (*string && (*string == ' ')) {
-			string++;
-		}
+	while (*string && isspace(*string)) {
+		string++;
+	}
 
-		if (!(*string)) {
-			return (NULL);
-		}
+	if (!(*string)) {
+		return (NULL);
 	}
 
 	switch (*string) {
@@ -570,7 +568,7 @@ char *acpi_db_get_next_token(char *string,
 
 		/* Find end of token */
 
-		while (*string && (*string != ' ')) {
+		while (*string && !isspace(*string)) {
 			string++;
 		}
 		break;
diff --git a/drivers/acpi/acpica/dswexec.c b/drivers/acpi/acpica/dswexec.c
index 5e81a1ae44cf..1d4f8c81028c 100644
--- a/drivers/acpi/acpica/dswexec.c
+++ b/drivers/acpi/acpica/dswexec.c
@@ -16,6 +16,9 @@
 #include "acinterp.h"
 #include "acnamesp.h"
 #include "acdebug.h"
+#ifdef ACPI_EXEC_APP
+#include "aecommon.h"
+#endif
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dswexec")
@@ -329,6 +332,10 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 	u32 op_class;
 	union acpi_parse_object *next_op;
 	union acpi_parse_object *first_arg;
+#ifdef ACPI_EXEC_APP
+	char *namepath;
+	union acpi_operand_object *obj_desc;
+#endif
 
 	ACPI_FUNCTION_TRACE_PTR(ds_exec_end_op, walk_state);
 
@@ -537,6 +544,32 @@ acpi_status acpi_ds_exec_end_op(struct acpi_walk_state *walk_state)
 
 			status =
 			    acpi_ds_eval_buffer_field_operands(walk_state, op);
+			if (ACPI_FAILURE(status)) {
+				break;
+			}
+#ifdef ACPI_EXEC_APP
+			/*
+			 * acpi_exec support for namespace initialization file (initialize
+			 * buffer_fields in this code.)
+			 */
+			namepath =
+			    acpi_ns_get_external_pathname(op->common.node);
+			status = ae_lookup_init_file_entry(namepath, &obj_desc);
+			if (ACPI_SUCCESS(status)) {
+				status =
+				    acpi_ex_write_data_to_field(obj_desc,
+								op->common.
+								node->object,
+								NULL);
+				if ACPI_FAILURE
+					(status) {
+					ACPI_EXCEPTION((AE_INFO, status,
+							"While writing to buffer field"));
+					}
+			}
+			ACPI_FREE(namepath);
+			status = AE_OK;
+#endif
 			break;
 
 		case AML_TYPE_CREATE_OBJECT:
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 697974e37edf..27069325b6de 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -14,7 +14,6 @@
 #include "acdispat.h"
 #include "acinterp.h"
 #include "acnamesp.h"
-
 #ifdef ACPI_ASL_COMPILER
 #include "acdisasm.h"
 #endif
@@ -399,7 +398,6 @@ acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state)
 	union acpi_parse_object *op;
 	acpi_object_type object_type;
 	acpi_status status = AE_OK;
-
 #ifdef ACPI_ASL_COMPILER
 	u8 param_count;
 #endif
diff --git a/drivers/acpi/acpica/dswload2.c b/drivers/acpi/acpica/dswload2.c
index b31457ca926c..9747f9d1518d 100644
--- a/drivers/acpi/acpica/dswload2.c
+++ b/drivers/acpi/acpica/dswload2.c
@@ -15,6 +15,9 @@
 #include "acinterp.h"
 #include "acnamesp.h"
 #include "acevents.h"
+#ifdef ACPI_EXEC_APP
+#include "aecommon.h"
+#endif
 
 #define _COMPONENT          ACPI_DISPATCHER
 ACPI_MODULE_NAME("dswload2")
@@ -373,6 +376,10 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 	struct acpi_namespace_node *new_node;
 	u32 i;
 	u8 region_space;
+#ifdef ACPI_EXEC_APP
+	union acpi_operand_object *obj_desc;
+	char *namepath;
+#endif
 
 	ACPI_FUNCTION_TRACE(ds_load2_end_op);
 
@@ -466,6 +473,12 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 		 * be evaluated later during the execution phase
 		 */
 		status = acpi_ds_create_buffer_field(op, walk_state);
+		if ACPI_FAILURE
+			(status) {
+			ACPI_EXCEPTION((AE_INFO, status,
+					"CreateBufferField failure"));
+			goto cleanup;
+			}
 		break;
 
 	case AML_TYPE_NAMED_FIELD:
@@ -604,6 +617,29 @@ acpi_status acpi_ds_load2_end_op(struct acpi_walk_state *walk_state)
 		case AML_NAME_OP:
 
 			status = acpi_ds_create_node(walk_state, node, op);
+			if (ACPI_FAILURE(status)) {
+				goto cleanup;
+			}
+#ifdef ACPI_EXEC_APP
+			/*
+			 * acpi_exec support for namespace initialization file (initialize
+			 * Name opcodes in this code.)
+			 */
+			namepath = acpi_ns_get_external_pathname(node);
+			status = ae_lookup_init_file_entry(namepath, &obj_desc);
+			if (ACPI_SUCCESS(status)) {
+
+				/* Detach any existing object, attach new object */
+
+				if (node->object) {
+					acpi_ns_detach_object(node);
+				}
+				acpi_ns_attach_object(node, obj_desc,
+						      obj_desc->common.type);
+			}
+			ACPI_FREE(namepath);
+			status = AE_OK;
+#endif
 			break;
 
 		case AML_METHOD_OP:
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index d4d26147610e..d91153f65700 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -13,9 +13,6 @@
 #define _COMPONENT          ACPI_NAMESPACE
 ACPI_MODULE_NAME("nsnames")
 
-/* Local Prototypes */
-static void acpi_ns_normalize_pathname(char *original_path);
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_get_external_pathname
@@ -30,7 +27,6 @@ static void acpi_ns_normalize_pathname(char *original_path);
  *              for error and debug statements.
  *
  ******************************************************************************/
-
 char *acpi_ns_get_external_pathname(struct acpi_namespace_node *node)
 {
 	char *name_buffer;
@@ -411,7 +407,7 @@ char *acpi_ns_build_prefixed_pathname(union acpi_generic_state *prefix_scope,
  *
  ******************************************************************************/
 
-static void acpi_ns_normalize_pathname(char *original_path)
+void acpi_ns_normalize_pathname(char *original_path)
 {
 	char *input_path = original_path;
 	char *new_path_buffer;
diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index eee263cb7beb..c365faf4e6cd 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -452,13 +452,13 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
  *
  * FUNCTION:    acpi_ut_update_object_reference
  *
- * PARAMETERS:  object              - Increment ref count for this object
- *                                    and all sub-objects
+ * PARAMETERS:  object              - Increment or decrement the ref count for
+ *                                    this object and all sub-objects
  *              action              - Either REF_INCREMENT or REF_DECREMENT
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Increment the object reference count
+ * DESCRIPTION: Increment or decrement the object reference count
  *
  * Object references are incremented when:
  * 1) An object is attached to a Node (namespace object)
@@ -492,7 +492,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 		}
 
 		/*
-		 * All sub-objects must have their reference count incremented
+		 * All sub-objects must have their reference count updated
 		 * also. Different object types have different subobjects.
 		 */
 		switch (object->common.type) {
@@ -559,6 +559,7 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 					break;
 				}
 			}
+
 			next_object = NULL;
 			break;
 
-- 
2.25.1

