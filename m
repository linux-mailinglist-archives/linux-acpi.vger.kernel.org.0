Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D396172B0E
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2020 23:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgB0WZf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Feb 2020 17:25:35 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52916 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbgB0WZU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Feb 2020 17:25:20 -0500
Received: from 79.184.237.30.ipv4.supernova.orange.pl (79.184.237.30) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id a8470c93d78cdccb; Thu, 27 Feb 2020 23:25:18 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 4/6] ACPI: EC: Unify handling of event handler installation failures
Date:   Thu, 27 Feb 2020 23:23:10 +0100
Message-ID: <1896616.ZZjdNj2dPd@kreacher>
In-Reply-To: <2094703.CetWLLyMuz@kreacher>
References: <2094703.CetWLLyMuz@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Commit 406857f773b0 ("ACPI: EC: add support for hardware-reduced
systems") made ec_install_handlers() return an error on failures
to configure a GPIO IRQ for the EC, but that is inconsistent with
the handling of the GPE event handler installation failures even
though it is exactly the same issue and the driver can respond to
it in the same way in both cases (the EC can be actively polled
for events through its registers if the event handler installation
fails).

Moreover, it requires acpi_ec_add() to take that special case into
account and disagrees with the ec_install_handlers() header comment.

For this reason, consolidate the handling of event handler
installation failures in ec_install_handlers() so that they do not
prevent the EC from being used in any case.  On top of that, reduce
code duplication between install_gpe_event_handler() and
install_gpio_irq_event_handler() by moving some code from there
into ec_install_handlers() and simplify the error code path in
acpi_ec_add().

While at it, turn the ec_install_handlers() header comment into
a proper kerneldoc one and add some general control flow information
to it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c | 96 +++++++++++++++++++++++++++----------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 6f501d552e6e..3f6127e919ab 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1427,54 +1427,53 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 	return AE_CTRL_TERMINATE;
 }
 
-static void install_gpe_event_handler(struct acpi_ec *ec)
-{
-	acpi_status status =
-		acpi_install_gpe_raw_handler(NULL, ec->gpe,
-					     ACPI_GPE_EDGE_TRIGGERED,
-					     &acpi_ec_gpe_handler,
-					     ec);
-	if (ACPI_SUCCESS(status)) {
-		/* This is not fatal as we can poll EC events */
-		set_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags);
-		acpi_ec_leave_noirq(ec);
-		if (test_bit(EC_FLAGS_STARTED, &ec->flags) &&
-		    ec->reference_count >= 1)
-			acpi_ec_enable_gpe(ec, true);
-	}
+static bool install_gpe_event_handler(struct acpi_ec *ec)
+{
+	acpi_status status;
+
+	status = acpi_install_gpe_raw_handler(NULL, ec->gpe,
+					      ACPI_GPE_EDGE_TRIGGERED,
+					      &acpi_ec_gpe_handler, ec);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	if (test_bit(EC_FLAGS_STARTED, &ec->flags) && ec->reference_count >= 1)
+		acpi_ec_enable_gpe(ec, true);
+
+	return true;
 }
 
-/* ACPI reduced hardware platforms use a GpioInt specified in _CRS. */
-static int install_gpio_irq_event_handler(struct acpi_ec *ec,
-					  struct acpi_device *device)
+static bool install_gpio_irq_event_handler(struct acpi_ec *ec,
+					   struct acpi_device *device)
 {
-	int irq = acpi_dev_gpio_irq_get(device, 0);
-	int ret;
+	int irq, ret;
 
+	/* ACPI reduced hardware platforms use a GpioInt specified in _CRS. */
+	irq = acpi_dev_gpio_irq_get(device, 0);
 	if (irq < 0)
-		return irq;
-
-	ret = request_irq(irq, acpi_ec_irq_handler, IRQF_SHARED,
-			  "ACPI EC", ec);
+		return false;
 
-	/*
-	 * Unlike the GPE case, we treat errors here as fatal, we'll only
-	 * implement GPIO polling if we find a case that needs it.
-	 */
+	ret = request_irq(irq, acpi_ec_irq_handler, IRQF_SHARED, "ACPI EC", ec);
 	if (ret < 0)
-		return ret;
+		return false;
 
 	ec->irq = irq;
-	set_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags);
-	acpi_ec_leave_noirq(ec);
 
-	return 0;
+	return true;
 }
 
-/*
- * Note: This function returns an error code only when the address space
- *       handler is not installed, which means "not able to handle
- *       transactions".
+/**
+ * ec_install_handlers - Install service callbacks and register query methods.
+ * @ec: Target EC.
+ * @device: ACPI device object corresponding to @ec.
+ *
+ * Install a handler for the EC address space type unless it has been installed
+ * already.  If @device is not NULL, also look for EC query methods in the
+ * namespace and register them, and install an event (either GPE or GPIO IRQ)
+ * handler for the EC, if possible.
+ *
+ * Return -ENODEV if the address space handler cannot be installed, which means
+ * "unable to handle transactions", or 0 (success) otherwise.
  */
 static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
 {
@@ -1506,13 +1505,17 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
 		set_bit(EC_FLAGS_QUERY_METHODS_INSTALLED, &ec->flags);
 	}
 	if (!test_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags)) {
-		if (ec->gpe >= 0) {
-			install_gpe_event_handler(ec);
-		} else {
-			int ret = install_gpio_irq_event_handler(ec, device);
-			if (ret)
-				return ret;
+		bool ready = ec->gpe >= 0 ?
+				install_gpe_event_handler(ec) :
+				install_gpio_irq_event_handler(ec, device);
+		if (ready) {
+			set_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags);
+			acpi_ec_leave_noirq(ec);
 		}
+		/*
+		 * Failures to install an event handler are not fatal, because
+		 * the EC can be polled for events.
+		 */
 	}
 	/* EC is fully operational, allow queries */
 	acpi_ec_enable_event(ec);
@@ -1625,7 +1628,7 @@ static int acpi_ec_add(struct acpi_device *device)
 		status = ec_parse_device(device->handle, 0, ec, NULL);
 		if (status != AE_CTRL_TERMINATE) {
 			ret = -EINVAL;
-			goto err_alloc;
+			goto err;
 		}
 
 		if (boot_ec && ec->command_addr == boot_ec->command_addr &&
@@ -1646,7 +1649,7 @@ static int acpi_ec_add(struct acpi_device *device)
 
 	ret = acpi_ec_setup(ec, device);
 	if (ret)
-		goto err_query;
+		goto err;
 
 	if (ec == boot_ec)
 		acpi_handle_info(boot_ec->handle,
@@ -1667,10 +1670,7 @@ static int acpi_ec_add(struct acpi_device *device)
 	acpi_handle_debug(ec->handle, "enumerated.\n");
 	return 0;
 
-err_query:
-	if (ec != boot_ec)
-		acpi_ec_remove_query_handlers(ec, true, 0);
-err_alloc:
+err:
 	if (ec != boot_ec)
 		acpi_ec_free(ec);
 	return ret;
-- 
2.16.4





