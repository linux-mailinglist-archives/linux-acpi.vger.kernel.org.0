Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F611E5637
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 23:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfJYVyz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 17:54:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:27339 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfJYVyy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 17:54:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 14:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="201936048"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 14:54:51 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH v2 07/12] ACPICA: debugger: add command to dump all fields of a particular subtype
Date:   Fri, 25 Oct 2019 14:36:55 -0700
Message-Id: <20191025213700.14685-8-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025213700.14685-1-erik.schmauss@intel.com>
References: <20191025213700.14685-1-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In acpiexec, this can be invoked by typing "fields" followed by a
number representing the address space ID of that field.

Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/acdebug.h  |   2 +
 drivers/acpi/acpica/acstruct.h |  10 +++
 drivers/acpi/acpica/dbinput.c  |  20 ++++++
 drivers/acpi/acpica/dbnames.c  | 109 +++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)

diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 32f2e38c7570..694cf206fa9a 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -148,6 +148,8 @@ void acpi_db_find_references(char *object_arg);
 
 void acpi_db_get_bus_info(void);
 
+acpi_status acpi_db_display_fields(u32 address_space_id);
+
 /*
  * dbdisply - debug display commands
  */
diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index 218ff4c8b817..2043dff370b1 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -192,6 +192,16 @@ struct acpi_device_walk_info {
 	u32 num_INI;
 };
 
+/* Info used by Acpi  acpi_db_display_fields */
+
+struct acpi_region_walk_info {
+	u32 debug_level;
+	u32 count;
+	acpi_owner_id owner_id;
+	u8 display_type;
+	u32 address_space_id;
+};
+
 /* TBD: [Restructure] Merge with struct above */
 
 struct acpi_walk_info {
diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index 95738313916b..44d6d7246e6e 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -50,6 +50,7 @@ enum acpi_ex_debugger_commands {
 	CMD_EVALUATE,
 	CMD_EXECUTE,
 	CMD_EXIT,
+	CMD_FIELDS,
 	CMD_FIND,
 	CMD_GO,
 	CMD_HANDLERS,
@@ -127,6 +128,7 @@ static const struct acpi_db_command_info acpi_gbl_db_commands[] = {
 	{"EVALUATE", 1},
 	{"EXECUTE", 1},
 	{"EXIT", 0},
+	{"FIELDS", 1},
 	{"FIND", 1},
 	{"GO", 0},
 	{"HANDLERS", 0},
@@ -200,6 +202,8 @@ static const struct acpi_db_command_help acpi_gbl_db_command_help[] = {
 	 "Find ACPI name(s) with wildcards\n"},
 	{1, "  Integrity", "Validate namespace integrity\n"},
 	{1, "  Methods", "Display list of loaded control methods\n"},
+	{1, "  Fields <AddressSpaceId>",
+	 "Display list of loaded field units by space ID\n"},
 	{1, "  Namespace [Object] [Depth]",
 	 "Display loaded namespace tree/subtree\n"},
 	{1, "  Notify <Object> <Value>", "Send a notification on Object\n"},
@@ -674,6 +678,7 @@ acpi_db_command_dispatch(char *input_buffer,
 			 union acpi_parse_object *op)
 {
 	u32 temp;
+	u64 temp64;
 	u32 command_index;
 	u32 param_count;
 	char *command_line;
@@ -789,6 +794,21 @@ acpi_db_command_dispatch(char *input_buffer,
 		status = acpi_db_find_name_in_namespace(acpi_gbl_db_args[1]);
 		break;
 
+	case CMD_FIELDS:
+
+		status = acpi_ut_strtoul64(acpi_gbl_db_args[1], &temp64);
+
+		if (ACPI_FAILURE(status)
+		    || temp64 >= ACPI_NUM_PREDEFINED_REGIONS) {
+			acpi_os_printf
+			    ("Invalid adress space ID: must be between 0 and %u inclusive\n",
+			     ACPI_NUM_PREDEFINED_REGIONS - 1);
+			return (AE_OK);
+		}
+
+		status = acpi_db_display_fields((u32)temp64);
+		break;
+
 	case CMD_GO:
 
 		acpi_gbl_cm_single_step = FALSE;
diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
index 63fe30e86807..bce2cfb17356 100644
--- a/drivers/acpi/acpica/dbnames.c
+++ b/drivers/acpi/acpica/dbnames.c
@@ -10,6 +10,7 @@
 #include "acnamesp.h"
 #include "acdebug.h"
 #include "acpredef.h"
+#include "acinterp.h"
 
 #define _COMPONENT          ACPI_CA_DEBUGGER
 ACPI_MODULE_NAME("dbnames")
@@ -502,6 +503,81 @@ acpi_db_walk_for_object_counts(acpi_handle obj_handle,
 	return (AE_OK);
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_walk_for_fields
+ *
+ * PARAMETERS:  Callback from walk_namespace
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Display short info about objects in the namespace
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_db_walk_for_fields(acpi_handle obj_handle,
+			u32 nesting_level, void *context, void **return_value)
+{
+	union acpi_object *ret_value;
+	struct acpi_region_walk_info *info =
+	    (struct acpi_region_walk_info *)context;
+	struct acpi_buffer buffer;
+	acpi_status status;
+	struct acpi_namespace_node *node = acpi_ns_validate_handle(obj_handle);
+
+	if (!node) {
+		return (AE_OK);
+	}
+	if (node->object->field.region_obj->region.space_id !=
+	    info->address_space_id) {
+		return (AE_OK);
+	}
+
+	info->count++;
+
+	/* Get and display the full pathname to this object */
+
+	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+	status = acpi_ns_handle_to_pathname(obj_handle, &buffer, TRUE);
+	if (ACPI_FAILURE(status)) {
+		acpi_os_printf("Could Not get pathname for object %p\n",
+			       obj_handle);
+		return (AE_OK);
+	}
+
+	acpi_os_printf("%s ", (char *)buffer.pointer);
+	ACPI_FREE(buffer.pointer);
+
+	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
+	acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
+
+	ret_value = (union acpi_object *)buffer.pointer;
+	switch (ret_value->type) {
+	case ACPI_TYPE_INTEGER:
+
+		acpi_os_printf("%8.8X%8.8X",
+			       ACPI_FORMAT_UINT64(ret_value->integer.value));
+		break;
+
+	case ACPI_TYPE_BUFFER:
+
+		acpi_ut_dump_buffer(ret_value->buffer.pointer,
+				    ret_value->buffer.length,
+				    DB_DISPLAY_DATA_ONLY | DB_BYTE_DISPLAY, 0);
+		break;
+
+	default:
+
+		break;
+	}
+	acpi_os_printf("\n");
+
+	ACPI_FREE(buffer.pointer);
+
+	return (AE_OK);
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_db_walk_for_specific_objects
@@ -628,6 +704,39 @@ acpi_status acpi_db_display_objects(char *obj_type_arg, char *display_count_arg)
 	return (AE_OK);
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_db_display_fields
+ *
+ * PARAMETERS:  obj_type_arg        - Type of object to display
+ *              display_count_arg   - Max depth to display
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Display objects in the namespace of the requested type
+ *
+ ******************************************************************************/
+
+acpi_status acpi_db_display_fields(u32 address_space_id)
+{
+	struct acpi_region_walk_info info;
+
+	info.count = 0;
+	info.owner_id = ACPI_OWNER_ID_MAX;
+	info.debug_level = ACPI_UINT32_MAX;
+	info.display_type = ACPI_DISPLAY_SUMMARY | ACPI_DISPLAY_SHORT;
+	info.address_space_id = address_space_id;
+
+	/* Walk the namespace from the root */
+
+	(void)acpi_walk_namespace(ACPI_TYPE_LOCAL_REGION_FIELD,
+				  ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
+				  acpi_db_walk_for_fields, NULL, (void *)&info,
+				  NULL);
+
+	return (AE_OK);
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_db_integrity_walk
-- 
2.21.0

