Return-Path: <linux-acpi+bounces-1634-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC697F1CD0
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 19:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1708B20E8B
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 18:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E0E31581
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55A9CF
	for <linux-acpi@vger.kernel.org>; Mon, 20 Nov 2023 09:31:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r587B-0004Xh-CC; Mon, 20 Nov 2023 18:31:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r587A-00AOwQ-7a; Mon, 20 Nov 2023 18:31:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5879-004Wj2-Ue; Mon, 20 Nov 2023 18:31:15 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH] ACPI: APEI: GHES: Convert to platform remove callback returning void
Date: Mon, 20 Nov 2023 18:30:54 +0100
Message-ID: <20231120173053.49597-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3117; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qWXOm6spRSs+mvy3w9SBH5SsGHLmPBD+TbQLmq328Zs=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtTo6WcnPfrS+CXOvCS870E3249Th+clR/ktMbx9Mfx4k sfpVoNZnYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBMxHM+B8Osh53mL64b/mpY +DLzWv9NxbTbfc3GatWB3yRV7aPmTJ4oU7f82RK9JVbVx/hW1y+4Fb5Pf0KHVAT3p+wdxgqu7N9 8PXpXXrzJUrz40jHm0D8fOJlal1X+DLdp4E22D51ewyPx90TQ/Sq7zIMbcnZNPstlpJB0pV2GP3 nmtZTli4U2xudrq/SmHzg70z3GVKva5E2xd+scWeupm9M+zO8oz+i14ph1oYmVOeZdrEHs+Qepb Wftw1+GFc8w7dnx3ZTd+PfBw+bS2b9sVnNYXhMXPt121iaSK3bhwuiivdLqRp/cEz77+j99ahB1 KPVzTMPC4ryd5x8qXnUT8W+IMc8KSghR27+g12p1HGs+AA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Instead of returning an error code, emit a better error message than the
core. Apart from the improved error message this patch has no effects
for the driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I tried to improve this driver before, see

	https://lore.kernel.org/linux-acpi/CAJZ5v0ifb-wvyp0JRq_4c1L6vTi_qEeXJ6P=Pmmq_56xRL74_A@mail.gmail.com
	https://lore.kernel.org/linux-arm-kernel/20221219221439.1681770-1-u.kleine-koenig@pengutronix.de
	https://lore.kernel.org/linux-arm-kernel/20221220154447.12341-1-u.kleine-koenig@pengutronix.de

but this didn't result in any patch being applied.

I think it's inarguable that there is a problem that wants to be fixed.
My tries to fix this problem fixxled out, so here comes a minimal change
that just points out the problem and otherwise makes ghes_remove()
return void without further side effects to allow me to continue my
quest to make platform_driver remove callbacks return no error.

Best regards
Uwe

 drivers/acpi/apei/ghes.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 63ad0541db38..dd8cd10b7809 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1438,7 +1438,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	return rc;
 }
 
-static int ghes_remove(struct platform_device *ghes_dev)
+static void ghes_remove(struct platform_device *ghes_dev)
 {
 	int rc;
 	struct ghes *ghes;
@@ -1475,8 +1475,15 @@ static int ghes_remove(struct platform_device *ghes_dev)
 		break;
 	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
 		rc = apei_sdei_unregister_ghes(ghes);
-		if (rc)
-			return rc;
+		if (rc) {
+			/*
+			 * Returning early results in a resource leak, but we're
+			 * only here if stopping the hardware failed.
+			 */
+			dev_err(&ghes_dev->dev, "Failed to unregister ghes (%pe)\n",
+				ERR_PTR(rc));
+			return;
+		}
 		break;
 	default:
 		BUG();
@@ -1490,8 +1497,6 @@ static int ghes_remove(struct platform_device *ghes_dev)
 	mutex_unlock(&ghes_devs_mutex);
 
 	kfree(ghes);
-
-	return 0;
 }
 
 static struct platform_driver ghes_platform_driver = {
@@ -1499,7 +1504,7 @@ static struct platform_driver ghes_platform_driver = {
 		.name	= "GHES",
 	},
 	.probe		= ghes_probe,
-	.remove		= ghes_remove,
+	.remove_new	= ghes_remove,
 };
 
 void __init acpi_ghes_init(void)

base-commit: 5a82d69d48c82e89aef44483d2a129f869f3506a
-- 
2.42.0


