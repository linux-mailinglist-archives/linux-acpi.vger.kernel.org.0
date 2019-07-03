Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA1B5EF66
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2019 01:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfGCXCx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 19:02:53 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61215 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfGCXCx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Jul 2019 19:02:53 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 8010e3fd10758b8f; Thu, 4 Jul 2019 01:02:49 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI: PM: Unexport acpi_device_get_power()
Date:   Thu, 04 Jul 2019 01:02:49 +0200
Message-ID: <1970901.ZntFDt4DbR@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Using acpi_device_get_power() outside of ACPI device initialization
and ACPI sysfs is problematic due to the way in which power resources
are handled by it, so unexport it and add a paragraph explaining the
pitfalls to its kerneldoc comment.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of the linux-next branch in the linux-pm.git tree.

---
 drivers/acpi/device_pm.c |    6 +++++-
 drivers/acpi/internal.h  |    7 +++++++
 include/acpi/acpi_bus.h  |    1 -
 3 files changed, 12 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -66,6 +66,11 @@ static int acpi_dev_pm_explicit_get(stru
  * This function does not update the device's power.state field, but it may
  * update its parent's power.state field (when the parent's power state is
  * unknown and the device's power state turns out to be D0).
+ *
+ * Also, it does not update power resource reference counters to ensure that
+ * the power state returned by it will be persistent and it may return a power
+ * state shallower than previously set by acpi_device_set_power() for @device
+ * (if that power state depends on any power resources).
  */
 int acpi_device_get_power(struct acpi_device *device, int *state)
 {
@@ -130,7 +135,6 @@ int acpi_device_get_power(struct acpi_de
 
 	return 0;
 }
-EXPORT_SYMBOL(acpi_device_get_power);
 
 static int acpi_dev_pm_explicit_set(struct acpi_device *adev, int state)
 {
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -506,7 +506,6 @@ int acpi_bus_get_status(struct acpi_devi
 
 int acpi_bus_set_power(acpi_handle handle, int state);
 const char *acpi_power_state_string(int state);
-int acpi_device_get_power(struct acpi_device *device, int *state);
 int acpi_device_set_power(struct acpi_device *device, int state);
 int acpi_bus_init_power(struct acpi_device *device);
 int acpi_device_fix_up_power(struct acpi_device *device);
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -139,8 +139,15 @@ int acpi_power_get_inferred_state(struct
 int acpi_power_on_resources(struct acpi_device *device, int state);
 int acpi_power_transition(struct acpi_device *device, int state);
 
+/* --------------------------------------------------------------------------
+                              Device Power Management
+   -------------------------------------------------------------------------- */
+int acpi_device_get_power(struct acpi_device *device, int *state);
 int acpi_wakeup_device_init(void);
 
+/* --------------------------------------------------------------------------
+                                  Processor
+   -------------------------------------------------------------------------- */
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
 void acpi_early_processor_set_pdc(void);
 #else



