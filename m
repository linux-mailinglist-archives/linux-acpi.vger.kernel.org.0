Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8FA55043A
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Jun 2022 13:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiFRLXm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 18 Jun 2022 07:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiFRLX3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Jun 2022 07:23:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965CA23BC1
        for <linux-acpi@vger.kernel.org>; Sat, 18 Jun 2022 04:23:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2WXv-0006pX-Lg; Sat, 18 Jun 2022 13:23:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2WXt-001F1T-3P; Sat, 18 Jun 2022 13:23:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o2WXt-00HA08-Rv; Sat, 18 Jun 2022 13:23:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org, kernel@pengutronix.de
Subject: [PATCH 1/2] ACPI: Drop redundant check in acpi_device_remove()
Date:   Sat, 18 Jun 2022 13:23:10 +0200
Message-Id: <20220618112311.14661-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; h=from:subject; bh=Jzu8Jg49n8C1110sIjZRzyLAF00kFE/+CUV+YhfazxU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBirbWVQdTsIuTPNa/ZfKhI/f1MCHVob3QE/EMaDRL6 XTN1wnqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYq21lQAKCRDB/BR4rcrsCbezB/ 9pM8J4dS/cUzPGwm3aaZ/dlVMfTWTix5SyDHUjI1M08bGyTGR7d7Yz4ZlLlgPqofsuNHnu4uABM+21 m0SbfMDfu3EQFZgMFF7dcRucTMhWhD8gpCuPW+UI82oTh7nfSLpO+VsOK6Nfmw9iGjpDvPGduqNAdD r6w81xSFvB7eExaMf+kSs6NeSD+kjaROsDO3J1MR+v1szp3c2HJvVY40jXoAbg/Spj/g8a8pdflvrM XlAtVCv9qqHgrZD6uVhE2IRh4l8u6INpsa1TXGXnfRaYTTyRAjU75GZfvIJrI6gWA3GkCsXNugMsJY FFHDsexNH3FLp1PnBpla+2JwYPtelh
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A bus remove callback is only ever called by the device core with a
bound driver. So there is no need to check if the driver is non-NULL.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/acpi/bus.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 86fa61a21826..67a3f8cf42f9 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1062,12 +1062,11 @@ static void acpi_device_remove(struct device *dev)
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 	struct acpi_driver *acpi_drv = acpi_dev->driver;
 
-	if (acpi_drv) {
-		if (acpi_drv->ops.notify)
-			acpi_device_remove_notify_handler(acpi_dev);
-		if (acpi_drv->ops.remove)
-			acpi_drv->ops.remove(acpi_dev);
-	}
+	if (acpi_drv->ops.notify)
+		acpi_device_remove_notify_handler(acpi_dev);
+	if (acpi_drv->ops.remove)
+		acpi_drv->ops.remove(acpi_dev);
+
 	acpi_dev->driver = NULL;
 	acpi_dev->driver_data = NULL;
 

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

