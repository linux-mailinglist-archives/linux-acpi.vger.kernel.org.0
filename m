Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7BA5BBAC5
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Sep 2022 23:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiIQV5D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 17 Sep 2022 17:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQV5C (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Sep 2022 17:57:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F327176
        for <linux-acpi@vger.kernel.org>; Sat, 17 Sep 2022 14:57:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZfnt-0004cL-AR; Sat, 17 Sep 2022 23:56:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZfnt-001Lj2-V6; Sat, 17 Sep 2022 23:56:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZfnr-001aw8-HV; Sat, 17 Sep 2022 23:56:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] ACPI: fan: Reorder symbols to get rid of a few forward declarations
Date:   Sat, 17 Sep 2022 23:56:22 +0200
Message-Id: <20220917215622.342912-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2540; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5UBymiGpCzJhyGvtBiTP3nYT+pVk61ooJjn7jF0XGJk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjJkKBLSugUGVM+ISGG6Hqf88pzROhfX66awu9W5ie iXiuGpSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYyZCgQAKCRDB/BR4rcrsCUnOB/ sFx4fKMft2DNGkOELlDe27rHRVG4NG6EPPtVnkNvfO6Qcjcd8YUSxoqjmHCQqhA36HxzLBGRKYkMJb Sf/O8IorIvgVKBd74UAg7QN2NHYx8bW/0EHgf9HPiPrauMgZsy/RaabJ+DLhtUwM+NmHxONZJNbgXP eVkx3oJ1XJFutvLtuyiW1IDpqYgwq/ibMtZxzDWmmPB/3ULsY2xCmLd13thB5spg5N9fs1BSnhAFTI IMhfSxZk15TnABTV7A1vJNCNP+dcVBIfR4FfkuEV2hLNBrYezf+yQ6mvK9yYkaF9dHVRa1jadnO0GI SlFv3WJtPdldablpfFs++QvMWB3leO
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Having the driver struct at the end of the file isn't only more usual, it
also allows to drop a few forward declarations which are just useless
repetition.

While at it also move the MODULE_... macros to the end of the file.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/acpi/fan_core.c | 58 +++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index b9a9a59ddcc1..52a0b303b70a 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -19,43 +19,12 @@
 
 #include "fan.h"
 
-MODULE_AUTHOR("Paul Diefenbaugh");
-MODULE_DESCRIPTION("ACPI Fan Driver");
-MODULE_LICENSE("GPL");
-
-static int acpi_fan_probe(struct platform_device *pdev);
-static int acpi_fan_remove(struct platform_device *pdev);
-
 static const struct acpi_device_id fan_device_ids[] = {
 	ACPI_FAN_DEVICE_IDS,
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, fan_device_ids);
 
-#ifdef CONFIG_PM_SLEEP
-static int acpi_fan_suspend(struct device *dev);
-static int acpi_fan_resume(struct device *dev);
-static const struct dev_pm_ops acpi_fan_pm = {
-	.resume = acpi_fan_resume,
-	.freeze = acpi_fan_suspend,
-	.thaw = acpi_fan_resume,
-	.restore = acpi_fan_resume,
-};
-#define FAN_PM_OPS_PTR (&acpi_fan_pm)
-#else
-#define FAN_PM_OPS_PTR NULL
-#endif
-
-static struct platform_driver acpi_fan_driver = {
-	.probe = acpi_fan_probe,
-	.remove = acpi_fan_remove,
-	.driver = {
-		.name = "acpi-fan",
-		.acpi_match_table = fan_device_ids,
-		.pm = FAN_PM_OPS_PTR,
-	},
-};
-
 /* thermal cooling device callbacks */
 static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned long
 			     *state)
@@ -459,6 +428,33 @@ static int acpi_fan_resume(struct device *dev)
 
 	return result;
 }
+
+static const struct dev_pm_ops acpi_fan_pm = {
+	.resume = acpi_fan_resume,
+	.freeze = acpi_fan_suspend,
+	.thaw = acpi_fan_resume,
+	.restore = acpi_fan_resume,
+};
+#define FAN_PM_OPS_PTR (&acpi_fan_pm)
+
+#else
+
+#define FAN_PM_OPS_PTR NULL
+
 #endif
 
+static struct platform_driver acpi_fan_driver = {
+	.probe = acpi_fan_probe,
+	.remove = acpi_fan_remove,
+	.driver = {
+		.name = "acpi-fan",
+		.acpi_match_table = fan_device_ids,
+		.pm = FAN_PM_OPS_PTR,
+	},
+};
+
 module_platform_driver(acpi_fan_driver);
+
+MODULE_AUTHOR("Paul Diefenbaugh");
+MODULE_DESCRIPTION("ACPI Fan Driver");
+MODULE_LICENSE("GPL");
-- 
2.37.2

