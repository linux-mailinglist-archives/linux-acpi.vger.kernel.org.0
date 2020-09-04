Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1B925E0BD
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 19:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgIDR0z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 13:26:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52256 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgIDR0Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 13:26:16 -0400
Received: from 89-64-89-131.dynamic.chello.pl (89.64.89.131) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.468)
 id 479dadb6a4c6bf8e; Fri, 4 Sep 2020 19:26:13 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 4/6] ACPICA: Add support for using logical addresses of GPE blocks
Date:   Fri, 04 Sep 2020 19:24:14 +0200
Message-ID: <9373262.piL2bvXoCD@kreacher>
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

The logical address of every GPE block in system memory must be
known before passing it to acpi_ev_initialize_gpe_block(), because
memory cannot be mapped on the fly from an interrupt handler.
Accordingly, the host OS must map every GPE block in system
memory upfront and it can store the logical addresses of GPE
blocks for future use.

If these logical addresses were known to ACPICA, it could use them
instead of the corresponding physical addresses of GPE block for
GPE register accesses and the memory mapping lookups carried out
by acpi_os_read_memory() and acpi_os_write_memory() on every
attempt to access a GPE register would not be necessary any more.

To allow that to happen, introduce the ACPI_GPE_USE_LOGICAL_ADDRESSES
symbol to indicate whether or not the host OS wants ACPICA to use the
logical addresses of GPE registers in system memory directly (which
is the case if this symbol is defined).  Moreover, conditional on
whether ACPI_GPE_USE_LOGICAL_ADDRESSES is defined, introduce two new
global variables for storing the logical addresses of the FADT GPE
blocks 0 and 1, respectively, acpi_gbl_xgpe0_block_logical_address and
acpi_gbl_xgpe1_block_logical_address, make acpi_ev_gpe_initialize()
pass their values instead of the physical addresses of the GPE blocks
in question to acpi_ev_create_gpe_block() and modify
acpi_hw_gpe_read() and acpi_hw_gpe_write() to access memory directly
via the addresses stored in the struct acpi_gpe_address objects,
which are expected to be the logical addresses of GPE registers if
ACPI_GPE_USE_LOGICAL_ADDRESSES is defined.

With the above changes in place, a host OS wanting ACPICA to
access GPE registers directly through their logical addresses
needs to define the ACPI_GPE_USE_LOGICAL_ADDRESSES symbol and
make sure that the logical addresses of the FADT GPE blocks 0
and 1 are stored in acpi_gbl_xgpe0_block_logical_address and
acpi_gbl_xgpe1_block_logical_address, respectively, prior to
calling acpi_ev_gpe_initialize().

[If such a host OS also uses acpi_install_gpe_block() to add
 non-FADT GPE register blocks located in system memory, it must
 pass their logical addresses instead of their physical addresses
 to this function.]

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acglobal.h  |  6 ++++++
 drivers/acpi/acpica/evgpeinit.c | 23 +++++++++++++++++------
 drivers/acpi/acpica/hwgpe.c     | 10 ++++++++++
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 1030a0ce1599..5215ff1cbbbe 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -42,6 +42,12 @@ ACPI_GLOBAL(struct acpi_generic_address, acpi_gbl_xpm1a_enable);
 ACPI_GLOBAL(struct acpi_generic_address, acpi_gbl_xpm1b_status);
 ACPI_GLOBAL(struct acpi_generic_address, acpi_gbl_xpm1b_enable);
 
+#ifdef ACPI_GPE_USE_LOGICAL_ADDRESSES
+ACPI_GLOBAL(void *, acpi_gbl_xgpe0_block_logical_address);
+ACPI_GLOBAL(void *, acpi_gbl_xgpe1_block_logical_address);
+
+#endif				/* ACPI_GPE_USE_LOGICAL_ADDRESSES */
+
 /*
  * Handle both ACPI 1.0 and ACPI 2.0+ Integer widths. The integer width is
  * determined by the revision of the DSDT: If the DSDT revision is less than
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 6effd8076dcc..6d82d30d8f7b 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -32,6 +32,16 @@ ACPI_MODULE_NAME("evgpeinit")
  * kernel boot time as well.
  */
 
+#ifdef ACPI_GPE_USE_LOGICAL_ADDRESSES
+#define ACPI_FADT_GPE_BLOCK_ADDRESS(N)	\
+	acpi_gbl_FADT.xgpe##N##_block.space_id == \
+					ACPI_ADR_SPACE_SYSTEM_MEMORY ? \
+		(u64)acpi_gbl_xgpe##N##_block_logical_address : \
+		acpi_gbl_FADT.xgpe##N##_block.address
+#else
+#define ACPI_FADT_GPE_BLOCK_ADDRESS(N)	acpi_gbl_FADT.xgpe##N##_block.address
+#endif		/* ACPI_GPE_USE_LOGICAL_ADDRESSES */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_gpe_initialize
@@ -49,6 +59,7 @@ acpi_status acpi_ev_gpe_initialize(void)
 	u32 register_count1 = 0;
 	u32 gpe_number_max = 0;
 	acpi_status status;
+	u64 address;
 
 	ACPI_FUNCTION_TRACE(ev_gpe_initialize);
 
@@ -85,8 +96,9 @@ acpi_status acpi_ev_gpe_initialize(void)
 	 * If EITHER the register length OR the block address are zero, then that
 	 * particular block is not supported.
 	 */
-	if (acpi_gbl_FADT.gpe0_block_length &&
-	    acpi_gbl_FADT.xgpe0_block.address) {
+	address = ACPI_FADT_GPE_BLOCK_ADDRESS(0);
+
+	if (acpi_gbl_FADT.gpe0_block_length && address) {
 
 		/* GPE block 0 exists (has both length and address > 0) */
 
@@ -97,7 +109,6 @@ acpi_status acpi_ev_gpe_initialize(void)
 		/* Install GPE Block 0 */
 
 		status = acpi_ev_create_gpe_block(acpi_gbl_fadt_gpe_device,
-						  acpi_gbl_FADT.xgpe0_block.
 						  address,
 						  acpi_gbl_FADT.xgpe0_block.
 						  space_id, register_count0, 0,
@@ -110,8 +121,9 @@ acpi_status acpi_ev_gpe_initialize(void)
 		}
 	}
 
-	if (acpi_gbl_FADT.gpe1_block_length &&
-	    acpi_gbl_FADT.xgpe1_block.address) {
+	address = ACPI_FADT_GPE_BLOCK_ADDRESS(1);
+
+	if (acpi_gbl_FADT.gpe1_block_length && address) {
 
 		/* GPE block 1 exists (has both length and address > 0) */
 
@@ -137,7 +149,6 @@ acpi_status acpi_ev_gpe_initialize(void)
 
 			status =
 			    acpi_ev_create_gpe_block(acpi_gbl_fadt_gpe_device,
-						     acpi_gbl_FADT.xgpe1_block.
 						     address,
 						     acpi_gbl_FADT.xgpe1_block.
 						     space_id, register_count1,
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index a0e71f34c77a..37bb67ef3232 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -46,8 +46,13 @@ acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_gpe_address *reg)
 	u32 value32;
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+#ifdef ACPI_GPE_USE_LOGICAL_ADDRESSES
+		*value = (u64)ACPI_GET8(reg->address);
+		return_ACPI_STATUS(AE_OK);
+#else
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
 					    value, ACPI_GPE_REGISTER_WIDTH);
+#endif
 	}
 
 	status = acpi_os_read_port((acpi_io_address)reg->address,
@@ -76,8 +81,13 @@ acpi_status acpi_hw_gpe_read(u64 *value, struct acpi_gpe_address *reg)
 acpi_status acpi_hw_gpe_write(u64 value, struct acpi_gpe_address *reg)
 {
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+#ifdef ACPI_GPE_USE_LOGICAL_ADDRESSES
+		ACPI_SET8(reg->address, value);
+		return_ACPI_STATUS(AE_OK);
+#else
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
 					    value, ACPI_GPE_REGISTER_WIDTH);
+#endif
 	}
 
 	return acpi_os_write_port((acpi_io_address)reg->address, (u32)value,
-- 
2.26.2




