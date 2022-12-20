Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD06E6523E6
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Dec 2022 16:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiLTPpW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Dec 2022 10:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiLTPo6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Dec 2022 10:44:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484A313CEF
        for <linux-acpi@vger.kernel.org>; Tue, 20 Dec 2022 07:44:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7enX-0007UU-Gq; Tue, 20 Dec 2022 16:44:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7enU-000bR9-D9; Tue, 20 Dec 2022 16:44:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p7enT-006duA-Ld; Tue, 20 Dec 2022 16:44:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, kernel@pengutronix.de,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Subject: [PATCH v2] firmware: arm_sdei: Make sdei_unregister_ghes() return void
Date:   Tue, 20 Dec 2022 16:44:47 +0100
Message-Id: <20221220154447.12341-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4590; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4gOO2k5Q3IZ26mNRtyWcfVI5xbazilOqZwSKb8gTxFc=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjodhmwLoABNrUBkj8SpsB+ZjKC8/4nPtw133jOMFE nT090P2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY6HYZgAKCRDB/BR4rcrsCbN7B/ 9RdMvScfNuYbbXfcJR58aVVw/PLlF4pb5hxwkNjU1XIw+lncBveIsuKzjbGxt3lBpna9OFuAhIuqOP oD5Qi84hBv62jXwYzacJydVqUN4W9Ltyaj0zUSZQZ3b4rRSfB9vCjiasmmvs4B7W8typmOHDOrHncB 4b02C2VYa2RfZ0/oG1Br9++2V/bUW3lO4U+H7vYuxI82WEWJEHW1l4VK8OTHPVixjsLFE6sD5l761N vlaM7JMcBUNugUtZeO1oU8ULEGlRoxeM5/kU2rtneUlq+kRH6GU68MJ6NKa3hBGGzMSPLFcvvAbyyI BULC5t6VSYl5fmOEC71c/KPDv0O2+w
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Unregistering a ghes shouldn't fail (because how can firmware refuse to
disable an event on unregister). And the callers are not really in a
position to handle errors. (Note: The return value of platform remove
callbacks is ignored.) So make sdei_unregister_ghes() return void and
add warnings at the few locations that can theoretically fail.

!IS_ENABLED(CONFIG_ACPI_APEI_GHES) and
!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE) cannot be hit here, because if
these aren't given, ghex_probe() already fails and so ghes_remove()
isn't called.

This change improves the behaviour in the error case. Without it the
platform code emits a very generic (and so very unhelpful) error
message. Now the warning is at least helpful.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

Changes since (implicit) v1: Add the if (...) BUG() part to fix a linker
error with CONFIG_ARM_SDE_INTERFACE disabled.

Best regards
Uwe

 drivers/acpi/apei/ghes.c    | 19 ++++++++++++-------
 drivers/firmware/arm_sdei.c | 14 +++++++-------
 include/linux/arm_sdei.h    |  2 +-
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 066dc1f5c235..7d705930e21b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1275,12 +1275,20 @@ static int apei_sdei_register_ghes(struct ghes *ghes)
 				 ghes_sdei_critical_callback);
 }
 
-static int apei_sdei_unregister_ghes(struct ghes *ghes)
+static void apei_sdei_unregister_ghes(struct ghes *ghes)
 {
+	/*
+	 * If CONFIG_ARM_SDE_INTERFACE isn't enabled apei_sdei_register_ghes()
+	 * cannot have been called successfully. So ghes_remove() won't be
+	 * called because either ghes_probe() failed or the notify type isn't
+	 * ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED.
+	 * Note the if statement below is necessary to prevent a linker error as
+	 * the compiler has no chance to understand the above correlation.
+	 */
 	if (!IS_ENABLED(CONFIG_ARM_SDE_INTERFACE))
-		return -EOPNOTSUPP;
+		BUG();
 
-	return sdei_unregister_ghes(ghes);
+	sdei_unregister_ghes(ghes);
 }
 
 static int ghes_probe(struct platform_device *ghes_dev)
@@ -1421,7 +1429,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 static int ghes_remove(struct platform_device *ghes_dev)
 {
-	int rc;
 	struct ghes *ghes;
 	struct acpi_hest_generic *generic;
 
@@ -1455,9 +1462,7 @@ static int ghes_remove(struct platform_device *ghes_dev)
 		ghes_nmi_remove(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
-		rc = apei_sdei_unregister_ghes(ghes);
-		if (rc)
-			return rc;
+		apei_sdei_unregister_ghes(ghes);
 		break;
 	default:
 		BUG();
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 1e1a51510e83..7af619464183 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -889,7 +889,7 @@ int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
 	return err;
 }
 
-int sdei_unregister_ghes(struct ghes *ghes)
+void sdei_unregister_ghes(struct ghes *ghes)
 {
 	int i;
 	int err;
@@ -897,16 +897,15 @@ int sdei_unregister_ghes(struct ghes *ghes)
 
 	might_sleep();
 
-	if (!IS_ENABLED(CONFIG_ACPI_APEI_GHES))
-		return -EOPNOTSUPP;
-
 	/*
 	 * The event may be running on another CPU. Disable it
 	 * to stop new events, then try to unregister a few times.
 	 */
 	err = sdei_event_disable(event_num);
-	if (err)
-		return err;
+	if (err) {
+		dev_warn(ghes->dev, "Failed to disable event %u: %pe\n", event_num, ERR_PTR(err));
+		return;
+	}
 
 	for (i = 0; i < 3; i++) {
 		err = sdei_event_unregister(event_num);
@@ -916,7 +915,8 @@ int sdei_unregister_ghes(struct ghes *ghes)
 		schedule();
 	}
 
-	return err;
+	if (err)
+		dev_warn(ghes->dev, "Failed to disable event %u: %pe\n", event_num, ERR_PTR(err));
 }
 
 static int sdei_get_conduit(struct platform_device *pdev)
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 14dc461b0e82..0812af4530a4 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -40,7 +40,7 @@ int sdei_event_disable(u32 event_num);
 /* GHES register/unregister helpers */
 int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
 		       sdei_event_callback *critical_cb);
-int sdei_unregister_ghes(struct ghes *ghes);
+void sdei_unregister_ghes(struct ghes *ghes);
 
 #ifdef CONFIG_ARM_SDE_INTERFACE
 /* For use by arch code when CPU hotplug notifiers are not appropriate. */
-- 
2.38.1

