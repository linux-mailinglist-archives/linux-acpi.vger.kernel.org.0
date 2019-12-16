Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF7312018E
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 10:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLPJzf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 04:55:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46229 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfLPJzf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 04:55:35 -0500
Received: from [125.35.49.90] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <aaron.ma@canonical.com>)
        id 1ign6B-00042h-J0; Mon, 16 Dec 2019 09:55:32 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, aaron.ma@canonical.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: video: Use native backlight on Lenovo E41-25/45
Date:   Mon, 16 Dec 2019 17:55:12 +0800
Message-Id: <20191216095512.1782-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI backlight control doesn't work on 2 Lenovo E41 laptops.
So force to use native backlight control on them.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/acpi/video_detect.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 31014c7d3793..13ce1bb9facf 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -302,6 +302,22 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "102434U"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 .ident = "Lenovo E41-25",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "81FS"),
+		},
+	},
+	{
+	 .callback = video_detect_force_native,
+	 .ident = "Lenovo E41-45",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
-- 
2.24.1

