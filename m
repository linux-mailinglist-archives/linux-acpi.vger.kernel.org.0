Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F73A551448
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jun 2022 11:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240661AbiFTJ05 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jun 2022 05:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbiFTJ05 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jun 2022 05:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CD2812D32
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2022 02:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655717215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wz1YBsAcsAwokHTqZOoquq1Xf5yDnsolTTxkPqD711Q=;
        b=SiekIIgtWew+uod9ecKFT2uS5uCrnWHxGxGPi+YiwDNPS48axjnRCm91qg2sykjw83p2Ey
        fxKU2mpwoyxVeOdvCjcvgC7/8TmOYbyXQRBYZMgQowhCoqyFmEc52l/HKpIvE4r6d0gpaK
        23Etk6ZLtdhXk/mxHUY9TDRgcjzz1dE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-drjpvh1CPpu6s--nMj37rg-1; Mon, 20 Jun 2022 05:26:50 -0400
X-MC-Unique: drjpvh1CPpu6s--nMj37rg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9080018E526E;
        Mon, 20 Jun 2022 09:26:49 +0000 (UTC)
Received: from x1.nl (unknown [10.39.195.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CE0E1415109;
        Mon, 20 Jun 2022 09:26:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Shevchenko <andy@kernel.org>, kai.heng.feng@canonical.com,
        linux-acpi@vger.kernel.org, devel@acpica.org
Subject: [PATCH 4/4] ACPI: EC: Drop unused ident initializers from dmi_system_id tables
Date:   Mon, 20 Jun 2022 11:25:46 +0200
Message-Id: <20220620092546.8298-5-hdegoede@redhat.com>
In-Reply-To: <20220620092546.8298-1-hdegoede@redhat.com>
References: <20220620092546.8298-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Drop the unused const string ident initializers from
the dmi_system_id tables to make the object size a bit smaller.

While at it also use proper named struct-member initializers for
the ec_dmi_table[].

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/ec.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a4c16b8540e5..79ba7b04417b 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1859,18 +1859,38 @@ static int ec_honor_dsdt_gpe(const struct dmi_system_id *id)
 
 static const struct dmi_system_id ec_dmi_table[] __initconst = {
 	{
-	ec_correct_ecdt, "MSI MS-171F", {
-	DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star"),
-	DMI_MATCH(DMI_PRODUCT_NAME, "MS-171F"),}, NULL},
+		/*
+		 * MSI MS-171F
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=12461
+		 */
+		.callback = ec_correct_ecdt,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MS-171F"),
+		},
+	},
 	{
-	/* https://bugzilla.kernel.org/show_bug.cgi?id=209989 */
-	ec_honor_dsdt_gpe, "HP Pavilion Gaming Laptop 15-cx0xxx", {
-	DMI_MATCH(DMI_SYS_VENDOR, "HP"),
-	DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-cx0xxx"),}, NULL},
+		/*
+		 * HP Pavilion Gaming Laptop 15-cx0xxx
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=209989
+		 */
+		.callback = ec_honor_dsdt_gpe,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-cx0xxx"),
+		},
+	},
 	{
-	ec_clear_on_resume, "Samsung hardware", {
-	DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD.")}, NULL},
-	{},
+		/*
+		 * Samsung hardware
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=44161
+		 */
+		.callback = ec_clear_on_resume,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		},
+	},
+	{}
 };
 
 void __init acpi_ec_ecdt_probe(void)
@@ -2165,21 +2185,18 @@ static int acpi_ec_init_workqueues(void)
 
 static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 	{
-		.ident = "Thinkpad X1 Carbon 6th",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Thinkpad X1 Carbon 6th"),
 		},
 	},
 	{
-		.ident = "ThinkPad X1 Yoga 3rd",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Yoga 3rd"),
 		},
 	},
 	{
-		.ident = "HP ZHAN 66 Pro",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
-- 
2.36.0

