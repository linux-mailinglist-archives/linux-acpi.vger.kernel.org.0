Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EED875B12
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2019 00:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfGYW4f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jul 2019 18:56:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54850 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfGYW4Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jul 2019 18:56:25 -0400
Received: from 79.184.253.188.ipv4.supernova.orange.pl (79.184.253.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 24f47bfa2e9ab75a; Fri, 26 Jul 2019 00:56:23 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/4] ACPI: PM: Set up EC GPE for system wakeup from drivers that need it
Date:   Fri, 26 Jul 2019 00:53:16 +0200
Message-ID: <3163213.d4HCi86EAO@kreacher>
In-Reply-To: <3471485.I2vrcDHEeC@kreacher>
References: <3471485.I2vrcDHEeC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The EC GPE needs to be set up for system wakeup only if there is a
driver depending on it, either intel-hid or intel-vbtn, bound to a
button device that is expected to wake up the system from sleep (such
as the power button on some Dell systems, like the XPS13 9360).  It
doesn't need to be set up for waking up the system from sleep in any
other cases and whether or not it is expected to wake up the system
from sleep doesn't depend on whether or not the LPS0 device is
present in the ACPI namespace.

For this reason, rearrange the ACPI suspend-to-idle code to make the
drivers depending on the EC GPE wakeup take care of setting it up and
decouple that from the LPS0 device handling.

While at it, make intel-hid and intel-vbtn prepare for system wakeup
only if they are allowed to wake up the system from sleep by user
space (via sysfs).

[Note that acpi_ec_mark_gpe_for_wake() and acpi_ec_set_gpe_wake_mask()
 are there to prevent the EC GPE from being disabled by the
 acpi_enable_all_wakeup_gpes() call in acpi_s2idle_prepare(), so on
 systems with either intel-hid or intel-vbtn this change doesn't
 affect any interactions with the hardware or platform firmware.]

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c                 |    5 ++++-
 drivers/acpi/internal.h           |    2 --
 drivers/acpi/sleep.c              |   11 +----------
 drivers/platform/x86/intel-hid.c  |   20 ++++++++++++++++----
 drivers/platform/x86/intel-vbtn.c |   20 ++++++++++++++++----
 include/linux/acpi.h              |    4 ++++
 6 files changed, 41 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -194,8 +194,6 @@ void acpi_ec_ecdt_probe(void);
 void acpi_ec_dsdt_probe(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
-void acpi_ec_mark_gpe_for_wake(void);
-void acpi_ec_set_gpe_wake_mask(u8 action);
 bool acpi_ec_dispatch_gpe(void);
 int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
 			      acpi_handle handle, acpi_ec_query_func func,
Index: linux-pm/drivers/platform/x86/intel-hid.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/intel-hid.c
+++ linux-pm/drivers/platform/x86/intel-hid.c
@@ -253,9 +253,12 @@ static void intel_button_array_enable(st
 
 static int intel_hid_pm_prepare(struct device *device)
 {
-	struct intel_hid_priv *priv = dev_get_drvdata(device);
+	if (device_may_wakeup(device)) {
+		struct intel_hid_priv *priv = dev_get_drvdata(device);
 
-	priv->wakeup_mode = true;
+		priv->wakeup_mode = true;
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
+	}
 	return 0;
 }
 
@@ -270,9 +273,12 @@ static int intel_hid_pl_suspend_handler(
 
 static int intel_hid_pl_resume_handler(struct device *device)
 {
-	struct intel_hid_priv *priv = dev_get_drvdata(device);
+	if (device_may_wakeup(device)) {
+		struct intel_hid_priv *priv = dev_get_drvdata(device);
 
-	priv->wakeup_mode = false;
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
+		priv->wakeup_mode = false;
+	}
 	if (pm_resume_via_firmware()) {
 		intel_hid_set_enable(device, true);
 		intel_button_array_enable(device, true);
@@ -491,6 +497,12 @@ static int intel_hid_probe(struct platfo
 	}
 
 	device_init_wakeup(&device->dev, true);
+	/*
+	 * In order for system wakeup to work, the EC GPE has to be marked as
+	 * a wakeup one, so do that here (this setting will persist, but it has
+	 * no effect until the wakeup mask is set for the EC GPE).
+	 */
+	acpi_ec_mark_gpe_for_wake();
 	return 0;
 
 err_remove_notify:
Index: linux-pm/drivers/platform/x86/intel-vbtn.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/intel-vbtn.c
+++ linux-pm/drivers/platform/x86/intel-vbtn.c
@@ -176,6 +176,12 @@ static int intel_vbtn_probe(struct platf
 		return -EBUSY;
 
 	device_init_wakeup(&device->dev, true);
+	/*
+	 * In order for system wakeup to work, the EC GPE has to be marked as
+	 * a wakeup one, so do that here (this setting will persist, but it has
+	 * no effect until the wakeup mask is set for the EC GPE).
+	 */
+	acpi_ec_mark_gpe_for_wake();
 	return 0;
 }
 
@@ -195,17 +201,23 @@ static int intel_vbtn_remove(struct plat
 
 static int intel_vbtn_pm_prepare(struct device *dev)
 {
-	struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
+	if (device_may_wakeup(dev)) {
+		struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
 
-	priv->wakeup_mode = true;
+		priv->wakeup_mode = true;
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
+	}
 	return 0;
 }
 
 static int intel_vbtn_pm_resume(struct device *dev)
 {
-	struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
+	if (device_may_wakeup(dev)) {
+		struct intel_vbtn_priv *priv = dev_get_drvdata(dev);
 
-	priv->wakeup_mode = false;
+		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
+		priv->wakeup_mode = false;
+	}
 	return 0;
 }
 
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -931,6 +931,8 @@ int acpi_subsys_suspend_noirq(struct dev
 int acpi_subsys_suspend(struct device *dev);
 int acpi_subsys_freeze(struct device *dev);
 int acpi_subsys_poweroff(struct device *dev);
+void acpi_ec_mark_gpe_for_wake(void);
+void acpi_ec_set_gpe_wake_mask(u8 action);
 #else
 static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
 static inline void acpi_subsys_complete(struct device *dev) {}
@@ -939,6 +941,8 @@ static inline int acpi_subsys_suspend_no
 static inline int acpi_subsys_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_freeze(struct device *dev) { return 0; }
 static inline int acpi_subsys_poweroff(struct device *dev) { return 0; }
+static inline void acpi_ec_mark_gpe_for_wake(void) {}
+static inline void acpi_ec_set_gpe_wake_mask(u8 action) {}
 #endif
 
 #ifdef CONFIG_ACPI
Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -25,6 +25,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <asm/io.h>
@@ -1053,12 +1054,14 @@ void acpi_ec_mark_gpe_for_wake(void)
 	if (first_ec && !ec_no_wakeup)
 		acpi_mark_gpe_for_wake(NULL, first_ec->gpe);
 }
+EXPORT_SYMBOL_GPL(acpi_ec_mark_gpe_for_wake);
 
 void acpi_ec_set_gpe_wake_mask(u8 action)
 {
-	if (first_ec && !ec_no_wakeup)
+	if (pm_suspend_no_platform() && first_ec && !ec_no_wakeup)
 		acpi_set_gpe_wake_mask(NULL, first_ec->gpe, action);
 }
+EXPORT_SYMBOL_GPL(acpi_ec_set_gpe_wake_mask);
 
 bool acpi_ec_dispatch_gpe(void)
 {
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -930,8 +930,6 @@ static int lps0_device_attach(struct acp
 
 		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
 				  bitmask);
-
-		acpi_ec_mark_gpe_for_wake();
 	} else {
 		acpi_handle_debug(adev->handle,
 				  "_DSM function 0 evaluation failed\n");
@@ -960,8 +958,6 @@ static int acpi_s2idle_prepare(void)
 	if (lps0_device_handle) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
-
-		acpi_ec_set_gpe_wake_mask(ACPI_GPE_ENABLE);
 	}
 
 	if (acpi_sci_irq_valid())
@@ -979,10 +975,7 @@ static int acpi_s2idle_prepare(void)
 
 static void acpi_s2idle_wake(void)
 {
-	if (!lps0_device_handle)
-		return;
-
-	if (pm_debug_messages_on)
+	if (lps0_device_handle && pm_debug_messages_on)
 		lpi_check_constraints();
 
 	/*
@@ -1031,8 +1024,6 @@ static void acpi_s2idle_restore(void)
 		disable_irq_wake(acpi_sci_irq);
 
 	if (lps0_device_handle) {
-		acpi_ec_set_gpe_wake_mask(ACPI_GPE_DISABLE);
-
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
 	}



