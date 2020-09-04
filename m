Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3308825E0B4
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgIDR0U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 13:26:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42296 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgIDR0S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 13:26:18 -0400
Received: from 89-64-89-131.dynamic.chello.pl (89.64.89.131) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.468)
 id 5fe1a974ca9da149; Fri, 4 Sep 2020 19:26:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 2/6] ACPICA: Introduce acpi_hw_gpe_read() and acpi_hw_gpe_write()
Date:   Fri, 04 Sep 2020 19:22:10 +0200
Message-ID: <10974679.vsXWU0Gk4m@kreacher>
In-Reply-To: <1748021.N9i9sLPJ40@kreacher>
References: <1748021.N9i9sLPJ40@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Now that GPE blocks are validated at the initialization time, accesses
to GPE registers can be made more straightforward by ommitting all of
the redundant checks in acpi_hw_read() and acpi_hw_write() and only
invoking the OS-provided helper for the given type of access (read or
write) and the address space holding these registers.

For this reason, introduce simplified routines for accessing GPE
registers, acpi_hw_gpe_read() and acpi_hw_gpe_write(), designed in
accordance with the above observation, and modify all of the code
accessing GPE registers to use them instead of acpi_hw_read() and
acpi_hw_write(), respectively.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/achware.h  |  4 ++
 drivers/acpi/acpica/evgpe.c    |  4 +-
 drivers/acpi/acpica/evgpeblk.c |  4 +-
 drivers/acpi/acpica/hwgpe.c    | 92 ++++++++++++++++++++++++++++------
 4 files changed, 84 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index f1f644b58b15..4dba7229f9c1 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -78,6 +78,10 @@ acpi_status acpi_hw_validate_io_block(u64 address, u32 bit_width, u32 count);
 /*
  * hwgpe - GPE support
  */
+acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_generic_address *reg);
+
+acpi_status acpi_hw_gpe_write(u64 value, struct acpi_generic_address *reg);
+
 u32 acpi_hw_get_gpe_register_bit(struct acpi_gpe_event_info *gpe_event_info);
 
 acpi_status
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 3e39907fedd9..06b9c8dd11c9 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -656,14 +656,14 @@ acpi_ev_detect_gpe(struct acpi_namespace_node *gpe_device,
 
 	/* GPE currently enabled (enable bit == 1)? */
 
-	status = acpi_hw_read(&enable_reg, &gpe_register_info->enable_address);
+	status = acpi_hw_gpe_read(&enable_reg, &gpe_register_info->enable_address);
 	if (ACPI_FAILURE(status)) {
 		goto error_exit;
 	}
 
 	/* GPE currently active (status bit == 1)? */
 
-	status = acpi_hw_read(&status_reg, &gpe_register_info->status_address);
+	status = acpi_hw_gpe_read(&status_reg, &gpe_register_info->status_address);
 	if (ACPI_FAILURE(status)) {
 		goto error_exit;
 	}
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index eb5d98757fdc..150c916dca5e 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -251,14 +251,14 @@ acpi_ev_create_gpe_info_blocks(struct acpi_gpe_block_info *gpe_block)
 
 		/* Disable all GPEs within this register */
 
-		status = acpi_hw_write(0x00, &this_register->enable_address);
+		status = acpi_hw_gpe_write(0x00, &this_register->enable_address);
 		if (ACPI_FAILURE(status)) {
 			goto error_exit;
 		}
 
 		/* Clear any pending GPE events within this register */
 
-		status = acpi_hw_write(0xFF, &this_register->status_address);
+		status = acpi_hw_gpe_write(0xFF, &this_register->status_address);
 		if (ACPI_FAILURE(status)) {
 			goto error_exit;
 		}
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 49c46d4dd070..6cc88524839d 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -24,6 +24,66 @@ static acpi_status
 acpi_hw_gpe_enable_write(u8 enable_mask,
 			 struct acpi_gpe_register_info *gpe_register_info);
 
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_gpe_read
+ *
+ * PARAMETERS:  value               - Where the value is returned
+ *              reg                 - GAS register structure
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Read from a GPE register in either memory or IO space.
+ *
+ * LIMITATIONS: <These limitations also apply to acpi_hw_gpe_write>
+ *      space_ID must be system_memory or system_IO.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_generic_address *reg)
+{
+	acpi_status status;
+	u32 value32;
+
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		return acpi_os_read_memory((acpi_physical_address)reg->address,
+					    value, ACPI_GPE_REGISTER_WIDTH);
+	}
+
+	status = acpi_os_read_port((acpi_io_address)reg->address,
+				   &value32, ACPI_GPE_REGISTER_WIDTH);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
+
+	*value = (u64)value32;
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_gpe_write
+ *
+ * PARAMETERS:  value               - Value to be written
+ *              reg                 - GAS register structure
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Write to a GPE register in either memory or IO space.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_hw_gpe_write(u64 value, struct acpi_generic_address *reg)
+{
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		return acpi_os_write_memory((acpi_physical_address)reg->address,
+					    value, ACPI_GPE_REGISTER_WIDTH);
+	}
+
+	return acpi_os_write_port((acpi_io_address)reg->address, (u32)value,
+				  ACPI_GPE_REGISTER_WIDTH);
+}
+
 /******************************************************************************
  *
  * FUNCTION:	acpi_hw_get_gpe_register_bit
@@ -79,7 +139,8 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
 
 	/* Get current value of the enable register that contains this GPE */
 
-	status = acpi_hw_read(&enable_mask, &gpe_register_info->enable_address);
+	status = acpi_hw_gpe_read(&enable_mask,
+				  &gpe_register_info->enable_address);
 	if (ACPI_FAILURE(status)) {
 		return (status);
 	}
@@ -118,9 +179,8 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
 
 		/* Write the updated enable mask */
 
-		status =
-		    acpi_hw_write(enable_mask,
-				  &gpe_register_info->enable_address);
+		status = acpi_hw_gpe_write(enable_mask,
+					   &gpe_register_info->enable_address);
 	}
 	return (status);
 }
@@ -158,8 +218,8 @@ acpi_status acpi_hw_clear_gpe(struct acpi_gpe_event_info *gpe_event_info)
 	 */
 	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info);
 
-	status =
-	    acpi_hw_write(register_bit, &gpe_register_info->status_address);
+	status = acpi_hw_gpe_write(register_bit,
+				   &gpe_register_info->status_address);
 	return (status);
 }
 
@@ -227,7 +287,7 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 
 	/* GPE currently enabled (enable bit == 1)? */
 
-	status = acpi_hw_read(&in_byte, &gpe_register_info->enable_address);
+	status = acpi_hw_gpe_read(&in_byte, &gpe_register_info->enable_address);
 	if (ACPI_FAILURE(status)) {
 		return (status);
 	}
@@ -238,7 +298,7 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 
 	/* GPE currently active (status bit == 1)? */
 
-	status = acpi_hw_read(&in_byte, &gpe_register_info->status_address);
+	status = acpi_hw_gpe_read(&in_byte, &gpe_register_info->status_address);
 	if (ACPI_FAILURE(status)) {
 		return (status);
 	}
@@ -274,7 +334,8 @@ acpi_hw_gpe_enable_write(u8 enable_mask,
 
 	gpe_register_info->enable_mask = enable_mask;
 
-	status = acpi_hw_write(enable_mask, &gpe_register_info->enable_address);
+	status = acpi_hw_gpe_write(enable_mask,
+				   &gpe_register_info->enable_address);
 	return (status);
 }
 
@@ -341,9 +402,8 @@ acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 		/* Clear status on all GPEs in this register */
 
-		status =
-		    acpi_hw_write(0xFF,
-				  &gpe_block->register_info[i].status_address);
+		status = acpi_hw_gpe_write(0xFF,
+					   &gpe_block->register_info[i].status_address);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
@@ -481,14 +541,14 @@ acpi_hw_get_gpe_block_status(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 	for (i = 0; i < gpe_block->register_count; i++) {
 		gpe_register_info = &gpe_block->register_info[i];
 
-		status = acpi_hw_read(&in_enable,
-				      &gpe_register_info->enable_address);
+		status = acpi_hw_gpe_read(&in_enable,
+					  &gpe_register_info->enable_address);
 		if (ACPI_FAILURE(status)) {
 			continue;
 		}
 
-		status = acpi_hw_read(&in_status,
-				      &gpe_register_info->status_address);
+		status = acpi_hw_gpe_read(&in_status,
+					  &gpe_register_info->status_address);
 		if (ACPI_FAILURE(status)) {
 			continue;
 		}
-- 
2.26.2




