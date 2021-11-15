Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1ED450DA6
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Nov 2021 18:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbhKOSBM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Nov 2021 13:01:12 -0500
Received: from tartarus.angband.pl ([51.83.246.204]:58956 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbhKOR6j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Nov 2021 12:58:39 -0500
X-Greylist: delayed 1397 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Nov 2021 12:58:39 EST
Received: from 89-73-149-240.dynamic.chello.pl ([89.73.149.240] helo=barad-dur.angband.pl)
        by tartarus.angband.pl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mmfq3-00BEET-A8; Mon, 15 Nov 2021 18:32:17 +0100
Received: from [2a02:a31c:8245:f980::4] (helo=valinor.angband.pl)
        by barad-dur.angband.pl with esmtp (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1mmfq2-0002O6-4d; Mon, 15 Nov 2021 18:32:14 +0100
Received: from kilobyte by valinor.angband.pl with local (Exim 4.95)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1mmfq0-000F5k-Fm;
        Mon, 15 Nov 2021 18:32:12 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Mon, 15 Nov 2021 18:32:08 +0100
Message-Id: <20211115173208.57911-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 89.73.149.240
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00=-1.9,RDNS_NONE=0.793,
        SPF_HELO_NONE=0.001,SPF_PASS=-0.001,TVD_RCVD_IP=0.001 autolearn=no
        autolearn_force=no languages=en
Subject: [PATCH] ACPI: thermal: drop an always true check
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Address of a field inside a struct can't possibly be null; gcc-12 warns
about this.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/acpi/thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 95105db642b9..155bbabcc6f5 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1098,8 +1098,6 @@ static int acpi_thermal_resume(struct device *dev)
 		return -EINVAL;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!(&tz->trips.active[i]))
-			break;
 		if (!tz->trips.active[i].flags.valid)
 			break;
 		tz->trips.active[i].flags.enabled = 1;
-- 
2.33.1

