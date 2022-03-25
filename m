Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1A4E7247
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Mar 2022 12:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356829AbiCYLf6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Mar 2022 07:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356834AbiCYLfu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Mar 2022 07:35:50 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81986D0AA0;
        Fri, 25 Mar 2022 04:34:14 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1B7B82000A;
        Fri, 25 Mar 2022 11:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648208053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MDm4YP1sE29344rf2R0COIQGSk7+i5VU29q/DiQVbuo=;
        b=fQumbr94pjkHijI+6zW+z78A41y+IOIUv0R9PUVZdKcQ+vXD5q0X9vEBQwhLZnbp7nuXR0
        4PwC6uqutz4MMEHFBFM/MHCYm4ocKnV9T7is0W7K7HwdoG2qazPDvh2JpM9KCoPg9084pp
        2EizFc+ySBSg4DQ5pezyrwFmSKyMwcOx5ZxnzlVh2LYgoFJqvSfXuK0OPAGQdtGF7AoBHk
        kDiiCAk3MSFsH+dtzhB9z8OSq/VEuWEQDWJfM5TYrIlfQT4U4xvUW/85LotXAkcUWiWb2Y
        umuSa2kv89CEHynCm5XDB5eO5KXXAoM4Lczj0Qpm4srEzl2XRUGdyW3BmGbXBQ==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH v3 6/9] i2c: fwnode: add fwnode_find_i2c_adapter_by_node()
Date:   Fri, 25 Mar 2022 12:31:45 +0100
Message-Id: <20220325113148.588163-7-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325113148.588163-1-clement.leger@bootlin.com>
References: <20220325113148.588163-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add fwnode_find_i2c_adapter_by_node() which allows to retrieve a i2c
adapter using a fwnode. Since dev_fwnode() uses the fwnode provided by
the of_node member of the device, this will also work for devices were
the of_node has been set and not the fwnode field.
For acpi nodes, the check for parent node is skipped since
i2c_acpi_find_adapter_by_handle() does not check it and we don't want
to change this behavior.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/i2c/Makefile          |  1 +
 drivers/i2c/i2c-core-fwnode.c | 45 +++++++++++++++++++++++++++++++++++
 include/linux/i2c.h           |  3 +++
 3 files changed, 49 insertions(+)
 create mode 100644 drivers/i2c/i2c-core-fwnode.c

diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index c1d493dc9bac..c9c97675163e 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+= i2c-core.o
 i2c-core-objs 			:= i2c-core-base.o i2c-core-smbus.o
+i2c-core-objs			+= i2c-core-fwnode.o
 i2c-core-$(CONFIG_ACPI)		+= i2c-core-acpi.o
 i2c-core-$(CONFIG_I2C_SLAVE) 	+= i2c-core-slave.o
 i2c-core-$(CONFIG_OF) 		+= i2c-core-of.o
diff --git a/drivers/i2c/i2c-core-fwnode.c b/drivers/i2c/i2c-core-fwnode.c
new file mode 100644
index 000000000000..fb1c820b686e
--- /dev/null
+++ b/drivers/i2c/i2c-core-fwnode.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Linux I2C core fwnode support code
+ *
+ * Copyright (C) 2022 Microchip
+ */
+
+#include <linux/device.h>
+#include <linux/i2c.h>
+
+#include "i2c-core.h"
+
+static int fwnode_dev_or_parent_node_match(struct device *dev, const void *data)
+{
+	if (device_match_fwnode(dev, data))
+		return 1;
+
+	/*
+	 * For ACPI device node, the behavior is to not match the parent (see
+	 * i2c_acpi_find_adapter_by_handle())
+	 */
+	if (!is_acpi_device_node(dev_fwnode(dev)) && dev->parent)
+		return device_match_fwnode(dev->parent, data);
+
+	return 0;
+}
+
+struct i2c_adapter *
+fwnode_find_i2c_adapter_by_node(struct fwnode_handle *fwnode)
+{
+	struct device *dev;
+	struct i2c_adapter *adapter;
+
+	dev = bus_find_device(&i2c_bus_type, NULL, fwnode,
+			      fwnode_dev_or_parent_node_match);
+	if (!dev)
+		return NULL;
+
+	adapter = i2c_verify_adapter(dev);
+	if (!adapter)
+		put_device(dev);
+
+	return adapter;
+}
+EXPORT_SYMBOL(fwnode_find_i2c_adapter_by_node);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 7d4f52ceb7b5..8dadf8c89fd9 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -967,6 +967,9 @@ int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr);
 
 #endif /* I2C */
 
+struct i2c_adapter *
+fwnode_find_i2c_adapter_by_node(struct fwnode_handle *fwnode);
+
 #if IS_ENABLED(CONFIG_OF)
 /* must call put_device() when done with returned i2c_client device */
 struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
-- 
2.34.1

