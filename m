Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1DB637FF6
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Nov 2022 20:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKXT7N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Nov 2022 14:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiKXT7J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Nov 2022 14:59:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAB92701
        for <linux-acpi@vger.kernel.org>; Thu, 24 Nov 2022 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669319866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kSYyhzQPfz68JBO1GSnCmXiXgzkI4gleaHz5wVtm2sk=;
        b=SnvPPxWEiRW+wMmM5q4y32R8wmgXk/dK1e7TkSDtG8z1OxNTsS2BFLNHk8WyClOjbIZGxl
        k5VpkdqwfR7o23UNU30csGTb9ShQLDtdD/JQABVwR4SoFDH0emFMKaMursUbRJZqCsgcnj
        gI/m9uU5mrxQkaYIKZmAoZLB4hfQ7IA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-9g6tJMaIPI61jKTEuPtqYQ-1; Thu, 24 Nov 2022 14:57:43 -0500
X-MC-Unique: 9g6tJMaIPI61jKTEuPtqYQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C24D11C05AAC;
        Thu, 24 Nov 2022 19:57:42 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 350D24022D5;
        Thu, 24 Nov 2022 19:57:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 2/3] platform/x86: int3472/discrete: Get the polarity from the _DSM entry
Date:   Thu, 24 Nov 2022 20:57:36 +0100
Message-Id: <20221124195737.390729-3-hdegoede@redhat.com>
In-Reply-To: <20221124195737.390729-1-hdegoede@redhat.com>
References: <20221124195737.390729-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The out of tree IPU6 driver has moved to also using the in kernel INT3472
code for doing power-ctrl rather then doing their own thing (good!).

On IPU6 the polarity is encoded in the _DSM entry rather then being
hardcoded to GPIO_ACTIVE_LOW.

Using the _DSM entry for this on IPU3 leads to regressions, so only
use the _DSM entry for this on non IPU3 devices.

Note there is a whole bunch of PCI-ids for the IPU6 which is why
the check is for the IPU3-CIO2, because the CIO2 there has a unique
PCI-id which can be used for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/int3472/discrete.c | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index bc6c62f3f3bf..9159291be28a 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/uuid.h>
 
@@ -36,6 +37,19 @@ static const guid_t cio2_sensor_module_guid =
 	GUID_INIT(0x822ace8f, 0x2814, 0x4174,
 		  0xa5, 0x6b, 0x5f, 0x02, 0x9f, 0xe0, 0x79, 0xee);
 
+/* IPU3 vs IPU6 needs to be handled differently */
+#define IPU3_CIO2_PCI_ID				0x9d32
+
+static const struct pci_device_id ipu3_cio2_pci_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, IPU3_CIO2_PCI_ID) },
+	{ }
+};
+
+static int ipu3_present(void)
+{
+	return pci_dev_present(ipu3_cio2_pci_id_table);
+}
+
 /*
  * Here follows platform specific mapping information that we can pass to
  * the functions mapping resources to the sensors. Where the sensors have
@@ -242,6 +256,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 	union acpi_object *obj;
 	const char *err_msg;
 	const char *func;
+	u32 polarity;
 	int ret;
 	u8 type;
 
@@ -265,13 +280,22 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 
 	type = obj->integer.value & 0xff;
 
+	/* IPU3 always uses active-low, IPU6 polarity is encoded in the _DSM entry. */
+	if (ipu3_present())
+		polarity = GPIO_ACTIVE_LOW;
+	else
+		polarity = ((obj->integer.value >> 24) & 0xff) ? GPIO_ACTIVE_HIGH : GPIO_ACTIVE_LOW;
+
 	func = int3472_dsm_type_to_func(type);
 
+	dev_dbg(int3472->dev, "%s %s pin %d active-%s\n", func,
+		agpio->resource_source.string_ptr, agpio->pin_table[0],
+		(polarity == GPIO_ACTIVE_HIGH) ? "high" : "low");
+
 	switch (type) {
 	case INT3472_GPIO_TYPE_RESET:
 	case INT3472_GPIO_TYPE_POWERDOWN:
-		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, func,
-						     GPIO_ACTIVE_LOW);
+		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, func, polarity);
 		if (ret)
 			err_msg = "Failed to map GPIO pin to sensor\n";
 
-- 
2.38.1

