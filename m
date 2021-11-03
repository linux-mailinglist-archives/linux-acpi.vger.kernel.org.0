Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF1044436E
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 15:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhKCO3E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 10:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231464AbhKCO3B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 10:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635949585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7TQQfZh0Da6Zi99K5RMBH2WwLK4UB9MF+vbFmd7kecE=;
        b=K0/G9LSSJ0OmUPF3LzN34jeGwDplx15Qw+tmCPVz1enDviQOmtPz+L+2HOoxPYEltwLGsd
        seaad/dFcYS7/rPqM9am7miybXCyjraKRsP4VlWNfgiZR3Nkj40gs8LCPGEncaG4I/8ssi
        vK7+H/iowh2kbhKxel5PNi0vZFuwDKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-8zxDhVc0Ot615C_yCuX8Yg-1; Wed, 03 Nov 2021 10:26:23 -0400
X-MC-Unique: 8zxDhVc0Ot615C_yCuX8Yg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0DD71018724;
        Wed,  3 Nov 2021 14:26:22 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.195.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65A015C1D5;
        Wed,  3 Nov 2021 14:26:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI: video: Drop dmi_system_id.ident settings from video_detect_dmi_table[]
Date:   Wed,  3 Nov 2021 15:26:19 +0100
Message-Id: <20211103142620.36480-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The .ident field of the dmi_system_id structs in the
video_detect_dmi_table[] is not used by the code.

Change all .ident = "..." assignments to comments, this reduces the
size of video_detect.o / video.ko by about 1500 bytes.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 70 ++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 33474fd96991..7a1f8e823208 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -115,7 +115,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	 */
 	{
 	 .callback = video_detect_force_vendor,
-	 .ident = "X360",
+	 /* X360 */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "X360"),
@@ -124,7 +124,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	.callback = video_detect_force_vendor,
-	.ident = "Asus UL30VT",
+	/* Asus UL30VT */
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "UL30VT"),
@@ -132,7 +132,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	.callback = video_detect_force_vendor,
-	.ident = "Asus UL30A",
+	/* Asus UL30A */
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "UL30A"),
@@ -140,7 +140,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	.callback = video_detect_force_vendor,
-	.ident = "GIGABYTE GB-BXBT-2807",
+	/* GIGABYTE GB-BXBT-2807 */
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "GB-BXBT-2807"),
@@ -148,7 +148,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	.callback = video_detect_force_vendor,
-	.ident = "Sony VPCEH3U1E",
+	/* Sony VPCEH3U1E */
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "VPCEH3U1E"),
@@ -164,7 +164,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	 */
 	{
 	 .callback = video_detect_force_video,
-	 .ident = "ThinkPad T420",
+	 /* ThinkPad T420 */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T420"),
@@ -172,7 +172,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	 .callback = video_detect_force_video,
-	 .ident = "ThinkPad T520",
+	 /* ThinkPad T520 */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T520"),
@@ -180,7 +180,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	 .callback = video_detect_force_video,
-	 .ident = "ThinkPad X201s",
+	 /* ThinkPad X201s */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
@@ -188,7 +188,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	 .callback = video_detect_force_video,
-	 .ident = "ThinkPad X201T",
+	 /* ThinkPad X201T */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201T"),
@@ -199,7 +199,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{
 	 /* https://bugs.freedesktop.org/show_bug.cgi?id=81515 */
 	 .callback = video_detect_force_video,
-	 .ident = "HP ENVY 15 Notebook",
+	 /* HP ENVY 15 Notebook */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "HP ENVY 15 Notebook PC"),
@@ -207,7 +207,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	 .callback = video_detect_force_video,
-	 .ident = "SAMSUNG 870Z5E/880Z5E/680Z5E",
+	 /* SAMSUNG 870Z5E/880Z5E/680Z5E */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "870Z5E/880Z5E/680Z5E"),
@@ -215,7 +215,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	 .callback = video_detect_force_video,
-	 .ident = "SAMSUNG 370R4E/370R4V/370R5E/3570RE/370R5V",
+	 /* SAMSUNG 370R4E/370R4V/370R5E/3570RE/370R5V */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
 		DMI_MATCH(DMI_PRODUCT_NAME,
@@ -225,7 +225,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1186097 */
 	 .callback = video_detect_force_video,
-	 .ident = "SAMSUNG 3570R/370R/470R/450R/510R/4450RV",
+	 /* SAMSUNG 3570R/370R/470R/450R/510R/4450RV */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
 		DMI_MATCH(DMI_PRODUCT_NAME,
@@ -235,7 +235,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1557060 */
 	 .callback = video_detect_force_video,
-	 .ident = "SAMSUNG 670Z5E",
+	 /* SAMSUNG 670Z5E */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "670Z5E"),
@@ -244,7 +244,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1094948 */
 	 .callback = video_detect_force_video,
-	 .ident = "SAMSUNG 730U3E/740U3E",
+	 /* SAMSUNG 730U3E/740U3E */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "730U3E/740U3E"),
@@ -253,7 +253,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{
 	 /* https://bugs.freedesktop.org/show_bug.cgi?id=87286 */
 	 .callback = video_detect_force_video,
-	 .ident = "SAMSUNG 900X3C/900X3D/900X3E/900X4C/900X4D",
+	 /* SAMSUNG 900X3C/900X3D/900X3E/900X4C/900X4D */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
 		DMI_MATCH(DMI_PRODUCT_NAME,
@@ -263,7 +263,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1272633 */
 	 .callback = video_detect_force_video,
-	 .ident = "Dell XPS14 L421X",
+	 /* Dell XPS14 L421X */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "XPS L421X"),
@@ -272,7 +272,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */
 	 .callback = video_detect_force_video,
-	 .ident = "Dell XPS15 L521X",
+	 /* Dell XPS15 L521X */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "XPS L521X"),
@@ -281,7 +281,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{
 	 /* https://bugzilla.kernel.org/show_bug.cgi?id=108971 */
 	 .callback = video_detect_force_video,
-	 .ident = "SAMSUNG 530U4E/540U4E",
+	 /* SAMSUNG 530U4E/540U4E */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "530U4E/540U4E"),
@@ -290,7 +290,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	/* https://bugs.launchpad.net/bugs/1894667 */
 	{
 	 .callback = video_detect_force_video,
-	 .ident = "HP 635 Notebook",
+	 /* HP 635 Notebook */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "HP 635 Notebook PC"),
@@ -301,7 +301,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1201530 */
 	 .callback = video_detect_force_native,
-	 .ident = "Lenovo Ideapad S405",
+	 /* Lenovo Ideapad S405 */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		DMI_MATCH(DMI_BOARD_NAME, "Lenovo IdeaPad S405"),
@@ -310,7 +310,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
 	 .callback = video_detect_force_native,
-	 .ident = "Lenovo Ideapad Z570",
+	 /* Lenovo Ideapad Z570 */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "102434U"),
@@ -318,7 +318,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	 .callback = video_detect_force_native,
-	 .ident = "Lenovo E41-25",
+	 /* Lenovo E41-25 */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "81FS"),
@@ -326,7 +326,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	 .callback = video_detect_force_native,
-	 .ident = "Lenovo E41-45",
+	 /* Lenovo E41-45 */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
@@ -335,7 +335,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
-	 .ident = "Apple MacBook Pro 12,1",
+	 /* Apple MacBook Pro 12,1 */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
@@ -343,7 +343,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	 .callback = video_detect_force_native,
-	 .ident = "Dell Vostro V131",
+	 /* Dell Vostro V131 */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V131"),
@@ -352,7 +352,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1123661 */
 	 .callback = video_detect_force_native,
-	 .ident = "Dell XPS 17 L702X",
+	 /* Dell XPS 17 L702X */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Dell System XPS L702X"),
@@ -360,7 +360,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	 .callback = video_detect_force_native,
-	 .ident = "Dell Precision 7510",
+	 /* Dell Precision 7510 */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
@@ -368,7 +368,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	 .callback = video_detect_force_native,
-	 .ident = "Acer Aspire 5738z",
+	 /* Acer Aspire 5738z */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
@@ -378,7 +378,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{
 	 /* https://bugzilla.kernel.org/show_bug.cgi?id=207835 */
 	 .callback = video_detect_force_native,
-	 .ident = "Acer TravelMate 5735Z",
+	 /* Acer TravelMate 5735Z */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 5735Z"),
@@ -387,7 +387,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	.callback = video_detect_force_native,
-	.ident = "ASUSTeK COMPUTER INC. GA401",
+	/* ASUSTeK COMPUTER INC. GA401 */
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "GA401"),
@@ -395,7 +395,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	.callback = video_detect_force_native,
-	.ident = "ASUSTeK COMPUTER INC. GA502",
+	/* ASUSTeK COMPUTER INC. GA502 */
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "GA502"),
@@ -403,7 +403,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	.callback = video_detect_force_native,
-	.ident = "ASUSTeK COMPUTER INC. GA503",
+	/* ASUSTeK COMPUTER INC. GA503 */
 	.matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "GA503"),
@@ -416,7 +416,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	 */
 	{
 	 .callback = video_detect_force_none,
-	 .ident = "Dell OptiPlex 9020M",
+	 /* Dell OptiPlex 9020M */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 9020M"),
@@ -424,7 +424,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	},
 	{
 	 .callback = video_detect_force_none,
-	 .ident = "MSI MS-7721",
+	 /* MSI MS-7721 */
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "MSI"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "MS-7721"),
-- 
2.31.1

