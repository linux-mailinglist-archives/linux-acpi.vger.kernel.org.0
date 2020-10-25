Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9D2298111
	for <lists+linux-acpi@lfdr.de>; Sun, 25 Oct 2020 10:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414935AbgJYJpw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 25 Oct 2020 05:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31667 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1414933AbgJYJpv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 25 Oct 2020 05:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603619149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qV+eTDCwgy2LIubPl4aW2lcG1O4eI22+KXOEyBYfeUk=;
        b=TYzPRIA6+szCSvRFCSTcKTVQ4YGqYouYnMIFbM/rWA2V9jFcATshRtJe/Za6cb58cEDkxX
        j+RbqMNj2S+EPuFoKvJIvfsy56H1NCogaqlvBkrUFGRg35D7U88Ecs0EmrD/GkW8VyP5RV
        tMF/3SAYXRDqJAVHIzsaWbg7tzOtY2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-TU-wMh9RNyeJIibl94_23Q-1; Sun, 25 Oct 2020 05:45:46 -0400
X-MC-Unique: TU-wMh9RNyeJIibl94_23Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CD2E186DD23;
        Sun, 25 Oct 2020 09:45:45 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-79.ams2.redhat.com [10.36.112.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 680C21002C09;
        Sun, 25 Oct 2020 09:45:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO OpRegions
Date:   Sun, 25 Oct 2020 10:45:42 +0100
Message-Id: <20201025094542.3669-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Before this commit acpi_ev_execute_reg_methods() had special handling
to handle "orphan" (no matching OpRegion declared) _REG methods for EC
nodes.

On Intel Cherry Trail devices there are 2 possible ACPI OpRegions for
accessing GPIOs. The standard GeneralPurposeIo OpRegion and the Cherry
Trail specific UserDefined 0x9X OpRegions.

Having 2 different types of OpRegions leads to potential issues with
checks for OpRegion availability, or in other words checks if _REG has
been called for the OpRegion which the ACPI code wants to use.

Except for the "orphan" EC handling, ACPICA core does not call _REG on
an ACPI node which does not define an OpRegion matching the type being
registered; and the reference design DSDT, from which most Cherry Trail
DSDTs are derived, does not define GeneralPurposeIo, nor UserDefined(0x93)
OpRegions for the GPO2 (UID 3) device, because no pins were assigned ACPI
controlled functions in the reference design.

Together this leads to the perfect storm, at least on the Cherry Trail
based Medion Akayo E1239T. This design does use a GPO2 pin from its ACPI
code and has added the Cherry Trail specific UserDefined(0x93) opregion
to its GPO2 ACPI node to access this pin.

But it uses a has _REG been called availability check for the standard
GeneralPurposeIo OpRegion. This clearly is a bug in the DSDT, but this
does work under Windows. This issue leads to the intel_vbtn driver
reporting the device always being in tablet-mode at boot, even if it
is in laptop mode. Which in turn causes userspace to ignore touchpad
events. So iow this issues causes the touchpad to not work at boot.

This commit fixes this by extending the "orphan" _REG method handling
to also apply to GPIO address-space handlers.

Note it seems that Windows always calls "orphan" _REG methods so me
may want to consider dropping the space-id check and always do
"orphan" _REG method handling.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpica/evregion.c | 54 +++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 738d4b231f34..21ff341e34a4 100644
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
+ * PARAMETERS:  device_node     - Namespace node for an ACPI device
+ *              space_id        - The address space ID
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
+	/* Evaluate the _REG(space_id, Connect) method */
 
 	args.count = 2;
 	args.pointer = objects;
 	objects[0].type = ACPI_TYPE_INTEGER;
-	objects[0].integer.value = ACPI_ADR_SPACE_EC;
+	objects[0].integer.value = space_id;
 	objects[1].type = ACPI_TYPE_INTEGER;
 	objects[1].integer.value = ACPI_REG_CONNECT;
 
-- 
2.28.0

