Return-Path: <linux-acpi+bounces-1533-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 433067ECA98
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 19:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC31B20B50
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A3928E36
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Nov 2023 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/H0pQnx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE84A127
	for <linux-acpi@vger.kernel.org>; Wed, 15 Nov 2023 09:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700070495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fBSVE/NM4ZmtPQSLo8QuKLMytC54qgOAFfh+R4N69ks=;
	b=U/H0pQnxFaTEy5C9DHM4hpq3UqUqnhRVIvd6yrjtFYudVt3Ax60vEbB9XG3pINWhBNhsaW
	XjV2w9Zzddk4lX1zPg1a6aaUyQ3sY2vRsvQjwzGLFbJgaK4pbn3QU1+0ujt6rWSj+eh0gT
	AyOSV08mZBR3fNNv2+eG6n6M1pu2mIQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-xzh8XGF-On2EHpguLvjWCQ-1; Wed,
 15 Nov 2023 12:48:13 -0500
X-MC-Unique: xzh8XGF-On2EHpguLvjWCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 387962824761;
	Wed, 15 Nov 2023 17:48:13 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 884411121306;
	Wed, 15 Nov 2023 17:48:12 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: video: Drop should_check_lcd_flag()
Date: Wed, 15 Nov 2023 18:48:11 +0100
Message-ID: <20231115174811.7571-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Since commit 3dbc80a3e4c5 ("ACPI: video: Make backlight class device
registration a separate step (v2)") acpi_video# backlights are no longer
automatically registered. Instead they now only get registered when
the GPU/KMS driver calls acpi_video_register_backlight() which it only
does when it has detected an internal LCD panel.

This fixes the issue of sometimes a non-working acpi_video# backlight
showing up on Desktops / HDMI-sticks without an internal LCD display
in a more complete and robust manner then the LCD flag check which
gets enabled by the should_check_lcd_flag() helper does.

Therefor the should_check_lcd_flag() helper is no longer necessary.

The lcd_only flag itself is still necessary to only register
a single backlight device (for the right output) on the ESPRIMO Mobile
M9410 which has 2 ACPI video connector nodes with a _BCM control method,
which is the issue for which the flag was originally introduced in
commit e50b9be14ab0 ("ACPI / video: only register backlight for LCD
device").

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c | 56 +--------------------------------------
 1 file changed, 1 insertion(+), 55 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index d321ca7160d9..5eded14f8853 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -67,7 +67,7 @@ MODULE_PARM_DESC(hw_changes_brightness,
 static bool device_id_scheme = false;
 module_param(device_id_scheme, bool, 0444);
 
-static int only_lcd = -1;
+static int only_lcd;
 module_param(only_lcd, int, 0444);
 
 static bool may_report_brightness_keys;
@@ -2141,57 +2141,6 @@ static int __init intel_opregion_present(void)
 	return opregion;
 }
 
-/* Check if the chassis-type indicates there is no builtin LCD panel */
-static bool dmi_is_desktop(void)
-{
-	const char *chassis_type;
-	unsigned long type;
-
-	chassis_type = dmi_get_system_info(DMI_CHASSIS_TYPE);
-	if (!chassis_type)
-		return false;
-
-	if (kstrtoul(chassis_type, 10, &type) != 0)
-		return false;
-
-	switch (type) {
-	case 0x03: /* Desktop */
-	case 0x04: /* Low Profile Desktop */
-	case 0x05: /* Pizza Box */
-	case 0x06: /* Mini Tower */
-	case 0x07: /* Tower */
-	case 0x10: /* Lunch Box */
-	case 0x11: /* Main Server Chassis */
-		return true;
-	}
-
-	return false;
-}
-
-/*
- * We're seeing a lot of bogus backlight interfaces on newer machines
- * without a LCD such as desktops, servers and HDMI sticks. Checking the
- * lcd flag fixes this, enable this by default on any machines which are:
- * 1.  Win8 ready (where we also prefer the native backlight driver, so
- *     normally the acpi_video code should not register there anyways); *and*
- * 2.1 Report a desktop/server DMI chassis-type, or
- * 2.2 Are an ACPI-reduced-hardware platform (and thus won't use the EC for
-       backlight control)
- */
-static bool should_check_lcd_flag(void)
-{
-	if (!acpi_osi_is_win8())
-		return false;
-
-	if (dmi_is_desktop())
-		return true;
-
-	if (acpi_reduced_hardware())
-		return true;
-
-	return false;
-}
-
 int acpi_video_register(void)
 {
 	int ret = 0;
@@ -2205,9 +2154,6 @@ int acpi_video_register(void)
 		goto leave;
 	}
 
-	if (only_lcd == -1)
-		only_lcd = should_check_lcd_flag();
-
 	dmi_check_system(video_dmi_table);
 
 	ret = acpi_bus_register_driver(&acpi_video_bus);
-- 
2.41.0


