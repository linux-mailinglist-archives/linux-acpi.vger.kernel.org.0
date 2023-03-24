Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ACF6C7949
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Mar 2023 09:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjCXIBB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Mar 2023 04:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCXIBA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Mar 2023 04:01:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF151E1EE
        for <linux-acpi@vger.kernel.org>; Fri, 24 Mar 2023 01:00:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfcKK-0006Av-JZ; Fri, 24 Mar 2023 08:59:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfcKG-006KZd-O5; Fri, 24 Mar 2023 08:59:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pfcKG-007XxX-0z; Fri, 24 Mar 2023 08:59:04 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, kernel@pengutronix.de
Subject: [PATCH] ACPICA: Make check to install handler more obviously correct
Date:   Fri, 24 Mar 2023 08:58:54 +0100
Message-Id: <20230324075854.458341-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=yff8pJaSr2OOYqnudyAyXa+Ae+DvLs0YIYVHJWEVNEY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkHVg9+pNcCROv4lht0GMJvsBW8dN8DeisSpVHd hRZrRoE6wmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZB1YPQAKCRCPgPtYfRL+ TiZbCAC6nqmRBRpIDbewDZx+i9jVtdSIsovIcGVys9Pz3HcVr+4q3uEN1I2J5LV1AO1tAXRXUCK VpcCprSBvEg88by6UjMk1QLyEN2MJYz8sMXNvoVSIqAmadm8u6fKFxPuhJs2BV1J9awB2IjJcZh MqKHCh/rhS2xa+LMI+cVzEtfm1K1NC0fBkvFrk2TNLjsblmHNYu3sI37gCwDdnXH357QH8WggS6 5jF2nFI5Pf7Sbcy11ZlaMBXZpSpIPiMtbNlEFxvmArF92tGRpjSsHji5YqDqRIaToGAj6OcDx0b /gDtFEsmcMyCBV0brySpSwS2fGsqg6MK8ql8udzeedPqlIYQ
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

The loop

	for (i = 0; i < ACPI_NUM_NOTIFY_TYPES; i++) {
		if (handler_type & (i + 1)) {
			...
		}
	}

looks strange. Only with knowing that ACPI_NUM_NOTIFY_TYPES == 2 you can
see that the two least significant bits are checked. Still replace

	i + 1

by

	1 << i

which shouldn't make a relevant difference to compiler and compiled
code, but is easier to understand for a human code reader.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/acpi/acpica/evxface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 18219abba108..d1b3411d2449 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -170,7 +170,7 @@ acpi_install_notify_handler(acpi_handle device,
 	/* Install the handler at the list head(s) */
 
 	for (i = 0; i < ACPI_NUM_NOTIFY_TYPES; i++) {
-		if (handler_type & (i + 1)) {
+		if (handler_type & (1 << i)) {
 			handler_obj->notify.next[i] =
 			    obj_desc->common_notify.notify_list[i];
 

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

