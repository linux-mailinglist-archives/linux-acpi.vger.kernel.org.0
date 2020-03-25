Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA0192651
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Mar 2020 11:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCYK4l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 25 Mar 2020 06:56:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45404 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgCYK4k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Mar 2020 06:56:40 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 832396319de3948e; Wed, 25 Mar 2020 11:56:38 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        =?utf-8?B?T25kxZllag==?= Caletka <ondrej@caletka.cz>
Subject: [PATCH 1/2] ACPICA: Allow acpi_any_gpe_status_set() to skip one GPE
Date:   Wed, 25 Mar 2020 11:54:29 +0100
Message-ID: <2501943.mi8mbN1kY1@kreacher>
In-Reply-To: <9291082.ZuhHelrm8h@kreacher>
References: <9291082.ZuhHelrm8h@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The check carried out by acpi_any_gpe_status_set() is not precise enough
for the suspend-to-idle implementation in Linux and in some cases it is
necessary make it skip one GPE (specifically, the EC GPE) from the check
to prevent a race condition leading to a premature system resume from
occurring.

For this reason, redefine acpi_any_gpe_status_set() to take the number
of a GPE to skip as an argument.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206629
Tested-by: Ondřej Caletka <ondrej@caletka.cz>
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/achware.h |  2 +-
 drivers/acpi/acpica/evxfgpe.c | 17 +++++++++++-----
 drivers/acpi/acpica/hwgpe.c   | 47 ++++++++++++++++++++++++++++++++++---------
 drivers/acpi/sleep.c          |  2 +-
 include/acpi/acpixf.h         |  2 +-
 5 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 6ad0517553d5..ebf6453d0e21 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -101,7 +101,7 @@ acpi_status acpi_hw_enable_all_runtime_gpes(void);
 
 acpi_status acpi_hw_enable_all_wakeup_gpes(void);
 
-u8 acpi_hw_check_all_gpes(void);
+u8 acpi_hw_check_all_gpes(acpi_handle gpe_skip_device, u32 gpe_skip_number);
 
 acpi_status
 acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index f2de66bfd8a7..3be60673e461 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -799,17 +799,19 @@ ACPI_EXPORT_SYMBOL(acpi_enable_all_wakeup_gpes)
  *
  * FUNCTION:    acpi_any_gpe_status_set
  *
- * PARAMETERS:  None
+ * PARAMETERS:  gpe_skip_number      - Number of the GPE to skip
  *
  * RETURN:      Whether or not the status bit is set for any GPE
  *
- * DESCRIPTION: Check the status bits of all enabled GPEs and return TRUE if any
- *              of them is set or FALSE otherwise.
+ * DESCRIPTION: Check the status bits of all enabled GPEs, except for the one
+ *              represented by the "skip" argument, and return TRUE if any of
+ *              them is set or FALSE otherwise.
  *
  ******************************************************************************/
-u32 acpi_any_gpe_status_set(void)
+u32 acpi_any_gpe_status_set(u32 gpe_skip_number)
 {
 	acpi_status status;
+	acpi_handle gpe_device;
 	u8 ret;
 
 	ACPI_FUNCTION_TRACE(acpi_any_gpe_status_set);
@@ -819,7 +821,12 @@ u32 acpi_any_gpe_status_set(void)
 		return (FALSE);
 	}
 
-	ret = acpi_hw_check_all_gpes();
+	status = acpi_get_gpe_device(gpe_skip_number, &gpe_device);
+	if (ACPI_FAILURE(status)) {
+		gpe_device = NULL;
+	}
+
+	ret = acpi_hw_check_all_gpes(gpe_device, gpe_skip_number);
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 
 	return (ret);
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index f4c285c2f595..49c46d4dd070 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -444,12 +444,19 @@ acpi_hw_enable_wakeup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 	return (AE_OK);
 }
 
+struct acpi_gpe_block_status_context {
+	struct acpi_gpe_register_info *gpe_skip_register_info;
+	u8 gpe_skip_mask;
+	u8 retval;
+};
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_hw_get_gpe_block_status
  *
  * PARAMETERS:  gpe_xrupt_info      - GPE Interrupt info
  *              gpe_block           - Gpe Block info
+ *              context             - GPE list walk context data
  *
  * RETURN:      Success
  *
@@ -460,12 +467,13 @@ acpi_hw_enable_wakeup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 static acpi_status
 acpi_hw_get_gpe_block_status(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			     struct acpi_gpe_block_info *gpe_block,
-			     void *ret_ptr)
+			     void *context)
 {
+	struct acpi_gpe_block_status_context *c = context;
 	struct acpi_gpe_register_info *gpe_register_info;
 	u64 in_enable, in_status;
 	acpi_status status;
-	u8 *ret = ret_ptr;
+	u8 ret_mask;
 	u32 i;
 
 	/* Examine each GPE Register within the block */
@@ -485,7 +493,11 @@ acpi_hw_get_gpe_block_status(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			continue;
 		}
 
-		*ret |= in_enable & in_status;
+		ret_mask = in_enable & in_status;
+		if (ret_mask && c->gpe_skip_register_info == gpe_register_info) {
+			ret_mask &= ~c->gpe_skip_mask;
+		}
+		c->retval |= ret_mask;
 	}
 
 	return (AE_OK);
@@ -561,24 +573,41 @@ acpi_status acpi_hw_enable_all_wakeup_gpes(void)
  *
  * FUNCTION:    acpi_hw_check_all_gpes
  *
- * PARAMETERS:  None
+ * PARAMETERS:  gpe_skip_device      - GPE devoce of the GPE to skip
+ *              gpe_skip_number      - Number of the GPE to skip
  *
  * RETURN:      Combined status of all GPEs
  *
- * DESCRIPTION: Check all enabled GPEs in all GPE blocks and return TRUE if the
+ * DESCRIPTION: Check all enabled GPEs in all GPE blocks, except for the one
+ *              represented by the "skip" arguments, and return TRUE if the
  *              status bit is set for at least one of them of FALSE otherwise.
  *
  ******************************************************************************/
 
-u8 acpi_hw_check_all_gpes(void)
+u8 acpi_hw_check_all_gpes(acpi_handle gpe_skip_device, u32 gpe_skip_number)
 {
-	u8 ret = 0;
+	struct acpi_gpe_block_status_context context = {
+		.gpe_skip_register_info = NULL,
+		.retval = 0,
+	};
+	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_cpu_flags flags;
 
 	ACPI_FUNCTION_TRACE(acpi_hw_check_all_gpes);
 
-	(void)acpi_ev_walk_gpe_list(acpi_hw_get_gpe_block_status, &ret);
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_skip_device,
+						    gpe_skip_number);
+	if (gpe_event_info) {
+		context.gpe_skip_register_info = gpe_event_info->register_info;
+		context.gpe_skip_mask = acpi_hw_get_gpe_register_bit(gpe_event_info);
+	}
+
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 
-	return (ret != 0);
+	(void)acpi_ev_walk_gpe_list(acpi_hw_get_gpe_block_status, &context);
+	return (context.retval != 0);
 }
 
 #endif				/* !ACPI_REDUCED_HARDWARE */
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index e5f95922bc21..857a6165c534 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -1022,7 +1022,7 @@ static bool acpi_s2idle_wake(void)
 		 * status bit from unset to set between the checks with the
 		 * status bits of all the other GPEs unset.
 		 */
-		if (acpi_any_gpe_status_set() && !acpi_ec_dispatch_gpe())
+		if (acpi_any_gpe_status_set(U32_MAX) && !acpi_ec_dispatch_gpe())
 			return true;
 
 		/*
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 8e8be989c2a6..a50d6dea44c3 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -752,7 +752,7 @@ ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_dispatch_gpe(acpi_handle gpe_device, u3
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
-ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_any_gpe_status_set(void))
+ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_any_gpe_status_set(u32 gpe_skip_number))
 ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_any_fixed_event_status_set(void))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
-- 
2.16.4




