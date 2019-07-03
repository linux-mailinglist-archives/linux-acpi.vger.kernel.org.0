Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810915ED70
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGCU0g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 16:26:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:5192 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfGCU0g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jul 2019 16:26:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="158088363"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2019 13:26:34 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 1/5] ACPICA: Namespace: simplify creation of the initial/default namespace
Date:   Wed,  3 Jul 2019 13:15:36 -0700
Message-Id: <20190703201540.26054-2-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190703201540.26054-1-erik.schmauss@intel.com>
References: <20190703201540.26054-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 76658f55d8cc498a763bdb92f8e0d934822a129c

For the objects that are created by default (_GPE, _SB_, etc)
there is no need to use the heavyweight ns_lookup function.
Instead, simply create each object and link it in as the namespace
is built.

Link: https://github.com/acpica/acpica/commit/76658f55
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/nsaccess.c | 54 +++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 7b855603f81a..2566e2d4c780 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -36,6 +36,7 @@ acpi_status acpi_ns_root_initialize(void)
 	acpi_status status;
 	const struct acpi_predefined_names *init_val = NULL;
 	struct acpi_namespace_node *new_node;
+	struct acpi_namespace_node *prev_node = NULL;
 	union acpi_operand_object *obj_desc;
 	acpi_string val = NULL;
 
@@ -61,12 +62,28 @@ acpi_status acpi_ns_root_initialize(void)
 	 */
 	acpi_gbl_root_node = &acpi_gbl_root_node_struct;
 
-	/* Enter the pre-defined names in the name table */
+	/* Enter the predefined names in the name table */
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Entering predefined entries into namespace\n"));
 
+	/*
+	 * Create the initial (default) namespace.
+	 * This namespace looks like something similar to this:
+	 *
+	 *   ACPI Namespace (from Namespace Root):
+	 *    0  _GPE Scope        00203160 00
+	 *    0  _PR_ Scope        002031D0 00
+	 *    0  _SB_ Device       00203240 00 Notify Object: 0020ADD8
+	 *    0  _SI_ Scope        002032B0 00
+	 *    0  _TZ_ Device       00203320 00
+	 *    0  _REV Integer      00203390 00 = 0000000000000002
+	 *    0  _OS_ String       00203488 00 Len 14 "Microsoft Windows NT"
+	 *    0  _GL_ Mutex        00203580 00 Object 002035F0
+	 *    0  _OSI Method       00203678 00 Args 1 Len 0000 Aml 00000000
+	 */
 	for (init_val = acpi_gbl_pre_defined_names; init_val->name; init_val++) {
+		status = AE_OK;
 
 		/* _OSI is optional for now, will be permanent later */
 
@@ -75,17 +92,32 @@ acpi_status acpi_ns_root_initialize(void)
 			continue;
 		}
 
-		status =
-		    acpi_ns_lookup(NULL, ACPI_CAST_PTR(char, init_val->name),
-				   init_val->type, ACPI_IMODE_LOAD_PASS2,
-				   ACPI_NS_NO_UPSEARCH, NULL, &new_node);
-		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status,
-					"Could not create predefined name %s",
-					init_val->name));
-			continue;
+		/*
+		 * Create, init, and link the new predefined name
+		 * Note: No need to use acpi_ns_lookup here because all the
+		 * predefined names are at the root level. It is much easier to
+		 * just create and link the new node(s) here.
+		 */
+		new_node =
+		    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_namespace_node));
+		if (!new_node) {
+			status = AE_NO_MEMORY;
+			goto unlock_and_exit;
 		}
 
+		ACPI_COPY_NAMESEG(new_node->name.ascii, init_val->name);
+		new_node->descriptor_type = ACPI_DESC_TYPE_NAMED;
+		new_node->type = init_val->type;
+
+		if (!prev_node) {
+			acpi_gbl_root_node_struct.child = new_node;
+		} else {
+			prev_node->peer = new_node;
+		}
+
+		new_node->parent = &acpi_gbl_root_node_struct;
+		prev_node = new_node;
+
 		/*
 		 * Name entered successfully. If entry in pre_defined_names[] specifies
 		 * an initial value, create the initial value.
@@ -131,7 +163,7 @@ acpi_status acpi_ns_root_initialize(void)
 
 				new_node->value = obj_desc->method.param_count;
 #else
-				/* Mark this as a very SPECIAL method */
+				/* Mark this as a very SPECIAL method (_OSI) */
 
 				obj_desc->method.info_flags =
 				    ACPI_METHOD_INTERNAL_ONLY;
-- 
2.17.2

