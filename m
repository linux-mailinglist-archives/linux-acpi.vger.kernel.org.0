Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C2025E0B7
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgIDR0X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 13:26:23 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65168 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgIDR0S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 13:26:18 -0400
Received: from 89-64-89-131.dynamic.chello.pl (89.64.89.131) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.468)
 id 83bc72f43659210a; Fri, 4 Sep 2020 19:26:16 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 1/6] ACPICA: Validate GPE blocks at init time
Date:   Fri, 04 Sep 2020 19:21:17 +0200
Message-ID: <22545488.GHJRr5m80a@kreacher>
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

Some of the checks done by acpi_hw_read() and acpi_hw_write(),
which are used for accessing GPE registers, are redundant in the
specific case of GPE registers and the ones that are not redundant
can be done upfront at the initialization time so as to fail the
initialization if they are not passed instead of failing every
access to the affected GPE registers going forward (including
accesses from the SCI interrupt handler).

Modify the GPE blocks initialization code accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/achware.h  |  2 ++
 drivers/acpi/acpica/evgpeblk.c | 17 +++++++++++++++++
 drivers/acpi/acpica/hwvalid.c  | 30 ++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index ebf6453d0e21..f1f644b58b15 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -73,6 +73,8 @@ acpi_status acpi_hw_read_port(acpi_io_address address, u32 *value, u32 width);
 
 acpi_status acpi_hw_write_port(acpi_io_address address, u32 value, u32 width);
 
+acpi_status acpi_hw_validate_io_block(u64 address, u32 bit_width, u32 count);
+
 /*
  * hwgpe - GPE support
  */
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 132adff1e131..eb5d98757fdc 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -317,6 +317,23 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 		return_ACPI_STATUS(AE_OK);
 	}
 
+	/* Validate the space_ID */
+
+	if ((space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY) &&
+	    (space_id != ACPI_ADR_SPACE_SYSTEM_IO)) {
+		ACPI_ERROR((AE_INFO,
+			    "Unsupported address space: 0x%X", space_id));
+		return_ACPI_STATUS(AE_SUPPORT);
+	}
+
+	if (space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+		status = acpi_hw_validate_io_block(address,
+						   ACPI_GPE_REGISTER_WIDTH,
+						   register_count);
+		if (ACPI_FAILURE(status))
+			return_ACPI_STATUS(status);
+	}
+
 	/* Allocate a new GPE block */
 
 	gpe_block = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_gpe_block_info));
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index 4d94861e6093..b2ca7dfd3fc9 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -292,3 +292,33 @@ acpi_status acpi_hw_write_port(acpi_io_address address, u32 value, u32 width)
 
 	return (AE_OK);
 }
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_validate_io_block
+ *
+ * PARAMETERS:  Address             Address of I/O port/register blobk
+ *              bit_width           Number of bits (8,16,32) in each register
+ *              count               Number of registers in the block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Validates a block of I/O ports/registers.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_hw_validate_io_block(u64 address, u32 bit_width, u32 count)
+{
+	acpi_status status;
+
+	while (count--) {
+		status = acpi_hw_validate_io_request((acpi_io_address)address,
+						     bit_width);
+		if (ACPI_FAILURE(status))
+			return_ACPI_STATUS(status);
+
+		address += ACPI_DIV_8(bit_width);
+	}
+
+	return_ACPI_STATUS(AE_OK);
+}
-- 
2.26.2




