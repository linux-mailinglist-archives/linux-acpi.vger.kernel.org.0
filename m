Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1F25FD541
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Oct 2022 08:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJMGxw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Oct 2022 02:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJMGxv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Oct 2022 02:53:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113B9326D5
        for <linux-acpi@vger.kernel.org>; Wed, 12 Oct 2022 23:53:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ois5w-0002d0-KZ; Thu, 13 Oct 2022 08:53:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ois5v-001EpY-KH; Thu, 13 Oct 2022 08:53:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ois5u-007cJP-Tk; Thu, 13 Oct 2022 08:53:26 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/2] ACPI: APEI: Warn loudly on unsuccessful driver unbind
Date:   Thu, 13 Oct 2022 08:44:59 +0200
Message-Id: <20221013064459.121933-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221013064459.121933-1-u.kleine-koenig@pengutronix.de>
References: <20221013064459.121933-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1957; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=atVJuSjcVnfDbW/uDQEir6CC+1Y9UD9A/dVOx9diJ1g=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjR7PnEiDIp11f+0Nawz4yaY1JubYJGw1j8T2wSvuW mw/12JKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY0ez5wAKCRDB/BR4rcrsCTEYB/ 4piJmq5j181mzKeFR1rGU60K2imMQhByOddMzR7SQMGfknFMjHXAqy+mVZX9tKCtuFx4ugXDhwb+OR yyFr1EPjfcADt5/DLNNmkLiSivVL687bWJUF0MFUEICcBYR3epMA37CPaYTpEnwXGmruHzs3pcIuQy oM3uFDj0QTm6ydwt806v6G0ufVN5pPXak4Jr8z52yV5urlRtTGdAovCtorVMa1NnNCRh3CmhUyb8I/ qlzVSJN6ZNzaPB2wX/MocUJKw2IIuNCUu5Ljil2Ov6ib6N4oH1k3omLcRmys3kDE7p//bsGkKFh+nA aAFCcSv4KpLd+/wOZthlO5YRn/oeBa
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

If the remove callback failed, it leaves some unfreed resources behind
that will never be cleared. I didn't manage to understand the driver
good enough to judge how critical that really is.

This patch is part of an effort to change the remove callbacks for
platform devices to return void in the hope this will prevent the wrong
assumption that returning an error code from .remove() is proper error
handling.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/acpi/apei/ghes.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

Hello,

on a side note: The remove callback calls (in some cases) free_irq() for
a shared interrupt. A requirement in this case is to disable the
device's interrupt beforehand. It's not obvious (to me that is) that
said irq is disabled here. This is another opportunity for ugly things
to happen.

Best regards
Uwe

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 307fbb97a116..78d2e4df74ee 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1393,7 +1393,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	return rc;
 }
 
-static int ghes_remove(struct platform_device *ghes_dev)
+static int _ghes_remove(struct platform_device *ghes_dev)
 {
 	int rc;
 	struct ghes *ghes;
@@ -1447,6 +1447,21 @@ static int ghes_remove(struct platform_device *ghes_dev)
 	return 0;
 }
 
+static int ghes_remove(struct platform_device *ghes_dev)
+{
+	/*
+	 * If _ghes_remove() returns an error, we're in trouble. Some of the
+	 * cleanup was skipped then and this will never be catched up. So some
+	 * resources will stay around, maybe even used although the platform
+	 * device will be gone.
+	 */
+	int err = _ghes_remove(ghes_dev);
+
+	WARN_ON(err);
+
+	return 0;
+}
+
 static struct platform_driver ghes_platform_driver = {
 	.driver		= {
 		.name	= "GHES",
-- 
2.37.2

