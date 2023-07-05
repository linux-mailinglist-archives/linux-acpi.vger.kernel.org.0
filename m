Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAFD748FD3
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjGEVcQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjGEVcI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357961BCC
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688592638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/idKObEBMF5v/OL1iE+Xb2PRP/FocktvUvdnk5HwcQ=;
        b=e5J2BH/k+fft8Xiil33M2NYskH/aH4z0eTfPd75NCCuxGrPWpJiycd0CfuJdW0bttpXL1Z
        tqzRi7fvoZh3rb9s39EqAg13tevdKdhn1VZuPH/Jz2QzOpI3A2AD587cTBukXoenVOppSX
        32EooaDZ8VQp2MXPR5h4FJEN8uy91uI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-l9S3beFqPQOkPFcI-Iz8JQ-1; Wed, 05 Jul 2023 17:30:34 -0400
X-MC-Unique: l9S3beFqPQOkPFcI-Iz8JQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC2B6800B35;
        Wed,  5 Jul 2023 21:30:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 335F840C2063;
        Wed,  5 Jul 2023 21:30:32 +0000 (UTC)
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
Subject: [PATCH v3 07/18] media: ipu-bridge: Only keep PLD around while parsing
Date:   Wed,  5 Jul 2023 23:29:59 +0200
Message-ID: <20230705213010.390849-8-hdegoede@redhat.com>
In-Reply-To: <20230705213010.390849-1-hdegoede@redhat.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no need to keep a reference to the PLD struct around,
it is only used once the get the sensor orientation.

Make ipu_bridge_parse_orientation() also get + put the PLD.

This is a preparation patch for making the ipu-bridge code more generic
so that it can be shared with the atomisp driver.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/pci/intel/ipu-bridge.c | 48 ++++++++++++++++------------
 drivers/media/pci/intel/ipu-bridge.h |  1 -
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 8e91d9b3e0fe..11cfab641513 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -112,23 +112,39 @@ static u32 ipu_bridge_parse_rotation(struct ipu_sensor *sensor)
 	}
 }
 
-static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct ipu_sensor *sensor)
+static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_device *adev)
 {
-	switch (sensor->pld->panel) {
+	enum v4l2_fwnode_orientation orientation;
+	struct acpi_pld_info *pld;
+	acpi_status status;
+
+	status = acpi_get_physical_device_location(adev->handle, &pld);
+	if (ACPI_FAILURE(status)) {
+		dev_warn(&adev->dev, "_PLD call failed, using default orientation\n");
+		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
+	}
+
+	switch (pld->panel) {
 	case ACPI_PLD_PANEL_FRONT:
-		return V4L2_FWNODE_ORIENTATION_FRONT;
+		orientation = V4L2_FWNODE_ORIENTATION_FRONT;
+		break;
 	case ACPI_PLD_PANEL_BACK:
-		return V4L2_FWNODE_ORIENTATION_BACK;
+		orientation = V4L2_FWNODE_ORIENTATION_BACK;
+		break;
 	case ACPI_PLD_PANEL_TOP:
 	case ACPI_PLD_PANEL_LEFT:
 	case ACPI_PLD_PANEL_RIGHT:
 	case ACPI_PLD_PANEL_UNKNOWN:
-		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
+		orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
+		break;
 	default:
-		dev_warn(&sensor->adev->dev, "Unknown _PLD panel value %d\n",
-			 sensor->pld->panel);
-		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
+		dev_warn(&adev->dev, "Unknown _PLD panel val %d\n", pld->panel);
+		orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
+		break;
 	}
+
+	ACPI_FREE(pld);
+	return orientation;
 }
 
 static void ipu_bridge_create_fwnode_properties(
@@ -140,7 +156,7 @@ static void ipu_bridge_create_fwnode_properties(
 	enum v4l2_fwnode_orientation orientation;
 
 	rotation = ipu_bridge_parse_rotation(sensor);
-	orientation = ipu_bridge_parse_orientation(sensor);
+	orientation = ipu_bridge_parse_orientation(sensor->adev);
 
 	sensor->prop_names = prop_names;
 
@@ -279,7 +295,6 @@ static void ipu_bridge_unregister_sensors(struct ipu_bridge *bridge)
 	for (i = 0; i < bridge->n_sensors; i++) {
 		sensor = &bridge->sensors[i];
 		software_node_unregister_node_group(sensor->group);
-		ACPI_FREE(sensor->pld);
 		acpi_dev_put(sensor->adev);
 		i2c_unregister_device(sensor->vcm_i2c_client);
 	}
@@ -291,7 +306,6 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 	struct fwnode_handle *fwnode, *primary;
 	struct ipu_sensor *sensor;
 	struct acpi_device *adev;
-	acpi_status status;
 	int ret;
 
 	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
@@ -326,17 +340,11 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 			sensor->ssdb.vcmtype = 0;
 		}
 
-		status = acpi_get_physical_device_location(adev->handle, &sensor->pld);
-		if (ACPI_FAILURE(status)) {
-			ret = -ENODEV;
-			goto err_put_adev;
-		}
-
 		if (sensor->ssdb.lanes > IPU_MAX_LANES) {
 			dev_err(&adev->dev,
 				"Number of lanes in SSDB is invalid\n");
 			ret = -EINVAL;
-			goto err_free_pld;
+			goto err_put_adev;
 		}
 
 		ipu_bridge_create_fwnode_properties(sensor, bridge, cfg);
@@ -344,7 +352,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 
 		ret = software_node_register_node_group(sensor->group);
 		if (ret)
-			goto err_free_pld;
+			goto err_put_adev;
 
 		fwnode = software_node_fwnode(&sensor->swnodes[
 						      SWNODE_SENSOR_HID]);
@@ -370,8 +378,6 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 
 err_free_swnodes:
 	software_node_unregister_node_group(sensor->group);
-err_free_pld:
-	ACPI_FREE(sensor->pld);
 err_put_adev:
 	acpi_dev_put(adev);
 	return ret;
diff --git a/drivers/media/pci/intel/ipu-bridge.h b/drivers/media/pci/intel/ipu-bridge.h
index 6cb68e3344dc..907ca833a7c1 100644
--- a/drivers/media/pci/intel/ipu-bridge.h
+++ b/drivers/media/pci/intel/ipu-bridge.h
@@ -124,7 +124,6 @@ struct ipu_sensor {
 	struct ipu_node_names node_names;
 
 	struct ipu_sensor_ssdb ssdb;
-	struct acpi_pld_info *pld;
 
 	struct ipu_property_names prop_names;
 	struct property_entry ep_properties[5];
-- 
2.41.0

