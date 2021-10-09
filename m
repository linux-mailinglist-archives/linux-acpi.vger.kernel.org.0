Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD67427BA1
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Oct 2021 18:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhJIQIV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Oct 2021 12:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230386AbhJIQIN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Oct 2021 12:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633795576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/WfrjlVFI3UoM80QLcnkyIdhiDPP7lbAiyBSN78tQo=;
        b=OIFjQUijQ/xQkI2IhjrdaUJoloLmuprXN1HAmKqojFakAcpWIfDsEW26noX9WBIR8RXbqS
        BMcCnO4nycU5fkX2G5kfqJ7VmAHf8v/drn6dNmvieWB23OT+qCs2D1b1aZnQi/4p4ucISn
        6drYc5zp3t1b9gVQYFJkRvx1RYdkf/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-FoCq71MJNQOdWAcf2YG3fg-1; Sat, 09 Oct 2021 12:06:10 -0400
X-MC-Unique: FoCq71MJNQOdWAcf2YG3fg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB06B1808304;
        Sat,  9 Oct 2021 16:06:08 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EA095C1B4;
        Sat,  9 Oct 2021 16:06:05 +0000 (UTC)
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
Subject: [PATCH v2 03/13] platform_data: Add linux/platform_data/tps68470.h file
Date:   Sat,  9 Oct 2021 18:05:38 +0200
Message-Id: <20211009160548.306550-4-hdegoede@redhat.com>
In-Reply-To: <20211009160548.306550-1-hdegoede@redhat.com>
References: <20211009160548.306550-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

