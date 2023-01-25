Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F45367B1A4
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 12:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbjAYLjs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 06:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbjAYLjn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 06:39:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBB41E1D8
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2023 03:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674646698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uAKpOu0dm4jpekjN+VBHs8u6gTx4Oo7BRUbgaRSJOSY=;
        b=RkOyU5y0hRN3IPrAvJ+Sbb9LIXaDbEJ4pyZnarne7karoYK6BLEaKkIRXO0/4dGQMTdCV3
        kR/6j3ZjSdcd3rtlWjvUMTLGUJrdroIqkcRT63vGAQMd/ARevRhY1qh9tjA9V2IPwszJYE
        evJ1zZK/vh4Lw2I2VKR7Osvbra7Ij20=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-qNPtCWWCOeuaZL5nHsx-kw-1; Wed, 25 Jan 2023 06:38:13 -0500
X-MC-Unique: qNPtCWWCOeuaZL5nHsx-kw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 438D585A588;
        Wed, 25 Jan 2023 11:38:13 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D936C1121330;
        Wed, 25 Jan 2023 11:38:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] ACPI: PMIC: Add comments with DSDT power opregion field names
Date:   Wed, 25 Jan 2023 12:38:11 +0100
Message-Id: <20230125113811.53409-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The DSDTs of CHT devices using the Dollar Cove TI PMIC, all use
LDO1 - LDO14 names for the DSDT power opregion field names.

Add comments with these fields to make it easier to see which PMIC
registers are being set by ACPI code using these.

Note that LDO4 is missing and the mapped registers jump from 0x43
to 0x45 to match. This matches with how the fields are declared
in the DSDT where LDO4 is skipped too. Note there is no hole in
the field addresses, LDO4 is simply just not defined on either side.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- s/LDO3/LDO4/ in the commit message, because I somehow go this
  wrong initially (thank you for catching this Andy)
---
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 26 ++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
index 418eec523025..c84ef3d15181 100644
--- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
+++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
@@ -20,19 +20,19 @@
 #define CHTDC_TI_GPADC		0x5a
 
 static struct pmic_table chtdc_ti_power_table[] = {
-	{ .address = 0x00, .reg = 0x41 },
-	{ .address = 0x04, .reg = 0x42 },
-	{ .address = 0x08, .reg = 0x43 },
-	{ .address = 0x0c, .reg = 0x45 },
-	{ .address = 0x10, .reg = 0x46 },
-	{ .address = 0x14, .reg = 0x47 },
-	{ .address = 0x18, .reg = 0x48 },
-	{ .address = 0x1c, .reg = 0x49 },
-	{ .address = 0x20, .reg = 0x4a },
-	{ .address = 0x24, .reg = 0x4b },
-	{ .address = 0x28, .reg = 0x4c },
-	{ .address = 0x2c, .reg = 0x4d },
-	{ .address = 0x30, .reg = 0x4e },
+	{ .address = 0x00, .reg = 0x41 }, /* LDO1 */
+	{ .address = 0x04, .reg = 0x42 }, /* LDO2 */
+	{ .address = 0x08, .reg = 0x43 }, /* LDO3 */
+	{ .address = 0x0c, .reg = 0x45 }, /* LDO5 */
+	{ .address = 0x10, .reg = 0x46 }, /* LDO6 */
+	{ .address = 0x14, .reg = 0x47 }, /* LDO7 */
+	{ .address = 0x18, .reg = 0x48 }, /* LDO8 */
+	{ .address = 0x1c, .reg = 0x49 }, /* LDO9 */
+	{ .address = 0x20, .reg = 0x4a }, /* LD10 */
+	{ .address = 0x24, .reg = 0x4b }, /* LD11 */
+	{ .address = 0x28, .reg = 0x4c }, /* LD12 */
+	{ .address = 0x2c, .reg = 0x4d }, /* LD13 */
+	{ .address = 0x30, .reg = 0x4e }, /* LD14 */
 };
 
 static struct pmic_table chtdc_ti_thermal_table[] = {
-- 
2.39.0

