Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4FD114E6C
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2019 10:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfLFJtt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Dec 2019 04:49:49 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64947 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLFJtf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Dec 2019 04:49:35 -0500
Received: from 79.184.254.100.ipv4.supernova.orange.pl (79.184.254.100) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 5e25dbf83e0c0420; Fri, 6 Dec 2019 10:49:31 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [RFC][PATCH 4/6] ACPI: processor: Export acpi_processor_evaluate_cst()
Date:   Fri, 06 Dec 2019 10:37:12 +0100
Message-ID: <1840912.Bc70b32FYA@kreacher>
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

The intel_idle driver will be modified to use ACPI _CST subsequently
and it will need to call acpi_processor_evaluate_cst(), so move that
function to acpi_processor.c so that it is always present (which is
required by intel_idle) and export it to modules to allow the ACPI
processor driver (which is modular) to call it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_processor.c |  154 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/processor_idle.c |  139 -------------------------------------
 include/linux/acpi.h          |    9 ++
 3 files changed, 163 insertions(+), 139 deletions(-)

Index: linux-pm/drivers/acpi/acpi_processor.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_processor.c
+++ linux-pm/drivers/acpi/acpi_processor.c
@@ -729,4 +729,161 @@ bool acpi_processor_claim_cst_control(vo
 	return true;
 }
 EXPORT_SYMBOL_GPL(acpi_processor_claim_cst_control);
+
+/**
+ * acpi_processor_evaluate_cst - Evaluate the processor _CST control method.
+ * @handle: ACPI handle of the processor object containing the _CST.
+ * @cpu: The numeric ID of the target CPU.
+ * @info: Object write the C-states information into.
+ *
+ * Extract the C-state information for the given CPU from the output of the _CST
+ * control method under the corresponding ACPI processor object (or processor
+ * device object) and populate @info with it.
+ *
+ * If any ACPI_ADR_SPACE_FIXED_HARDWARE C-states are found, invoke
+ * acpi_processor_ffh_cstate_probe() to verify them and update the
+ * cpu_cstate_entry data for @cpu.
+ */
+int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
+				struct acpi_processor_power *info)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *cst;
+	acpi_status status;
+	u64 count;
+	int last_index = 0;
+	int i, ret = 0;
+
+	status = acpi_evaluate_object(handle, "_CST", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(handle, "No _CST\n");
+		return -ENODEV;
+	}
+
+	cst = buffer.pointer;
+
+	/* There must be at least 2 elements. */
+	if (!cst || cst->type != ACPI_TYPE_PACKAGE || cst->package.count < 2) {
+		acpi_handle_warn(handle, "Invalid _CST output\n");
+		ret = -EFAULT;
+		goto end;
+	}
+
+	count = cst->package.elements[0].integer.value;
+
+	/* Validate the number of C-states. */
+	if (count < 1 || count != cst->package.count - 1) {
+		acpi_handle_warn(handle, "Inconsistent _CST data\n");
+		ret = -EFAULT;
+		goto end;
+	}
+
+	for (i = 1; i <= count; i++) {
+		union acpi_object *element;
+		union acpi_object *obj;
+		struct acpi_power_register *reg;
+		struct acpi_processor_cx cx;
+
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
+		memset(&cx, 0, sizeof(cx));
+
+		element = &cst->package.elements[i];
+		if (element->type != ACPI_TYPE_PACKAGE)
+			continue;
+
+		if (element->package.count != 4)
+			continue;
+
+		obj = &element->package.elements[0];
+
+		if (obj->type != ACPI_TYPE_BUFFER)
+			continue;
+
+		reg = (struct acpi_power_register *)obj->buffer.pointer;
+
+		obj = &element->package.elements[1];
+		if (obj->type != ACPI_TYPE_INTEGER)
+			continue;
+
+		cx.type = obj->integer.value;
+		/*
+		 * There are known cases in which the _CST output does not
+		 * contain C1, so if the type of the first state found is not
+		 * C1, leave an empty slot for C1 to be filled in later.
+		 */
+		if (i == 1 && cx.type != ACPI_STATE_C1)
+			last_index = 1;
+
+		cx.address = reg->address;
+		cx.index = last_index + 1;
+
+		if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
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
+			} else if (cx.type == ACPI_STATE_C1) {
+				/*
+				 * In the special case of C1, FIXED_HARDWARE can
+				 * be handled by executing the HLT instruction.
+				 */
+				cx.entry_method = ACPI_CSTATE_HALT;
+				snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
+			} else {
+				continue;
+			}
+		} else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+			cx.entry_method = ACPI_CSTATE_SYSTEMIO;
+			snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI IOPORT 0x%x",
+				 cx.address);
+		} else {
+			continue;
+		}
+
+		if (cx.type == ACPI_STATE_C1)
+			cx.valid = 1;
+
+		obj = &element->package.elements[2];
+		if (obj->type != ACPI_TYPE_INTEGER)
+			continue;
+
+		cx.latency = obj->integer.value;
+
+		obj = &element->package.elements[3];
+		if (obj->type != ACPI_TYPE_INTEGER)
+			continue;
+
+		memcpy(&info->states[++last_index], &cx, sizeof(cx));
+	}
+
+	acpi_handle_info(handle, "Found %d idle states\n", last_index);
+
+	info->count = last_index;
+
+      end:
+	kfree(buffer.pointer);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(acpi_processor_evaluate_cst);
 #endif /* CONFIG_ACPI_PROCESSOR_CSTATE */
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -280,10 +280,19 @@ static inline bool invalid_phys_cpuid(ph
 /* Validate the processor object's proc_id */
 bool acpi_duplicate_processor_id(int proc_id);
 /* Processor _CTS control */
+struct acpi_processor_power;
+
 #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
 bool acpi_processor_claim_cst_control(void);
+int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
+				struct acpi_processor_power *info);
 #else
 static inline bool acpi_processor_claim_cst_control(void) { return false; }
+static inline int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
+					      struct acpi_processor_power *info)
+{
+	return -ENODEV;
+}
 #endif
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -297,148 +297,6 @@ static int acpi_processor_get_power_info
 	return 0;
 }
 
-static int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
-				       struct acpi_processor_power *info)
-{
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *cst;
-	acpi_status status;
-	u64 count;
-	int last_index = 0;
-	int i, ret = 0;
-
-	status = acpi_evaluate_object(handle, "_CST", NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		acpi_handle_debug(handle, "No _CST\n");
-		return -ENODEV;
-	}
-
-	cst = buffer.pointer;
-
-	/* There must be at least 2 elements. */
-	if (!cst || cst->type != ACPI_TYPE_PACKAGE || cst->package.count < 2) {
-		acpi_handle_warn(handle, "Invalid _CST output\n");
-		ret = -EFAULT;
-		goto end;
-	}
-
-	count = cst->package.elements[0].integer.value;
-
-	/* Validate the number of C-states. */
-	if (count < 1 || count != cst->package.count - 1) {
-		acpi_handle_warn(handle, "Inconsistent _CST data\n");
-		ret = -EFAULT;
-		goto end;
-	}
-
-	for (i = 1; i <= count; i++) {
-		union acpi_object *element;
-		union acpi_object *obj;
-		struct acpi_power_register *reg;
-		struct acpi_processor_cx cx;
-
-		/*
-		 * If there is not enough space for all C-states, skip the
-		 * excess ones and log a warning.
-		 */
-		if (last_index >= ACPI_PROCESSOR_MAX_POWER - 1) {
-			acpi_handle_warn(handle,
-					 "No room for more idle states (limit: %d)\n",
-					 ACPI_PROCESSOR_MAX_POWER - 1);
-			break;
-		}
-
-		memset(&cx, 0, sizeof(cx));
-
-		element = &cst->package.elements[i];
-		if (element->type != ACPI_TYPE_PACKAGE)
-			continue;
-
-		if (element->package.count != 4)
-			continue;
-
-		obj = &element->package.elements[0];
-
-		if (obj->type != ACPI_TYPE_BUFFER)
-			continue;
-
-		reg = (struct acpi_power_register *)obj->buffer.pointer;
-
-		obj = &element->package.elements[1];
-		if (obj->type != ACPI_TYPE_INTEGER)
-			continue;
-
-		cx.type = obj->integer.value;
-		/*
-		 * There are known cases in which the _CST output does not
-		 * contain C1, so if the type of the first state found is not
-		 * C1, leave an empty slot for C1 to be filled in later.
-		 */
-		if (i == 1 && cx.type != ACPI_STATE_C1)
-			last_index = 1;
-
-		cx.address = reg->address;
-		cx.index = last_index + 1;
-
-		if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
-			if (!acpi_processor_ffh_cstate_probe(cpu, &cx, reg)) {
-				/*
-				 * In the majority of cases _CST describes C1 as
-				 * a FIXED_HARDWARE C-state, but if the command
-				 * line forbids using MWAIT, use CSTATE_HALT for
-				 * C1 regardless.
-				 */
-				if (cx.type == ACPI_STATE_C1 &&
-				    boot_option_idle_override == IDLE_NOMWAIT) {
-					cx.entry_method = ACPI_CSTATE_HALT;
-					snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
-				} else {
-					cx.entry_method = ACPI_CSTATE_FFH;
-				}
-			} else if (cx.type == ACPI_STATE_C1) {
-				/*
-				 * In the special case of C1, FIXED_HARDWARE can
-				 * be handled by executing the HLT instruction.
-				 */
-				cx.entry_method = ACPI_CSTATE_HALT;
-				snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
-			} else {
-				continue;
-			}
-		} else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-			cx.entry_method = ACPI_CSTATE_SYSTEMIO;
-			snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI IOPORT 0x%x",
-				 cx.address);
-		} else {
-			continue;
-		}
-
-		if (cx.type == ACPI_STATE_C1)
-			cx.valid = 1;
-
-		obj = &element->package.elements[2];
-		if (obj->type != ACPI_TYPE_INTEGER)
-			continue;
-
-		cx.latency = obj->integer.value;
-
-		obj = &element->package.elements[3];
-		if (obj->type != ACPI_TYPE_INTEGER)
-			continue;
-
-		memcpy(&info->states[++last_index], &cx, sizeof(cx));
-	}
-
-	acpi_handle_info(handle, "Found %d idle states\n", last_index);
-
-	info->count = last_index;
-
-      end:
-	kfree(buffer.pointer);
-
-	return ret;
-}
-
 static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 {
 	int ret;



