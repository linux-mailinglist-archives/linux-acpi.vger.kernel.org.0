Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0B07715CB
	for <lists+linux-acpi@lfdr.de>; Sun,  6 Aug 2023 17:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjHFPPu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Aug 2023 11:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjHFPPt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Aug 2023 11:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF8AE49
        for <linux-acpi@vger.kernel.org>; Sun,  6 Aug 2023 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691334902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CNB47Sp7trc9bmNcKr/Qyt4K/JLPlJPyfPKXwvKIQrU=;
        b=ZcM8aOALc04BxzlGAGGzpy/mIWspkHJp6F/KN1xDMqz+SPnsRg+Ih++kih/HLVls2UKvH9
        EOt4c7SHS9DBg+jWGx8eQIhi+AnUpV+E2IENU4SGNT3uxqbYGk8vu7YxJevEQHs4QmeM9H
        waY+mA3nIVgb0vouadtoz/kADSfICxA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-70ptTuQVNsewBDtaapMtnw-1; Sun, 06 Aug 2023 11:14:58 -0400
X-MC-Unique: 70ptTuQVNsewBDtaapMtnw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E30038002BF;
        Sun,  6 Aug 2023 15:14:57 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1E232166B25;
        Sun,  6 Aug 2023 15:14:56 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
Subject: [PATCH] ACPI: resource: revert "Remove "Zen" specific match and quirks"
Date:   Sun,  6 Aug 2023 17:14:53 +0200
Message-ID: <20230806151453.10690-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and
quirks") is causing keyboard problems for quite a log of AMD based
laptop users, leading to many bug reports.

Revert this change for now, until we can come up with
a better fix for the PS/2 IRQ trigger-type/polarity problems
on some x86 laptops.

Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229165
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229317
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217726
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 60 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 1dd8d5aebf67..0800a9d77558 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -470,6 +470,52 @@ static const struct dmi_system_id asus_laptop[] = {
 	{ }
 };
 
+static const struct dmi_system_id lenovo_laptop[] = {
+	{
+		.ident = "LENOVO IdeaPad Flex 5 14ALC7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
+		},
+	},
+	{
+		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
+		},
+	},
+	{ }
+};
+
+static const struct dmi_system_id tongfang_gm_rg[] = {
+	{
+		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
+		},
+	},
+	{ }
+};
+
+static const struct dmi_system_id maingear_laptop[] = {
+	{
+		.ident = "MAINGEAR Vector Pro 2 15",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
+		}
+	},
+	{
+		.ident = "MAINGEAR Vector Pro 2 17",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
+		},
+	},
+	{ }
+};
+
 static const struct dmi_system_id lg_laptop[] = {
 	{
 		.ident = "LG Electronics 17U70P",
@@ -493,6 +539,10 @@ struct irq_override_cmp {
 static const struct irq_override_cmp override_table[] = {
 	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
+	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
+	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
+	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
+	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 };
 
@@ -512,6 +562,16 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
 			return entry->override;
 	}
 
+#ifdef CONFIG_X86
+	/*
+	 * IRQ override isn't needed on modern AMD Zen systems and
+	 * this override breaks active low IRQs on AMD Ryzen 6000 and
+	 * newer systems. Skip it.
+	 */
+	if (boot_cpu_has(X86_FEATURE_ZEN))
+		return false;
+#endif
+
 	return true;
 }
 
-- 
2.41.0

