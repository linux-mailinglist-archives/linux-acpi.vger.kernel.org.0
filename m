Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B484C748FC7
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjGEVcC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjGEVcC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3061BC0
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688592633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ilvrk/UjadBncuCU/QdWXzeVv/FrT9PPmpBzWnFZGYA=;
        b=H9Vn+yKCmQogf3bZsjc3tp0YTeZalEoyYN1/wQ1sX5aHMEko0BF7/3yxCnZo7y/0UmckuB
        u2YBU9mDSE80+PYbHelzO78HK/AYtl6GC9Zpe4ZWYTQDM1L/5fNrRxcckdrRSrTgDJ0Fyz
        5+aZYAlPthvLyZVkRKf7GN16OMUSorw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-Yn4FujaxNmy7pEPDiq-Y1g-1; Wed, 05 Jul 2023 17:30:32 -0400
X-MC-Unique: Yn4FujaxNmy7pEPDiq-Y1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F30A5101A529;
        Wed,  5 Jul 2023 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D9D240C2063;
        Wed,  5 Jul 2023 21:30:30 +0000 (UTC)
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
Subject: [PATCH v3 06/18] media: ipu-bridge: Store dev pointer in struct ipu_bridge
Date:   Wed,  5 Jul 2023 23:29:58 +0200
Message-ID: <20230705213010.390849-7-hdegoede@redhat.com>
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

Store the dev pointer in struct ipu_bridge instead of passing it
around 3 levels deep.

This takes up slightly more memory but further patches in this series
add more data which needs to be passed around making passing
everything as arguments cumbersome and those further patches also
add data to struct ipu_bridge.

To be consistent with these upcoming patches also add
the dev pointer to struct ipu_bridge.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/pci/intel/ipu-bridge.c | 15 +++++++--------
 drivers/media/pci/intel/ipu-bridge.h |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 9027a8d2d176..8e91d9b3e0fe 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -286,8 +286,7 @@ static void ipu_bridge_unregister_sensors(struct ipu_bridge *bridge)
 }
 
 static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
-				     struct ipu_bridge *bridge,
-				     struct device *dev)
+				     struct ipu_bridge *bridge)
 {
 	struct fwnode_handle *fwnode, *primary;
 	struct ipu_sensor *sensor;
@@ -301,7 +300,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 
 		if (bridge->n_sensors >= IPU_MAX_PORTS) {
 			acpi_dev_put(adev);
-			dev_err(dev, "Exceeded available IPU ports\n");
+			dev_err(bridge->dev, "Exceeded available IPU ports\n");
 			return -EINVAL;
 		}
 
@@ -361,7 +360,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 
 		ipu_bridge_instantiate_vcm_i2c_client(sensor);
 
-		dev_info(dev, "Found supported sensor %s\n",
+		dev_info(bridge->dev, "Found supported sensor %s\n",
 			 acpi_dev_name(adev));
 
 		bridge->n_sensors++;
@@ -378,8 +377,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 	return ret;
 }
 
-static int ipu_bridge_connect_sensors(struct ipu_bridge *bridge,
-				      struct device *dev)
+static int ipu_bridge_connect_sensors(struct ipu_bridge *bridge)
 {
 	unsigned int i;
 	int ret;
@@ -388,7 +386,7 @@ static int ipu_bridge_connect_sensors(struct ipu_bridge *bridge,
 		const struct ipu_sensor_config *cfg =
 			&ipu_supported_sensors[i];
 
-		ret = ipu_bridge_connect_sensor(cfg, bridge, dev);
+		ret = ipu_bridge_connect_sensor(cfg, bridge);
 		if (ret)
 			goto err_unregister_sensors;
 	}
@@ -451,6 +449,7 @@ int ipu_bridge_init(struct device *dev)
 	strscpy(bridge->ipu_node_name, IPU_HID,
 		sizeof(bridge->ipu_node_name));
 	bridge->ipu_hid_node.name = bridge->ipu_node_name;
+	bridge->dev = dev;
 
 	ret = software_node_register(&bridge->ipu_hid_node);
 	if (ret < 0) {
@@ -468,7 +467,7 @@ int ipu_bridge_init(struct device *dev)
 	for (i = 0; i < IPU_MAX_LANES; i++)
 		bridge->data_lanes[i] = i + 1;
 
-	ret = ipu_bridge_connect_sensors(bridge, dev);
+	ret = ipu_bridge_connect_sensors(bridge);
 	if (ret || bridge->n_sensors == 0)
 		goto err_unregister_ipu;
 
diff --git a/drivers/media/pci/intel/ipu-bridge.h b/drivers/media/pci/intel/ipu-bridge.h
index 8c1437f252d2..6cb68e3344dc 100644
--- a/drivers/media/pci/intel/ipu-bridge.h
+++ b/drivers/media/pci/intel/ipu-bridge.h
@@ -136,6 +136,7 @@ struct ipu_sensor {
 };
 
 struct ipu_bridge {
+	struct device *dev;
 	char ipu_node_name[ACPI_ID_LEN];
 	struct software_node ipu_hid_node;
 	u32 data_lanes[4];
-- 
2.41.0

