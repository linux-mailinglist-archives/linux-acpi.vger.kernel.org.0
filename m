Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 461302AC21
	for <lists+linux-acpi@lfdr.de>; Sun, 26 May 2019 22:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbfEZUfU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 May 2019 16:35:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:15778 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfEZUfU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 26 May 2019 16:35:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 May 2019 13:35:19 -0700
X-ExtLoop1: 1
Received: from shaunak-z87x-ud5h.sc.intel.com ([10.3.62.50])
  by orsmga002.jf.intel.com with ESMTP; 26 May 2019 13:35:19 -0700
From:   Shaunak Saha <shaunak.saha@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, mario_limonciello@dell.com,
        Shaunak Saha <shaunak.saha@intel.com>
Subject: drivers/acpi: Change the lpit function call flow
Date:   Sun, 26 May 2019 13:27:50 -0700
Message-Id: <20190526202750.4614-1-shaunak.saha@intel.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In the present implementation sleep function was getting called in
acpi_s2idle_prepare and as all the devices may not have suspended
at that stage e.g. if we are telling ec about the S0ix then calling early
can cause ec reply wrongly interpreted as spurious wake events.
Here we call it at much later stage in acpi_s2idle_sync. As per the
specification the entry _DSM function may be invoked when the OS state has
reached sufficient criteria for processor idle state entry matching
Entry Trigger defined in LPIT to be interpreted as a request for the
platform to enter a Low Power S0 Idle (LPI) state. Here we are checking if
the we reached the minimum D-State defined in the constraint function of
the LPIT _DSM method before calling the sleep entry function. Also not
checking for constraint in acpi_s2idle_wake anymore and also changed the
acpi info loglevel to debug in lpi_check_constraint.

Signed-off-by: Shaunak Saha <shaunak.saha@intel.com>
---
 drivers/acpi/Kconfig | 13 +++++++++
 drivers/acpi/sleep.c | 76 +++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 77 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 283ee94..57a9b2e 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -93,6 +93,19 @@ config ACPI_LPIT
 	depends on X86_64
 	default y
 
+config LPIT_CONSTRAINTS_CHECK_FAILURE
+	bool
+	depends on X86_64
+	default n
+	help
+	  For platforms defining the device constraints _DSM function in the
+	  Low Power Idle table this option allows the platform to choose
+	  if they wants to fail or succeed in calling the Low Power Entry
+	  Notification _DSM function. If this config is defined by a
+	  platform then the Low Power S0 Entry Notification _DSM function
+	  is not called if the idle state has not achieved the Entry Trigger
+	  defined in LPIT.
+
 config ACPI_SLEEP
 	bool
 	depends on SUSPEND || HIBERNATION
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index e52f123..9f2359c 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -860,11 +860,25 @@ static void lpi_device_get_constraints(void)
 
 free_acpi_buffer:
 	ACPI_FREE(out_obj);
+	/*
+	 * lpi_constraints_table_size only increments if we have proper package
+	 * definitions for the constraints, its done after parsing all the
+	 * fields for constraints. Memory is allocated for lpi_constraints_table
+	 * through kcalloc much before we start parsing the packages we need to
+	 * free the memory here in case of any failures.
+	 */
+	if (!lpi_constraints_table_size && lpi_constraints_table)
+		kfree(lpi_constraints_table);
 }
 
-static void lpi_check_constraints(void)
+static int lpi_check_constraints(void)
 {
 	int i;
+	int lpi_error = 0;
+
+	/* We do not have any table so return from here */
+	if (!lpi_constraints_table_size)
+		return lpi_error;
 
 	for (i = 0; i < lpi_constraints_table_size; ++i) {
 		acpi_handle handle = lpi_constraints_table[i].handle;
@@ -879,17 +893,21 @@ static void lpi_check_constraints(void)
 			acpi_power_state_string(adev->power.state));
 
 		if (!adev->flags.power_manageable) {
-			acpi_handle_info(handle, "LPI: Device not power manageable\n");
+			acpi_handle_debug(handle, "LPI: Device not power manageable\n");
 			lpi_constraints_table[i].handle = NULL;
 			continue;
 		}
 
-		if (adev->power.state < lpi_constraints_table[i].min_dstate)
-			acpi_handle_info(handle,
+		if (adev->power.state < lpi_constraints_table[i].min_dstate) {
+			acpi_handle_debug(handle,
 				"LPI: Constraint not met; min power state:%s current power state:%s\n",
 				acpi_power_state_string(lpi_constraints_table[i].min_dstate),
 				acpi_power_state_string(adev->power.state));
+			/* Error is set here if any of the constraints fail */
+			lpi_error = 1;
+		}
 	}
+	return lpi_error;
 }
 
 static void acpi_sleep_run_lps0_dsm(unsigned int func)
@@ -967,12 +985,8 @@ static int acpi_s2idle_begin(void)
 
 static int acpi_s2idle_prepare(void)
 {
-	if (lps0_device_handle) {
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
-		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
-
+	if (lps0_device_handle)
 		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
-	}
 
 	if (acpi_sci_irq_valid())
 		enable_irq_wake(acpi_sci_irq);
@@ -990,9 +1004,6 @@ static void acpi_s2idle_wake(void)
 	if (!lps0_device_handle)
 		return;
 
-	if (pm_debug_messages_on)
-		lpi_check_constraints();
-
 	/*
 	 * If IRQD_WAKEUP_ARMED is not set for the SCI at this point, it means
 	 * that the SCI has triggered while suspended, so cancel the wakeup in
@@ -1013,6 +1024,7 @@ static void acpi_s2idle_wake(void)
 
 static void acpi_s2idle_sync(void)
 {
+	int lpi_check;
 	/*
 	 * Process all pending events in case there are any wakeup ones.
 	 *
@@ -1023,6 +1035,46 @@ static void acpi_s2idle_sync(void)
 	acpi_ec_flush_work();
 	acpi_os_wait_events_complete();	/* synchronize Notify handling */
 	s2idle_wakeup = false;
+
+	if (!lps0_device_handle)
+		return;
+
+	acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
+
+	/*
+	 * Check here if device constraints(Function 1) is defined.
+	 * If only the sleep functions are defined in lpit we run that here.
+	 */
+	if (!lpi_constraints_table_size)
+		goto lps0_entry;
+
+	lpi_check = lpi_check_constraints();
+
+	/*
+	 * _DSM function may be invoked when the OS state
+	 * has reached sufficient criteria for processor idle
+	 * state.
+	 */
+	if (lpi_check) {
+		/*
+		 * We check the config LPIT_CONSTRAINTS_FAILURE
+		 * here for the devices which defines the constraints
+		 * properly and LPIT_CONSTRAINTS_FAILURE config in kernel.
+		 * We fail here if constraints are not met. But we still run
+		 * the sleep function for the devices which do not define
+		 * the LPIT_CONSTRAINTS_FAILURE kernel config.
+		 */
+		if (!IS_ENABLED(CONFIG_LPIT_CONSTRAINTS_CHECK_FAILURE))
+			goto lps0_entry;
+
+		return;
+	}
+
+lps0_entry:
+	/*
+	 * If only the sleep functions are defined in lpit we run that here.
+	 */
+	acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
 }
 
 static void acpi_s2idle_restore(void)

