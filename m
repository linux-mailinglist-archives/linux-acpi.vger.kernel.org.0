Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03F54593A1
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Nov 2021 18:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbhKVRJC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Nov 2021 12:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237306AbhKVRJC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Nov 2021 12:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637600755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3yGDxkrWbCgcdS2sbWaIpvcaHaLCUSf/Ag68PKJIm/w=;
        b=NWv57pFUr1Fg3+fiffPvmWXvxH8fG848IIsiB8PkFkChprDWPu+ECZbiOw11YloxyklFNo
        FhboWH6H/fWuwPE4itqOogxmG7G3cLf67G8l0R90OyCx9vIpaLYU07K9fmJiybjSjKkI5r
        yBoLbMvnlI6wa4id+kALRhwSpRDrOnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-FVfN6hq2MR2wEjyhc0uCZQ-1; Mon, 22 Nov 2021 12:05:53 -0500
X-MC-Unique: FVfN6hq2MR2wEjyhc0uCZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CC8C100C66A;
        Mon, 22 Nov 2021 17:05:52 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA9F25D6D5;
        Mon, 22 Nov 2021 17:05:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v2 2/7] ACPI: Change acpi_device_always_present() into acpi_device_override_status()
Date:   Mon, 22 Nov 2021 18:05:31 +0100
Message-Id: <20211122170536.7725-3-hdegoede@redhat.com>
In-Reply-To: <20211122170536.7725-1-hdegoede@redhat.com>
References: <20211122170536.7725-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ATM acpi_bus_get_status() calls acpi_device_always_present() to allow
platform quirks to override the _STA return to report that a device
is present (status = ACPI_STA_DEFAULT) independent of the _STA return.

In some cases it might also be useful to have the opposite functionality
and have a platform quirk which marks a device as not present (status = 0)
to work around ACPI table bugs.

Change acpi_device_always_present() into a more generic
acpi_device_override_status() function to allow this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- No changes in v2 of this patch-series
---
 drivers/acpi/bus.c       |  4 +--
 drivers/acpi/x86/utils.c | 64 +++++++++++++++++++++++-----------------
 include/acpi/acpi_bus.h  |  5 ++--
 3 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index fa923a929224..dd535b4b9a16 100644
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
index 3bcac98f6eca..edb4f3fd93dc 100644
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
index 480f9207a4c6..d6fe27b695c3 100644
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
2.33.1

