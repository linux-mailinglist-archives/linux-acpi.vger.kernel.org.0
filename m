Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A517D79E67C
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Sep 2023 13:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbjIMLUz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Sep 2023 07:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239920AbjIMLUy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Sep 2023 07:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A066E1BF2
        for <linux-acpi@vger.kernel.org>; Wed, 13 Sep 2023 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694604003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9uK2ZCHt7+DptUvO5y1cGJFhZuY9Ft2cExymZCEByu8=;
        b=EqE2yguM5l7D2iPmn5YN5On9a2ESKFoJXYrw4mFM4dk95G3Ajty+yPOzc5Z0Xo60qGmilc
        H4uhDopsoxFjOEQOciWKoqMgjlT5YhMmoX20yFwp2jeOraqsXVwVbR/lt/Q3VnCwXIrd5B
        SGkU2vo49coS/0zYJvOmARtHP4TEIJs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-AraU-NVSOz6IAkXB6pzI5w-1; Wed, 13 Sep 2023 07:20:01 -0400
X-MC-Unique: AraU-NVSOz6IAkXB6pzI5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5421A857A9E;
        Wed, 13 Sep 2023 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF8C92026D4B;
        Wed, 13 Sep 2023 11:20:00 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPI: resource: Drop .ident values from dmi_system_id tables
Date:   Wed, 13 Sep 2023 13:19:51 +0200
Message-ID: <20230913111951.30414-2-hdegoede@redhat.com>
In-Reply-To: <20230913111951.30414-1-hdegoede@redhat.com>
References: <20230913111951.30414-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The dmi_system_id.ident values are not used, replace the
.ident = "$ident" lines with /* $ident */ to drop the unused strings
from the text section.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/resource.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index c6bb28db8f30..014a3911381b 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -392,91 +392,91 @@ EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
  */
 static const struct dmi_system_id irq1_level_low_skip_override[] = {
 	{
-		.ident = "MEDION P15651",
+		/* MEDION P15651 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
 			DMI_MATCH(DMI_BOARD_NAME, "M15T"),
 		},
 	},
 	{
-		.ident = "MEDION S17405",
+		/* MEDION S17405 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
 			DMI_MATCH(DMI_BOARD_NAME, "M17T"),
 		},
 	},
 	{
-		.ident = "MEDION S17413",
+		/* MEDION S17413 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
 			DMI_MATCH(DMI_BOARD_NAME, "M1xA"),
 		},
 	},
 	{
-		.ident = "Asus Vivobook K3402ZA",
+		/* Asus Vivobook K3402ZA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "K3402ZA"),
 		},
 	},
 	{
-		.ident = "Asus Vivobook K3502ZA",
+		/* Asus Vivobook K3502ZA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "K3502ZA"),
 		},
 	},
 	{
-		.ident = "Asus Vivobook S5402ZA",
+		/* Asus Vivobook S5402ZA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "S5402ZA"),
 		},
 	},
 	{
-		.ident = "Asus Vivobook S5602ZA",
+		/* Asus Vivobook S5602ZA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
 		},
 	},
 	{
-		.ident = "Asus ExpertBook B1402CBA",
+		/* Asus ExpertBook B1402CBA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
 		},
 	},
 	{
-		.ident = "Asus ExpertBook B1502CBA",
+		/* Asus ExpertBook B1502CBA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "B1502CBA"),
 		},
 	},
 	{
-		.ident = "Asus ExpertBook B2402CBA",
+		/* Asus ExpertBook B2402CBA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "B2402CBA"),
 		},
 	},
 	{
-		.ident = "Asus ExpertBook B2402FBA",
+		/* Asus ExpertBook B2402FBA */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "B2402FBA"),
 		},
 	},
 	{
-		.ident = "Asus ExpertBook B2502",
+		/* Asus ExpertBook B2502 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
 			DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
 		},
 	},
 	{
-		.ident = "LG Electronics 17U70P",
+		/* LG Electronics 17U70P */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
 			DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
@@ -492,28 +492,29 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
  */
 static const struct dmi_system_id irq1_edge_low_force_override[] = {
 	{
-		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
+		/* TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
 		},
 	},
 	{
-		.ident = "MAINGEAR Vector Pro 2 15",
+		/* MAINGEAR Vector Pro 2 15 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
 		}
 	},
 	{
-		.ident = "MAINGEAR Vector Pro 2 17",
+		/* MAINGEAR Vector Pro 2 17 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
 		},
 	},
 	{
-		.ident = "PCSpecialist Elimina Pro 16 M",
 		/*
+		 * PCSpecialist Elimina Pro 16 M
+		 *
 		 * Some models have product-name "Elimina Pro 16 M",
 		 * others "GM6BGEQ". Match on board-name to match both.
 		 */
-- 
2.41.0

