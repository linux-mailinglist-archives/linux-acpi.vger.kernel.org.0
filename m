Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CD7426ED1
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 18:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhJHQ10 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 12:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234046AbhJHQ1V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Oct 2021 12:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633710325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/WfrjlVFI3UoM80QLcnkyIdhiDPP7lbAiyBSN78tQo=;
        b=bvkcSOu3Izv4U3c9MFKiS8UePodNl48DTOwhabuV6YencM4UlJBUYoEbxtqIdj0t5H0itB
        kY+ST7LMXNZOd0/kbr89LdFCaE78VVirETMlTIy6xu7hkVo53sNSLjqipYPftYMwJjiktx
        o8Lmrc/HBCpT0y3l+bUgxNlp+1YAQOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-gFyrJz9RMIOsjFhtfYBCQw-1; Fri, 08 Oct 2021 12:25:24 -0400
X-MC-Unique: gFyrJz9RMIOsjFhtfYBCQw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D15718B3408;
        Fri,  8 Oct 2021 16:22:50 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2503460C0F;
        Fri,  8 Oct 2021 16:22:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 04/12] platform_data: Add linux/platform_data/tps68470.h file
Date:   Fri,  8 Oct 2021 18:21:13 +0200
Message-Id: <20211008162121.6628-5-hdegoede@redhat.com>
In-Reply-To: <20211008162121.6628-1-hdegoede@redhat.com>
References: <20211008162121.6628-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The clk and regulator frameworks expect clk/regulator consumer-devices
to have info about the consumed clks/regulators described in the device's
fw_node.

To work around cases where this info is not present in the firmware tables,
which is often the case on x86/ACPI devices, both frameworks allow the
provider-driver to attach info about consumers to the provider-device
during probe/registration of the provider device.

The TI TPS68470 PMIC is used x86/ACPI devices with the consumer-info
missing from the ACPI tables. Thus the tps68470-clk and tps68470-regulator
drivers must provide the consumer-info at probe time.

Define tps68470_clk_platform_data and tps68470_regulator_platform_data
structs to allow the x86 platform code to pass the necessary consumer info
to these drivers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/linux/platform_data/tps68470.h | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 include/linux/platform_data/tps68470.h

diff --git a/include/linux/platform_data/tps68470.h b/include/linux/platform_data/tps68470.h
new file mode 100644
index 000000000000..126d082c3f2e
--- /dev/null
+++ b/include/linux/platform_data/tps68470.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * TI TPS68470 PMIC platform data definition.
+ *
+ * Copyright (c) 2021 Red Hat Inc.
+ *
+ * Red Hat authors:
+ * Hans de Goede <hdegoede@redhat.com>
+ */
+#ifndef __PDATA_TPS68470_H
+#define __PDATA_TPS68470_H
+
+enum tps68470_regulators {
+	TPS68470_CORE,
+	TPS68470_ANA,
+	TPS68470_VCM,
+	TPS68470_VIO,
+	TPS68470_VSIO,
+	TPS68470_AUX1,
+	TPS68470_AUX2,
+	TPS68470_NUM_REGULATORS
+};
+
+struct regulator_init_data;
+
+struct tps68470_regulator_platform_data {
+	const struct regulator_init_data *reg_init_data[TPS68470_NUM_REGULATORS];
+};
+
+struct tps68470_clk_platform_data {
+	const char *consumer_dev_name;
+	const char *consumer_con_id;
+};
+
+#endif
-- 
2.31.1

