Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC0A317B21F
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2020 00:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCEXQy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Mar 2020 18:16:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60073 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgCEXQy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2020 18:16:54 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id f388919591f175cd; Fri, 6 Mar 2020 00:16:52 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/2] ACPI: EC: Simplify acpi_ec_ecdt_start() and acpi_ec_init()
Date:   Fri, 06 Mar 2020 00:14:35 +0100
Message-ID: <2919587.tjZHhiJ8Q4@kreacher>
In-Reply-To: <2656743.kaaXMJBMQx@kreacher>
References: <2656743.kaaXMJBMQx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Notice that the return value of acpi_ec_init() is discarded anyway,
so it can be void and it doesn't need to check the return values of
acpi_bus_register_driver() and acpi_ec_ecdt_start() called by it.
Thus the latter can be void too and it really has nothing to do
if acpi_ec_add() has already found an EC matching the boot one in the
namespace.  Also, acpi_ec_ecdt_get_handle() can be folded into it.

Modify the code accordingly and while at it create a propoer kerneldoc
comment to document acpi_ec_ecdt_start() and move the remark regarding
ASUS X550ZE along with the related bug URL from acpi_ec_init() into
that comment.

Additionally, fix up a stale comment in acpi_ec_init().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c       | 91 +++++++++++++++++++------------------------------
 drivers/acpi/internal.h |  2 +-
 2 files changed, 37 insertions(+), 56 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 47baeec9190d..9e7ee6ae4706 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1594,25 +1594,6 @@ static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device)
 	return ret;
 }
 
-static bool acpi_ec_ecdt_get_handle(acpi_handle *phandle)
-{
-	struct acpi_table_ecdt *ecdt_ptr;
-	acpi_status status;
-	acpi_handle handle;
-
-	status = acpi_get_table(ACPI_SIG_ECDT, 1,
-				(struct acpi_table_header **)&ecdt_ptr);
-	if (ACPI_FAILURE(status))
-		return false;
-
-	status = acpi_get_handle(NULL, ecdt_ptr->id, &handle);
-	if (ACPI_FAILURE(status))
-		return false;
-
-	*phandle = handle;
-	return true;
-}
-
 static int acpi_ec_add(struct acpi_device *device)
 {
 	struct acpi_ec *ec;
@@ -1784,35 +1765,42 @@ void __init acpi_ec_dsdt_probe(void)
 }
 
 /*
- * If the DSDT EC is not functioning, we still need to prepare a fully
- * functioning ECDT EC first in order to handle the events.
- * https://bugzilla.kernel.org/show_bug.cgi?id=115021
+ * acpi_ec_ecdt_start - Finalize the boot ECDT EC initialization.
+ *
+ * First, look for an ACPI handle for the boot ECDT EC if acpi_ec_add() has not
+ * found a matching object in the namespace.
+ *
+ * Next, in case the DSDT EC is not functioning, it is still necessary to
+ * provide a functional ECDT EC to handle events, so add an extra device object
+ * to represent it (see https://bugzilla.kernel.org/show_bug.cgi?id=115021).
+ *
+ * This is useful on platforms with valid ECDT and invalid DSDT EC settings,
+ * like ASUS X550ZE (see https://bugzilla.kernel.org/show_bug.cgi?id=196847).
  */
-static int __init acpi_ec_ecdt_start(void)
+static void __init acpi_ec_ecdt_start(void)
 {
+	struct acpi_table_ecdt *ecdt_ptr;
 	acpi_handle handle;
+	acpi_status status;
 
-	if (!boot_ec)
-		return -ENODEV;
-	/* In case acpi_ec_ecdt_start() is called after acpi_ec_add() */
-	if (!boot_ec_is_ecdt)
-		return -ENODEV;
+	/* Bail out if a matching EC has been found in the namespace. */
+	if (!boot_ec || boot_ec->handle != ACPI_ROOT_OBJECT)
+		return;
 
-	/*
-	 * At this point, the namespace and the GPE is initialized, so
-	 * start to find the namespace objects and handle the events.
-	 *
-	 * Note: ec->handle can be valid if this function is called after
-	 * acpi_ec_add(), hence the fast path.
-	 */
-	if (boot_ec->handle == ACPI_ROOT_OBJECT) {
-		if (!acpi_ec_ecdt_get_handle(&handle))
-			return -ENODEV;
-		boot_ec->handle = handle;
-	}
+	/* Look up the object pointed to from the ECDT in the namespace. */
+	status = acpi_get_table(ACPI_SIG_ECDT, 1,
+				(struct acpi_table_header **)&ecdt_ptr);
+	if (ACPI_FAILURE(status))
+		return;
+
+	status = acpi_get_handle(NULL, ecdt_ptr->id, &handle);
+	if (ACPI_FAILURE(status))
+		return;
 
-	/* Register to ACPI bus with PM ops attached */
-	return acpi_bus_register_early_device(ACPI_BUS_TYPE_ECDT_EC);
+	boot_ec->handle = handle;
+
+	/* Add a special ACPI device object to represent the boot EC. */
+	acpi_bus_register_early_device(ACPI_BUS_TYPE_ECDT_EC);
 }
 
 #if 0
@@ -2156,14 +2144,13 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 	{ },
 };
 
-int __init acpi_ec_init(void)
+void __init acpi_ec_init(void)
 {
 	int result;
-	int ecdt_fail, dsdt_fail;
 
 	result = acpi_ec_init_workqueues();
 	if (result)
-		return result;
+		return;
 
 	/*
 	 * Disable EC wakeup on following systems to prevent periodic
@@ -2174,16 +2161,10 @@ int __init acpi_ec_init(void)
 		pr_debug("Disabling EC wakeup on suspend-to-idle\n");
 	}
 
-	/* Drivers must be started after acpi_ec_query_init() */
-	dsdt_fail = acpi_bus_register_driver(&acpi_ec_driver);
-	/*
-	 * Register ECDT to ACPI bus only when PNP0C09 probe fails. This is
-	 * useful for platforms (confirmed on ASUS X550ZE) with valid ECDT
-	 * settings but invalid DSDT settings.
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=196847
-	 */
-	ecdt_fail = acpi_ec_ecdt_start();
-	return ecdt_fail && dsdt_fail ? -ENODEV : 0;
+	/* Driver must be registered after acpi_ec_init_workqueues(). */
+	acpi_bus_register_driver(&acpi_ec_driver);
+
+	acpi_ec_ecdt_start();
 }
 
 /* EC driver currently not unloadable */
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 3616daec650b..43411a7457cd 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -190,7 +190,7 @@ extern struct acpi_ec *first_ec;
 /* External interfaces use first EC only, so remember */
 typedef int (*acpi_ec_query_func) (void *data);
 
-int acpi_ec_init(void);
+void acpi_ec_init(void);
 void acpi_ec_ecdt_probe(void);
 void acpi_ec_dsdt_probe(void);
 void acpi_ec_block_transactions(void);
-- 
2.16.4




