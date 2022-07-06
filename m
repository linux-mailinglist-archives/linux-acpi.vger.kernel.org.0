Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841A2569323
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jul 2022 22:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiGFUOX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jul 2022 16:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiGFUOW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jul 2022 16:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAEBA1018
        for <linux-acpi@vger.kernel.org>; Wed,  6 Jul 2022 13:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657138460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ti+nZsEOP1Aj3/9iJ9rsuq04U1ZpFkFYqRwK0yE0Yks=;
        b=d03UMcrHGH9d3eMsEZCns63vT5cIfhtf62Hy+ZNKEAgakvatWek0gXxIdlWKjaMwpjBXy6
        jmcKZEMqpAW9p+htXH4iBhcvC0JeC62j/AQfN4JLm+YFEm8LUnwgRD9NUEU+IEQGaFwuEL
        3f8FQn/gmzq3wN7Q226sDKImCHSvAXI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-6nrN2FaEN9i37Rh1XeSaaQ-1; Wed, 06 Jul 2022 16:14:16 -0400
X-MC-Unique: 6nrN2FaEN9i37Rh1XeSaaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 129CC29AA2FB;
        Wed,  6 Jul 2022 20:14:16 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94866140EBE3;
        Wed,  6 Jul 2022 20:14:14 +0000 (UTC)
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
Subject: [RFC v2 2/2] ACPI: EC: fix ECDT probe ordering issues
Date:   Wed,  6 Jul 2022 22:14:10 +0200
Message-Id: <20220706201410.88244-3-hdegoede@redhat.com>
In-Reply-To: <20220706201410.88244-1-hdegoede@redhat.com>
References: <20220706201410.88244-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI-2.0 says that the EC OpRegion handler must be available immediately
(like the standard default OpRegion handlers):

Quoting from the ACPI spec version 6.3: "6.5.4 _REG (Region) ...
2. OSPM must make Embedded Controller operation regions, accessed via
the Embedded Controllers described in ECDT, available before executing
any control method. These operation regions may become inaccessible
after OSPM runs _REG(EmbeddedControl, 0)."

So acpi_bus_init() calls acpi_ec_ecdt_probe(), which calls
acpi_install_address_space_handler() to install the EC's OpRegion
handler, early on.

This not only installs the OpRegion handler, but also calls the EC's
_REG method. The _REG method call is a problem because it may rely on
initialization done by the _INI methods of one of the PCI / _SB root devs,
see for example: https://bugzilla.kernel.org/show_bug.cgi?id=214899 .

Generally speaking _REG methods are executed when the ACPI-device they
are part of has a driver bound to it. Where as _INI methods must be
executed at table load time (according to the spec). The problem here
is that the early acpi_install_address_space_handler() call causes
the _REG handler to run too early.

To allow fixing this the ACPICA code now allows to split the OpRegion
handler installation and the executing of _REG into 2 separate steps.

This commit uses this ACPICA functionality to fix the EC probe ordering
by delaying the executing of _REG for ECDT described ECs till the matching
EC device in the DSDT gets parsed and acpi_ec_add() for it gets called.
This moves the calling of _REG for the EC on devices with an ECDT to
the same point in time where it is called on devices without an ECDT table.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214899
Reported-and-tested-by: Johannes Penßel <johannespenssel@posteo.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/ec.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c95e535035a0..1e93677e4b82 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -94,6 +94,7 @@ enum {
 	EC_FLAGS_QUERY_ENABLED,		/* Query is enabled */
 	EC_FLAGS_EVENT_HANDLER_INSTALLED,	/* Event handler installed */
 	EC_FLAGS_EC_HANDLER_INSTALLED,	/* OpReg handler installed */
+	EC_FLAGS_EC_REG_CALLED,		/* OpReg ACPI _REG method called */
 	EC_FLAGS_QUERY_METHODS_INSTALLED, /* _Qxx handlers installed */
 	EC_FLAGS_STARTED,		/* Driver is started */
 	EC_FLAGS_STOPPED,		/* Driver is stopped */
@@ -1450,6 +1451,7 @@ static bool install_gpio_irq_event_handler(struct acpi_ec *ec)
  * ec_install_handlers - Install service callbacks and register query methods.
  * @ec: Target EC.
  * @device: ACPI device object corresponding to @ec.
+ * @call_reg: If _REG should be called to notify OpRegion availability
  *
  * Install a handler for the EC address space type unless it has been installed
  * already.  If @device is not NULL, also look for EC query methods in the
@@ -1462,7 +1464,8 @@ static bool install_gpio_irq_event_handler(struct acpi_ec *ec)
  * -EPROBE_DEFER if GPIO IRQ acquisition needs to be deferred,
  * or 0 (success) otherwise.
  */
-static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
+static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
+			       bool call_reg)
 {
 	acpi_status status;
 
@@ -1470,10 +1473,11 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
 
 	if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
 		acpi_ec_enter_noirq(ec);
-		status = acpi_install_address_space_handler(ec->handle,
-							    ACPI_ADR_SPACE_EC,
-							    &acpi_ec_space_handler,
-							    NULL, ec);
+		status = acpi_install_address_space_handler_flags(ec->handle,
+								  ACPI_ADR_SPACE_EC,
+								  &acpi_ec_space_handler,
+								  NULL, ec,
+								  ACPI_NO_EXEC__REG);
 		if (ACPI_FAILURE(status)) {
 			acpi_ec_stop(ec, false);
 			return -ENODEV;
@@ -1481,6 +1485,15 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
 		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
 	}
 
+	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
+		acpi_install_address_space_handler_flags(ec->handle,
+							 ACPI_ADR_SPACE_EC,
+							 &acpi_ec_space_handler,
+							 NULL, ec,
+							 ACPI_NO_INSTALL_SPACE_HANDLER);
+		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
+	}
+
 	if (!device)
 		return 0;
 
@@ -1566,11 +1579,11 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 	}
 }
 
-static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device)
+static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device, bool call_reg)
 {
 	int ret;
 
-	ret = ec_install_handlers(ec, device);
+	ret = ec_install_handlers(ec, device, call_reg);
 	if (ret)
 		return ret;
 
@@ -1635,7 +1648,7 @@ static int acpi_ec_add(struct acpi_device *device)
 		}
 	}
 
-	ret = acpi_ec_setup(ec, device);
+	ret = acpi_ec_setup(ec, device, true);
 	if (ret)
 		goto err;
 
@@ -1755,7 +1768,7 @@ void __init acpi_ec_dsdt_probe(void)
 	 * At this point, the GPE is not fully initialized, so do not to
 	 * handle the events.
 	 */
-	ret = acpi_ec_setup(ec, NULL);
+	ret = acpi_ec_setup(ec, NULL, true);
 	if (ret) {
 		acpi_ec_free(ec);
 		return;
@@ -1939,7 +1952,7 @@ void __init acpi_ec_ecdt_probe(void)
 	 * At this point, the namespace is not initialized, so do not find
 	 * the namespace objects, or handle the events.
 	 */
-	ret = acpi_ec_setup(ec, NULL);
+	ret = acpi_ec_setup(ec, NULL, false);
 	if (ret) {
 		acpi_ec_free(ec);
 		goto out;
-- 
2.36.0

