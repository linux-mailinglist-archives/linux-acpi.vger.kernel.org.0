Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF06267B0A1
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jan 2023 12:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjAYLIS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Jan 2023 06:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbjAYLIK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2023 06:08:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310612D73
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2023 03:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674644844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dS43aJpa1ps5Oa8L08uCnwuEc5s1e+B3k9swVSeZQqE=;
        b=CF8/CSBaLFsktifj4fR949xSV8CiRA6KlvHAkB9JaUS6p9mowDp5/s9LJM65JV8bujveOC
        9f7PKvIL+D0yOPB4EnKcil9sa4+ywBmNNNHhI6N6r8bhpblhPupfTRfn6V0baEkmvZi2Kp
        PkEBO4GDBv+7dIjerDo3/nwtrYNPDX8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-1n8ZzHqlM8a6YX6-YiMLHg-1; Wed, 25 Jan 2023 06:07:20 -0500
X-MC-Unique: 1n8ZzHqlM8a6YX6-YiMLHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 053E8101AA78;
        Wed, 25 Jan 2023 11:07:20 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB60840C945A;
        Wed, 25 Jan 2023 11:07:18 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: PMIC: Add comments with DSDT power opregion field names
Date:   Wed, 25 Jan 2023 12:07:18 +0100
Message-Id: <20230125110718.18194-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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
in the DSDT where LDO3 is skipped to. Note there is no hole in
the field addresses, LDO3 is simply just not defined on either side.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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

