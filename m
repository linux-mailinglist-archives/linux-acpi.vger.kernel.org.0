Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6448A178EED
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2020 11:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbgCDKw6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Mar 2020 05:52:58 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64488 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387888AbgCDKw5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2020 05:52:57 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 208bb65062888295; Wed, 4 Mar 2020 11:52:55 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v2 2/6] ACPI: EC: Avoid passing redundant argument to functions
Date:   Wed, 04 Mar 2020 11:45:41 +0100
Message-ID: <2707424.uHLvDKgFoG@kreacher>
In-Reply-To: <2411774.6kdisLRoUK@kreacher>
References: <2094703.CetWLLyMuz@kreacher> <2411774.6kdisLRoUK@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

After commit 406857f773b0 ("ACPI: EC: add support for hardware-reduced
systems") the handle_events argument passed to ec_install_handlers()
and acpi_ec_setup() is redundant, because it is always 'false' when
the device argument passed to them in NULL and it is always 'true'
otherwise, so the device argument can be tested against NULL instead
of testing the handle_events one.

Accordingly, modify ec_install_handlers() and acpi_ec_setup() to take
two arguments and reduce the number of checks in the former.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: No changes.

---
 drivers/acpi/ec.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 2dc7cf2aeb21..3153e7684053 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1476,8 +1476,7 @@ static int install_gpio_irq_event_handler(struct acpi_ec *ec,
  *       handler is not installed, which means "not able to handle
  *       transactions".
  */
-static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
-			       bool handle_events)
+static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
 {
 	acpi_status status;
 
@@ -1507,7 +1506,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
 	}
 
-	if (!handle_events)
+	if (!device)
 		return 0;
 
 	if (!test_bit(EC_FLAGS_QUERY_METHODS_INSTALLED, &ec->flags)) {
@@ -1520,13 +1519,10 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
 	if (!test_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags)) {
 		if (ec->gpe >= 0) {
 			install_gpe_event_handler(ec);
-		} else if (device) {
+		} else {
 			int ret = install_gpio_irq_event_handler(ec, device);
-
 			if (ret)
 				return ret;
-		} else { /* No GPE and no GpioInt? */
-			return -ENODEV;
 		}
 	}
 	/* EC is fully operational, allow queries */
@@ -1574,12 +1570,11 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 	}
 }
 
-static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device,
-			 bool handle_events)
+static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device)
 {
 	int ret;
 
-	ret = ec_install_handlers(ec, device, handle_events);
+	ret = ec_install_handlers(ec, device);
 	if (ret)
 		return ret;
 
@@ -1660,7 +1655,7 @@ static int acpi_ec_add(struct acpi_device *device)
 		}
 	}
 
-	ret = acpi_ec_setup(ec, device, true);
+	ret = acpi_ec_setup(ec, device);
 	if (ret)
 		goto err_query;
 
@@ -1780,7 +1775,7 @@ void __init acpi_ec_dsdt_probe(void)
 	 * At this point, the GPE is not fully initialized, so do not to
 	 * handle the events.
 	 */
-	ret = acpi_ec_setup(ec, NULL, false);
+	ret = acpi_ec_setup(ec, NULL);
 	if (ret) {
 		acpi_ec_free(ec);
 		return;
@@ -1967,7 +1962,7 @@ void __init acpi_ec_ecdt_probe(void)
 	 * At this point, the namespace is not initialized, so do not find
 	 * the namespace objects, or handle the events.
 	 */
-	ret = acpi_ec_setup(ec, NULL, false);
+	ret = acpi_ec_setup(ec, NULL);
 	if (ret) {
 		acpi_ec_free(ec);
 		return;
-- 
2.16.4





