Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC02159565
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2020 17:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbgBKQyJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Feb 2020 11:54:09 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41020 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgBKQyI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Feb 2020 11:54:08 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 9cf39a09d67bf79b; Tue, 11 Feb 2020 17:54:06 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        David Box <david.e.box@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 1/2] ACPICA: Introduce acpi_any_gpe_status_set()
Date:   Tue, 11 Feb 2020 17:52:32 +0100
Message-ID: <6824745.IKPLm0Xgeq@kreacher>
In-Reply-To: <6974889.tv0o8xEHfr@kreacher>
References: <6974889.tv0o8xEHfr@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a new helper function, acpi_any_gpe_status_set(), for
checking the status bits of all enabled GPEs in one go.

It is needed to distinguish spurious SCIs from genuine ones when
deciding whether or not to wake up the system from suspend-to-idle.

Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/achware.h |    2 +
 drivers/acpi/acpica/evxfgpe.c |   32 ++++++++++++++++++
 drivers/acpi/acpica/hwgpe.c   |   71 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h         |    1 
 4 files changed, 106 insertions(+)

Index: linux-pm/drivers/acpi/acpica/hwgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwgpe.c
+++ linux-pm/drivers/acpi/acpica/hwgpe.c
@@ -446,6 +446,53 @@ acpi_hw_enable_wakeup_gpe_block(struct a
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_hw_get_gpe_block_status
+ *
+ * PARAMETERS:  gpe_xrupt_info      - GPE Interrupt info
+ *              gpe_block           - Gpe Block info
+ *
+ * RETURN:      Success
+ *
+ * DESCRIPTION: Produce a combined GPE status bits mask for the given block.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_hw_get_gpe_block_status(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
+			     struct acpi_gpe_block_info *gpe_block,
+			     void *ret_ptr)
+{
+	struct acpi_gpe_register_info *gpe_register_info;
+	u64 in_enable, in_status;
+	acpi_status status;
+	u8 *ret = ret_ptr;
+	u32 i;
+
+	/* Examine each GPE Register within the block */
+
+	for (i = 0; i < gpe_block->register_count; i++) {
+		gpe_register_info = &gpe_block->register_info[i];
+
+		status = acpi_hw_read(&in_enable,
+				      &gpe_register_info->enable_address);
+		if (ACPI_FAILURE(status)) {
+			continue;
+		}
+
+		status = acpi_hw_read(&in_status,
+				      &gpe_register_info->status_address);
+		if (ACPI_FAILURE(status)) {
+			continue;
+		}
+
+		*ret |= in_enable & in_status;
+	}
+
+	return (AE_OK);
+}
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_hw_disable_all_gpes
  *
  * PARAMETERS:  None
@@ -510,4 +557,28 @@ acpi_status acpi_hw_enable_all_wakeup_gp
 	return_ACPI_STATUS(status);
 }
 
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_check_all_gpes
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Combined status of all GPEs
+ *
+ * DESCRIPTION: Check all enabled GPEs in all GPE blocks and return TRUE if the
+ *              status bit is set for at least one of them of FALSE otherwise.
+ *
+ ******************************************************************************/
+
+u8 acpi_hw_check_all_gpes(void)
+{
+	u8 ret = 0;
+
+	ACPI_FUNCTION_TRACE(acpi_hw_check_all_gpes);
+
+	(void)acpi_ev_walk_gpe_list(acpi_hw_get_gpe_block_status, &ret);
+
+	return (ret != 0);
+}
+
 #endif				/* !ACPI_REDUCED_HARDWARE */
Index: linux-pm/drivers/acpi/acpica/achware.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/achware.h
+++ linux-pm/drivers/acpi/acpica/achware.h
@@ -101,6 +101,8 @@ acpi_status acpi_hw_enable_all_runtime_g
 
 acpi_status acpi_hw_enable_all_wakeup_gpes(void);
 
+u8 acpi_hw_check_all_gpes(void);
+
 acpi_status
 acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 				 struct acpi_gpe_block_info *gpe_block,
Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-pm/drivers/acpi/acpica/evxfgpe.c
@@ -795,6 +795,38 @@ acpi_status acpi_enable_all_wakeup_gpes(
 
 ACPI_EXPORT_SYMBOL(acpi_enable_all_wakeup_gpes)
 
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_any_gpe_status_set
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Whether or not the status bit is set for any GPE
+ *
+ * DESCRIPTION: Check the status bits of all enabled GPEs and return TRUE if any
+ *              of them is set or FALSE otherwise.
+ *
+ ******************************************************************************/
+u32 acpi_any_gpe_status_set(void)
+{
+	acpi_status status;
+	u8 ret;
+
+	ACPI_FUNCTION_TRACE(acpi_any_gpe_status_set);
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return (FALSE);
+	}
+
+	ret = acpi_hw_check_all_gpes();
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+
+	return (ret);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_any_gpe_status_set)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_install_gpe_block
Index: linux-pm/include/acpi/acpixf.h
===================================================================
--- linux-pm.orig/include/acpi/acpixf.h
+++ linux-pm/include/acpi/acpixf.h
@@ -752,6 +752,7 @@ ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
+ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_any_gpe_status_set(void))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_get_gpe_device(u32 gpe_index,



