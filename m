Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899EE768A1B
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jul 2023 04:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGaCnI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 30 Jul 2023 22:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGaCnH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 30 Jul 2023 22:43:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A46A1
        for <linux-acpi@vger.kernel.org>; Sun, 30 Jul 2023 19:43:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A85A60CF5
        for <linux-acpi@vger.kernel.org>; Mon, 31 Jul 2023 02:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBDCC433C7;
        Mon, 31 Jul 2023 02:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690771385;
        bh=YBV+TipDX26PgzOLWGNPzTtOQ6VHqNpYWrBJRqii2jY=;
        h=From:To:Cc:Subject:Date:From;
        b=f556BfrGp79U+o/061A/bhNt9ia57hEcxPhBLIKlRNDLefVyadj+6yIgn4qHu6Wnz
         cWGNxNh88NHoXlPGc4nojVVA7DSJqDxXkXy9AN20TGQlMwsVb7jvqoMHtUNikUzNp7
         oGqGxGoQWQIO6qCrqwcm65+KSUhxflcd3buKWhFVdvku2GJ1FO0RKReFJCSVFBV5fJ
         /u8opzK/SAAjfoK9hz0ZKTh0+y2sVmrxXS+9NKFuNRGjSuSlgnqcOKmMpHYI7nzK/d
         tVQ8GfZS41l9fXQ1i6NNWBHElgEbqB/lyLU7aa72HICk8AdY5IvUzkv+kbdqUjzs2G
         fcMHRhE2yyVHg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, rafael@kernel.org,
        lenb@kernel.org
Cc:     guillaume.tucker@collabora.com, denys.f@collabora.com,
        ricardo.canuelo@collabora.com, usama.anjum@collabora.com,
        chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3] platform/chrome: chromeos_acpi: support official HID GOOG0016
Date:   Mon, 31 Jul 2023 10:42:14 +0800
Message-ID: <20230731024214.908235-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Support official HID GOOG0016 for ChromeOS ACPI (see [1]).

[1]: https://crrev.com/c/2266713

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v2[2]:
- Instead of replacing, appending "GOOG0016" in sysfs-driver-chromeos-acpi.

Changes from v1[3]:
- Preserve the PNP ID GGL0001 for backward compatible to older firmwares.
- Modify commit title and message accordingly.

[2]: https://patchwork.kernel.org/project/chrome-platform/patch/20230728065438.4026629-1-tzungbi@kernel.org/
[3]: https://patchwork.kernel.org/project/chrome-platform/patch/20230728014256.3836298-1-tzungbi@kernel.org/

 .../ABI/testing/sysfs-driver-chromeos-acpi        | 15 +++++++++++++++
 .../firmware-guide/acpi/chromeos-acpi-device.rst  |  5 ++---
 drivers/platform/chrome/chromeos_acpi.c           |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
index c308926e1568..22082f9a7922 100644
--- a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
+++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
@@ -1,4 +1,5 @@
 What:		/sys/bus/platform/devices/GGL0001:*/BINF.2
+		/sys/bus/platform/devices/GOOG0016:*/BINF.2
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -10,6 +11,7 @@ Description:
 		== ===============================
 
 What:		/sys/bus/platform/devices/GGL0001:*/BINF.3
+		/sys/bus/platform/devices/GOOG0016:*/BINF.3
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -23,6 +25,7 @@ Description:
 		== =====================================
 
 What:		/sys/bus/platform/devices/GGL0001:*/CHSW
+		/sys/bus/platform/devices/GOOG0016:*/CHSW
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -38,6 +41,7 @@ Description:
 		==== ===========================================
 
 What:		/sys/bus/platform/devices/GGL0001:*/FMAP
+		/sys/bus/platform/devices/GOOG0016:*/FMAP
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -45,6 +49,7 @@ Description:
 		processor firmware flashmap.
 
 What:		/sys/bus/platform/devices/GGL0001:*/FRID
+		/sys/bus/platform/devices/GOOG0016:*/FRID
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -52,6 +57,7 @@ Description:
 		main processor firmware.
 
 What:		/sys/bus/platform/devices/GGL0001:*/FWID
+		/sys/bus/platform/devices/GOOG0016:*/FWID
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -59,6 +65,7 @@ Description:
 		main processor firmware.
 
 What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.0
+		/sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.0
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -73,6 +80,7 @@ Description:
 		=========== ==================================
 
 What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.1
+		/sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.1
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -84,6 +92,7 @@ Description:
 		== =======================
 
 What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.2
+		/sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.2
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -91,18 +100,21 @@ Description:
 		controller.
 
 What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.3
+		/sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.3
 Date:		May 2022
 KernelVersion:	5.19
 Description:
 		Returns name of the GPIO controller.
 
 What:		/sys/bus/platform/devices/GGL0001:*/HWID
+		/sys/bus/platform/devices/GOOG0016:*/HWID
 Date:		May 2022
 KernelVersion:	5.19
 Description:
 		Returns hardware ID for the Chromebook.
 
 What:		/sys/bus/platform/devices/GGL0001:*/MECK
+		/sys/bus/platform/devices/GOOG0016:*/MECK
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -113,6 +125,7 @@ Description:
 		present, or if the firmware was unable to read the extended registers, this buffer size can be zero.
 
 What:		/sys/bus/platform/devices/GGL0001:*/VBNV.0
+		/sys/bus/platform/devices/GOOG0016:*/VBNV.0
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -122,6 +135,7 @@ Description:
 		clock data).
 
 What:		/sys/bus/platform/devices/GGL0001:*/VBNV.1
+		/sys/bus/platform/devices/GOOG0016:*/VBNV.1
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -129,6 +143,7 @@ Description:
 		storage block.
 
 What:		/sys/bus/platform/devices/GGL0001:*/VDAT
+		/sys/bus/platform/devices/GOOG0016:*/VDAT
 Date:		May 2022
 KernelVersion:	5.19
 Description:
diff --git a/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst b/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
index f37fc90ce340..89419e116413 100644
--- a/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
+++ b/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
@@ -5,9 +5,8 @@ Chrome OS ACPI Device
 =====================
 
 Hardware functionality specific to Chrome OS is exposed through a Chrome OS ACPI device.
-The plug and play ID of a Chrome OS ACPI device is GGL0001. GGL is a valid PNP ID of Google.
-PNP ID can be used with the ACPI devices according to the guidelines. The following ACPI
-objects are supported:
+The plug and play ID of a Chrome OS ACPI device is GGL0001 and the hardware ID is
+GOOG0016.  The following ACPI objects are supported:
 
 .. flat-table:: Supported ACPI Objects
    :widths: 1 2
diff --git a/drivers/platform/chrome/chromeos_acpi.c b/drivers/platform/chrome/chromeos_acpi.c
index 50d8a4d4352d..1cc01d893ada 100644
--- a/drivers/platform/chrome/chromeos_acpi.c
+++ b/drivers/platform/chrome/chromeos_acpi.c
@@ -235,9 +235,9 @@ static int chromeos_acpi_device_probe(struct platform_device *pdev)
 	return 0;
 }
 
-/* GGL is valid PNP ID of Google. PNP ID can be used with the ACPI devices. */
 static const struct acpi_device_id chromeos_device_ids[] = {
 	{ "GGL0001", 0 },
+	{ "GOOG0016", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, chromeos_device_ids);
-- 
2.41.0.487.g6d72f3e995-goog

