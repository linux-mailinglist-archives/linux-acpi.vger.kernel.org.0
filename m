Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BAE5FF201
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Oct 2022 18:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJNQGp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Oct 2022 12:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJNQGp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Oct 2022 12:06:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB719420A
        for <linux-acpi@vger.kernel.org>; Fri, 14 Oct 2022 09:06:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ojNCd-0001FW-1f; Fri, 14 Oct 2022 18:06:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ojNCb-001W1F-PY; Fri, 14 Oct 2022 18:06:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ojNCb-007w70-3S; Fri, 14 Oct 2022 18:06:25 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH] ACPI: AGDI: Improve error reporting for problems during .remove()
Date:   Fri, 14 Oct 2022 18:06:23 +0200
Message-Id: <20221014160623.467195-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bcSCjGDaMicMoVHsmrxJg21//gzyQbiwls29wgz3bJs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjSYj7fZ5B6M0Qx5T1rmKYuU/r8Tlet1+bduZ8O2Us j8dRyp+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY0mI+wAKCRDB/BR4rcrsCemXB/ 9xw8DkVVaQBm/4NUA+JJZ8ee+nLh/UGXezwD62uXtTRmoF8zzCYRG5e7BvZWphXmoKSRR+1ACeotta iQRg135YS9On0dS2kYfPqtoQss3El5BLYTIu2UavHVnX/O11lMroJUj+r8TYi4Iv9+GY6LCCLPc0ch VF3MvrcPxLrN4f79fV7HqM5Sfu9NoikyxXvTBE5Ng/au0/zdF2bNYO4WBIbk7IGM2uIFNuAZekWFcR tIAfIu6RhNl962PBKPMKcNpT8FOV3RXwdA6uOEpxz3y0Y8GQKqCd8tbFq/5hiPlmA4/02Kqn4VvKRV uP1jUM3VG/O9Q20fF++yWwlPL/cLb9
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

Returning an error value in a platform driver's remove callback results in
a generic error message being emitted by the driver core, but otherwise it
doesn't make a difference. The device goes away anyhow.

So instead of triggering the generic platform error message, emit a more
helpful message if a problem occurs and return 0 to suppress the generic
message.

This patch is a preparation for making platform remove callbacks return
void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

note that in the situations where the driver returned an error before
and now emits a message, there is a resource leak. Someone who knows
more about this driver and maybe even can test stuff, might want to
address this. This might not only be about non-freed memory, the device
disappears but it is kept in sdei_list and so might be used after being
gone.

Best regards
Uwe

 drivers/acpi/arm64/agdi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
index cf31abd0ed1b..f605302395c3 100644
--- a/drivers/acpi/arm64/agdi.c
+++ b/drivers/acpi/arm64/agdi.c
@@ -64,8 +64,11 @@ static int agdi_remove(struct platform_device *pdev)
 	int err, i;
 
 	err = sdei_event_disable(adata->sdei_event);
-	if (err)
-		return err;
+	if (err) {
+		dev_err(&pdev->dev, "Failed to disable sdei-event #%d (%pe)\n",
+			adata->sdei_event, ERR_PTR(err));
+		return 0;
+	}
 
 	for (i = 0; i < 3; i++) {
 		err = sdei_event_unregister(adata->sdei_event);
@@ -75,7 +78,11 @@ static int agdi_remove(struct platform_device *pdev)
 		schedule();
 	}
 
-	return err;
+	if (err)
+		dev_err(&pdev->dev, "Failed to unregister sdei-event #%d (%pe)\n",
+			adata->sdei_event, ERR_PTR(err));
+
+	return 0;
 }
 
 static struct platform_driver agdi_driver = {

base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.37.2

