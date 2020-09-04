Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF4725E0BA
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 19:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgIDR0j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 13:26:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51326 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgIDR0R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 13:26:17 -0400
Received: from 89-64-89-131.dynamic.chello.pl (89.64.89.131) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.468)
 id d8ffa229734c6c46; Fri, 4 Sep 2020 19:26:14 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 3/6] ACPICA: Introduce special struct type for GPE register addresses
Date:   Fri, 04 Sep 2020 19:23:04 +0200
Message-ID: <17404025.GhfappsbzY@kreacher>
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

Notice that the bit_width, bit_offset and access_width fields in
struct acpi_generic_address are not used during GPE register
accesses any more, so introduce a simplified address structure
type, struct acpi_gpe_address, to represent addresses of GPE
registers and use it instead of struct acpi_generic_address in
struct acpi_gpe_register_info.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/achware.h  |  4 ++--
 drivers/acpi/acpica/aclocal.h  | 11 +++++++++--
 drivers/acpi/acpica/evgpeblk.c |  6 ------
 drivers/acpi/acpica/hwgpe.c    |  8 ++++----
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 4dba7229f9c1..6ab92e28330d 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -78,9 +78,9 @@ acpi_status acpi_hw_validate_io_block(u64 address, u32 bit_width, u32 count);
 /*
  * hwgpe - GPE support
  */
-acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_generic_address *reg);
+acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_gpe_address *reg);
 
-acpi_status acpi_hw_gpe_write(u64 value, struct acpi_generic_address *reg);
+acpi_status acpi_hw_gpe_write(u64 value, struct acpi_gpe_address *reg);
 
 u32 acpi_hw_get_gpe_register_bit(struct acpi_gpe_event_info *gpe_event_info);
 
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index af58cd2dc9d3..f83b98fa13ac 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -454,11 +454,18 @@ struct acpi_gpe_event_info {
 	u8 disable_for_dispatch;	/* Masked during dispatching */
 };
 
+/* GPE register address */
+
+struct acpi_gpe_address {
+	u8 space_id;	/* Address space where the register exists */
+	u64 address;	/* 64-bit address of the register */
+};
+
 /* Information about a GPE register pair, one per each status/enable pair in an array */
 
 struct acpi_gpe_register_info {
-	struct acpi_generic_address status_address;	/* Address of status reg */
-	struct acpi_generic_address enable_address;	/* Address of enable reg */
+	struct acpi_gpe_address status_address;	/* Address of status reg */
+	struct acpi_gpe_address enable_address;	/* Address of enable reg */
 	u16 base_gpe_number;	/* Base GPE number for this register */
 	u8 enable_for_wake;	/* GPEs to keep enabled when sleeping */
 	u8 enable_for_run;	/* GPEs to keep enabled when running */
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 150c916dca5e..f5298be4273a 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -233,12 +233,6 @@ acpi_ev_create_gpe_info_blocks(struct acpi_gpe_block_info *gpe_block)
 
 		this_register->status_address.space_id = gpe_block->space_id;
 		this_register->enable_address.space_id = gpe_block->space_id;
-		this_register->status_address.bit_width =
-		    ACPI_GPE_REGISTER_WIDTH;
-		this_register->enable_address.bit_width =
-		    ACPI_GPE_REGISTER_WIDTH;
-		this_register->status_address.bit_offset = 0;
-		this_register->enable_address.bit_offset = 0;
 
 		/* Init the event_info for each GPE within this register */
 
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 6cc88524839d..a0e71f34c77a 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -29,7 +29,7 @@ acpi_hw_gpe_enable_write(u8 enable_mask,
  * FUNCTION:    acpi_hw_gpe_read
  *
  * PARAMETERS:  value               - Where the value is returned
- *              reg                 - GAS register structure
+ *              reg                 - GPE register structure
  *
  * RETURN:      Status
  *
@@ -40,7 +40,7 @@ acpi_hw_gpe_enable_write(u8 enable_mask,
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_generic_address *reg)
+acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_gpe_address *reg)
 {
 	acpi_status status;
 	u32 value32;
@@ -65,7 +65,7 @@ acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_generic_address *reg)
  * FUNCTION:    acpi_hw_gpe_write
  *
  * PARAMETERS:  value               - Value to be written
- *              reg                 - GAS register structure
+ *              reg                 - GPE register structure
  *
  * RETURN:      Status
  *
@@ -73,7 +73,7 @@ acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_generic_address *reg)
  *
  ******************************************************************************/
 
-acpi_status acpi_hw_gpe_write(u64 value, struct acpi_generic_address *reg)
+acpi_status acpi_hw_gpe_write(u64 value, struct acpi_gpe_address *reg)
 {
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
-- 
2.26.2





