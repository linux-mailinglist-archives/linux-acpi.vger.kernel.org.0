Return-Path: <linux-acpi+bounces-1237-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D1F7E1167
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 23:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091E0281452
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 22:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57B32629A
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8LtynpC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291AD24A04
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 20:58:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B1CD64
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 13:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699131512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuWj4wrV9zaKh/jpJVFwSK8WbIq3siZjo2RbPjHRdzM=;
	b=d8LtynpCTrD3DMASIei8MvoTRsVMkCXvA1y9vyHQzxhNq76jln/vb79W8781edR0nrTN3j
	i8PPhHDiJbi2Uf0WjdrZOqAj0iwzgw0VXxRX3mpIfI2TZteapEs4WFZ0dW0A7LkxJ8Lb2M
	emzx5mq43RQGGKm1ueXq6iD8fkpz6do=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-c_VZuYWRM1KjXK4VhjG-pQ-1; Sat, 04 Nov 2023 16:58:31 -0400
X-MC-Unique: c_VZuYWRM1KjXK4VhjG-pQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D35280C343;
	Sat,  4 Nov 2023 20:58:31 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94A0C2026D4C;
	Sat,  4 Nov 2023 20:58:30 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 2/4] platform/x86: x86-android-tablets: Add support for SPI device instantiation
Date: Sat,  4 Nov 2023 21:58:26 +0100
Message-ID: <20231104205828.63139-2-hdegoede@redhat.com>
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

Some x86 Android tablets have SPI devices which are not properly described
in their DSDT. Add support for instantiating SPI devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../platform/x86/x86-android-tablets/core.c   | 62 +++++++++++++++++++
 .../x86-android-tablets/x86-android-tablets.h |  9 +++
 2 files changed, 71 insertions(+)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index b55957bde034..6a5975ac3286 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -141,9 +141,11 @@ int x86_acpi_irq_helper_get(const struct x86_acpi_irq_data *data)
 }
 
 static int i2c_client_count;
+static int spi_dev_count;
 static int pdev_count;
 static int serdev_count;
 static struct i2c_client **i2c_clients;
+static struct spi_device **spi_devs;
 static struct platform_device **pdevs;
 static struct serdev_device **serdevs;
 static struct gpio_keys_button *buttons;
@@ -185,6 +187,46 @@ static __init int x86_instantiate_i2c_client(const struct x86_dev_info *dev_info
 	return 0;
 }
 
+static __init int x86_instantiate_spi_dev(const struct x86_dev_info *dev_info, int idx)
+{
+	const struct x86_spi_dev_info *spi_dev_info = &dev_info->spi_dev_info[idx];
+	struct spi_board_info board_info = spi_dev_info->board_info;
+	struct spi_controller *controller;
+	struct acpi_device *adev;
+	acpi_handle handle;
+	acpi_status status;
+
+	board_info.irq = x86_acpi_irq_helper_get(&spi_dev_info->irq_data);
+	if (board_info.irq < 0)
+		return board_info.irq;
+
+	status = acpi_get_handle(NULL, spi_dev_info->ctrl_path, &handle);
+	if (ACPI_FAILURE(status)) {
+		pr_err("Error could not get %s handle\n", spi_dev_info->ctrl_path);
+		return -ENODEV;
+	}
+
+	adev = acpi_fetch_acpi_dev(handle);
+	if (!adev) {
+		pr_err("Error could not get adev for %s\n", spi_dev_info->ctrl_path);
+		return -ENODEV;
+	}
+
+	controller = acpi_spi_find_controller_by_adev(adev);
+	if (!controller) {
+		pr_err("Error could not get SPI controller for %s\n", spi_dev_info->ctrl_path);
+		return -ENODEV;
+	}
+
+	spi_devs[idx] = spi_new_device(controller, &board_info);
+	put_device(&controller->dev);
+	if (IS_ERR(spi_devs[idx]))
+		return dev_err_probe(&controller->dev, PTR_ERR(spi_devs[idx]),
+				     "creating SPI-device %d\n", idx);
+
+	return 0;
+}
+
 static __init int x86_instantiate_serdev(const struct x86_serdev_info *info, int idx)
 {
 	struct acpi_device *ctrl_adev, *serdev_adev;
@@ -263,6 +305,11 @@ static void x86_android_tablet_remove(struct platform_device *pdev)
 	kfree(pdevs);
 	kfree(buttons);
 
+	for (i = 0; i < spi_dev_count; i++)
+		spi_unregister_device(spi_devs[i]);
+
+	kfree(spi_devs);
+
 	for (i = 0; i < i2c_client_count; i++)
 		i2c_unregister_device(i2c_clients[i]);
 
@@ -333,6 +380,21 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 		}
 	}
 
+	spi_devs = kcalloc(dev_info->spi_dev_count, sizeof(*spi_devs), GFP_KERNEL);
+	if (!spi_devs) {
+		x86_android_tablet_remove(pdev);
+		return -ENOMEM;
+	}
+
+	spi_dev_count = dev_info->spi_dev_count;
+	for (i = 0; i < spi_dev_count; i++) {
+		ret = x86_instantiate_spi_dev(dev_info, i);
+		if (ret < 0) {
+			x86_android_tablet_remove(pdev);
+			return ret;
+		}
+	}
+
 	/* + 1 to make space for (optional) gpio_keys_button pdev */
 	pdevs = kcalloc(dev_info->pdev_count + 1, sizeof(*pdevs), GFP_KERNEL);
 	if (!pdevs) {
diff --git a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
index 9d2fb7fded6d..49fed9410adb 100644
--- a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
+++ b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
@@ -14,6 +14,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/i2c.h>
 #include <linux/irqdomain_defs.h>
+#include <linux/spi/spi.h>
 
 struct gpio_desc;
 struct gpiod_lookup_table;
@@ -48,6 +49,12 @@ struct x86_i2c_client_info {
 	struct x86_acpi_irq_data irq_data;
 };
 
+struct x86_spi_dev_info {
+	struct spi_board_info board_info;
+	char *ctrl_path;
+	struct x86_acpi_irq_data irq_data;
+};
+
 struct x86_serdev_info {
 	const char *ctrl_hid;
 	const char *ctrl_uid;
@@ -72,10 +79,12 @@ struct x86_dev_info {
 	const struct software_node *bat_swnode;
 	struct gpiod_lookup_table * const *gpiod_lookup_tables;
 	const struct x86_i2c_client_info *i2c_client_info;
+	const struct x86_spi_dev_info *spi_dev_info;
 	const struct platform_device_info *pdev_info;
 	const struct x86_serdev_info *serdev_info;
 	const struct x86_gpio_button *gpio_button;
 	int i2c_client_count;
+	int spi_dev_count;
 	int pdev_count;
 	int serdev_count;
 	int gpio_button_count;
-- 
2.41.0


