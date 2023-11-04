Return-Path: <linux-acpi+bounces-1238-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FF67E1168
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 23:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB212814B5
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 22:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FF62628E
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYg4WdNu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640024A04
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 20:58:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF89D66
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699131517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kxn/CA8QqqELJZfqiaqUQ4EUf+IVUlLXmqNdlz2zfhw=;
	b=MYg4WdNuz2dM51w8KXLHePlkZohJh4/pyFpHPt326Zr0toZ2Z9Zp1CU/+fGLZnSy9Hoozz
	ubWe3KEAbS4VQVhg0G5/lfKRtIP2su09kmCLfR+YyX7Uq/jIj6lg1IHu7C90kgI+tR3Lxw
	+vzKBmChRXsgXfdGbBYIxfziXqutlXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-4uiq1WNSPFyvrl_hQiKn6A-1; Sat, 04 Nov 2023 16:58:33 -0400
X-MC-Unique: 4uiq1WNSPFyvrl_hQiKn6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 513A1185A785;
	Sat,  4 Nov 2023 20:58:33 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 889232026D4C;
	Sat,  4 Nov 2023 20:58:32 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 4/4] platform/x86: x86-android-tablets: Fix backlight ctrl for Lenovo Yoga Tab 3 Pro YT3-X90F
Date: Sat,  4 Nov 2023 21:58:28 +0100
Message-ID: <20231104205828.63139-4-hdegoede@redhat.com>
In-Reply-To: <20231104205828.63139-1-hdegoede@redhat.com>
References: <20231104205828.63139-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Fix the maximum brightness being much too low on the Yoga Tab 3 Pro.

The LP8557 backlight controller can either be configured to multiply its
PWM input and the I2C register set level (requiring both to be at 100%
for 100% output); or to only take the I2C register set level into account.

Multiplying the 2 levels is useful because this will turn off the backlight
when the panel goes off and turns off its PWM output.

But on the YT3-X90F the panel's PWM output defaults to a duty-cycle of much
less then 100%, severely limiting max brightness. In this case the LP8557
should be configured to only take the I2C register into account and
the i915 driver must turn off the backlight separately using a VBT MIPI
sequence to turn off the backlight.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../platform/x86/x86-android-tablets/lenovo.c | 26 ++++++++++++++++---
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index 0bc6a74b8beb..f1c66a61bfc5 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -34,12 +34,30 @@
  *
  * To avoid having to have a similar hack in the mainline kernel program the
  * LP8557 to directly set the level and use the lp855x_bl driver for control.
+ *
+ * The LP8557 can either be configured to multiply its PWM input and
+ * the I2C register set level (requiring both to be at 100% for 100% output);
+ * or to only take the I2C register set level into account.
+ *
+ * Multiplying the 2 levels is useful because this will turn off the backlight
+ * when the panel goes off and turns off its PWM output.
+ *
+ * But on some models the panel's PWM output defaults to a duty-cycle of
+ * much less then 100%, severely limiting max brightness. In this case
+ * the LP8557 should be configured to only take the I2C register into
+ * account and the i915 driver must turn off the panel and the backlight
+ * separately using e.g. VBT MIPI sequences to turn off the backlight.
  */
-static struct lp855x_platform_data lenovo_lp8557_pdata = {
+static struct lp855x_platform_data lenovo_lp8557_pwm_and_reg_pdata = {
 	.device_control = 0x86,
 	.initial_brightness = 128,
 };
 
+static struct lp855x_platform_data lenovo_lp8557_reg_only_pdata = {
+	.device_control = 0x85,
+	.initial_brightness = 128,
+};
+
 /* Lenovo Yoga Book X90F / X90L's Android factory img has everything hardcoded */
 
 static const struct property_entry lenovo_yb1_x90_wacom_props[] = {
@@ -122,7 +140,7 @@ static const struct x86_i2c_client_info lenovo_yb1_x90_i2c_clients[] __initconst
 			.type = "lp8557",
 			.addr = 0x2c,
 			.dev_name = "lp8557",
-			.platform_data = &lenovo_lp8557_pdata,
+			.platform_data = &lenovo_lp8557_pwm_and_reg_pdata,
 		},
 		.adapter_path = "\\_SB_.PCI0.I2C4",
 	}, {
@@ -358,7 +376,7 @@ static struct x86_i2c_client_info lenovo_yoga_tab2_830_1050_i2c_clients[] __init
 			.type = "lp8557",
 			.addr = 0x2c,
 			.dev_name = "lp8557",
-			.platform_data = &lenovo_lp8557_pdata,
+			.platform_data = &lenovo_lp8557_pwm_and_reg_pdata,
 		},
 		.adapter_path = "\\_SB_.I2C3",
 	},
@@ -655,7 +673,7 @@ static const struct x86_i2c_client_info lenovo_yt3_i2c_clients[] __initconst = {
 			.type = "lp8557",
 			.addr = 0x2c,
 			.dev_name = "lp8557",
-			.platform_data = &lenovo_lp8557_pdata,
+			.platform_data = &lenovo_lp8557_reg_only_pdata,
 		},
 		.adapter_path = "\\_SB_.PCI0.I2C1",
 	}
-- 
2.41.0


