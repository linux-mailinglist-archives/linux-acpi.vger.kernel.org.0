Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1F55FD540
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Oct 2022 08:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJMGxw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Oct 2022 02:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJMGxv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Oct 2022 02:53:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338C73B943
        for <linux-acpi@vger.kernel.org>; Wed, 12 Oct 2022 23:53:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ois5w-0002cz-KU; Thu, 13 Oct 2022 08:53:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ois5u-001EpU-On; Thu, 13 Oct 2022 08:53:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ois5t-007cJL-VJ; Thu, 13 Oct 2022 08:53:25 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/2] ACPI: APEI: Drop unsetting driver data on remove
Date:   Thu, 13 Oct 2022 08:44:58 +0200
Message-Id: <20221013064459.121933-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=725; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=T8a43Sp/M4ss1s8Yzq+/Dccpmu46VlGb82k1gc0LM/U=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjR7Pj+Fh5YdtFb4xB/WS5KXM668BWmME0t8XosfRU aLxseb2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY0ez4wAKCRDB/BR4rcrsCcPvB/ 40O8aLFFo0aLCp49G5Txz0VlMr917e7YMBMIEd0BgIj4ka7aam82sqV82AJBylk59h+DW20eMvpKGA YjArknCgKqry2wVPxoi4OxUoqNCkHPrDs+OSnHmyg0qLJc/2jnhj4wUgp8ZTQzCe1/nYfn/6MC/eca jM9CrZinVYEdypuSN/7br9oXAOTUNlBKoFOlEGdFHv42ZOJcJkolIZx9B82CR3+EVZqNTcm4KvbugK suxrMe9oNoC5lOAuwBUGB3WFlgR1vmLKm3LIMNT/h5MD5+5zOJtrt/lMLs4b30pmUaiTssTt96g4c3 yBGViKCfAZ9xERR3VAdd8RIAlsujtO
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

Since commit 0998d0631001 ("device-core: Ensure drvdata = NULL when no
driver is bound") the driver core cares for cleaning driver data, so
don't do it in the driver, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/acpi/apei/ghes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d91ad378c00d..307fbb97a116 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1444,8 +1444,6 @@ static int ghes_remove(struct platform_device *ghes_dev)
 
 	kfree(ghes);
 
-	platform_set_drvdata(ghes_dev, NULL);
-
 	return 0;
 }
 

base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.37.2

