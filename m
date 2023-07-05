Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D6A748FD5
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjGEVcT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjGEVcL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7A71BD5
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688592640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9Bd8/Rp4jdRCxy0KSQZbBQIKQPGfl3txo4ktjY0yMg=;
        b=OmIwp9qDrw9N+CvqHz/Doqo9vDFD4k08hm3o94iKUn6bp6rHzBghOP/1ri/uTBwNYl5MOR
        UDJSb/CJev80Lk7zyR1tovpI6QkO+8uolbsLItmbURktv1kFzoMDMx3CZBCr/mbfoogz6N
        1s+hhtoLBYRBj93ka2XQ5MD7g7uBKHY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-cn7oAmxcOT6GmRSglOJqyQ-1; Wed, 05 Jul 2023 17:30:39 -0400
X-MC-Unique: cn7oAmxcOT6GmRSglOJqyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08F1685A58A;
        Wed,  5 Jul 2023 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 782F440C2063;
        Wed,  5 Jul 2023 21:30:37 +0000 (UTC)
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
Subject: [PATCH v3 10/18] media: ipu-bridge: Add a parse_sensor_fwnode callback to ipu_bridge_init()
Date:   Wed,  5 Jul 2023 23:30:02 +0200
Message-ID: <20230705213010.390849-11-hdegoede@redhat.com>
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

Add a parse_sensor_fwnode() callback to ipu_bridge_init(), so that
ipu_bridge_init() can be used with other sensor fwnode parse functions
then just ipu_bridge_parse_ssdb().

This will allow the ipu3-bridge code to also be used by the atomisp
driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Add ipu_parse_sensor_fwnode_t type for the callback function
---
 drivers/media/pci/intel/ipu-bridge.c     | 10 ++++++----
 drivers/media/pci/intel/ipu-bridge.h     | 11 +++++++++--
 drivers/media/pci/intel/ipu3/ipu3-cio2.c |  2 +-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 1f01f2c8b8a6..db67a75ae1b7 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -148,8 +148,7 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
 	return orientation;
 }
 
-static int ipu_bridge_parse_ssdb(struct acpi_device *adev,
-				 struct ipu_sensor *sensor)
+int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor)
 {
 	struct ipu_sensor_ssdb ssdb = {};
 	int ret;
@@ -179,6 +178,7 @@ static int ipu_bridge_parse_ssdb(struct acpi_device *adev,
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(ipu_bridge_parse_ssdb, INTEL_IPU_BRIDGE);
 
 static void ipu_bridge_create_fwnode_properties(
 	struct ipu_sensor *sensor,
@@ -343,7 +343,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 
 		sensor = &bridge->sensors[bridge->n_sensors];
 
-		ret = ipu_bridge_parse_ssdb(adev, sensor);
+		ret = bridge->parse_sensor_fwnode(adev, sensor);
 		if (ret)
 			goto err_put_adev;
 
@@ -441,7 +441,8 @@ static int ipu_bridge_sensors_are_ready(void)
 	return ready;
 }
 
-int ipu_bridge_init(struct device *dev)
+int ipu_bridge_init(struct device *dev,
+		    ipu_parse_sensor_fwnode_t parse_sensor_fwnode)
 {
 	struct fwnode_handle *fwnode;
 	struct ipu_bridge *bridge;
@@ -459,6 +460,7 @@ int ipu_bridge_init(struct device *dev)
 		sizeof(bridge->ipu_node_name));
 	bridge->ipu_hid_node.name = bridge->ipu_node_name;
 	bridge->dev = dev;
+	bridge->parse_sensor_fwnode = parse_sensor_fwnode;
 
 	ret = software_node_register(&bridge->ipu_hid_node);
 	if (ret < 0) {
diff --git a/drivers/media/pci/intel/ipu-bridge.h b/drivers/media/pci/intel/ipu-bridge.h
index a8b89c4b95bc..7d84b22b2111 100644
--- a/drivers/media/pci/intel/ipu-bridge.h
+++ b/drivers/media/pci/intel/ipu-bridge.h
@@ -140,8 +140,12 @@ struct ipu_sensor {
 	struct software_node_ref_args vcm_ref[1];
 };
 
+typedef int (*ipu_parse_sensor_fwnode_t)(struct acpi_device *adev,
+					 struct ipu_sensor *sensor);
+
 struct ipu_bridge {
 	struct device *dev;
+	ipu_parse_sensor_fwnode_t parse_sensor_fwnode;
 	char ipu_node_name[ACPI_ID_LEN];
 	struct software_node ipu_hid_node;
 	u32 data_lanes[4];
@@ -150,9 +154,12 @@ struct ipu_bridge {
 };
 
 #if IS_ENABLED(CONFIG_IPU_BRIDGE)
-int ipu_bridge_init(struct device *dev);
+int ipu_bridge_init(struct device *dev,
+		    ipu_parse_sensor_fwnode_t parse_sensor_fwnode);
+int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor);
 #else
-static inline int ipu_bridge_init(struct device *dev) { return 0; }
+/* Use a define to avoid the @parse_sensor_fwnode argument getting evaluated */
+#define ipu_bridge_init(dev, parse_sensor_fwnode)	(0)
 #endif
 
 #endif
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 4068fa0a5ecf..26c4c1375990 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1725,7 +1725,7 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 			return -EINVAL;
 		}
 
-		r = ipu_bridge_init(dev);
+		r = ipu_bridge_init(dev, ipu_bridge_parse_ssdb);
 		if (r)
 			return r;
 	}
-- 
2.41.0

