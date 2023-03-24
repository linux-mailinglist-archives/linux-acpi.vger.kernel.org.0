Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B826C7AE3
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Mar 2023 10:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjCXJKb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Mar 2023 05:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCXJKW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 05:10:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4D11D931
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 02:10:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfdQx-00028X-M7; Fri, 24 Mar 2023 10:10:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfdQw-006Lek-87; Fri, 24 Mar 2023 10:10:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfdQv-007Yh5-Hq; Fri, 24 Mar 2023 10:10:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        kernel@pengutronix.de, Pierre Asselin <pa@panix.com>
Subject: [PATCH] ACPI: bus: Only call notify for a completely bound ACPI device
Date:   Fri, 24 Mar 2023 10:09:55 +0100
Message-Id: <20230324090955.462581-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2492; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+1ASVMWYoTJJSET7TofNOtXqzWIt5AluaMDYWDrOPD4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkHWjixgPHIDwmgaWGQ05L4PDc9Q/Ph/JZPTshl 2FUBHH2isqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZB1o4gAKCRCPgPtYfRL+ TvkOCACILlEc+n2fYlG9XAPm3ulSluBx3L7CSaq4P8Q14cE0YQEJj/CedZ+6JfMakolnAiSUfA6 1lL6Tppqpd1Ue7CQX79YsWG+W/kWarIM/tPVOe7VOejqOnOZRf0DCbRWr4t2pxIH/2l5X5oyQWP tc9TiMcj3ZJ4dPS3HCEokGsifTTWC0/R5jIE+PneMUF0JrxjLe34n9rIzfmSAWpX28xxxwFc1rw cf0WLsMNK4NJtz4xjQjGmIMKPAb0VdQj3oJbnlfmJK6nltWRhhkNtpp/E1hiPCxg2mEVfjywLs7 mdBcYL2O6GFQ9OJw5qjJESI06dj0URRkb92phcLioVxQiIH0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit d6fb6ee1820c ("ACPI: bus: Drop driver member of struct
acpi_device") removed acpi_device::driver in favour of struct
acpi_device::dev.driver.

However there is a problem: While the two pointers are equivalent after
the device is completely probed, there is a small time frame where
acpi_device::dev->driver is already set but acpi_device::driver wasn't.

The function acpi_bus_notify() used to have a check for
acpi_device::driver that was changed to a check for adev->dev.driver in
Commit d6fb6ee1820c.

Pierre Asselin reports that starting with above change his laptop
crashed during boot when on AC power. That's because acpi_bus_notify()
is called in that small time frame (triggered by acpi_ac_add()) which
results in a call to acpi_ac_notify while this function isn't ready yet.

So in acpi_bus_notify() check for the device being bound (which becomes
true only after the acpi probe call succeeds) instead of for
acpi_device::dev.driver.

Note that usually you have to hold the device lock to call
device_is_bound(). I don't think this is the case here, so there likely
is a race condition. The problem might be that the driver unbinds after
the check but before adev->dev.driver is evaluated. However this race
already existed before commit d6fb6ee1820c, so the change here is a net
improvement even though it might not result in a completely correct
handling.

A similar check in the acpi sysfs code is also converted. This is less
critical as it happens in code that is run when a sysfs file is
accessed. That shouldn't happen for a device that isn't bound.

Fixes: d6fb6ee1820c ("ACPI: bus: Drop driver member of struct acpi_device")
Reported-by: Pierre Asselin <pa@panix.com>
Link: https://lore.kernel.org/linux-acpi/9f6cba7a8a57e5a687c934e8e406e28c.squirrel@mail.panix.com
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/acpi/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9531dd0fef50..a5a8f82981ce 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -518,7 +518,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	if (!adev)
 		goto err;
 
-	if (adev->dev.driver) {
+	if (device_is_bound(&adev->dev)) {
 		struct acpi_driver *driver = to_acpi_driver(adev->dev.driver);
 
 		if (driver && driver->ops.notify &&

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

