Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8F4491509
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jan 2022 03:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbiARCZt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jan 2022 21:25:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38308 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244678AbiARCYH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jan 2022 21:24:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2A71B8123D;
        Tue, 18 Jan 2022 02:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E16C36AF2;
        Tue, 18 Jan 2022 02:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642472643;
        bh=QbywbAkiZZf7B4uSrLQeF2h38uZrBQBQWJ34uLHNb1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3jLKWfex8vJ13oqWDJ9oS2+wcgstozXwJs377N9NXrY4Al43WeTsblJ7z/EP8NRJ
         HQCopZ8v7K87xKZpTMWM3bklsLbnCdbsb/fy9U6kn2Tsa2nD3gG4xgeTOoO6zdaGLd
         mX4Cds2FaYDrCMTNOo2cBne09KWttqHjn7elYv7ERm8rAxnT+mh/g4fh8luwN5zbXd
         xSmKFzLybr6AsEfjBYtra/zenNRVdzlHDIABFiGTQHZkWQ1xWfOfSoX1i9dqjhbuEq
         bp76s2040+TbS8ofjKnH3yyXQMK/raUMeBhD8rSNxGEcLeAgg0dAYXnhI5qaDKD12Y
         M3shObYdFhS/Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        robert.moore@intel.com, mario.limonciello@amd.com,
        linux-acpi@vger.kernel.org, devel@acpica.org
Subject: [PATCH AUTOSEL 5.16 085/217] ACPI: Change acpi_device_always_present() into acpi_device_override_status()
Date:   Mon, 17 Jan 2022 21:17:28 -0500
Message-Id: <20220118021940.1942199-85-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118021940.1942199-1-sashal@kernel.org>
References: <20220118021940.1942199-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1a68b346a2c9969c05e80a3b99a9ab160b5655c0 ]

Currently, acpi_bus_get_status() calls acpi_device_always_present() to
allow platform quirks to override the _STA return to report that a
device is present (status = ACPI_STA_DEFAULT) independent of the _STA
return.

In some cases it might also be useful to have the opposite functionality
and have a platform quirk which marks a device as not present (status = 0)
to work around ACPI table bugs.

Change acpi_device_always_present() into a more generic
acpi_device_override_status() function to allow this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/bus.c       |  4 +--
 drivers/acpi/x86/utils.c | 64 +++++++++++++++++++++++-----------------
 include/acpi/acpi_bus.h  |  5 ++--
 3 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index fa923a9292244..dd535b4b9a160 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -98,8 +98,8 @@ int acpi_bus_get_status(struct acpi_device *device)
 	acpi_status status;
 	unsigned long long sta;
 
-	if (acpi_device_always_present(device)) {
-		acpi_set_device_status(device, ACPI_STA_DEFAULT);
+	if (acpi_device_override_status(device, &sta)) {
+		acpi_set_device_status(device, sta);
 		return 0;
 	}
 
diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 3bcac98f6eca6..edb4f3fd93dc3 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -22,54 +22,63 @@
  * Some BIOS-es (temporarily) hide specific APCI devices to work around Windows
  * driver bugs. We use DMI matching to match known cases of this.
  *
- * We work around this by always reporting ACPI_STA_DEFAULT for these
- * devices. Note this MUST only be done for devices where this is safe.
+ * Likewise sometimes some not-actually present devices are sometimes
+ * reported as present, which may cause issues.
  *
- * This forcing of devices to be present is limited to specific CPU (SoC)
- * models both to avoid potentially causing trouble on other models and
- * because some HIDs are re-used on different SoCs for completely
- * different devices.
+ * We work around this by using the below quirk list to override the status
+ * reported by the _STA method with a fixed value (ACPI_STA_DEFAULT or 0).
+ * Note this MUST only be done for devices where this is safe.
+ *
+ * This status overriding is limited to specific CPU (SoC) models both to
+ * avoid potentially causing trouble on other models and because some HIDs
+ * are re-used on different SoCs for completely different devices.
  */
-struct always_present_id {
+struct override_status_id {
 	struct acpi_device_id hid[2];
 	struct x86_cpu_id cpu_ids[2];
 	struct dmi_system_id dmi_ids[2]; /* Optional */
 	const char *uid;
+	unsigned long long status;
 };
 
-#define X86_MATCH(model)	X86_MATCH_INTEL_FAM6_MODEL(model, NULL)
-
-#define ENTRY(hid, uid, cpu_models, dmi...) {				\
+#define ENTRY(status, hid, uid, cpu_model, dmi...) {			\
 	{ { hid, }, {} },						\
-	{ cpu_models, {} },						\
+	{ X86_MATCH_INTEL_FAM6_MODEL(cpu_model, NULL), {} },		\
 	{ { .matches = dmi }, {} },					\
 	uid,								\
+	status,								\
 }
 
-static const struct always_present_id always_present_ids[] = {
+#define PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
+	ENTRY(ACPI_STA_DEFAULT, hid, uid, cpu_model, dmi)
+
+#define NOT_PRESENT_ENTRY_HID(hid, uid, cpu_model, dmi...) \
+	ENTRY(0, hid, uid, cpu_model, dmi)
+
+static const struct override_status_id override_status_ids[] = {
 	/*
 	 * Bay / Cherry Trail PWM directly poked by GPU driver in win10,
 	 * but Linux uses a separate PWM driver, harmless if not used.
 	 */
-	ENTRY("80860F09", "1", X86_MATCH(ATOM_SILVERMONT), {}),
-	ENTRY("80862288", "1", X86_MATCH(ATOM_AIRMONT), {}),
+	PRESENT_ENTRY_HID("80860F09", "1", ATOM_SILVERMONT, {}),
+	PRESENT_ENTRY_HID("80862288", "1", ATOM_AIRMONT, {}),
 
 	/*
 	 * The INT0002 device is necessary to clear wakeup interrupt sources
 	 * on Cherry Trail devices, without it we get nobody cared IRQ msgs.
 	 */
-	ENTRY("INT0002", "1", X86_MATCH(ATOM_AIRMONT), {}),
+	PRESENT_ENTRY_HID("INT0002", "1", ATOM_AIRMONT, {}),
 	/*
 	 * On the Dell Venue 11 Pro 7130 and 7139, the DSDT hides
 	 * the touchscreen ACPI device until a certain time
 	 * after _SB.PCI0.GFX0.LCD.LCD1._ON gets called has passed
 	 * *and* _STA has been called at least 3 times since.
 	 */
-	ENTRY("SYNA7500", "1", X86_MATCH(HASWELL_L), {
+	PRESENT_ENTRY_HID("SYNA7500", "1", HASWELL_L, {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7130"),
 	      }),
-	ENTRY("SYNA7500", "1", X86_MATCH(HASWELL_L), {
+	PRESENT_ENTRY_HID("SYNA7500", "1", HASWELL_L, {
 		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
 	      }),
@@ -85,19 +94,19 @@ static const struct always_present_id always_present_ids[] = {
 	 * was copy-pasted from the GPD win, so it has a disabled KIOX000A
 	 * node which we should not enable, thus we also check the BIOS date.
 	 */
-	ENTRY("KIOX000A", "1", X86_MATCH(ATOM_AIRMONT), {
+	PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "02/21/2017")
 	      }),
-	ENTRY("KIOX000A", "1", X86_MATCH(ATOM_AIRMONT), {
+	PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		DMI_MATCH(DMI_BIOS_DATE, "03/20/2017")
 	      }),
-	ENTRY("KIOX000A", "1", X86_MATCH(ATOM_AIRMONT), {
+	PRESENT_ENTRY_HID("KIOX000A", "1", ATOM_AIRMONT, {
 		DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		DMI_MATCH(DMI_BOARD_NAME, "Default string"),
 		DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
@@ -105,26 +114,27 @@ static const struct always_present_id always_present_ids[] = {
 	      }),
 };
 
-bool acpi_device_always_present(struct acpi_device *adev)
+bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *status)
 {
 	bool ret = false;
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(always_present_ids); i++) {
-		if (acpi_match_device_ids(adev, always_present_ids[i].hid))
+	for (i = 0; i < ARRAY_SIZE(override_status_ids); i++) {
+		if (acpi_match_device_ids(adev, override_status_ids[i].hid))
 			continue;
 
 		if (!adev->pnp.unique_id ||
-		    strcmp(adev->pnp.unique_id, always_present_ids[i].uid))
+		    strcmp(adev->pnp.unique_id, override_status_ids[i].uid))
 			continue;
 
-		if (!x86_match_cpu(always_present_ids[i].cpu_ids))
+		if (!x86_match_cpu(override_status_ids[i].cpu_ids))
 			continue;
 
-		if (always_present_ids[i].dmi_ids[0].matches[0].slot &&
-		    !dmi_check_system(always_present_ids[i].dmi_ids))
+		if (override_status_ids[i].dmi_ids[0].matches[0].slot &&
+		    !dmi_check_system(override_status_ids[i].dmi_ids))
 			continue;
 
+		*status = override_status_ids[i].status;
 		ret = true;
 		break;
 	}
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 480f9207a4c6b..d6fe27b695c3d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -613,9 +613,10 @@ int acpi_enable_wakeup_device_power(struct acpi_device *dev, int state);
 int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 
 #ifdef CONFIG_X86
-bool acpi_device_always_present(struct acpi_device *adev);
+bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *status);
 #else
-static inline bool acpi_device_always_present(struct acpi_device *adev)
+static inline bool acpi_device_override_status(struct acpi_device *adev,
+					       unsigned long long *status)
 {
 	return false;
 }
-- 
2.34.1

