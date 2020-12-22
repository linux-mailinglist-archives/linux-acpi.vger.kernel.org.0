Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303DA2DD946
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Dec 2020 20:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgLQTYE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 14:24:04 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58104 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgLQTYE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 14:24:04 -0500
Received: from 89-64-78-63.dynamic.chello.pl (89.64.78.63) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 67e7cc8a24bb5ec3; Thu, 17 Dec 2020 20:23:18 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH] ACPI: PM: s2idle: More x86-specific code to the x86 directory
Date:   Thu, 17 Dec 2020 20:23:17 +0100
Message-ID: <1702151.Z2izUkvjaf@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some code in drivers/acpi/sleep.c (which is regarded as a generic
file) related to suspend-to-idle support has grown direct dependencies
on x86, but in fact it has been specific to x86 (which is the only
user of it) anyway for a long time.

For this reason, move that code to a separate file under acpi/x86/
and make it build and run as before under the right conditions.

While at it, rename a vendor checking function in that code and
consistently use acpi_handle_debug() for printing debug-related
information in it.

No expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This patch is on top of

https://patchwork.kernel.org/project/linux-acpi/patch/20201120060752.3146704-1-Shyam-sundar.S-k@amd.com/

which I promised to push for 5.11-rc, but the x86 dependencies
added by it shouldn't be present in a generic ACPI fine, so IMO
this change should be made along with the patch above.

Please let me know if you see any issues with it.

---
 drivers/acpi/Makefile     |    1 
 drivers/acpi/sleep.c      |  453 +--------------------------------------------
 drivers/acpi/sleep.h      |   16 +
 drivers/acpi/x86/s2idle.c |  460 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 489 insertions(+), 441 deletions(-)

Index: linux-pm/drivers/acpi/x86/s2idle.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/acpi/x86/s2idle.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Architecture-specific ACPI-based support for suspend-to-idle.
+ *
+ * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ * Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
+ * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+ *
+ * On platforms supporting the Low Power S0 Idle interface there is an ACPI
+ * device object with the PNP0D80 compatible device ID (System Power Management
+ * Controller) and a specific _DSM method under it.  That method, if present,
+ * can be used to indicate to the platform that the OS is transitioning into a
+ * low-power state in which certain types of activity are not desirable or that
+ * it is leaving such a state, which allows the platform to adjust its operation
+ * mode accordingly.
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/suspend.h>
+
+#include "../sleep.h"
+
+#ifdef CONFIG_SUSPEND
+
+static bool sleep_no_lps0 __read_mostly;
+module_param(sleep_no_lps0, bool, 0644);
+MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");
+
+static const struct acpi_device_id lps0_device_ids[] = {
+	{"PNP0D80", },
+	{"", },
+};
+
+#define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
+
+#define ACPI_LPS0_GET_DEVICE_CONSTRAINTS	1
+#define ACPI_LPS0_SCREEN_OFF	3
+#define ACPI_LPS0_SCREEN_ON	4
+#define ACPI_LPS0_ENTRY		5
+#define ACPI_LPS0_EXIT		6
+
+/* AMD */
+#define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
+#define ACPI_LPS0_SCREEN_OFF_AMD    4
+#define ACPI_LPS0_SCREEN_ON_AMD     5
+
+static acpi_handle lps0_device_handle;
+static guid_t lps0_dsm_guid;
+static char lps0_dsm_func_mask;
+
+/* Device constraint entry structure */
+struct lpi_device_info {
+	char *name;
+	int enabled;
+	union acpi_object *package;
+};
+
+/* Constraint package structure */
+struct lpi_device_constraint {
+	int uid;
+	int min_dstate;
+	int function_states;
+};
+
+struct lpi_constraints {
+	acpi_handle handle;
+	int min_dstate;
+};
+
+/* AMD */
+/* Device constraint entry structure */
+struct lpi_device_info_amd {
+	int revision;
+	int count;
+	union acpi_object *package;
+};
+
+/* Constraint package structure */
+struct lpi_device_constraint_amd {
+	char *name;
+	int enabled;
+	int function_states;
+	int min_dstate;
+};
+
+static struct lpi_constraints *lpi_constraints_table;
+static int lpi_constraints_table_size;
+static int rev_id;
+
+static void lpi_device_get_constraints_amd(void)
+{
+	union acpi_object *out_obj;
+	int i, j, k;
+
+	out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
+					  1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
+					  NULL, ACPI_TYPE_PACKAGE);
+
+	if (!out_obj)
+		return;
+
+	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
+			  out_obj ? "successful" : "failed");
+
+	for (i = 0; i < out_obj->package.count; i++) {
+		union acpi_object *package = &out_obj->package.elements[i];
+		struct lpi_device_info_amd info = { };
+
+		if (package->type == ACPI_TYPE_INTEGER) {
+			switch (i) {
+			case 0:
+				info.revision = package->integer.value;
+				break;
+			case 1:
+				info.count = package->integer.value;
+				break;
+			}
+		} else if (package->type == ACPI_TYPE_PACKAGE) {
+			lpi_constraints_table = kcalloc(package->package.count,
+							sizeof(*lpi_constraints_table),
+							GFP_KERNEL);
+
+			if (!lpi_constraints_table)
+				goto free_acpi_buffer;
+
+			acpi_handle_debug(lps0_device_handle,
+					  "LPI: constraints list begin:\n");
+
+			for (j = 0; j < package->package.count; ++j) {
+				union acpi_object *info_obj = &package->package.elements[j];
+				struct lpi_device_constraint_amd dev_info = {};
+				struct lpi_constraints *list;
+				acpi_status status;
+
+				for (k = 0; k < info_obj->package.count; ++k) {
+					union acpi_object *obj = &info_obj->package.elements[k];
+					union acpi_object *obj_new;
+
+					list = &lpi_constraints_table[lpi_constraints_table_size];
+					list->min_dstate = -1;
+
+					obj_new = &obj[k];
+					switch (k) {
+					case 0:
+						dev_info.enabled = obj->integer.value;
+						break;
+					case 1:
+						dev_info.name = obj->string.pointer;
+						break;
+					case 2:
+						dev_info.function_states = obj->integer.value;
+						break;
+					case 3:
+						dev_info.min_dstate = obj->integer.value;
+						break;
+					}
+
+					if (!dev_info.enabled || !dev_info.name ||
+					    !dev_info.min_dstate)
+						continue;
+
+					status = acpi_get_handle(NULL, dev_info.name,
+								 &list->handle);
+					if (ACPI_FAILURE(status))
+						continue;
+
+					acpi_handle_debug(lps0_device_handle,
+							  "Name:%s\n", dev_info.name);
+
+					list->min_dstate = dev_info.min_dstate;
+
+					if (list->min_dstate < 0) {
+						acpi_handle_debug(lps0_device_handle,
+								  "Incomplete constraint defined\n");
+						continue;
+					}
+				}
+				lpi_constraints_table_size++;
+			}
+		}
+	}
+
+	acpi_handle_debug(lps0_device_handle, "LPI: constraints list end\n");
+
+free_acpi_buffer:
+	ACPI_FREE(out_obj);
+}
+
+static void lpi_device_get_constraints(void)
+{
+	union acpi_object *out_obj;
+	int i;
+
+	out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
+					  1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
+					  NULL, ACPI_TYPE_PACKAGE);
+
+	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
+			  out_obj ? "successful" : "failed");
+
+	if (!out_obj)
+		return;
+
+	lpi_constraints_table = kcalloc(out_obj->package.count,
+					sizeof(*lpi_constraints_table),
+					GFP_KERNEL);
+	if (!lpi_constraints_table)
+		goto free_acpi_buffer;
+
+	acpi_handle_debug(lps0_device_handle, "LPI: constraints list begin:\n");
+
+	for (i = 0; i < out_obj->package.count; i++) {
+		struct lpi_constraints *constraint;
+		acpi_status status;
+		union acpi_object *package = &out_obj->package.elements[i];
+		struct lpi_device_info info = { };
+		int package_count = 0, j;
+
+		if (!package)
+			continue;
+
+		for (j = 0; j < package->package.count; ++j) {
+			union acpi_object *element =
+					&(package->package.elements[j]);
+
+			switch (element->type) {
+			case ACPI_TYPE_INTEGER:
+				info.enabled = element->integer.value;
+				break;
+			case ACPI_TYPE_STRING:
+				info.name = element->string.pointer;
+				break;
+			case ACPI_TYPE_PACKAGE:
+				package_count = element->package.count;
+				info.package = element->package.elements;
+				break;
+			}
+		}
+
+		if (!info.enabled || !info.package || !info.name)
+			continue;
+
+		constraint = &lpi_constraints_table[lpi_constraints_table_size];
+
+		status = acpi_get_handle(NULL, info.name, &constraint->handle);
+		if (ACPI_FAILURE(status))
+			continue;
+
+		acpi_handle_debug(lps0_device_handle,
+				  "index:%d Name:%s\n", i, info.name);
+
+		constraint->min_dstate = -1;
+
+		for (j = 0; j < package_count; ++j) {
+			union acpi_object *info_obj = &info.package[j];
+			union acpi_object *cnstr_pkg;
+			union acpi_object *obj;
+			struct lpi_device_constraint dev_info;
+
+			switch (info_obj->type) {
+			case ACPI_TYPE_INTEGER:
+				/* version */
+				break;
+			case ACPI_TYPE_PACKAGE:
+				if (info_obj->package.count < 2)
+					break;
+
+				cnstr_pkg = info_obj->package.elements;
+				obj = &cnstr_pkg[0];
+				dev_info.uid = obj->integer.value;
+				obj = &cnstr_pkg[1];
+				dev_info.min_dstate = obj->integer.value;
+
+				acpi_handle_debug(lps0_device_handle,
+					"uid:%d min_dstate:%s\n",
+					dev_info.uid,
+					acpi_power_state_string(dev_info.min_dstate));
+
+				constraint->min_dstate = dev_info.min_dstate;
+				break;
+			}
+		}
+
+		if (constraint->min_dstate < 0) {
+			acpi_handle_debug(lps0_device_handle,
+					  "Incomplete constraint defined\n");
+			continue;
+		}
+
+		lpi_constraints_table_size++;
+	}
+
+	acpi_handle_debug(lps0_device_handle, "LPI: constraints list end\n");
+
+free_acpi_buffer:
+	ACPI_FREE(out_obj);
+}
+
+static void lpi_check_constraints(void)
+{
+	int i;
+
+	for (i = 0; i < lpi_constraints_table_size; ++i) {
+		acpi_handle handle = lpi_constraints_table[i].handle;
+		struct acpi_device *adev;
+
+		if (!handle || acpi_bus_get_device(handle, &adev))
+			continue;
+
+		acpi_handle_debug(handle,
+			"LPI: required min power state:%s current power state:%s\n",
+			acpi_power_state_string(lpi_constraints_table[i].min_dstate),
+			acpi_power_state_string(adev->power.state));
+
+		if (!adev->flags.power_manageable) {
+			acpi_handle_info(handle, "LPI: Device not power manageable\n");
+			lpi_constraints_table[i].handle = NULL;
+			continue;
+		}
+
+		if (adev->power.state < lpi_constraints_table[i].min_dstate)
+			acpi_handle_info(handle,
+				"LPI: Constraint not met; min power state:%s current power state:%s\n",
+				acpi_power_state_string(lpi_constraints_table[i].min_dstate),
+				acpi_power_state_string(adev->power.state));
+	}
+}
+
+static void acpi_sleep_run_lps0_dsm(unsigned int func)
+{
+	union acpi_object *out_obj;
+
+	if (!(lps0_dsm_func_mask & (1 << func)))
+		return;
+
+	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);
+	ACPI_FREE(out_obj);
+
+	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
+			  func, out_obj ? "successful" : "failed");
+}
+
+static bool acpi_s2idle_vendor_amd(void)
+{
+	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
+}
+
+static int lps0_device_attach(struct acpi_device *adev,
+			      const struct acpi_device_id *not_used)
+{
+	union acpi_object *out_obj;
+
+	if (lps0_device_handle)
+		return 0;
+
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+		return 0;
+
+	if (acpi_s2idle_vendor_amd()) {
+		guid_parse(ACPI_LPS0_DSM_UUID_AMD, &lps0_dsm_guid);
+		out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 0, 0, NULL);
+		rev_id = 0;
+	} else {
+		guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
+		out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL);
+		rev_id = 1;
+	}
+
+	/* Check if the _DSM is present and as expected. */
+	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER) {
+		acpi_handle_debug(adev->handle,
+				  "_DSM function 0 evaluation failed\n");
+		return 0;
+	}
+
+	lps0_dsm_func_mask = *(char *)out_obj->buffer.pointer;
+
+	ACPI_FREE(out_obj);
+
+	acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
+			  lps0_dsm_func_mask);
+
+	lps0_device_handle = adev->handle;
+
+	if (acpi_s2idle_vendor_amd())
+		lpi_device_get_constraints_amd();
+	else
+		lpi_device_get_constraints();
+
+	/*
+	 * Use suspend-to-idle by default if the default suspend mode was not
+	 * set from the command line.
+	 */
+	if (mem_sleep_default > PM_SUSPEND_MEM && !acpi_sleep_default_s3)
+		mem_sleep_current = PM_SUSPEND_TO_IDLE;
+
+	/*
+	 * Some LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U, require the
+	 * EC GPE to be enabled while suspended for certain wakeup devices to
+	 * work, so mark it as wakeup-capable.
+	 */
+	acpi_ec_mark_gpe_for_wake();
+
+	return 0;
+}
+
+static struct acpi_scan_handler lps0_handler = {
+	.ids = lps0_device_ids,
+	.attach = lps0_device_attach,
+};
+
+int acpi_s2idle_prepare_late(void)
+{
+	if (!lps0_device_handle || sleep_no_lps0)
+		return 0;
+
+	if (pm_debug_messages_on)
+		lpi_check_constraints();
+
+	if (acpi_s2idle_vendor_amd()) {
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
+	} else {
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
+	}
+
+	return 0;
+}
+
+void acpi_s2idle_restore_early(void)
+{
+	if (!lps0_device_handle || sleep_no_lps0)
+		return;
+
+	if (acpi_s2idle_vendor_amd()) {
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
+	} else {
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
+	}
+}
+
+static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
+	.begin = acpi_s2idle_begin,
+	.prepare = acpi_s2idle_prepare,
+	.prepare_late = acpi_s2idle_prepare_late,
+	.wake = acpi_s2idle_wake,
+	.restore_early = acpi_s2idle_restore_early,
+	.restore = acpi_s2idle_restore,
+	.end = acpi_s2idle_end,
+};
+
+void acpi_s2idle_setup(void)
+{
+	acpi_scan_add_handler(&lps0_handler);
+	s2idle_set_ops(&acpi_s2idle_ops_lps0);
+}
+
+#endif /* CONFIG_SUSPEND */
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -92,10 +92,6 @@ bool acpi_sleep_state_supported(u8 sleep
 }
 
 #ifdef CONFIG_ACPI_SLEEP
-static bool sleep_no_lps0 __read_mostly;
-module_param(sleep_no_lps0, bool, 0644);
-MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");
-
 static u32 acpi_target_sleep_state = ACPI_STATE_S0;
 
 u32 acpi_target_system_state(void)
@@ -165,7 +161,7 @@ static int __init init_nvs_nosave(const
 	return 0;
 }
 
-static bool acpi_sleep_default_s3;
+bool acpi_sleep_default_s3;
 
 static int __init init_default_s3(const struct dmi_system_id *d)
 {
@@ -688,409 +684,13 @@ static const struct platform_suspend_ops
 
 static bool s2idle_wakeup;
 
-/*
- * On platforms supporting the Low Power S0 Idle interface there is an ACPI
- * device object with the PNP0D80 compatible device ID (System Power Management
- * Controller) and a specific _DSM method under it.  That method, if present,
- * can be used to indicate to the platform that the OS is transitioning into a
- * low-power state in which certain types of activity are not desirable or that
- * it is leaving such a state, which allows the platform to adjust its operation
- * mode accordingly.
- */
-static const struct acpi_device_id lps0_device_ids[] = {
-	{"PNP0D80", },
-	{"", },
-};
-
-#define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
-
-#define ACPI_LPS0_GET_DEVICE_CONSTRAINTS	1
-#define ACPI_LPS0_SCREEN_OFF	3
-#define ACPI_LPS0_SCREEN_ON	4
-#define ACPI_LPS0_ENTRY		5
-#define ACPI_LPS0_EXIT		6
-
-/* AMD */
-#define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
-#define ACPI_LPS0_SCREEN_OFF_AMD    4
-#define ACPI_LPS0_SCREEN_ON_AMD     5
-
-static acpi_handle lps0_device_handle;
-static guid_t lps0_dsm_guid;
-static char lps0_dsm_func_mask;
-
-/* Device constraint entry structure */
-struct lpi_device_info {
-	char *name;
-	int enabled;
-	union acpi_object *package;
-};
-
-/* Constraint package structure */
-struct lpi_device_constraint {
-	int uid;
-	int min_dstate;
-	int function_states;
-};
-
-struct lpi_constraints {
-	acpi_handle handle;
-	int min_dstate;
-};
-
-/* AMD */
-/* Device constraint entry structure */
-struct lpi_device_info_amd {
-	int revision;
-	int count;
-	union acpi_object *package;
-};
-
-/* Constraint package structure */
-struct lpi_device_constraint_amd {
-	char *name;
-	int enabled;
-	int function_states;
-	int min_dstate;
-};
-
-static struct lpi_constraints *lpi_constraints_table;
-static int lpi_constraints_table_size;
-static int rev_id;
-
-static void lpi_device_get_constraints_amd(void)
-{
-	union acpi_object *out_obj;
-	int i, j, k;
-
-	out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
-					  1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
-					  NULL, ACPI_TYPE_PACKAGE);
-
-	if (!out_obj)
-		return;
-
-	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
-			  out_obj ? "successful" : "failed");
-
-	for (i = 0; i < out_obj->package.count; i++) {
-		union acpi_object *package = &out_obj->package.elements[i];
-		struct lpi_device_info_amd info = { };
-
-		if (package->type == ACPI_TYPE_INTEGER) {
-			switch (i) {
-			case 0:
-				info.revision = package->integer.value;
-				break;
-			case 1:
-				info.count = package->integer.value;
-				break;
-			}
-		} else if (package->type == ACPI_TYPE_PACKAGE) {
-			lpi_constraints_table = kcalloc(package->package.count,
-							sizeof(*lpi_constraints_table),
-							GFP_KERNEL);
-
-			if (!lpi_constraints_table)
-				goto free_acpi_buffer;
-
-			acpi_handle_info(lps0_device_handle,
-					 "LPI: constraints list begin:\n");
-
-			for (j = 0; j < package->package.count; ++j) {
-				union acpi_object *info_obj = &package->package.elements[j];
-				struct lpi_device_constraint_amd dev_info = {};
-				struct lpi_constraints *list;
-				acpi_status status;
-
-				for (k = 0; k < info_obj->package.count; ++k) {
-					union acpi_object *obj = &info_obj->package.elements[k];
-					union acpi_object *obj_new;
-
-					list = &lpi_constraints_table[lpi_constraints_table_size];
-					list->min_dstate = -1;
-
-					obj_new = &obj[k];
-					switch (k) {
-					case 0:
-						dev_info.enabled = obj->integer.value;
-						break;
-					case 1:
-						dev_info.name = obj->string.pointer;
-						break;
-					case 2:
-						dev_info.function_states = obj->integer.value;
-						break;
-					case 3:
-						dev_info.min_dstate = obj->integer.value;
-						break;
-					}
-
-					if (!dev_info.enabled || !dev_info.name ||
-					    !dev_info.min_dstate)
-						continue;
-
-					status = acpi_get_handle(NULL, dev_info.name,
-								 &list->handle);
-					if (ACPI_FAILURE(status))
-						continue;
-
-					acpi_handle_info(lps0_device_handle,
-							 "Name:%s\n", dev_info.name);
-
-					list->min_dstate = dev_info.min_dstate;
-
-					if (list->min_dstate < 0) {
-						acpi_handle_info(lps0_device_handle,
-								 "Incomplete constraint defined\n");
-						continue;
-					}
-				}
-				lpi_constraints_table_size++;
-			}
-		}
-	}
-
-	acpi_handle_info(lps0_device_handle, "LPI: constraints list end\n");
-
-free_acpi_buffer:
-	ACPI_FREE(out_obj);
-}
-
-static void lpi_device_get_constraints(void)
-{
-	union acpi_object *out_obj;
-	int i;
-
-	out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
-					  1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
-					  NULL, ACPI_TYPE_PACKAGE);
-
-	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
-			  out_obj ? "successful" : "failed");
-
-	if (!out_obj)
-		return;
-
-	lpi_constraints_table = kcalloc(out_obj->package.count,
-					sizeof(*lpi_constraints_table),
-					GFP_KERNEL);
-	if (!lpi_constraints_table)
-		goto free_acpi_buffer;
-
-	acpi_handle_debug(lps0_device_handle, "LPI: constraints list begin:\n");
-
-	for (i = 0; i < out_obj->package.count; i++) {
-		struct lpi_constraints *constraint;
-		acpi_status status;
-		union acpi_object *package = &out_obj->package.elements[i];
-		struct lpi_device_info info = { };
-		int package_count = 0, j;
-
-		if (!package)
-			continue;
-
-		for (j = 0; j < package->package.count; ++j) {
-			union acpi_object *element =
-					&(package->package.elements[j]);
-
-			switch (element->type) {
-			case ACPI_TYPE_INTEGER:
-				info.enabled = element->integer.value;
-				break;
-			case ACPI_TYPE_STRING:
-				info.name = element->string.pointer;
-				break;
-			case ACPI_TYPE_PACKAGE:
-				package_count = element->package.count;
-				info.package = element->package.elements;
-				break;
-			}
-		}
-
-		if (!info.enabled || !info.package || !info.name)
-			continue;
-
-		constraint = &lpi_constraints_table[lpi_constraints_table_size];
-
-		status = acpi_get_handle(NULL, info.name, &constraint->handle);
-		if (ACPI_FAILURE(status))
-			continue;
-
-		acpi_handle_debug(lps0_device_handle,
-				  "index:%d Name:%s\n", i, info.name);
-
-		constraint->min_dstate = -1;
-
-		for (j = 0; j < package_count; ++j) {
-			union acpi_object *info_obj = &info.package[j];
-			union acpi_object *cnstr_pkg;
-			union acpi_object *obj;
-			struct lpi_device_constraint dev_info;
-
-			switch (info_obj->type) {
-			case ACPI_TYPE_INTEGER:
-				/* version */
-				break;
-			case ACPI_TYPE_PACKAGE:
-				if (info_obj->package.count < 2)
-					break;
-
-				cnstr_pkg = info_obj->package.elements;
-				obj = &cnstr_pkg[0];
-				dev_info.uid = obj->integer.value;
-				obj = &cnstr_pkg[1];
-				dev_info.min_dstate = obj->integer.value;
-
-				acpi_handle_debug(lps0_device_handle,
-					"uid:%d min_dstate:%s\n",
-					dev_info.uid,
-					acpi_power_state_string(dev_info.min_dstate));
-
-				constraint->min_dstate = dev_info.min_dstate;
-				break;
-			}
-		}
-
-		if (constraint->min_dstate < 0) {
-			acpi_handle_debug(lps0_device_handle,
-					  "Incomplete constraint defined\n");
-			continue;
-		}
-
-		lpi_constraints_table_size++;
-	}
-
-	acpi_handle_debug(lps0_device_handle, "LPI: constraints list end\n");
-
-free_acpi_buffer:
-	ACPI_FREE(out_obj);
-}
-
-static void lpi_check_constraints(void)
-{
-	int i;
-
-	for (i = 0; i < lpi_constraints_table_size; ++i) {
-		acpi_handle handle = lpi_constraints_table[i].handle;
-		struct acpi_device *adev;
-
-		if (!handle || acpi_bus_get_device(handle, &adev))
-			continue;
-
-		acpi_handle_debug(handle,
-			"LPI: required min power state:%s current power state:%s\n",
-			acpi_power_state_string(lpi_constraints_table[i].min_dstate),
-			acpi_power_state_string(adev->power.state));
-
-		if (!adev->flags.power_manageable) {
-			acpi_handle_info(handle, "LPI: Device not power manageable\n");
-			lpi_constraints_table[i].handle = NULL;
-			continue;
-		}
-
-		if (adev->power.state < lpi_constraints_table[i].min_dstate)
-			acpi_handle_info(handle,
-				"LPI: Constraint not met; min power state:%s current power state:%s\n",
-				acpi_power_state_string(lpi_constraints_table[i].min_dstate),
-				acpi_power_state_string(adev->power.state));
-	}
-}
-
-static void acpi_sleep_run_lps0_dsm(unsigned int func)
-{
-	union acpi_object *out_obj;
-
-	if (!(lps0_dsm_func_mask & (1 << func)))
-		return;
-
-	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);
-	ACPI_FREE(out_obj);
-
-	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
-			  func, out_obj ? "successful" : "failed");
-}
-
-static bool acpi_match_vendor_name(void)
-{
-#ifdef CONFIG_X86
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
-		return true;
-#endif
-	return false;
-}
-
-static int lps0_device_attach(struct acpi_device *adev,
-			      const struct acpi_device_id *not_used)
-{
-	union acpi_object *out_obj;
-
-	if (lps0_device_handle)
-		return 0;
-
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
-		return 0;
-
-	if (acpi_match_vendor_name()) {
-		guid_parse(ACPI_LPS0_DSM_UUID_AMD, &lps0_dsm_guid);
-		out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 0, 0, NULL);
-		rev_id = 0;
-	} else {
-		guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
-		out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL);
-		rev_id = 1;
-	}
-
-	/* Check if the _DSM is present and as expected. */
-	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER) {
-		acpi_handle_debug(adev->handle,
-				  "_DSM function 0 evaluation failed\n");
-		return 0;
-	}
-
-	lps0_dsm_func_mask = *(char *)out_obj->buffer.pointer;
-
-	ACPI_FREE(out_obj);
-
-	acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
-			  lps0_dsm_func_mask);
-
-	lps0_device_handle = adev->handle;
-
-	if (acpi_match_vendor_name())
-		lpi_device_get_constraints_amd();
-	else
-		lpi_device_get_constraints();
-
-	/*
-	 * Use suspend-to-idle by default if the default suspend mode was not
-	 * set from the command line.
-	 */
-	if (mem_sleep_default > PM_SUSPEND_MEM && !acpi_sleep_default_s3)
-		mem_sleep_current = PM_SUSPEND_TO_IDLE;
-
-	/*
-	 * Some LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U, require the
-	 * EC GPE to be enabled while suspended for certain wakeup devices to
-	 * work, so mark it as wakeup-capable.
-	 */
-	acpi_ec_mark_gpe_for_wake();
-
-	return 0;
-}
-
-static struct acpi_scan_handler lps0_handler = {
-	.ids = lps0_device_ids,
-	.attach = lps0_device_attach,
-};
-
-static int acpi_s2idle_begin(void)
+int acpi_s2idle_begin(void)
 {
 	acpi_scan_lock_acquire();
 	return 0;
 }
 
-static int acpi_s2idle_prepare(void)
+int acpi_s2idle_prepare(void)
 {
 	if (acpi_sci_irq_valid()) {
 		enable_irq_wake(acpi_sci_irq);
@@ -1107,24 +707,7 @@ static int acpi_s2idle_prepare(void)
 	return 0;
 }
 
-static int acpi_s2idle_prepare_late(void)
-{
-	if (!lps0_device_handle || sleep_no_lps0)
-		return 0;
-
-	if (pm_debug_messages_on)
-		lpi_check_constraints();
-
-	if (acpi_match_vendor_name()) {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
-	} else {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
-	}
-	return 0;
-}
-
-static bool acpi_s2idle_wake(void)
+bool acpi_s2idle_wake(void)
 {
 	if (!acpi_sci_irq_valid())
 		return pm_wakeup_pending();
@@ -1190,20 +773,7 @@ static bool acpi_s2idle_wake(void)
 	return false;
 }
 
-static void acpi_s2idle_restore_early(void)
-{
-	if (!lps0_device_handle || sleep_no_lps0)
-		return;
-
-	if (acpi_match_vendor_name()) {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
-	} else {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
-	}
-}
-
-static void acpi_s2idle_restore(void)
+void acpi_s2idle_restore(void)
 {
 	/*
 	 * Drain pending events before restoring the working-state configuration
@@ -1225,7 +795,7 @@ static void acpi_s2idle_restore(void)
 	}
 }
 
-static void acpi_s2idle_end(void)
+void acpi_s2idle_end(void)
 {
 	acpi_scan_lock_release();
 }
@@ -1233,13 +803,16 @@ static void acpi_s2idle_end(void)
 static const struct platform_s2idle_ops acpi_s2idle_ops = {
 	.begin = acpi_s2idle_begin,
 	.prepare = acpi_s2idle_prepare,
-	.prepare_late = acpi_s2idle_prepare_late,
 	.wake = acpi_s2idle_wake,
-	.restore_early = acpi_s2idle_restore_early,
 	.restore = acpi_s2idle_restore,
 	.end = acpi_s2idle_end,
 };
 
+void __weak acpi_s2idle_setup(void)
+{
+	s2idle_set_ops(&acpi_s2idle_ops);
+}
+
 static void acpi_sleep_suspend_setup(void)
 {
 	int i;
@@ -1251,13 +824,11 @@ static void acpi_sleep_suspend_setup(voi
 	suspend_set_ops(old_suspend_ordering ?
 		&acpi_suspend_ops_old : &acpi_suspend_ops);
 
-	acpi_scan_add_handler(&lps0_handler);
-	s2idle_set_ops(&acpi_s2idle_ops);
+	acpi_s2idle_setup();
 }
 
 #else /* !CONFIG_SUSPEND */
 #define s2idle_wakeup		(false)
-#define lps0_device_handle	(NULL)
 static inline void acpi_sleep_suspend_setup(void) {}
 #endif /* !CONFIG_SUSPEND */
 
Index: linux-pm/drivers/acpi/sleep.h
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.h
+++ linux-pm/drivers/acpi/sleep.h
@@ -15,3 +15,19 @@ static inline acpi_status acpi_set_wakin
 	return acpi_set_firmware_waking_vector(
 				(acpi_physical_address)wakeup_address, 0);
 }
+
+extern int acpi_s2idle_begin(void);
+extern int acpi_s2idle_prepare(void);
+extern int acpi_s2idle_prepare_late(void);
+extern bool acpi_s2idle_wake(void);
+extern void acpi_s2idle_restore_early(void);
+extern void acpi_s2idle_restore(void);
+extern void acpi_s2idle_end(void);
+
+extern void acpi_s2idle_setup(void);
+
+#ifdef CONFIG_ACPI_SLEEP
+extern bool acpi_sleep_default_s3;
+#else
+#define acpi_sleep_default_s3	(1)
+#endif
Index: linux-pm/drivers/acpi/Makefile
===================================================================
--- linux-pm.orig/drivers/acpi/Makefile
+++ linux-pm/drivers/acpi/Makefile
@@ -54,6 +54,7 @@ acpi-y				+= property.o
 acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
 acpi-$(CONFIG_X86)		+= x86/apple.o
 acpi-$(CONFIG_X86)		+= x86/utils.o
+acpi-$(CONFIG_X86)		+= x86/s2idle.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-y				+= acpi_lpat.o
 acpi-$(CONFIG_ACPI_LPIT)	+= acpi_lpit.o



