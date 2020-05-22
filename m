Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F01DE6B6
	for <lists+linux-acpi@lfdr.de>; Fri, 22 May 2020 14:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgEVMWs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 May 2020 08:22:48 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:33617 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728409AbgEVMWs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 May 2020 08:22:48 -0400
Received: from ersatz.localdomain (x590e9651.dyn.telefonica.de [89.14.150.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9F5F32002EE36;
        Fri, 22 May 2020 14:22:45 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-acpi@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI: video: Use native backlight on Acer TravelMate 5735Z
Date:   Fri, 22 May 2020 14:22:28 +0200
Message-Id: <20200522122228.9494-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently, changing the brightness of the internal display of the Acer
TravelMate 5735Z does not work. Pressing the function keys or changing the
slider, GNOME Shell 3.36.2 displays the OSD (five steps), but the
brightness does not change.

The Acer TravelMate 5735Z shipped with Windows 7 and as such does not
trigger our "win8 ready" heuristic for preferring the native backlight
interface.

Still ACPI backlight control doesn't work on this model, where as the
native (intel_video) backlight interface does work by adding
`acpi_backlight=native` or `acpi_backlight=none` to Linux’ command line.

So, add a quirk to force using native backlight control on this model.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=207835

Cc: linux-acpi@vger.kernel.org
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/acpi/video_detect.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b4994e50608d..2499d7e3c710 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -361,6 +361,16 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "JV50"),
 		},
 	},
+	{
+	 /* https://bugzilla.kernel.org/show_bug.cgi?id=207835 */
+	 .callback = video_detect_force_native,
+	 .ident = "Acer TravelMate 5735Z",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 5735Z"),
+		DMI_MATCH(DMI_BOARD_NAME, "BA51_MV"),
+		},
+	},
 
 	/*
 	 * Desktops which falsely report a backlight and which our heuristics
-- 
2.27.0.rc0

