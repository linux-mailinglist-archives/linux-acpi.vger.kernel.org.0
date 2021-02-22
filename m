Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16158321F9A
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Feb 2021 20:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhBVTEv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Feb 2021 14:04:51 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63654 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhBVTD3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Feb 2021 14:03:29 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_smtp) via UNIX with SMTP (IdeaSmtpServer 0.83.537)
 id c9b60e5f5714d9de; Mon, 22 Feb 2021 20:02:23 +0100
Received: from kreacher.localnet (89-64-81-242.dynamic.chello.pl [89.64.81.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 6D229662057;
        Mon, 22 Feb 2021 20:02:22 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v1 1/4] ACPI: processor: Get rid of ACPICA message printing
Date:   Mon, 22 Feb 2021 19:59:13 +0100
Message-ID: <10245832.OiMb8u2cOm@kreacher>
In-Reply-To: <5138173.kHyPcihzTF@kreacher>
References: <5138173.kHyPcihzTF@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrkeefgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtvdenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefgleehfffhtefflefhleetjeffteettefgteekjedvhfeffedtueefveegveeiveenucfkphepkeelrdeigedrkedurddvgedvnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedurddvgedvpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhuohhhrghnjhhunheshhhurgifvghirdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() macros are used for
message printing in the ACPICA code and they should not be used
elsewhere.  Special configuration (either kernel command line or
sysfs-based) is needed to see the messages printed by them and
the format of those messages is also special and convoluted.

For this reason, replace all of the ACPI_DEBUG_PRINT() and
ACPI_EXCEPTION() instances in the ACPI processor driver with
corresponding dev_*(), acpi_handle_*() and pr_*() calls depending
on the context in which they appear.

Also drop the ACPI_PROCESSOR_COMPONENT definition that is not going
to be necessary any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/firmware-guide/acpi/debug.rst |    1 
 drivers/acpi/acpi_processor.c               |   33 +++-----
 drivers/acpi/processor_driver.c             |    6 -
 drivers/acpi/processor_idle.c               |   34 +++-----
 drivers/acpi/processor_pdc.c                |    7 -
 drivers/acpi/processor_perflib.c            |   41 +++++-----
 drivers/acpi/processor_throttling.c         |  110 ++++++++++++++--------------
 drivers/acpi/sysfs.c                        |    1 
 include/acpi/acpi_drivers.h                 |    1 
 9 files changed, 108 insertions(+), 126 deletions(-)

Index: linux-pm/drivers/acpi/acpi_processor.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_processor.c
+++ linux-pm/drivers/acpi/acpi_processor.c
@@ -22,10 +22,6 @@
 
 #include "internal.h"
 
-#define _COMPONENT	ACPI_PROCESSOR_COMPONENT
-
-ACPI_MODULE_NAME("processor");
-
 DEFINE_PER_CPU(struct acpi_processor *, processors);
 EXPORT_PER_CPU_SYMBOL(processors);
 
@@ -51,19 +47,19 @@ static int acpi_processor_errata_piix4(s
 
 	switch (dev->revision) {
 	case 0:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found PIIX4 A-step\n"));
+		dev_dbg(&dev->dev, "Found PIIX4 A-step\n");
 		break;
 	case 1:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found PIIX4 B-step\n"));
+		dev_dbg(&dev->dev, "Found PIIX4 B-step\n");
 		break;
 	case 2:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found PIIX4E\n"));
+		dev_dbg(&dev->dev, "Found PIIX4E\n");
 		break;
 	case 3:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found PIIX4M\n"));
+		dev_dbg(&dev->dev, "Found PIIX4M\n");
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found unknown PIIX4\n"));
+		dev_dbg(&dev->dev, "Found unknown PIIX4\n");
 		break;
 	}
 
@@ -129,11 +125,9 @@ static int acpi_processor_errata_piix4(s
 	}
 
 	if (errata.piix4.bmisx)
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Bus master activity detection (BM-IDE) erratum enabled\n"));
+		dev_dbg(&dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
 	if (errata.piix4.fdma)
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Type-F DMA livelock erratum (C3 disabled)\n"));
+		dev_dbg(&dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
 
 	return 0;
 }
@@ -244,11 +238,9 @@ static int acpi_processor_get_info(struc
 	 */
 	if (acpi_gbl_FADT.pm2_control_block && acpi_gbl_FADT.pm2_control_length) {
 		pr->flags.bm_control = 1;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Bus mastering arbitration control present\n"));
+		dev_dbg(&device->dev, "Bus mastering arbitration control present\n");
 	} else
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "No bus mastering arbitration control\n"));
+		dev_dbg(&device->dev, "No bus mastering arbitration control\n");
 
 	if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_OBJECT_HID)) {
 		/* Declared with "Processor" statement; match ProcessorID */
@@ -291,7 +283,7 @@ static int acpi_processor_get_info(struc
 	pr->phys_id = acpi_get_phys_id(pr->handle, device_declaration,
 					pr->acpi_id);
 	if (invalid_phys_cpuid(pr->phys_id))
-		acpi_handle_debug(pr->handle, "failed to get CPU physical ID.\n");
+		dev_dbg(&device->dev, "Failed to get CPU physical ID.\n");
 
 	pr->id = acpi_map_cpuid(pr->phys_id, pr->acpi_id);
 	if (!cpu0_initialized && !acpi_has_cpu_in_madt()) {
@@ -328,11 +320,10 @@ static int acpi_processor_get_info(struc
 	 * CPU+CPU ID.
 	 */
 	sprintf(acpi_device_bid(device), "CPU%X", pr->id);
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Processor [%d:%d]\n", pr->id,
-			  pr->acpi_id));
+	dev_dbg(&device->dev, "Processor [%d:%d]\n", pr->id, pr->acpi_id);
 
 	if (!object.processor.pblk_address)
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No PBLK (NULL address)\n"));
+		dev_dbg(&device->dev, "No PBLK (NULL address)\n");
 	else if (object.processor.pblk_length != 6)
 		dev_err(&device->dev, "Invalid PBLK length [%d]\n",
 			    object.processor.pblk_length);
Index: linux-pm/drivers/acpi/processor_driver.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_driver.c
+++ linux-pm/drivers/acpi/processor_driver.c
@@ -28,9 +28,6 @@
 #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
 #define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
 
-#define _COMPONENT		ACPI_PROCESSOR_COMPONENT
-ACPI_MODULE_NAME("processor_driver");
-
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Processor Driver");
 MODULE_LICENSE("GPL");
@@ -87,8 +84,7 @@ static void acpi_processor_notify(acpi_h
 						  dev_name(&device->dev), event, 0);
 		break;
 	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
+		acpi_handle_debug(handle, "Unsupported event [0x%x]\n", event);
 		break;
 	}
 
Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -31,9 +31,6 @@
 #include <asm/apic.h>
 #endif
 
-#define _COMPONENT              ACPI_PROCESSOR_COMPONENT
-ACPI_MODULE_NAME("processor_idle");
-
 #define ACPI_IDLE_STATE_START	(IS_ENABLED(CONFIG_ARCH_HAS_CPU_RELAX) ? 1 : 0)
 
 static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
@@ -239,8 +236,8 @@ static int acpi_processor_get_power_info
 	 * 100 microseconds.
 	 */
 	if (acpi_gbl_FADT.c2_latency > ACPI_PROCESSOR_MAX_C2_LATENCY) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			"C2 latency too large [%d]\n", acpi_gbl_FADT.c2_latency));
+		acpi_handle_debug(pr->handle, "C2 latency too large [%d]\n",
+				  acpi_gbl_FADT.c2_latency);
 		/* invalidate C2 */
 		pr->power.states[ACPI_STATE_C2].address = 0;
 	}
@@ -250,16 +247,15 @@ static int acpi_processor_get_power_info
 	 * 1000 microseconds.
 	 */
 	if (acpi_gbl_FADT.c3_latency > ACPI_PROCESSOR_MAX_C3_LATENCY) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			"C3 latency too large [%d]\n", acpi_gbl_FADT.c3_latency));
+		acpi_handle_debug(pr->handle, "C3 latency too large [%d]\n",
+				  acpi_gbl_FADT.c3_latency);
 		/* invalidate C3 */
 		pr->power.states[ACPI_STATE_C3].address = 0;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "lvl2[0x%08x] lvl3[0x%08x]\n",
+	acpi_handle_debug(pr->handle, "lvl2[0x%08x] lvl3[0x%08x]\n",
 			  pr->power.states[ACPI_STATE_C2].address,
-			  pr->power.states[ACPI_STATE_C3].address));
+			  pr->power.states[ACPI_STATE_C3].address);
 
 	snprintf(pr->power.states[ACPI_STATE_C2].desc,
 			 ACPI_CX_DESC_LEN, "ACPI P_LVL2 IOPORT 0x%x",
@@ -324,8 +320,8 @@ static void acpi_processor_power_verify_
 	 * devices thus we take the conservative approach.
 	 */
 	else if (errata.piix4.fdma) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "C3 not supported on PIIX4 with Type-F DMA\n"));
+		acpi_handle_debug(pr->handle,
+				  "C3 not supported on PIIX4 with Type-F DMA\n");
 		return;
 	}
 
@@ -344,13 +340,13 @@ static void acpi_processor_power_verify_
 		if (!pr->flags.bm_control) {
 			if (pr->flags.has_cst != 1) {
 				/* bus mastering control is necessary */
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					"C3 support requires BM control\n"));
+				acpi_handle_debug(pr->handle,
+						  "C3 support requires BM control\n");
 				return;
 			} else {
 				/* Here we enter C3 without bus mastering */
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					"C3 support without BM control\n"));
+				acpi_handle_debug(pr->handle,
+						  "C3 support without BM control\n");
 			}
 		}
 	} else {
@@ -359,9 +355,9 @@ static void acpi_processor_power_verify_
 		 * supported on when bm_check is not required.
 		 */
 		if (!(acpi_gbl_FADT.flags & ACPI_FADT_WBINVD)) {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			acpi_handle_debug(pr->handle,
 					  "Cache invalidation should work properly"
-					  " for C3 to be enabled on SMP systems\n"));
+					  " for C3 to be enabled on SMP systems\n");
 			return;
 		}
 	}
@@ -843,7 +839,7 @@ static int acpi_processor_evaluate_lpi(a
 
 	status = acpi_evaluate_object(handle, "_LPI", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No _LPI, giving up\n"));
+		acpi_handle_debug(handle, "No _LPI, giving up\n");
 		return -ENODEV;
 	}
 
Index: linux-pm/drivers/acpi/processor_pdc.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_pdc.c
+++ linux-pm/drivers/acpi/processor_pdc.c
@@ -16,9 +16,6 @@
 
 #include "internal.h"
 
-#define _COMPONENT              ACPI_PROCESSOR_COMPONENT
-ACPI_MODULE_NAME("processor_pdc");
-
 static bool __init processor_physically_present(acpi_handle handle)
 {
 	int cpuid, type;
@@ -132,8 +129,8 @@ acpi_processor_eval_pdc(acpi_handle hand
 	status = acpi_evaluate_object(handle, "_PDC", pdc_in, NULL);
 
 	if (ACPI_FAILURE(status))
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-		    "Could not evaluate _PDC, using legacy perf. control.\n"));
+		acpi_handle_debug(handle,
+		    "Could not evaluate _PDC, using legacy perf control\n");
 
 	return status;
 }
Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -23,8 +23,6 @@
 #define PREFIX "ACPI: "
 
 #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
-#define _COMPONENT		ACPI_PROCESSOR_COMPONENT
-ACPI_MODULE_NAME("processor_perflib");
 
 static DEFINE_MUTEX(performance_mutex);
 
@@ -70,7 +68,8 @@ static int acpi_processor_get_platform_l
 		acpi_processor_ppc_in_use = true;
 
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PPC"));
+		acpi_handle_warn(pr->handle, "_PPC evaluation failed: %s\n",
+				 acpi_format_exception(status));
 		return -ENODEV;
 	}
 
@@ -199,7 +198,8 @@ static int acpi_processor_get_performanc
 
 	status = acpi_evaluate_object(pr->handle, "_PCT", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PCT"));
+		acpi_handle_warn(pr->handle, "_PCT evaluation failed: %s\n",
+				 acpi_format_exception(status));
 		return -ENODEV;
 	}
 
@@ -299,7 +299,8 @@ static int acpi_processor_get_performanc
 
 	status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PSS"));
+		acpi_handle_warn(pr->handle, "_PSS evaluation failed: %s\n",
+				 acpi_format_exception(status));
 		return -ENODEV;
 	}
 
@@ -310,8 +311,8 @@ static int acpi_processor_get_performanc
 		goto end;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d performance states\n",
-			  pss->package.count));
+	acpi_handle_debug(pr->handle, "Found %d performance states\n",
+			  pss->package.count);
 
 	pr->performance->state_count = pss->package.count;
 	pr->performance->states =
@@ -330,12 +331,13 @@ static int acpi_processor_get_performanc
 		state.length = sizeof(struct acpi_processor_px);
 		state.pointer = px;
 
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Extracting state %d\n", i));
+		acpi_handle_debug(pr->handle, "Extracting state %d\n", i);
 
 		status = acpi_extract_package(&(pss->package.elements[i]),
 					      &format, &state);
 		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status, "Invalid _PSS data"));
+			acpi_handle_warn(pr->handle, "Invalid _PSS data: %s\n",
+					 acpi_format_exception(status));
 			result = -EFAULT;
 			kfree(pr->performance->states);
 			goto end;
@@ -343,14 +345,14 @@ static int acpi_processor_get_performanc
 
 		amd_fixup_frequency(px, i);
 
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+		acpi_handle_debug(pr->handle,
 				  "State [%d]: core_frequency[%d] power[%d] transition_latency[%d] bus_master_latency[%d] control[0x%x] status[0x%x]\n",
 				  i,
 				  (u32) px->core_frequency,
 				  (u32) px->power,
 				  (u32) px->transition_latency,
 				  (u32) px->bus_master_latency,
-				  (u32) px->control, (u32) px->status));
+				  (u32) px->control, (u32) px->status);
 
 		/*
 		 * Check that ACPI's u64 MHz will be valid as u32 KHz in cpufreq
@@ -400,8 +402,8 @@ int acpi_processor_get_performance_info(
 		return -EINVAL;
 
 	if (!acpi_has_method(pr->handle, "_PCT")) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "ACPI-based processor performance control unavailable\n"));
+		acpi_handle_debug(pr->handle,
+				  "ACPI-based processor performance control unavailable\n");
 		return -ENODEV;
 	}
 
@@ -442,18 +444,17 @@ int acpi_processor_pstate_control(void)
 	if (!acpi_gbl_FADT.smi_command || !acpi_gbl_FADT.pstate_control)
 		return 0;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Writing pstate_control [0x%x] to smi_command [0x%x]\n",
-			  acpi_gbl_FADT.pstate_control, acpi_gbl_FADT.smi_command));
+	pr_debug("Writing pstate_control [0x%x] to smi_command [0x%x]\n",
+		 acpi_gbl_FADT.pstate_control, acpi_gbl_FADT.smi_command);
 
 	status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
 				    (u32)acpi_gbl_FADT.pstate_control, 8);
 	if (ACPI_SUCCESS(status))
 		return 1;
 
-	ACPI_EXCEPTION((AE_INFO, status,
-			"Failed to write pstate_control [0x%x] to smi_command [0x%x]",
-			acpi_gbl_FADT.pstate_control, acpi_gbl_FADT.smi_command));
+	pr_warn("Failed to write pstate_control [0x%x] to smi_command [0x%x]: %s\n",
+		acpi_gbl_FADT.pstate_control, acpi_gbl_FADT.smi_command,
+		acpi_format_exception(status));
 	return -EIO;
 }
 
@@ -485,7 +486,7 @@ int acpi_processor_notify_smm(struct mod
 
 	result = acpi_processor_pstate_control();
 	if (!result) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No SMI port or pstate_control\n"));
+		pr_debug("No SMI port or pstate_control\n");
 		module_put(calling_module);
 		return 0;
 	}
Index: linux-pm/drivers/acpi/processor_throttling.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_throttling.c
+++ linux-pm/drivers/acpi/processor_throttling.c
@@ -22,9 +22,6 @@
 
 #define PREFIX "ACPI: "
 
-#define _COMPONENT              ACPI_PROCESSOR_COMPONENT
-ACPI_MODULE_NAME("processor_throttling");
-
 /* ignore_tpc:
  *  0 -> acpi processor driver doesn't ignore _TPC values
  *  1 -> acpi processor driver ignores _TPC values
@@ -196,10 +193,8 @@ err_ret:
  */
 void acpi_processor_throttling_init(void)
 {
-	if (acpi_processor_update_tsd_coord()) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			"Assume no T-state coordination\n"));
-	}
+	if (acpi_processor_update_tsd_coord())
+		pr_debug("Assume no T-state coordination\n");
 
 	return;
 }
@@ -216,12 +211,13 @@ static int acpi_processor_throttling_not
 	cpu = p_tstate->cpu;
 	pr = per_cpu(processors, cpu);
 	if (!pr) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Invalid pr pointer\n"));
+		pr_debug("Invalid pr pointer\n");
 		return 0;
 	}
 	if (!pr->flags.throttling) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Throttling control is "
-				"unsupported on CPU %d\n", cpu));
+		acpi_handle_debug(pr->handle,
+				  "Throttling control unsupported on CPU %d\n",
+				  cpu);
 		return 0;
 	}
 	target_state = p_tstate->target_state;
@@ -245,9 +241,9 @@ static int acpi_processor_throttling_not
 			target_state = p_throttling->state_count - 1;
 		}
 		p_tstate->target_state = target_state;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PreChange Event:"
-				"target T-state of CPU %d is T%d\n",
-				cpu, target_state));
+		acpi_handle_debug(pr->handle,
+				  "PreChange Event: target T-state of CPU %d is T%d\n",
+				  cpu, target_state);
 		break;
 	case THROTTLING_POSTCHANGE:
 		/*
@@ -255,9 +251,9 @@ static int acpi_processor_throttling_not
 		 * T-state flag of acpi_processor_throttling.
 		 */
 		p_throttling->state = target_state;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "PostChange Event:"
-				"CPU %d is switched to T%d\n",
-				cpu, target_state));
+		acpi_handle_debug(pr->handle,
+				  "PostChange Event: CPU %d is switched to T%d\n",
+				  cpu, target_state);
 		break;
 	default:
 		printk(KERN_WARNING
@@ -284,9 +280,11 @@ static int acpi_processor_get_platform_l
 
 	status = acpi_evaluate_integer(pr->handle, "_TPC", NULL, &tpc);
 	if (ACPI_FAILURE(status)) {
-		if (status != AE_NOT_FOUND) {
-			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TPC"));
-		}
+		if (status != AE_NOT_FOUND)
+			acpi_handle_warn(pr->handle,
+					 "_TPC evaluation failed: %s\n",
+					 acpi_format_exception(status));
+
 		return -ENODEV;
 	}
 
@@ -417,9 +415,11 @@ static int acpi_processor_get_throttling
 
 	status = acpi_evaluate_object(pr->handle, "_PTC", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		if (status != AE_NOT_FOUND) {
-			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PTC"));
-		}
+		if (status != AE_NOT_FOUND)
+			acpi_handle_warn(pr->handle,
+					 "_PTC evaluation failed: %s\n",
+					 acpi_format_exception(status));
+
 		return -ENODEV;
 	}
 
@@ -502,9 +502,11 @@ static int acpi_processor_get_throttling
 
 	status = acpi_evaluate_object(pr->handle, "_TSS", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		if (status != AE_NOT_FOUND) {
-			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TSS"));
-		}
+		if (status != AE_NOT_FOUND)
+			acpi_handle_warn(pr->handle,
+					 "_TSS evaluation failed: %s\n",
+					 acpi_format_exception(status));
+
 		return -ENODEV;
 	}
 
@@ -515,8 +517,8 @@ static int acpi_processor_get_throttling
 		goto end;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d throttling states\n",
-			  tss->package.count));
+	acpi_handle_debug(pr->handle, "Found %d throttling states\n",
+			  tss->package.count);
 
 	pr->throttling.state_count = tss->package.count;
 	pr->throttling.states_tss =
@@ -537,12 +539,13 @@ static int acpi_processor_get_throttling
 		state.length = sizeof(struct acpi_processor_tx_tss);
 		state.pointer = tx;
 
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Extracting state %d\n", i));
+		acpi_handle_debug(pr->handle, "Extracting state %d\n", i);
 
 		status = acpi_extract_package(&(tss->package.elements[i]),
 					      &format, &state);
 		if (ACPI_FAILURE(status)) {
-			ACPI_EXCEPTION((AE_INFO, status, "Invalid _TSS data"));
+			acpi_handle_warn(pr->handle, "Invalid _TSS data: %s\n",
+					 acpi_format_exception(status));
 			result = -EFAULT;
 			kfree(pr->throttling.states_tss);
 			goto end;
@@ -582,9 +585,11 @@ static int acpi_processor_get_tsd(struct
 
 	status = acpi_evaluate_object(pr->handle, "_TSD", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
-		if (status != AE_NOT_FOUND) {
-			ACPI_EXCEPTION((AE_INFO, status, "Evaluating _TSD"));
-		}
+		if (status != AE_NOT_FOUND)
+			acpi_handle_warn(pr->handle,
+					 "_TSD evaluation failed: %s\n",
+					 acpi_format_exception(status));
+
 		return -ENODEV;
 	}
 
@@ -698,9 +703,9 @@ static int acpi_processor_get_throttling
 
 	local_irq_enable();
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+	acpi_handle_debug(pr->handle,
 			  "Throttling state is T%d (%d%% throttling applied)\n",
-			  state, pr->throttling.states[state].performance));
+			  state, pr->throttling.states[state].performance);
 
 	return 0;
 }
@@ -875,8 +880,8 @@ static int acpi_processor_get_throttling
 	if (ret >= 0) {
 		state = acpi_get_throttling_state(pr, value);
 		if (state == -1) {
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				"Invalid throttling state, reset\n"));
+			acpi_handle_debug(pr->handle,
+					  "Invalid throttling state, reset\n");
 			state = 0;
 			ret = __acpi_processor_set_throttling(pr, state, true,
 							      true);
@@ -921,10 +926,10 @@ static int acpi_processor_get_fadt_info(
 	int i, step;
 
 	if (!pr->throttling.address) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling register\n"));
+		acpi_handle_debug(pr->handle, "No throttling register\n");
 		return -EINVAL;
 	} else if (!pr->throttling.duty_width) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No throttling states\n"));
+		acpi_handle_debug(pr->handle, "No throttling states\n");
 		return -EINVAL;
 	}
 	/* TBD: Support duty_cycle values that span bit 4. */
@@ -1015,10 +1020,10 @@ static int acpi_processor_set_throttling
 
 	local_irq_enable();
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+	acpi_handle_debug(pr->handle,
 			  "Throttling state set to T%d (%d%%)\n", state,
 			  (pr->throttling.states[state].performance ? pr->
-			   throttling.states[state].performance / 10 : 0)));
+			   throttling.states[state].performance / 10 : 0));
 
 	return 0;
 }
@@ -1129,8 +1134,8 @@ static int __acpi_processor_set_throttli
 			 * error message and continue.
 			 */
 			if (!match_pr) {
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					"Invalid Pointer for CPU %d\n", i));
+				acpi_handle_debug(pr->handle,
+					"Invalid Pointer for CPU %d\n", i);
 				continue;
 			}
 			/*
@@ -1138,9 +1143,8 @@ static int __acpi_processor_set_throttli
 			 * we will report the error message and continue.
 			 */
 			if (!match_pr->flags.throttling) {
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					"Throttling Control is unsupported "
-					"on CPU %d\n", i));
+				acpi_handle_debug(pr->handle,
+					"Throttling Control unsupported on CPU %d\n", i);
 				continue;
 			}
 
@@ -1177,11 +1181,11 @@ int acpi_processor_get_throttling_info(s
 	int result = 0;
 	struct acpi_processor_throttling *pthrottling;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+	acpi_handle_debug(pr->handle,
 			  "pblk_address[0x%08x] duty_offset[%d] duty_width[%d]\n",
 			  pr->throttling.address,
 			  pr->throttling.duty_offset,
-			  pr->throttling.duty_width));
+			  pr->throttling.duty_width);
 
 	/*
 	 * Evaluate _PTC, _TSS and _TPC
@@ -1221,13 +1225,13 @@ int acpi_processor_get_throttling_info(s
 	 * used this part.
 	 */
 	if (errata.piix4.throttle) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Throttling not supported on PIIX4 A- or B-step\n"));
+		acpi_handle_debug(pr->handle,
+				  "Throttling not supported on PIIX4 A- or B-step\n");
 		return 0;
 	}
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d throttling states\n",
-			  pr->throttling.state_count));
+	acpi_handle_debug(pr->handle, "Found %d throttling states\n",
+			  pr->throttling.state_count);
 
 	pr->flags.throttling = 1;
 
@@ -1242,9 +1246,9 @@ int acpi_processor_get_throttling_info(s
 		goto end;
 
 	if (pr->throttling.state) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+		acpi_handle_debug(pr->handle,
 				  "Disabling throttling (was T%d)\n",
-				  pr->throttling.state));
+				  pr->throttling.state);
 		result = acpi_processor_set_throttling(pr, 0, false);
 		if (result)
 			goto end;
Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
+++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
@@ -57,7 +57,6 @@ shows the supported mask values, current
     ACPI_CONTAINER_COMPONENT        0x01000000
     ACPI_SYSTEM_COMPONENT           0x02000000
     ACPI_MEMORY_DEVICE_COMPONENT    0x08000000
-    ACPI_PROCESSOR_COMPONENT        0x20000000
 
 debug_level
 ===========
Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -57,7 +57,6 @@ static const struct acpi_dlayer acpi_deb
 	ACPI_DEBUG_INIT(ACPI_CONTAINER_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_SYSTEM_COMPONENT),
 	ACPI_DEBUG_INIT(ACPI_MEMORY_DEVICE_COMPONENT),
-	ACPI_DEBUG_INIT(ACPI_PROCESSOR_COMPONENT),
 };
 
 static const struct acpi_dlevel acpi_debug_levels[] = {
Index: linux-pm/include/acpi/acpi_drivers.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_drivers.h
+++ linux-pm/include/acpi/acpi_drivers.h
@@ -20,7 +20,6 @@
 #define ACPI_CONTAINER_COMPONENT	0x01000000
 #define ACPI_SYSTEM_COMPONENT		0x02000000
 #define ACPI_MEMORY_DEVICE_COMPONENT	0x08000000
-#define ACPI_PROCESSOR_COMPONENT	0x20000000
 
 /*
  * _HID definitions



