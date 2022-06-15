Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA054D22B
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jun 2022 21:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345218AbiFOT5K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jun 2022 15:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354405AbiFOT5H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2022 15:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32C6831DEA
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jun 2022 12:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655323021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4IRAOOrn3E/U28/R5lp+r2POD0+f5WZIETyGHTaPKlg=;
        b=dOwOlvO5YlHhZ85wjGn/qF8jJ6D1ytMS6sx9etNQOlGRs0mMzi2GcwXE1DT//bxkfTYVUv
        PQ3EE1+IZaSkaSrVfbsLXRw2sSeWYRtt88mB2Z0Q1161qd4RHj+SSy5KrqqBsInwEQhTXs
        DcOMXnCOzWVBxvFoN//SP8CqtlwqQRQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-XPRckmE2NLObuB-3g_nw9Q-1; Wed, 15 Jun 2022 15:56:58 -0400
X-MC-Unique: XPRckmE2NLObuB-3g_nw9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 991EF185A79C;
        Wed, 15 Jun 2022 19:56:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BFA32026D64;
        Wed, 15 Jun 2022 19:56:56 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>, kai.heng.feng@canonical.com,
        =?UTF-8?q?Johannes=20Pen=C3=9Fel?= <johannespenssel@posteo.net>,
        linux-acpi@vger.kernel.org, devel@acpica.org
Subject: [RFC 4/4] ACPI: fix ECDT EC probe ordering issues
Date:   Wed, 15 Jun 2022 21:56:43 +0200
Message-Id: <20220615195643.12608-5-hdegoede@redhat.com>
In-Reply-To: <20220615195643.12608-1-hdegoede@redhat.com>
References: <20220615195643.12608-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI-2.0 says that the EC OpRegion handler must be available immediately
(like the standard default OpRegion handlers). So acpi_bus_init() calls
acpi_ec_ecdt_probe(), which calls acpi_install_address_space_handler() to
install the EC's OpRegion handler, early on.

This not only installs the OpRegion handler, but also calls the EC's
_REG method. The _REG method call is a problem because it may rely on
initialization done by the _INI methods of one of the PCI / _SB root devs,
see for example: https://bugzilla.kernel.org/show_bug.cgi?id=214899 .

This _REG depends on _INI problem can be fixed by calling the new ACPICA
acpi_early_initialize_objects() function before acpi_ec_ecdt_probe().

But on some boards (e.g. Lenovo X1C8) the root devices _INI method
relies on the EC OpRegion so executing the _INI methods before
registering the EC OpRegion handler leads to errors there.

To allow fixing this the ACPICA code now allows to do the OpRegion handler
installation early on (without calling _REG) and to do the EC's _REG
execution later on as a separate step.

This commit uses this new ACPICA functions to fix the EC probe ordering
by changing the acpi_bus_init() initialization order to this:

1. acpi_load_tables()
2. acpi_ec_ecdt_probe()
   This now calls acpi_install_address_space_handler(ACPI_NO_EXEC__REG)
   which installs the OpRegion handler without executing _REG
3. acpi_enable_subsystem()
4. acpi_early_initialize_objects()
   This calls the _INI method of the PCI and _SB root devices
5. acpi_ec_ecdt_exec_reg();
   This executes the EC's _REG now that the root devices _INI has run
6. acpi_initialize_objects(ACPI_NO_EARLY_DEVICE_INIT)

This allows the EC's _REG method to depend on e.g. the \OSYS global/GVNS
variable often set by a root-device's _INI method, while at the same time
allowing these _INI methods to access EmbeddedController OpRegions.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/bus.c      | 19 ++++++++++++++++++-
 drivers/acpi/ec.c       | 38 ++++++++++++++++++++++++++++----------
 drivers/acpi/internal.h |  1 +
 3 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 86fa61a21826..fe5c46da5265 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1303,7 +1303,24 @@ static int __init acpi_bus_init(void)
 		goto error1;
 	}
 
-	status = acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
+	/*
+	 * This usually sets an OSYS global variable based on _OSI checks,
+	 * and the EC's _REG method may rely on this OSYS variable, so do
+	 * this before acpi_ec_ecdt_exec_reg().
+	 */
+	status = acpi_early_initialize_objects();
+	if (ACPI_FAILURE(status)) {
+		pr_err("Unable to do early ACPI objects initialization\n");
+		goto error1;
+	}
+
+	acpi_ec_ecdt_exec_reg();
+
+	/*
+	 * ACPI_NO_EARLY_DEVICE_INIT to avoid ACPICA calling
+	 * acpi_early_initialize_objects() a second time.
+	 */
+	status = acpi_initialize_objects(ACPI_NO_EARLY_DEVICE_INIT);
 	if (ACPI_FAILURE(status)) {
 		pr_err("Unable to initialize ACPI objects\n");
 		goto error1;
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a1b871a418f8..cd86e68d6b98 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1459,6 +1459,7 @@ static bool install_gpio_irq_event_handler(struct acpi_ec *ec)
  * ec_install_handlers - Install service callbacks and register query methods.
  * @ec: Target EC.
  * @device: ACPI device object corresponding to @ec.
+ * @flags: Flags to pass to acpi_install_address_space_handler()
  *
  * Install a handler for the EC address space type unless it has been installed
  * already.  If @device is not NULL, also look for EC query methods in the
@@ -1471,7 +1472,7 @@ static bool install_gpio_irq_event_handler(struct acpi_ec *ec)
  * -EPROBE_DEFER if GPIO IRQ acquisition needs to be deferred,
  * or 0 (success) otherwise.
  */
-static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
+static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device, u32 flags)
 {
 	acpi_status status;
 
@@ -1479,10 +1480,10 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
 
 	if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
 		acpi_ec_enter_noirq(ec);
-		status = acpi_install_address_space_handler(ec->handle,
-							    ACPI_ADR_SPACE_EC,
-							    &acpi_ec_space_handler,
-							    NULL, ec);
+		status = acpi_install_address_space_handler_flags(ec->handle,
+								  ACPI_ADR_SPACE_EC,
+								  &acpi_ec_space_handler,
+								  NULL, ec, flags);
 		if (ACPI_FAILURE(status)) {
 			acpi_ec_stop(ec, false);
 			return -ENODEV;
@@ -1575,11 +1576,11 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 	}
 }
 
-static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device)
+static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device, u32 flags)
 {
 	int ret;
 
-	ret = ec_install_handlers(ec, device);
+	ret = ec_install_handlers(ec, device, flags);
 	if (ret)
 		return ret;
 
@@ -1641,7 +1642,7 @@ static int acpi_ec_add(struct acpi_device *device)
 		}
 	}
 
-	ret = acpi_ec_setup(ec, device);
+	ret = acpi_ec_setup(ec, device, 0);
 	if (ret)
 		goto err;
 
@@ -1761,7 +1762,7 @@ void __init acpi_ec_dsdt_probe(void)
 	 * At this point, the GPE is not fully initialized, so do not to
 	 * handle the events.
 	 */
-	ret = acpi_ec_setup(ec, NULL);
+	ret = acpi_ec_setup(ec, NULL, 0);
 	if (ret) {
 		acpi_ec_free(ec);
 		return;
@@ -1973,7 +1974,7 @@ void __init acpi_ec_ecdt_probe(void)
 	 * At this point, the namespace is not initialized, so do not find
 	 * the namespace objects, or handle the events.
 	 */
-	ret = acpi_ec_setup(ec, NULL);
+	ret = acpi_ec_setup(ec, NULL, ACPI_NO_EXEC__REG);
 	if (ret) {
 		acpi_ec_free(ec);
 		goto out;
@@ -1988,6 +1989,23 @@ void __init acpi_ec_ecdt_probe(void)
 	acpi_put_table((struct acpi_table_header *)ecdt_ptr);
 }
 
+void __init acpi_ec_ecdt_exec_reg(void)
+{
+	if (!boot_ec || !boot_ec_is_ecdt)
+		return;
+
+	/*
+	 * Second call, first call is done in acpi_ec_ecdt_probe(), pass
+	 * ACPI_NO_INSTALL_SPACE_HANDLER so as to only exec _REG now that
+	 * the namespace has been setup.
+	 */
+	acpi_install_address_space_handler_flags(boot_ec->handle,
+						 ACPI_ADR_SPACE_EC,
+						 &acpi_ec_space_handler, NULL,
+						 boot_ec,
+						 ACPI_NO_INSTALL_SPACE_HANDLER);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int acpi_ec_suspend(struct device *dev)
 {
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 628bf8f18130..14dce6830e01 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -203,6 +203,7 @@ typedef int (*acpi_ec_query_func) (void *data);
 
 void acpi_ec_init(void);
 void acpi_ec_ecdt_probe(void);
+void acpi_ec_ecdt_exec_reg(void);
 void acpi_ec_dsdt_probe(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
-- 
2.36.0

