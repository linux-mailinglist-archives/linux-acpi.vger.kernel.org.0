Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3337B76648D
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jul 2023 08:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjG1GzG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Jul 2023 02:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjG1GzF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jul 2023 02:55:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC19819B
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jul 2023 23:55:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5789061FC9
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jul 2023 06:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F174FC433C7;
        Fri, 28 Jul 2023 06:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690527302;
        bh=1JXAtuvsHcx72LenZV1LOxG30qliT492nHY36zHPi/I=;
        h=From:To:Cc:Subject:Date:From;
        b=J6UuesLJclhvpekNeeF0OVHYd5/vOCQvPue0BGFw8YflZxzd6opQcbyqD5qaZzvbt
         SQ5KctYbj6S9Ju2TbHX8lP6FGWfyrsi8iLwbzvV8pNXs9+cwrJoxjBwtZfrmkJLeLs
         3GebUxljkYBBBhSnAH/g5LgcEOsvKwM+kMCsb8UFHkcHW+dlsLsYRcIqQ8wR+lgWGe
         WQSBpmM9jYAWf9ZBqXbhqrlw8q7jb2b9C8v5dUx2NmTVPSUo8z/loYcDh5DJV+vEwY
         Ek8+5VlCJd8lK3hwPFgeZZakZWAv4O2r0W50ZQMWfKd23oIrfU9AyKdn5dUSV06Hhf
         XFcr9JMru7N0g==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     rafael@kernel.org, lenb@kernel.org, bleung@chromium.org,
        groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@kernel.org,
        linux-acpi@vger.kernel.org, guillaume.tucker@collabora.com,
        denys.f@collabora.com, ricardo.canuelo@collabora.com,
        usama.anjum@collabora.com
Subject: [PATCH v2] platform/chrome: chromeos_acpi: support official HID GOOG0016
Date:   Fri, 28 Jul 2023 14:54:38 +0800
Message-ID: <20230728065438.4026629-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
Changes from v1[2]:
- Preserve the PNP ID GGL0001 for backward compatible to older firmwares.
- Modify commit title and message accordingly.

[2]: https://patchwork.kernel.org/project/chrome-platform/patch/20230728014256.3836298-1-tzungbi@kernel.org/

 .../ABI/testing/sysfs-driver-chromeos-acpi    | 30 +++++++++----------
 .../acpi/chromeos-acpi-device.rst             |  5 ++--
 drivers/platform/chrome/chromeos_acpi.c       |  2 +-
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
index c308926e1568..8e8a5d6610b8 100644
--- a/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
+++ b/Documentation/ABI/testing/sysfs-driver-chromeos-acpi
@@ -1,4 +1,4 @@
-What:		/sys/bus/platform/devices/GGL0001:*/BINF.2
+What:		/sys/bus/platform/devices/GOOG0016:*/BINF.2
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -9,7 +9,7 @@ Description:
 		1  Rewritable firmware.
 		== ===============================
 
-What:		/sys/bus/platform/devices/GGL0001:*/BINF.3
+What:		/sys/bus/platform/devices/GOOG0016:*/BINF.3
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -22,7 +22,7 @@ Description:
 		3  Netboot (factory installation only).
 		== =====================================
 
-What:		/sys/bus/platform/devices/GGL0001:*/CHSW
+What:		/sys/bus/platform/devices/GOOG0016:*/CHSW
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -37,28 +37,28 @@ Description:
 		512  Firmware write protection was disabled.
 		==== ===========================================
 
-What:		/sys/bus/platform/devices/GGL0001:*/FMAP
+What:		/sys/bus/platform/devices/GOOG0016:*/FMAP
 Date:		May 2022
 KernelVersion:	5.19
 Description:
 		Returns physical memory address of the start of the main
 		processor firmware flashmap.
 
-What:		/sys/bus/platform/devices/GGL0001:*/FRID
+What:		/sys/bus/platform/devices/GOOG0016:*/FRID
 Date:		May 2022
 KernelVersion:	5.19
 Description:
 		Returns firmware version for the read-only portion of the
 		main processor firmware.
 
-What:		/sys/bus/platform/devices/GGL0001:*/FWID
+What:		/sys/bus/platform/devices/GOOG0016:*/FWID
 Date:		May 2022
 KernelVersion:	5.19
 Description:
 		Returns firmware version for the rewritable portion of the
 		main processor firmware.
 
-What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.0
+What:		/sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.0
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -72,7 +72,7 @@ Description:
 		256 to 511  Debug header GPIO 0 to GPIO 255.
 		=========== ==================================
 
-What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.1
+What:		/sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.1
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -83,26 +83,26 @@ Description:
 		1  Signal is active high.
 		== =======================
 
-What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.2
+What:		/sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.2
 Date:		May 2022
 KernelVersion:	5.19
 Description:
 		Returns the GPIO number on the specified GPIO
 		controller.
 
-What:		/sys/bus/platform/devices/GGL0001:*/GPIO.X/GPIO.3
+What:		/sys/bus/platform/devices/GOOG0016:*/GPIO.X/GPIO.3
 Date:		May 2022
 KernelVersion:	5.19
 Description:
 		Returns name of the GPIO controller.
 
-What:		/sys/bus/platform/devices/GGL0001:*/HWID
+What:		/sys/bus/platform/devices/GOOG0016:*/HWID
 Date:		May 2022
 KernelVersion:	5.19
 Description:
 		Returns hardware ID for the Chromebook.
 
-What:		/sys/bus/platform/devices/GGL0001:*/MECK
+What:		/sys/bus/platform/devices/GOOG0016:*/MECK
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -112,7 +112,7 @@ Description:
 		Engine firmware has not changed. If Management Engine is not
 		present, or if the firmware was unable to read the extended registers, this buffer size can be zero.
 
-What:		/sys/bus/platform/devices/GGL0001:*/VBNV.0
+What:		/sys/bus/platform/devices/GOOG0016:*/VBNV.0
 Date:		May 2022
 KernelVersion:	5.19
 Description:
@@ -121,14 +121,14 @@ Description:
 		(that is, 'offset = 0' is the byte following the 14 bytes of
 		clock data).
 
-What:		/sys/bus/platform/devices/GGL0001:*/VBNV.1
+What:		/sys/bus/platform/devices/GOOG0016:*/VBNV.1
 Date:		May 2022
 KernelVersion:	5.19
 Description:
 		Return the size in bytes of the verified boot non-volatile
 		storage block.
 
-What:		/sys/bus/platform/devices/GGL0001:*/VDAT
+What:		/sys/bus/platform/devices/GOOG0016:*/VDAT
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

