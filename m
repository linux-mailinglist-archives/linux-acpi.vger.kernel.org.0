Return-Path: <linux-acpi+bounces-296-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A8E7B3B40
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 22:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B95CE2820F2
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 20:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140C521B5
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 20:32:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5D66DD3
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 20:30:16 +0000 (UTC)
X-Greylist: delayed 529 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Sep 2023 13:30:14 PDT
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE4451B2;
	Fri, 29 Sep 2023 13:30:14 -0700 (PDT)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by hosting.gsystem.sk (Postfix) with ESMTPSA id 168A07A00A5;
	Fri, 29 Sep 2023 22:21:22 +0200 (CEST)
From: Ondrej Zary <linux@zary.sk>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?ACPI:=20video:=20Add=20acpi=5Fbacklight=3Dvendo?= =?UTF-8?q?r=20quirk=20for=20Toshiba=20Port=C3=A9g=C3=A9=20R100?=
Date: Fri, 29 Sep 2023 22:20:55 +0200
Message-Id: <20230929202055.12724-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Toshiba Portégé R100 has both acpi_video and toshiba_acpi vendor
backlight driver working. But none of them gets activated as it has
a VGA with no kernel driver (Trident CyberBlade XP4m32).

The DMI strings are very generic ("Portable PC") so add a custom
callback function to check for Trident CyberBlade XP4m32 PCI device
before enabling the vendor backlight driver (better than acpi_video
as it has more brightness steps).

Fixes: 5aa9d943e9b6 ("ACPI: video: Don't enable fallback path for creating ACPI backlight by default")
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/acpi/video_detect.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 442396f6ed1f..31205fee59d4 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -130,6 +130,16 @@ static int video_detect_force_native(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int video_detect_portege_r100(const struct dmi_system_id *d)
+{
+	struct pci_dev *dev;
+	/* Search for Trident CyberBlade XP4m32 to confirm Portégé R100 */
+	dev = pci_get_device(PCI_VENDOR_ID_TRIDENT, 0x2100, NULL);
+	if (dev)
+		acpi_backlight_dmi = acpi_backlight_vendor;
+	return 0;
+}
+
 static const struct dmi_system_id video_detect_dmi_table[] = {
 	/*
 	 * Models which should use the vendor backlight interface,
@@ -270,6 +280,22 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		},
 	},
 
+	/*
+	 * Toshiba Portégé R100 has working both acpi_video and toshiba_acpi
+	 * vendor driver. But none of them gets activated as it has a VGA with
+	 * no kernel driver (Trident CyberBlade XP4m32).
+	 * The DMI strings are generic so check for the VGA chip in callback.
+	 */
+	{
+	 .callback = video_detect_portege_r100,
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Portable PC"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "Version 1.0"),
+		DMI_MATCH(DMI_BOARD_NAME, "Portable PC")
+		},
+	},
+
 	/*
 	 * Models which need acpi_video backlight control where the GPU drivers
 	 * do not call acpi_video_register_backlight() because no internal panel
-- 
Ondrej Zary


