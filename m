Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0C35ED72
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 22:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfGCU0h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 16:26:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:5192 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfGCU0h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jul 2019 16:26:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="158088369"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2019 13:26:34 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 3/5] ACPICA: Update for object initialization sequence
Date:   Wed,  3 Jul 2019 13:15:38 -0700
Message-Id: <20190703201540.26054-4-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190703201540.26054-1-erik.schmauss@intel.com>
References: <20190703201540.26054-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 106c72a97f5ca972f29956e5e9a0429b8c4a2723

1) Do not allow the objects to be initialized twice
2) Only package objects require a deferred initialization
3) Cleanup initialization output

Link: https://github.com/acpica/acpica/commit/106c72a9
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/dsinit.c   |  2 +-
 drivers/acpi/acpica/nsinit.c   | 49 +++++++++++++---------------------
 drivers/acpi/acpica/utxfinit.c | 11 ++++++--
 3 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/acpica/dsinit.c b/drivers/acpi/acpica/dsinit.c
index 4ebd23700bbc..a1ffed29903b 100644
--- a/drivers/acpi/acpica/dsinit.c
+++ b/drivers/acpi/acpica/dsinit.c
@@ -202,7 +202,7 @@ acpi_ds_initialize_objects(u32 table_index,
 
 	if (ACPI_COMPARE_NAMESEG(table->signature, ACPI_SIG_DSDT)) {
 		ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-				      "\nInitializing Namespace objects:\n"));
+				      "\nACPI table initialization:\n"));
 	}
 
 	/* Summary of objects initialized */
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 53e5d00d3a5e..61e9dfc9fe8c 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -55,14 +55,19 @@ acpi_status acpi_ns_initialize_objects(void)
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 			  "**** Starting initialization of namespace objects ****\n"));
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "Completing Region/Field/Buffer/Package initialization:\n"));
+			      "Final data object initialization: "));
 
-	/* Set all init info to zero */
+	/* Clear the info block */
 
 	memset(&info, 0, sizeof(struct acpi_init_walk_info));
 
 	/* Walk entire namespace from the supplied root */
 
+	/*
+	 * TBD: will become ACPI_TYPE_PACKAGE as this type object
+	 * is now the only one that supports deferred initialization
+	 * (forward references).
+	 */
 	status = acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
 				     ACPI_UINT32_MAX, acpi_ns_init_one_object,
 				     NULL, &info, NULL);
@@ -71,13 +76,8 @@ acpi_status acpi_ns_initialize_objects(void)
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INIT,
-			      "    Initialized %u/%u Regions %u/%u Fields %u/%u "
-			      "Buffers %u/%u Packages (%u nodes)\n",
-			      info.op_region_init, info.op_region_count,
-			      info.field_init, info.field_count,
-			      info.buffer_init, info.buffer_count,
-			      info.package_init, info.package_count,
-			      info.object_count));
+			      "Namespace contains %u (0x%X) objects\n",
+			      info.object_count, info.object_count));
 
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 			  "%u Control Methods found\n%u Op Regions found\n",
@@ -382,34 +382,18 @@ acpi_ns_init_one_object(acpi_handle obj_handle,
 	acpi_ex_enter_interpreter();
 
 	/*
-	 * Each of these types can contain executable AML code within the
-	 * declaration.
+	 * Only initialization of Package objects can be deferred, in order
+	 * to support forward references.
 	 */
 	switch (type) {
-	case ACPI_TYPE_REGION:
-
-		info->op_region_init++;
-		status = acpi_ds_get_region_arguments(obj_desc);
-		break;
-
-	case ACPI_TYPE_BUFFER_FIELD:
-
-		info->field_init++;
-		status = acpi_ds_get_buffer_field_arguments(obj_desc);
-		break;
-
 	case ACPI_TYPE_LOCAL_BANK_FIELD:
 
+		/* TBD: bank_fields do not require deferred init, remove this code */
+
 		info->field_init++;
 		status = acpi_ds_get_bank_field_arguments(obj_desc);
 		break;
 
-	case ACPI_TYPE_BUFFER:
-
-		info->buffer_init++;
-		status = acpi_ds_get_buffer_arguments(obj_desc);
-		break;
-
 	case ACPI_TYPE_PACKAGE:
 
 		/* Complete the initialization/resolution of the package object */
@@ -421,8 +405,13 @@ acpi_ns_init_one_object(acpi_handle obj_handle,
 
 	default:
 
-		/* No other types can get here */
+		/* No other types should get here */
 
+		status = AE_TYPE;
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Opcode is not deferred [%4.4s] (%s)",
+				acpi_ut_get_node_name(node),
+				acpi_ut_get_type_name(type)));
 		break;
 	}
 
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 077b1af03283..cf769e94fe0f 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -211,11 +211,17 @@ acpi_status ACPI_INIT_FUNCTION acpi_initialize_objects(u32 flags)
 
 	ACPI_FUNCTION_TRACE(acpi_initialize_objects);
 
+#ifdef ACPI_OBSOLETE_BEHAVIOR
+	/*
+	 * 05/2019: Removed, initialization now happens at both object
+	 * creation and table load time
+	 */
+
 	/*
 	 * Initialize the objects that remain uninitialized. This
 	 * runs the executable AML that may be part of the
-	 * declaration of these objects:
-	 * operation_regions, buffer_fields, Buffers, and Packages.
+	 * declaration of these objects: operation_regions, buffer_fields,
+	 * bank_fields, Buffers, and Packages.
 	 */
 	if (!(flags & ACPI_NO_OBJECT_INIT)) {
 		status = acpi_ns_initialize_objects();
@@ -223,6 +229,7 @@ acpi_status ACPI_INIT_FUNCTION acpi_initialize_objects(u32 flags)
 			return_ACPI_STATUS(status);
 		}
 	}
+#endif
 
 	/*
 	 * Initialize all device/region objects in the namespace. This runs
-- 
2.17.2

