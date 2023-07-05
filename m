Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A870748FC8
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjGEVcD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjGEVcC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D841BC2
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688592634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RIOYZWKFZnnVX+fRZk228ehuIyHNvqiFYc52E4HU1Bw=;
        b=FC4lUvO0FSdL6XQCPS8u7uYxKUWvNy8k3a3mgYnzvAwNxHz08GTp2cYlCL+8j9oMmHJWiU
        HssjCq9FehBDx8ePaHZ4HK0oUcq6/4AQZ2U1kK4/KMbWYNNkFSNiWwlOVxs78zPIydtvwu
        /l0D306PqDXKz7/Y2Ku3HecERiIe9/A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-gl5RHiVwNCqRkbjH5qry8w-1; Wed, 05 Jul 2023 17:30:30 -0400
X-MC-Unique: gl5RHiVwNCqRkbjH5qry8w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 398C73814951;
        Wed,  5 Jul 2023 21:30:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A64D240C2063;
        Wed,  5 Jul 2023 21:30:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Kate Hsuan <hpa@redhat.com>,
        Hao Yao <hao.yao@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v3 05/18] media: ipu-bridge: Make ipu_bridge_init() take a regular struct device as argument
Date:   Wed,  5 Jul 2023 23:29:57 +0200
Message-ID: <20230705213010.390849-6-hdegoede@redhat.com>
In-Reply-To: <20230705213010.390849-1-hdegoede@redhat.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Make ipu_bridge_init() take a regular struct device, rather then
a pci_dev as argument.

This is a preparation patch for making the ipu-bridge code more generic
so that it can be shared with the atomisp driver.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/pci/intel/ipu-bridge.c     | 16 +++++++---------
 drivers/media/pci/intel/ipu-bridge.h     |  4 ++--
 drivers/media/pci/intel/ipu3/ipu3-cio2.c |  2 +-
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 97b544736af2..9027a8d2d176 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -4,7 +4,6 @@
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
-#include <linux/pci.h>
 #include <linux/property.h>
 #include <media/v4l2-fwnode.h>
 
@@ -288,7 +287,7 @@ static void ipu_bridge_unregister_sensors(struct ipu_bridge *bridge)
 
 static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 				     struct ipu_bridge *bridge,
-				     struct pci_dev *ipu)
+				     struct device *dev)
 {
 	struct fwnode_handle *fwnode, *primary;
 	struct ipu_sensor *sensor;
@@ -302,7 +301,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 
 		if (bridge->n_sensors >= IPU_MAX_PORTS) {
 			acpi_dev_put(adev);
-			dev_err(&ipu->dev, "Exceeded available IPU ports\n");
+			dev_err(dev, "Exceeded available IPU ports\n");
 			return -EINVAL;
 		}
 
@@ -362,7 +361,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 
 		ipu_bridge_instantiate_vcm_i2c_client(sensor);
 
-		dev_info(&ipu->dev, "Found supported sensor %s\n",
+		dev_info(dev, "Found supported sensor %s\n",
 			 acpi_dev_name(adev));
 
 		bridge->n_sensors++;
@@ -380,7 +379,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 }
 
 static int ipu_bridge_connect_sensors(struct ipu_bridge *bridge,
-				      struct pci_dev *ipu)
+				      struct device *dev)
 {
 	unsigned int i;
 	int ret;
@@ -389,7 +388,7 @@ static int ipu_bridge_connect_sensors(struct ipu_bridge *bridge,
 		const struct ipu_sensor_config *cfg =
 			&ipu_supported_sensors[i];
 
-		ret = ipu_bridge_connect_sensor(cfg, bridge, ipu);
+		ret = ipu_bridge_connect_sensor(cfg, bridge, dev);
 		if (ret)
 			goto err_unregister_sensors;
 	}
@@ -435,9 +434,8 @@ static int ipu_bridge_sensors_are_ready(void)
 	return ready;
 }
 
-int ipu_bridge_init(struct pci_dev *ipu)
+int ipu_bridge_init(struct device *dev)
 {
-	struct device *dev = &ipu->dev;
 	struct fwnode_handle *fwnode;
 	struct ipu_bridge *bridge;
 	unsigned int i;
@@ -470,7 +468,7 @@ int ipu_bridge_init(struct pci_dev *ipu)
 	for (i = 0; i < IPU_MAX_LANES; i++)
 		bridge->data_lanes[i] = i + 1;
 
-	ret = ipu_bridge_connect_sensors(bridge, ipu);
+	ret = ipu_bridge_connect_sensors(bridge, dev);
 	if (ret || bridge->n_sensors == 0)
 		goto err_unregister_ipu;
 
diff --git a/drivers/media/pci/intel/ipu-bridge.h b/drivers/media/pci/intel/ipu-bridge.h
index 6cce712a0f34..8c1437f252d2 100644
--- a/drivers/media/pci/intel/ipu-bridge.h
+++ b/drivers/media/pci/intel/ipu-bridge.h
@@ -144,9 +144,9 @@ struct ipu_bridge {
 };
 
 #if IS_ENABLED(CONFIG_IPU_BRIDGE)
-int ipu_bridge_init(struct pci_dev *ipu);
+int ipu_bridge_init(struct device *dev);
 #else
-static inline int ipu_bridge_init(struct pci_dev *ipu) { return 0; }
+static inline int ipu_bridge_init(struct device *dev) { return 0; }
 #endif
 
 #endif
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index dc09fbdb062b..4068fa0a5ecf 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1725,7 +1725,7 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 			return -EINVAL;
 		}
 
-		r = ipu_bridge_init(pci_dev);
+		r = ipu_bridge_init(dev);
 		if (r)
 			return r;
 	}
-- 
2.41.0

