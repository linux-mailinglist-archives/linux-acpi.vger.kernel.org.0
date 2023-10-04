Return-Path: <linux-acpi+bounces-423-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D577B8555
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 890AD2816DD
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717041C287
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 16:32:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A81BDE8
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 16:23:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DBEDC
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 09:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696436626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCKgDeYs5G2UxuYhogLBnsUuAjSI/jIJLn3GDbWKl68=;
	b=Kgr9THxiV3w9VLmmx0b4dwIsD/ElDQ/7dO34kjuosOpbtg87ebf6ktU33awABusok79qMz
	hOulS2WywM9pXTlsRZzg2402FeZNEmn98+gMFtBNX/9e1nyDHB03rWiCHrGWGN6V5HR3Ry
	rP5Xjcw620BUzqTqxM6qj8u7F+RZSvM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-333-utG86j4yNrClnCeAeKUEZg-1; Wed, 04 Oct 2023 12:23:31 -0400
X-MC-Unique: utG86j4yNrClnCeAeKUEZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5074C98B723;
	Wed,  4 Oct 2023 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D949540C2015;
	Wed,  4 Oct 2023 16:23:29 +0000 (UTC)
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
Subject: [PATCH v3 2/5] platform/x86: int3472: Add new skl_int3472_gpiod_get_from_temp_lookup() helper
Date: Wed,  4 Oct 2023 18:23:14 +0200
Message-ID: <20231004162317.163488-3-hdegoede@redhat.com>
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

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a new skl_int3472_gpiod_get_from_temp_lookup() helper.

This is a preparation patch for removing usage of the deprecated
gpiod_toggle_active_low() and acpi_get_and_request_gpiod() functions.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
[hdegoede@redhat.com] use the new skl_int3472_fill_gpiod_lookup() helper
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Fix wrong size of gpio lookup table allocation. There must also
  be an empty terminating lookup, so 2 entries must be allocated.

Changes in v2:
- Use the new skl_int3472_fill_gpiod_lookup() helper.
---
 drivers/platform/x86/intel/int3472/discrete.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index 351ecf047944..b69ef63f75ab 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -99,6 +99,32 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
 	return 0;
 }
 
+/* This should *really* only be used when there's no other way... */
+static struct gpio_desc *
+skl_int3472_gpiod_get_from_temp_lookup(struct int3472_discrete_device *int3472,
+				       struct acpi_resource_gpio *agpio,
+				       const char *func, u32 polarity)
+{
+	struct gpio_desc *desc;
+	int ret;
+
+	struct gpiod_lookup_table *lookup __free(kfree) =
+			kzalloc(struct_size(lookup, table, 2), GFP_KERNEL);
+	if (!lookup)
+		return ERR_PTR(-ENOMEM);
+
+	lookup->dev_id = dev_name(int3472->dev);
+	ret = skl_int3472_fill_gpiod_lookup(&lookup->table[0], agpio, func, polarity);
+	if (ret)
+		return ERR_PTR(ret);
+
+	gpiod_add_lookup_table(lookup);
+	desc = gpiod_get(int3472->dev, func, GPIOD_OUT_LOW);
+	gpiod_remove_lookup_table(lookup);
+
+	return desc;
+}
+
 static void int3472_get_func_and_polarity(u8 type, const char **func, u32 *polarity)
 {
 	switch (type) {
-- 
2.41.0


