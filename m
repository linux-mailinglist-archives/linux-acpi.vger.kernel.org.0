Return-Path: <linux-acpi+bounces-1239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053BD7E1169
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 23:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870051F215CF
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 22:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DCF26280
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dk44lO+j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3CE24A15
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 20:58:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7AAD67
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 13:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699131518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQs1SgGeriGT/KTGdmHErJX1vFqxNyAPlIcLeiu5w/0=;
	b=dk44lO+jj4xKHLUUA+t1yf0e8JXebugrkfVyNHDKmfKGaYG/rGY74llksotweXC/knKmGl
	SBC6SNNyNRJ0KlX+IUCyHsQONSAAx5JXB7lR9PGvzVGsgcBDRNF7KAbUyjJT09vPBFuNDZ
	lBnkvZw2iChuzNV8leV81q4aHKSPeTk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-pF22zOmDM7id50awMMiqZg-1; Sat,
 04 Nov 2023 16:58:32 -0400
X-MC-Unique: pF22zOmDM7id50awMMiqZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 572E71C0650B;
	Sat,  4 Nov 2023 20:58:32 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8F6602026D4C;
	Sat,  4 Nov 2023 20:58:31 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 3/4] platform/x86: x86-android-tablets: Add audio codec info for Lenovo Yoga Tab 3 Pro YT3-X90F
Date: Sat,  4 Nov 2023 21:58:27 +0100
Message-ID: <20231104205828.63139-3-hdegoede@redhat.com>
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

The SPI attached WM5102 codec on the Lenovo Yoga Tab 3 Pro YT3-X90F
is not described in the ACPI tables.

Add info to instantiate the SPI device for the codec manually.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Fix identation and style issues in lenovo_yt3_wm5102_pdata initializer
---
 .../platform/x86/x86-android-tablets/lenovo.c | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index c1e68211283f..0bc6a74b8beb 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -12,6 +12,8 @@
 
 #include <linux/efi.h>
 #include <linux/gpio/machine.h>
+#include <linux/mfd/arizona/pdata.h>
+#include <linux/mfd/arizona/registers.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/machine.h>
@@ -659,6 +661,88 @@ static const struct x86_i2c_client_info lenovo_yt3_i2c_clients[] __initconst = {
 	}
 };
 
+/*
+ * The AOSP 3.5 mm Headset: Accessory Specification gives the following values:
+ * Function A Play/Pause:           0 ohm
+ * Function D Voice assistant:    135 ohm
+ * Function B Volume Up           240 ohm
+ * Function C Volume Down         470 ohm
+ * Minimum Mic DC resistance     1000 ohm
+ * Minimum Ear speaker impedance   16 ohm
+ * Note the first max value below must be less then the min. speaker impedance,
+ * to allow CTIA/OMTP detection to work. The other max values are the closest
+ * value from extcon-arizona.c:arizona_micd_levels halfway 2 button resistances.
+ */
+static const struct arizona_micd_range arizona_micd_aosp_ranges[] = {
+	{ .max =  11, .key = KEY_PLAYPAUSE },
+	{ .max = 186, .key = KEY_VOICECOMMAND },
+	{ .max = 348, .key = KEY_VOLUMEUP },
+	{ .max = 752, .key = KEY_VOLUMEDOWN },
+};
+
+/* YT3 WM5102 arizona_micd_config comes from Android kernel sources */
+static struct arizona_micd_config lenovo_yt3_wm5102_micd_config[] = {
+	{ 0, 1, 0 },
+	{ ARIZONA_ACCDET_SRC, 2, 1 },
+};
+
+static struct arizona_pdata lenovo_yt3_wm5102_pdata = {
+	.irq_flags = IRQF_TRIGGER_LOW,
+	.micd_detect_debounce = 200,
+	.micd_ranges = arizona_micd_aosp_ranges,
+	.num_micd_ranges = ARRAY_SIZE(arizona_micd_aosp_ranges),
+	.hpdet_channel = ARIZONA_ACCDET_MODE_HPL,
+
+	/* Below settings come from Android kernel sources */
+	.micd_bias_start_time = 1,
+	.micd_rate = 6,
+	.micd_configs = lenovo_yt3_wm5102_micd_config,
+	.num_micd_configs = ARRAY_SIZE(lenovo_yt3_wm5102_micd_config),
+	.micbias = {
+		[0] = { /* MICBIAS1 */
+			.mV = 2800,
+			.ext_cap = 1,
+			.discharge = 1,
+			.soft_start = 0,
+			.bypass = 0,
+		},
+		[1] = { /* MICBIAS2 */
+			.mV = 2800,
+			.ext_cap = 1,
+			.discharge = 1,
+			.soft_start = 0,
+			.bypass = 0,
+		},
+		[2] = { /* MICBIAS2 */
+			.mV = 2800,
+			.ext_cap = 1,
+			.discharge = 1,
+			.soft_start = 0,
+			.bypass = 0,
+		},
+	},
+};
+
+static const struct x86_spi_dev_info lenovo_yt3_spi_devs[] __initconst = {
+	{
+		/* WM5102 codec */
+		.board_info = {
+			.modalias = "wm5102",
+			.platform_data = &lenovo_yt3_wm5102_pdata,
+			.max_speed_hz = 5000000,
+		},
+		.ctrl_path = "\\_SB_.PCI0.SPI1",
+		.irq_data = {
+			.type = X86_ACPI_IRQ_TYPE_GPIOINT,
+			.chip = "INT33FF:00",
+			.index = 91,
+			.trigger = ACPI_LEVEL_SENSITIVE,
+			.polarity = ACPI_ACTIVE_LOW,
+			.con_id = "wm5102_irq",
+		},
+	}
+};
+
 static int __init lenovo_yt3_init(void)
 {
 	int ret;
@@ -702,14 +786,28 @@ static struct gpiod_lookup_table lenovo_yt3_hideep_gpios = {
 	},
 };
 
+static struct gpiod_lookup_table lenovo_yt3_wm5102_gpios = {
+	.dev_id = "spi1.0",
+	.table = {
+		GPIO_LOOKUP("INT33FF:00", 75, "wlf,spkvdd-ena", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("INT33FF:00", 81, "wlf,ldoena", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("INT33FF:00", 82, "reset", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("arizona", 2, "wlf,micd-pol", GPIO_ACTIVE_HIGH),
+		{ }
+	},
+};
+
 static struct gpiod_lookup_table * const lenovo_yt3_gpios[] = {
 	&lenovo_yt3_hideep_gpios,
+	&lenovo_yt3_wm5102_gpios,
 	NULL
 };
 
 const struct x86_dev_info lenovo_yt3_info __initconst = {
 	.i2c_client_info = lenovo_yt3_i2c_clients,
 	.i2c_client_count = ARRAY_SIZE(lenovo_yt3_i2c_clients),
+	.spi_dev_info = lenovo_yt3_spi_devs,
+	.spi_dev_count = ARRAY_SIZE(lenovo_yt3_spi_devs),
 	.gpiod_lookup_tables = lenovo_yt3_gpios,
 	.init = lenovo_yt3_init,
 };
-- 
2.41.0


