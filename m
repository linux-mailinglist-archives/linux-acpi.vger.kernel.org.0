Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C574172B08
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2020 23:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgB0WZW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Feb 2020 17:25:22 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44163 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbgB0WZW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Feb 2020 17:25:22 -0500
Received: from 79.184.237.30.ipv4.supernova.orange.pl (79.184.237.30) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id c5af9dd566d2263a; Thu, 27 Feb 2020 23:25:20 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 1/6] ACPI: EC: Avoid printing confusing messages in  acpi_ec_setup()
Date:   Thu, 27 Feb 2020 23:21:18 +0100
Message-ID: <2905294.VeAyQmVl7x@kreacher>
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

It doesn't really make sense to pass ec->handle of the ECDT EC to
acpi_handle_info(), because it is set to ACPI_ROOT_OBJECT in
acpi_ec_ecdt_probe(), so rework acpi_ec_setup() to avoid using
acpi_handle_info() for printing messages.

First, notice that the "Used as first EC" message is not really
useful, because it is immediately followed by a more meaningful one
from either acpi_ec_ecdt_probe() or acpi_ec_dsdt_probe() (the latter
also includes the EC object path), so drop it altogether.

Second, use pr_info() for printing the EC configuration information.

While at it, make the code in question avoid printing invalid GPE or
IRQ numbers and make it print the GPE/IRQ information only when the
driver is ready to handle events.

Fixes: 72c77b7ea9ce ("ACPI / EC: Cleanup first_ec/boot_ec code")
Fixes: 406857f773b0 ("ACPI: EC: add support for hardware-reduced systems")
Cc: 5.5+ <stable@vger.kernel.org> # 5.5+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index d1f1cf5d4bf0..2dc7cf2aeb21 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1584,14 +1584,19 @@ static int acpi_ec_setup(struct acpi_ec *ec, struct acpi_device *device,
 		return ret;
 
 	/* First EC capable of handling transactions */
-	if (!first_ec) {
+	if (!first_ec)
 		first_ec = ec;
-		acpi_handle_info(first_ec->handle, "Used as first EC\n");
+
+	pr_info("EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n", ec->command_addr,
+		ec->data_addr);
+
+	if (test_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags)) {
+		if (ec->gpe >= 0)
+			pr_info("GPE=0x%x\n", ec->gpe);
+		else
+			pr_info("IRQ=%d\n", ec->irq);
 	}
 
-	acpi_handle_info(ec->handle,
-			 "GPE=0x%x, IRQ=%d, EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n",
-			 ec->gpe, ec->irq, ec->command_addr, ec->data_addr);
 	return ret;
 }
 
-- 
2.16.4





