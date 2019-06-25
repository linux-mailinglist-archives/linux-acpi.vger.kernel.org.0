Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F75F54E51
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2019 14:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfFYMGf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jun 2019 08:06:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50952 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFYMGe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jun 2019 08:06:34 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 83cfdbf0013218ff; Tue, 25 Jun 2019 14:06:32 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] ACPI: PM: Allow transitions to D0 to occur in special cases
Date:   Tue, 25 Jun 2019 14:06:13 +0200
Message-ID: <2807567.5m5tnf7bLv@kreacher>
In-Reply-To: <10419005.Mb09WM6RCc@kreacher>
References: <10419005.Mb09WM6RCc@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If a device with ACPI PM is left in D0 during a system-wide
transition to the S3 (suspend-to-RAM) or S4 (hibernation) sleep
state, the actual state of the device need not be D0 during resume
from it, although its power.state value will still reflect D0 (that
is, the power state from before the system-wide transition).

In that case, the acpi_device_set_power() call made to ensure that
the power state of the device will be D0 going forward has no effect,
because the new state (D0) is equal to the one reflected by the
device's power.state value.  That does not affect power resources,
which are taken care of by acpi_resume_power_resources() called from
acpi_pm_finish() during resume from system-wide sleep states, but it
still may be necessary to invoke _PS0 for the device on top of that
in order to finalize its transition to D0.

For this reason, modify acpi_device_set_power() to allow transitions
to D0 to occur even if D0 is the current power state of the device
according to its power.state value.

That will not affect power resources, which are assumed to be in
the right configuration already (as reflected by the current values
of their reference counters), but it may cause _PS0 to be evaluated
for the device.  However, evaluating _PS0 for a device already in D0
may lead to confusion in general, so invoke _PSC (if present) to
check the device's current power state upfront and only evaluate
_PS0 for it if _PSC has returned a power state different from D0.
[If _PSC is not present or the evaluation of it fails, the power
state of the device is assumed to be D0 at this point.]

Fixes: 20dacb71ad28 (ACPI / PM: Rework device power management to follow ACPI 6)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |   53 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -45,6 +45,19 @@ const char *acpi_power_state_string(int
 	}
 }
 
+static int acpi_dev_pm_explicit_get(struct acpi_device *device, int *state)
+{
+	unsigned long long psc;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(device->handle, "_PSC", NULL, &psc);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	*state = psc;
+	return 0;
+}
+
 /**
  * acpi_device_get_power - Get power state of an ACPI device.
  * @device: Device to get the power state of.
@@ -57,6 +70,7 @@ const char *acpi_power_state_string(int
 int acpi_device_get_power(struct acpi_device *device, int *state)
 {
 	int result = ACPI_STATE_UNKNOWN;
+	int error;
 
 	if (!device || !state)
 		return -EINVAL;
@@ -73,18 +87,16 @@ int acpi_device_get_power(struct acpi_de
 	 * if available.
 	 */
 	if (device->power.flags.power_resources) {
-		int error = acpi_power_get_inferred_state(device, &result);
+		error = acpi_power_get_inferred_state(device, &result);
 		if (error)
 			return error;
 	}
 	if (device->power.flags.explicit_get) {
-		acpi_handle handle = device->handle;
-		unsigned long long psc;
-		acpi_status status;
+		int psc;
 
-		status = acpi_evaluate_integer(handle, "_PSC", NULL, &psc);
-		if (ACPI_FAILURE(status))
-			return -ENODEV;
+		error = acpi_dev_pm_explicit_get(device, &psc);
+		if (error)
+			return error;
 
 		/*
 		 * The power resources settings may indicate a power state
@@ -152,7 +164,8 @@ int acpi_device_set_power(struct acpi_de
 
 	/* Make sure this is a valid target state */
 
-	if (state == device->power.state) {
+	/* There is a special case for D0 addressed below. */
+	if (state > ACPI_STATE_D0 && state == device->power.state) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] already in %s\n",
 				  device->pnp.bus_id,
 				  acpi_power_state_string(state)));
@@ -214,6 +227,30 @@ int acpi_device_set_power(struct acpi_de
 			if (result)
 				goto end;
 		}
+
+		if (device->power.state == ACPI_STATE_D0) {
+			int psc;
+
+			/* Nothing to do here if _PSC is not present. */
+			if (!device->power.flags.explicit_get)
+				return 0;
+
+			/*
+			 * The power state of the device was set to D0 last
+			 * time, but that might have happened before a
+			 * system-wide transition involving the platform
+			 * firmware, so it may be necessary to evaluate _PS0
+			 * for the device here.  However, use extra care here
+			 * and evaluate _PSC to check the device's current power
+			 * state, and only invoke _PS0 if the evaluation of _PSC
+			 * is successful and it returns a power state different
+			 * from D0.
+			 */
+			result = acpi_dev_pm_explicit_get(device, &psc);
+			if (result || psc == ACPI_STATE_D0)
+				return 0;
+		}
+
 		result = acpi_dev_pm_explicit_set(device, ACPI_STATE_D0);
 	}
 



