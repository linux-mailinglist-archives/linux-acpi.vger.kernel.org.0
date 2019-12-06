Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A34114E5E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2019 10:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLFJtf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Dec 2019 04:49:35 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49199 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfLFJtf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Dec 2019 04:49:35 -0500
Received: from 79.184.254.100.ipv4.supernova.orange.pl (79.184.254.100) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 3282e608d9a507bd; Fri, 6 Dec 2019 10:49:32 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [RFC][PATCH 3/6] ACPI: processor: Clean up acpi_processor_evaluate_cst()
Date:   Fri, 06 Dec 2019 10:36:00 +0100
Message-ID: <1748087.ybfdX8pjRl@kreacher>
In-Reply-To: <2037014.bnAicLLH9b@kreacher>
References: <2037014.bnAicLLH9b@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Clean up acpi_processor_evaluate_cst() in multiple ways:

 * Rename current_count to last_index which matches the purpose of
   the variable better.

 * Consistently use acpi_handle_*() for printing messages and make
   the messages cleaner.

 * Drop redundant parens and braces.

 * Rewrite and clarify comments.

 * Rearrange checks and drop the redundant ones.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |  114 +++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 62 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -304,29 +304,29 @@ static int acpi_processor_evaluate_cst(a
 	union acpi_object *cst;
 	acpi_status status;
 	u64 count;
-	int current_count = 0;
+	int last_index = 0;
 	int i, ret = 0;
 
 	status = acpi_evaluate_object(handle, "_CST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No _CST, giving up\n"));
+		acpi_handle_debug(handle, "No _CST\n");
 		return -ENODEV;
 	}
 
 	cst = buffer.pointer;
 
-	/* There must be at least 2 elements */
-	if (!cst || (cst->type != ACPI_TYPE_PACKAGE) || cst->package.count < 2) {
-		pr_err("not enough elements in _CST\n");
+	/* There must be at least 2 elements. */
+	if (!cst || cst->type != ACPI_TYPE_PACKAGE || cst->package.count < 2) {
+		acpi_handle_warn(handle, "Invalid _CST output\n");
 		ret = -EFAULT;
 		goto end;
 	}
 
 	count = cst->package.elements[0].integer.value;
 
-	/* Validate number of power states. */
+	/* Validate the number of C-states. */
 	if (count < 1 || count != cst->package.count - 1) {
-		pr_err("count given by _CST is not valid\n");
+		acpi_handle_warn(handle, "Inconsistent _CST data\n");
 		ret = -EFAULT;
 		goto end;
 	}
@@ -337,111 +337,101 @@ static int acpi_processor_evaluate_cst(a
 		struct acpi_power_register *reg;
 		struct acpi_processor_cx cx;
 
+		/*
+		 * If there is not enough space for all C-states, skip the
+		 * excess ones and log a warning.
+		 */
+		if (last_index >= ACPI_PROCESSOR_MAX_POWER - 1) {
+			acpi_handle_warn(handle,
+					 "No room for more idle states (limit: %d)\n",
+					 ACPI_PROCESSOR_MAX_POWER - 1);
+			break;
+		}
+
 		memset(&cx, 0, sizeof(cx));
 
-		element = &(cst->package.elements[i]);
+		element = &cst->package.elements[i];
 		if (element->type != ACPI_TYPE_PACKAGE)
 			continue;
 
 		if (element->package.count != 4)
 			continue;
 
-		obj = &(element->package.elements[0]);
+		obj = &element->package.elements[0];
 
 		if (obj->type != ACPI_TYPE_BUFFER)
 			continue;
 
 		reg = (struct acpi_power_register *)obj->buffer.pointer;
 
-		if (reg->space_id != ACPI_ADR_SPACE_SYSTEM_IO &&
-		    (reg->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE))
-			continue;
-
-		/* There should be an easy way to extract an integer... */
-		obj = &(element->package.elements[1]);
+		obj = &element->package.elements[1];
 		if (obj->type != ACPI_TYPE_INTEGER)
 			continue;
 
 		cx.type = obj->integer.value;
 		/*
-		 * Some buggy BIOSes won't list C1 in _CST -
-		 * Let acpi_processor_get_power_info_default() handle them later
+		 * There are known cases in which the _CST output does not
+		 * contain C1, so if the type of the first state found is not
+		 * C1, leave an empty slot for C1 to be filled in later.
 		 */
 		if (i == 1 && cx.type != ACPI_STATE_C1)
-			current_count++;
+			last_index = 1;
 
 		cx.address = reg->address;
-		cx.index = current_count + 1;
+		cx.index = last_index + 1;
 
-		cx.entry_method = ACPI_CSTATE_SYSTEMIO;
 		if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
-			if (acpi_processor_ffh_cstate_probe
-					(cpu, &cx, reg) == 0) {
-				cx.entry_method = ACPI_CSTATE_FFH;
+			if (!acpi_processor_ffh_cstate_probe(cpu, &cx, reg)) {
+				/*
+				 * In the majority of cases _CST describes C1 as
+				 * a FIXED_HARDWARE C-state, but if the command
+				 * line forbids using MWAIT, use CSTATE_HALT for
+				 * C1 regardless.
+				 */
+				if (cx.type == ACPI_STATE_C1 &&
+				    boot_option_idle_override == IDLE_NOMWAIT) {
+					cx.entry_method = ACPI_CSTATE_HALT;
+					snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
+				} else {
+					cx.entry_method = ACPI_CSTATE_FFH;
+				}
 			} else if (cx.type == ACPI_STATE_C1) {
 				/*
-				 * C1 is a special case where FIXED_HARDWARE
-				 * can be handled in non-MWAIT way as well.
-				 * In that case, save this _CST entry info.
-				 * Otherwise, ignore this info and continue.
+				 * In the special case of C1, FIXED_HARDWARE can
+				 * be handled by executing the HLT instruction.
 				 */
 				cx.entry_method = ACPI_CSTATE_HALT;
 				snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
 			} else {
 				continue;
 			}
-			if (cx.type == ACPI_STATE_C1 &&
-			    (boot_option_idle_override == IDLE_NOMWAIT)) {
-				/*
-				 * In most cases the C1 space_id obtained from
-				 * _CST object is FIXED_HARDWARE access mode.
-				 * But when the option of idle=halt is added,
-				 * the entry_method type should be changed from
-				 * CSTATE_FFH to CSTATE_HALT.
-				 * When the option of idle=nomwait is added,
-				 * the C1 entry_method type should be
-				 * CSTATE_HALT.
-				 */
-				cx.entry_method = ACPI_CSTATE_HALT;
-				snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
-			}
-		} else {
+		} else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+			cx.entry_method = ACPI_CSTATE_SYSTEMIO;
 			snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI IOPORT 0x%x",
 				 cx.address);
+		} else {
+			continue;
 		}
 
-		if (cx.type == ACPI_STATE_C1) {
+		if (cx.type == ACPI_STATE_C1)
 			cx.valid = 1;
-		}
 
-		obj = &(element->package.elements[2]);
+		obj = &element->package.elements[2];
 		if (obj->type != ACPI_TYPE_INTEGER)
 			continue;
 
 		cx.latency = obj->integer.value;
 
-		obj = &(element->package.elements[3]);
+		obj = &element->package.elements[3];
 		if (obj->type != ACPI_TYPE_INTEGER)
 			continue;
 
-		current_count++;
-		memcpy(&info->states[current_count], &cx, sizeof(cx));
-
-		/*
-		 * We support total ACPI_PROCESSOR_MAX_POWER - 1
-		 * (From 1 through ACPI_PROCESSOR_MAX_POWER - 1)
-		 */
-		if (current_count >= (ACPI_PROCESSOR_MAX_POWER - 1)) {
-			pr_warn("Limiting number of power states to max (%d)\n",
-				ACPI_PROCESSOR_MAX_POWER);
-			pr_warn("Please increase ACPI_PROCESSOR_MAX_POWER if needed.\n");
-			break;
-		}
+		memcpy(&info->states[++last_index], &cx, sizeof(cx));
 	}
 
-	acpi_handle_info(handle, "Found %d idle states\n", current_count);
+	acpi_handle_info(handle, "Found %d idle states\n", last_index);
 
-	info->count = current_count;
+	info->count = last_index;
 
       end:
 	kfree(buffer.pointer);



