Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2E65ED74
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 22:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfGCU0h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 16:26:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:5194 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfGCU0h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jul 2019 16:26:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="158088372"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2019 13:26:34 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 4/5] ACPICA: Update table load object initialization
Date:   Wed,  3 Jul 2019 13:15:39 -0700
Message-Id: <20190703201540.26054-5-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190703201540.26054-1-erik.schmauss@intel.com>
References: <20190703201540.26054-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit c7ef9f3526765bed8930825dda1eed1a274b9668

Use the common internal "initialize objects" interface
Affects:
Load()
load_table()
acpi_load_table

Link: https://github.com/acpica/acpica/commit/c7ef9f35
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/exconfig.c | 16 ++++++----------
 drivers/acpi/acpica/tbxfload.c | 10 +++-------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 587aeeeb5070..58c04d706723 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -174,12 +174,9 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 		return_ACPI_STATUS(status);
 	}
 
-	/* Complete the initialization/resolution of package objects */
+	/* Complete the initialization/resolution of new objects */
 
-	status = acpi_ns_walk_namespace(ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJECT,
-					ACPI_UINT32_MAX, 0,
-					acpi_ns_init_one_package, NULL, NULL,
-					NULL);
+	acpi_ns_initialize_objects();
 
 	/* Parameter Data (optional) */
 
@@ -437,12 +434,11 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(status);
 	}
 
-	/* Complete the initialization/resolution of package objects */
+	/* Complete the initialization/resolution of new objects */
 
-	status = acpi_ns_walk_namespace(ACPI_TYPE_PACKAGE, ACPI_ROOT_OBJECT,
-					ACPI_UINT32_MAX, 0,
-					acpi_ns_init_one_package, NULL, NULL,
-					NULL);
+	acpi_ex_exit_interpreter();
+	acpi_ns_initialize_objects();
+	acpi_ex_enter_interpreter();
 
 	/* Store the ddb_handle into the Target operand */
 
diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index ef8f8a9f3c9c..86f1693f6d29 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -297,15 +297,11 @@ acpi_status acpi_load_table(struct acpi_table_header *table)
 	status = acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
 						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
 						FALSE, &table_index);
-
 	if (ACPI_SUCCESS(status)) {
-		/* Complete the initialization/resolution of package objects */
 
-		status = acpi_ns_walk_namespace(ACPI_TYPE_PACKAGE,
-						ACPI_ROOT_OBJECT,
-						ACPI_UINT32_MAX, 0,
-						acpi_ns_init_one_package,
-						NULL, NULL, NULL);
+		/* Complete the initialization/resolution of new objects */
+
+		acpi_ns_initialize_objects();
 	}
 
 	return_ACPI_STATUS(status);
-- 
2.17.2

