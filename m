Return-Path: <linux-acpi+bounces-419-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D43E7B8551
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 18:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3F86D2816EE
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234131BDFE
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 16:32:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE31BDC3
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 16:23:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E8195
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696436611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxlB9jGPDkVTrNs+dLX6hYItM8N/DBvuylNLWowa8UI=;
	b=iwwoS4MluQllVM0xxku5VXOR8e0OGJ7inPtVvBgibh/u/GJM43nGCFDkFkSoiHOQT2YpqP
	pTPhOaJZxoQ0iJuRH//SmRYY8Cp8Q7rCqNAa3ok5yAA2ayYToa6BFilQKQDpPUNgyM10VU
	1lrTI7RG5VZLH3CdWkkZd2hlaq2xLIk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-kczh6-UgOn2uLNeDCCXT6w-1; Wed, 04 Oct 2023 12:23:30 -0400
X-MC-Unique: kczh6-UgOn2uLNeDCCXT6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A71B11C04B58;
	Wed,  4 Oct 2023 16:23:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3AD8A40C2015;
	Wed,  4 Oct 2023 16:23:28 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v3 1/5] platform/x86: int3472: Add new skl_int3472_fill_gpiod_lookup() helper
Date: Wed,  4 Oct 2023 18:23:13 +0200
Message-ID: <20231004162317.163488-2-hdegoede@redhat.com>
In-Reply-To: <20231004162317.163488-1-hdegoede@redhat.com>
References: <20231004162317.163488-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a new skl_int3472_fill_gpiod_lookup() helper.

This is a preparation patch for removing usage of the deprecated
gpiod_toggle_active_low() and acpi_get_and_request_gpiod() functions.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 32 +++++++++++++------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index e33c2d75975c..351ecf047944 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -52,21 +52,15 @@ static void skl_int3472_log_sensor_module_name(struct int3472_discrete_device *i
 	}
 }
 
-static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int3472,
-					  struct acpi_resource_gpio *agpio,
-					  const char *func, u32 polarity)
+static int skl_int3472_fill_gpiod_lookup(struct gpiod_lookup *table_entry,
+					 struct acpi_resource_gpio *agpio,
+					 const char *func, u32 polarity)
 {
 	char *path = agpio->resource_source.string_ptr;
-	struct gpiod_lookup *table_entry;
 	struct acpi_device *adev;
 	acpi_handle handle;
 	acpi_status status;
 
-	if (int3472->n_sensor_gpios >= INT3472_MAX_SENSOR_GPIOS) {
-		dev_warn(int3472->dev, "Too many GPIOs mapped\n");
-		return -EINVAL;
-	}
-
 	status = acpi_get_handle(NULL, path, &handle);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
@@ -75,13 +69,31 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
 	if (!adev)
 		return -ENODEV;
 
-	table_entry = &int3472->gpios.table[int3472->n_sensor_gpios];
 	table_entry->key = acpi_dev_name(adev);
 	table_entry->chip_hwnum = agpio->pin_table[0];
 	table_entry->con_id = func;
 	table_entry->idx = 0;
 	table_entry->flags = polarity;
 
+	return 0;
+}
+
+static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int3472,
+					  struct acpi_resource_gpio *agpio,
+					  const char *func, u32 polarity)
+{
+	int ret;
+
+	if (int3472->n_sensor_gpios >= INT3472_MAX_SENSOR_GPIOS) {
+		dev_warn(int3472->dev, "Too many GPIOs mapped\n");
+		return -EINVAL;
+	}
+
+	ret = skl_int3472_fill_gpiod_lookup(&int3472->gpios.table[int3472->n_sensor_gpios],
+					    agpio, func, polarity);
+	if (ret)
+		return ret;
+
 	int3472->n_sensor_gpios++;
 
 	return 0;
-- 
2.41.0


