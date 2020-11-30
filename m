Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5E2C8E69
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Nov 2020 20:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgK3Tsp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 14:48:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:18516 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729943AbgK3Tsp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Nov 2020 14:48:45 -0500
IronPort-SDR: 27e/4gornbpcDIF2Ax1CPInbGht5JP0bKp7YOC2dUqHH0C7LCRxhYB32sylnSqEVOYlS/TA+WZ
 TAgE3kk+iACQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151954743"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151954743"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 11:47:55 -0800
IronPort-SDR: xym4H3v1tT3xqB7zrJRZ4Wu3P2qlIuwTplxGNYHLBp7C/LDYc1EdmzE18/cKVxJH9bSOUplMEO
 gCNEGv+IgpAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="404844886"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2020 11:47:55 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 3/6] ACPICA: Also handle "orphan" _REG methods for GPIO OpRegions 
Date:   Mon, 30 Nov 2020 11:20:45 -0800
Message-Id: <20201130192048.3093726-4-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201130192048.3093726-1-erik.kaneda@intel.com>
References: <20201130192048.3093726-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

ACPICA commit b9dc31e2fc67cf196fab5253a9a673bee68b2ef5

Before this commit acpi_ev_execute_reg_methods() had special handling
to handle "orphan" (no matching op_region declared) _REG methods for EC
nodes.

On Intel Cherry Trail devices there are 2 possible ACPI op_regions for
accessing GPIOs. The standard general_purpose_io op_region and the Cherry
Trail specific user_defined 0x9X op_regions.

Having 2 different types of op_regions leads to potential issues with
checks for op_region availability, or in other words checks if _REG has
been called for the op_region which the ACPI code wants to use.

Except for the "orphan" EC handling, ACPICA core does not call _REG on
an ACPI node which does not define an op_region matching the type being
registered; and the reference design DSDT, from which most Cherry Trail
DSDTs are derived, does not define general_purpose_io, nor user_defined(0x93)
op_regions for the GPO2 (UID 3) device, because no pins were assigned ACPI
controlled functions in the reference design.

Together this leads to the perfect storm, at least on the Cherry Trail
based Medion Akayo E1239T. This design does use a GPO2 pin from its ACPI
code and has added the Cherry Trail specific user_defined(0x93) opregion
to its GPO2 ACPI node to access this pin.

But it uses a has _REG been called availability check for the standard
general_purpose_io op_region. This clearly is a bug in the DSDT, but this
does work under Windows. This issue leads to the intel_vbtn driver
reporting the device always being in tablet-mode at boot, even if it
is in laptop mode. Which in turn causes userspace to ignore touchpad
events. So iow this issues causes the touchpad to not work at boot.

This commit fixes this by extending the "orphan" _REG method handling
to also apply to GPIO address-space handlers.

Note it seems that Windows always calls "orphan" _REG methods so me
may want to consider dropping the space-id check and always do
"orphan" _REG method handling.

Link: https://github.com/acpica/acpica/commit/b9dc31e2
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evregion.c | 54 +++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 738d4b231f34..a8a4c8c9b9ef 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -21,7 +21,8 @@ extern u8 acpi_gbl_default_address_spaces[];
 /* Local prototypes */
 
 static void
-acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node *ec_device_node);
+acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
+				  acpi_adr_space_type space_id);
 
 static acpi_status
 acpi_ev_reg_run(acpi_handle obj_handle,
@@ -684,10 +685,12 @@ acpi_ev_execute_reg_methods(struct acpi_namespace_node *node,
 				     ACPI_NS_WALK_UNLOCK, acpi_ev_reg_run, NULL,
 				     &info, NULL);
 
-	/* Special case for EC: handle "orphan" _REG methods with no region */
-
-	if (space_id == ACPI_ADR_SPACE_EC) {
-		acpi_ev_orphan_ec_reg_method(node);
+	/*
+	 * Special case for EC and GPIO: handle "orphan" _REG methods with
+	 * no region.
+	 */
+	if (space_id == ACPI_ADR_SPACE_EC || space_id == ACPI_ADR_SPACE_GPIO) {
+		acpi_ev_execute_orphan_reg_method(node, space_id);
 	}
 
 	ACPI_DEBUG_PRINT_RAW((ACPI_DB_NAMES,
@@ -760,31 +763,28 @@ acpi_ev_reg_run(acpi_handle obj_handle,
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ev_orphan_ec_reg_method
+ * FUNCTION:    acpi_ev_execute_orphan_reg_method
  *
- * PARAMETERS:  ec_device_node      - Namespace node for an EC device
+ * PARAMETERS:  device_node         - Namespace node for an ACPI device
+ *              space_id            - The address space ID
  *
  * RETURN:      None
  *
- * DESCRIPTION: Execute an "orphan" _REG method that appears under the EC
+ * DESCRIPTION: Execute an "orphan" _REG method that appears under an ACPI
  *              device. This is a _REG method that has no corresponding region
- *              within the EC device scope. The orphan _REG method appears to
- *              have been enabled by the description of the ECDT in the ACPI
- *              specification: "The availability of the region space can be
- *              detected by providing a _REG method object underneath the
- *              Embedded Controller device."
- *
- *              To quickly access the EC device, we use the ec_device_node used
- *              during EC handler installation. Otherwise, we would need to
- *              perform a time consuming namespace walk, executing _HID
- *              methods to find the EC device.
+ *              within the device's scope. ACPI tables depending on these
+ *              "orphan" _REG methods have been seen for both EC and GPIO
+ *              Operation Regions. Presumably the Windows ACPI implementation
+ *              always calls the _REG method independent of the presence of
+ *              an actual Operation Region with the correct address space ID.
  *
  *  MUTEX:      Assumes the namespace is locked
  *
  ******************************************************************************/
 
 static void
-acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node *ec_device_node)
+acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node *device_node,
+				  acpi_adr_space_type space_id)
 {
 	acpi_handle reg_method;
 	struct acpi_namespace_node *next_node;
@@ -792,9 +792,9 @@ acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node *ec_device_node)
 	struct acpi_object_list args;
 	union acpi_object objects[2];
 
-	ACPI_FUNCTION_TRACE(ev_orphan_ec_reg_method);
+	ACPI_FUNCTION_TRACE(ev_execute_orphan_reg_method);
 
-	if (!ec_device_node) {
+	if (!device_node) {
 		return_VOID;
 	}
 
@@ -804,7 +804,7 @@ acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node *ec_device_node)
 
 	/* Get a handle to a _REG method immediately under the EC device */
 
-	status = acpi_get_handle(ec_device_node, METHOD_NAME__REG, &reg_method);
+	status = acpi_get_handle(device_node, METHOD_NAME__REG, &reg_method);
 	if (ACPI_FAILURE(status)) {
 		goto exit;	/* There is no _REG method present */
 	}
@@ -816,23 +816,23 @@ acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node *ec_device_node)
 	 * with other space IDs to be present; but the code below will then
 	 * execute the _REG method with the embedded_control space_ID argument.
 	 */
-	next_node = acpi_ns_get_next_node(ec_device_node, NULL);
+	next_node = acpi_ns_get_next_node(device_node, NULL);
 	while (next_node) {
 		if ((next_node->type == ACPI_TYPE_REGION) &&
 		    (next_node->object) &&
-		    (next_node->object->region.space_id == ACPI_ADR_SPACE_EC)) {
+		    (next_node->object->region.space_id == space_id)) {
 			goto exit;	/* Do not execute the _REG */
 		}
 
-		next_node = acpi_ns_get_next_node(ec_device_node, next_node);
+		next_node = acpi_ns_get_next_node(device_node, next_node);
 	}
 
-	/* Evaluate the _REG(embedded_control,Connect) method */
+	/* Evaluate the _REG(space_id,Connect) method */
 
 	args.count = 2;
 	args.pointer = objects;
 	objects[0].type = ACPI_TYPE_INTEGER;
-	objects[0].integer.value = ACPI_ADR_SPACE_EC;
+	objects[0].integer.value = space_id;
 	objects[1].type = ACPI_TYPE_INTEGER;
 	objects[1].integer.value = ACPI_REG_CONNECT;
 
-- 
2.25.1

