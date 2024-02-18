Return-Path: <linux-acpi+bounces-3665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0F0859792
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 16:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491F728169E
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A16BFDB;
	Sun, 18 Feb 2024 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W7a43Pyp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA11E535
	for <linux-acpi@vger.kernel.org>; Sun, 18 Feb 2024 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708269343; cv=none; b=bKxYhHszLO0dDRtYkeK8FDSDWNWw49TyXyL6RIGwBnVdcqbigmOJST/6glSEoY3F0/qQfSR7qb76BWqNhbur1ksSy7cTdEIbr5fhgKAjLkAR1y7dXctk1pi5ezPsWv1eUTuNFWS+/OihnduTOQ8oQWmmStl7RmY9Zk14Z9RwqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708269343; c=relaxed/simple;
	bh=47gYo+6V4NcqdbeCjPKxECWzFOEikvDHDEcE27qBXnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zeu/sp7w3M0jCVj7bNa8RafDGiDEE1MRM2U1W5HR371t+C1mmoFXt9IrkRNYuMolA4wIqrsMgpHWvKtc+M8NHjGjmmJk16fGr3gXgSJRCGEK00j+34AOY0cSFshFiiBUpN2axhZXM7i2BboWKVz0IxpQxpsUNvyI3g+Hcs+QGOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W7a43Pyp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708269340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DvS7py2O5sHCpgd6/qQ9PkKedBLMh3VykhNo0lcazUc=;
	b=W7a43PypxbTiI4t2NuXbzN2fJcZlcucAMMe5oa+X2O4vx7/Zzqc/ot2jYz4UolK12l1cwh
	yRcETLQIeVot3Qfk2raRsM/vnVYUYQICZ2CVQ+KfGMXsX0CXU86knPmV2Tx3u06ib0copI
	fpq8evRuHbmqOM6GCNYX5qW+SH/aUjw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-ejna66cBMGqfGLEuEJodEg-1; Sun, 18 Feb 2024 10:15:36 -0500
X-MC-Unique: ejna66cBMGqfGLEuEJodEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3F728489A5;
	Sun, 18 Feb 2024 15:15:35 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 55431200B302;
	Sun, 18 Feb 2024 15:15:35 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [RFC 1/2] ACPI: x86: Move acpi_quirk_skip_serdev_enumeration() out of CONFIG_X86_ANDROID_TABLETS
Date: Sun, 18 Feb 2024 16:15:32 +0100
Message-ID: <20240218151533.5720-2-hdegoede@redhat.com>
In-Reply-To: <20240218151533.5720-1-hdegoede@redhat.com>
References: <20240218151533.5720-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Some recent(ish) Dell AIO devices have a backlight controller board
connected to an UART.

This UART has a DELL0501 HID with CID set to PNP0501 so that the UART is
still handled by 8250_pnp.c. Unfortunately there is no separate ACPI device
with an UartSerialBusV2() resource to model the backlight-controller.

The next patch in this series will use acpi_quirk_skip_serdev_enumeration()
to still create a serdev for this for a backlight driver to bind to
instead of creating a /dev/ttyS0.

This new acpi_quirk_skip_serdev_enumeration() use is not limited to Android
X86 tablets, so move it out of the ifdef CONFIG_X86_ANDROID_TABLETS block.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/x86/utils.c | 18 ++++++++++++++----
 include/acpi/acpi_bus.h  | 22 +++++++++++-----------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index b37a4f44d05f..185176a521ad 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -437,7 +437,7 @@ bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_device *adev)
 }
 EXPORT_SYMBOL_GPL(acpi_quirk_skip_i2c_client_enumeration);
 
-int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
+static int acpi_dmi_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
 {
 	struct acpi_device *adev = ACPI_COMPANION(controller_parent);
 	const struct dmi_system_id *dmi_id;
@@ -445,8 +445,6 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 	u64 uid;
 	int ret;
 
-	*skip = false;
-
 	ret = acpi_dev_uid_to_integer(adev, &uid);
 	if (ret)
 		return 0;
@@ -472,7 +470,6 @@ int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *s
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(acpi_quirk_skip_serdev_enumeration);
 
 bool acpi_quirk_skip_gpio_event_handlers(void)
 {
@@ -487,8 +484,21 @@ bool acpi_quirk_skip_gpio_event_handlers(void)
 	return (quirks & ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS);
 }
 EXPORT_SYMBOL_GPL(acpi_quirk_skip_gpio_event_handlers);
+#else
+static int acpi_dmi_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
+{
+	return 0;
+}
 #endif
 
+int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
+{
+	*skip = false;
+
+	return acpi_dmi_skip_serdev_enumeration(controller_parent, skip);
+}
+EXPORT_SYMBOL_GPL(acpi_quirk_skip_serdev_enumeration);
+
 /* Lists of PMIC ACPI HIDs with an (often better) native charger driver */
 static const struct {
 	const char *hid;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e4d24d3f9abb..446225aada50 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -749,6 +749,7 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 bool acpi_quirk_skip_acpi_ac_and_battery(void);
 int acpi_install_cmos_rtc_space_handler(acpi_handle handle);
 void acpi_remove_cmos_rtc_space_handler(acpi_handle handle);
+int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip);
 #else
 static inline bool acpi_device_override_status(struct acpi_device *adev,
 					       unsigned long long *status)
@@ -766,23 +767,22 @@ static inline int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
 static inline void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
 {
 }
-#endif
-
-#if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
-bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_device *adev);
-int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip);
-bool acpi_quirk_skip_gpio_event_handlers(void);
-#else
-static inline bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_device *adev)
-{
-	return false;
-}
 static inline int
 acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, bool *skip)
 {
 	*skip = false;
 	return 0;
 }
+#endif
+
+#if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
+bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_device *adev);
+bool acpi_quirk_skip_gpio_event_handlers(void);
+#else
+static inline bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_device *adev)
+{
+	return false;
+}
 static inline bool acpi_quirk_skip_gpio_event_handlers(void)
 {
 	return false;
-- 
2.43.0


