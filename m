Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FE4748FD6
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjGEVcR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjGEVcL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE911BD4
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688592639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eu9vKmvO4hJd5WQ+6pK0TDy4bLBACb4kwNWCf9ICztM=;
        b=MqWzNC6yeVC3pzJDTWB9w51MgLqyLs6tlBKC37i/FBrKMudmip4ZtISRPeXkdO/ndiQ9Qz
        CDGHfoaUIh2F5U4Ns/glBUtHynVWuQahdfn5dAuDHNpK4EtpC0AJf95u/6hIsKR8GK/j2u
        Lu6ZeSlhNSzsIkU/j5LZ2hxnNQ5wUgo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-1cKjrlLuNBGwH3Op0r_t-g-1; Wed, 05 Jul 2023 17:30:36 -0400
X-MC-Unique: 1cKjrlLuNBGwH3Op0r_t-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8212F800B35;
        Wed,  5 Jul 2023 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFCE440C2063;
        Wed,  5 Jul 2023 21:30:33 +0000 (UTC)
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
Subject: [PATCH v3 08/18] media: ipu-bridge: Add a ipu_bridge_parse_ssdb() helper function
Date:   Wed,  5 Jul 2023 23:30:00 +0200
Message-ID: <20230705213010.390849-9-hdegoede@redhat.com>
In-Reply-To: <20230705213010.390849-1-hdegoede@redhat.com>
References: <20230705213010.390849-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The code to go from ACPI sensor info to a fwnode-tree with connector
nodes and endpoint properties is 99% the same for the atomisp2 and
the IPU3.

The main difference is that atomisp2 devices do not have a SSDB table
with various info.

Abstract out the parsing of the sensor's ACPI fwnode into a helper
function and store the parsed results, rather then the raw SSDB
in struct ipu_sensor.

This is a preparation patch for making the ipu-bridge code more generic
so that it can be shared with the atomisp driver.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/media/pci/intel/ipu-bridge.c | 96 +++++++++++++++-------------
 drivers/media/pci/intel/ipu-bridge.h |  8 ++-
 2 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 11cfab641513..ee0ca5e6e33b 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -97,17 +97,18 @@ static int ipu_bridge_read_acpi_buffer(struct acpi_device *adev, char *id,
 	return ret;
 }
 
-static u32 ipu_bridge_parse_rotation(struct ipu_sensor *sensor)
+static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
+				     struct ipu_sensor_ssdb *ssdb)
 {
-	switch (sensor->ssdb.degree) {
+	switch (ssdb->degree) {
 	case IPU_SENSOR_ROTATION_NORMAL:
 		return 0;
 	case IPU_SENSOR_ROTATION_INVERTED:
 		return 180;
 	default:
-		dev_warn(&sensor->adev->dev,
+		dev_warn(&adev->dev,
 			 "Unknown rotation %d. Assume 0 degree rotation\n",
-			 sensor->ssdb.degree);
+			 ssdb->degree);
 		return 0;
 	}
 }
@@ -147,17 +148,43 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
 	return orientation;
 }
 
+static int ipu_bridge_parse_ssdb(struct acpi_device *adev,
+				 struct ipu_sensor *sensor)
+{
+	struct ipu_sensor_ssdb ssdb = {};
+	int ret;
+
+	ret = ipu_bridge_read_acpi_buffer(adev, "SSDB", &ssdb, sizeof(ssdb));
+	if (ret)
+		return ret;
+
+	if (ssdb.vcmtype > ARRAY_SIZE(ipu_vcm_types)) {
+		dev_warn(&adev->dev, "Unknown VCM type %d\n", ssdb.vcmtype);
+		ssdb.vcmtype = 0;
+	}
+
+	if (ssdb.lanes > IPU_MAX_LANES) {
+		dev_err(&adev->dev, "Number of lanes in SSDB is invalid\n");
+		return -EINVAL;
+	}
+
+	sensor->link = ssdb.link;
+	sensor->lanes = ssdb.lanes;
+	sensor->mclkspeed = ssdb.mclkspeed;
+	sensor->rotation = ipu_bridge_parse_rotation(adev, &ssdb);
+	sensor->orientation = ipu_bridge_parse_orientation(adev);
+
+	if (ssdb.vcmtype)
+		sensor->vcm_type = ipu_vcm_types[ssdb.vcmtype - 1];
+
+	return 0;
+}
+
 static void ipu_bridge_create_fwnode_properties(
 	struct ipu_sensor *sensor,
 	struct ipu_bridge *bridge,
 	const struct ipu_sensor_config *cfg)
 {
-	u32 rotation;
-	enum v4l2_fwnode_orientation orientation;
-
-	rotation = ipu_bridge_parse_rotation(sensor);
-	orientation = ipu_bridge_parse_orientation(sensor->adev);
-
 	sensor->prop_names = prop_names;
 
 	sensor->local_ref[0] = SOFTWARE_NODE_REFERENCE(&sensor->swnodes[SWNODE_IPU_ENDPOINT]);
@@ -165,14 +192,14 @@ static void ipu_bridge_create_fwnode_properties(
 
 	sensor->dev_properties[0] = PROPERTY_ENTRY_U32(
 					sensor->prop_names.clock_frequency,
-					sensor->ssdb.mclkspeed);
+					sensor->mclkspeed);
 	sensor->dev_properties[1] = PROPERTY_ENTRY_U32(
 					sensor->prop_names.rotation,
-					rotation);
+					sensor->rotation);
 	sensor->dev_properties[2] = PROPERTY_ENTRY_U32(
 					sensor->prop_names.orientation,
-					orientation);
-	if (sensor->ssdb.vcmtype) {
+					sensor->orientation);
+	if (sensor->vcm_type) {
 		sensor->vcm_ref[0] =
 			SOFTWARE_NODE_REFERENCE(&sensor->swnodes[SWNODE_VCM]);
 		sensor->dev_properties[3] =
@@ -184,8 +211,7 @@ static void ipu_bridge_create_fwnode_properties(
 					V4L2_FWNODE_BUS_TYPE_CSI2_DPHY);
 	sensor->ep_properties[1] = PROPERTY_ENTRY_U32_ARRAY_LEN(
 					sensor->prop_names.data_lanes,
-					bridge->data_lanes,
-					sensor->ssdb.lanes);
+					bridge->data_lanes, sensor->lanes);
 	sensor->ep_properties[2] = PROPERTY_ENTRY_REF_ARRAY(
 					sensor->prop_names.remote_endpoint,
 					sensor->local_ref);
@@ -198,8 +224,7 @@ static void ipu_bridge_create_fwnode_properties(
 
 	sensor->ipu_properties[0] = PROPERTY_ENTRY_U32_ARRAY_LEN(
 					sensor->prop_names.data_lanes,
-					bridge->data_lanes,
-					sensor->ssdb.lanes);
+					bridge->data_lanes, sensor->lanes);
 	sensor->ipu_properties[1] = PROPERTY_ENTRY_REF_ARRAY(
 					sensor->prop_names.remote_endpoint,
 					sensor->remote_ref);
@@ -209,18 +234,17 @@ static void ipu_bridge_init_swnode_names(struct ipu_sensor *sensor)
 {
 	snprintf(sensor->node_names.remote_port,
 		 sizeof(sensor->node_names.remote_port),
-		 SWNODE_GRAPH_PORT_NAME_FMT, sensor->ssdb.link);
+		 SWNODE_GRAPH_PORT_NAME_FMT, sensor->link);
 	snprintf(sensor->node_names.port,
 		 sizeof(sensor->node_names.port),
 		 SWNODE_GRAPH_PORT_NAME_FMT, 0); /* Always port 0 */
 	snprintf(sensor->node_names.endpoint,
 		 sizeof(sensor->node_names.endpoint),
 		 SWNODE_GRAPH_ENDPOINT_NAME_FMT, 0); /* And endpoint 0 */
-	if (sensor->ssdb.vcmtype) {
-		/* append ssdb.link to distinguish nodes with same model VCM */
+	if (sensor->vcm_type) {
+		/* append link to distinguish nodes with same model VCM */
 		snprintf(sensor->node_names.vcm, sizeof(sensor->node_names.vcm),
-			 "%s-%u", ipu_vcm_types[sensor->ssdb.vcmtype - 1],
-			 sensor->ssdb.link);
+			 "%s-%u", sensor->vcm_type, sensor->link);
 	}
 }
 
@@ -233,7 +257,7 @@ static void ipu_bridge_init_swnode_group(struct ipu_sensor *sensor)
 	sensor->group[SWNODE_SENSOR_ENDPOINT] = &nodes[SWNODE_SENSOR_ENDPOINT];
 	sensor->group[SWNODE_IPU_PORT] = &nodes[SWNODE_IPU_PORT];
 	sensor->group[SWNODE_IPU_ENDPOINT] = &nodes[SWNODE_IPU_ENDPOINT];
-	if (sensor->ssdb.vcmtype)
+	if (sensor->vcm_type)
 		sensor->group[SWNODE_VCM] =  &nodes[SWNODE_VCM];
 }
 
@@ -268,13 +292,12 @@ static void ipu_bridge_instantiate_vcm_i2c_client(struct ipu_sensor *sensor)
 	struct i2c_board_info board_info = { };
 	char name[16];
 
-	if (!sensor->ssdb.vcmtype)
+	if (!sensor->vcm_type)
 		return;
 
 	snprintf(name, sizeof(name), "%s-VCM", acpi_dev_name(sensor->adev));
 	board_info.dev_name = name;
-	strscpy(board_info.type, ipu_vcm_types[sensor->ssdb.vcmtype - 1],
-		ARRAY_SIZE(board_info.type));
+	strscpy(board_info.type, sensor->vcm_type, ARRAY_SIZE(board_info.type));
 	board_info.swnode = &sensor->swnodes[SWNODE_VCM];
 
 	sensor->vcm_i2c_client =
@@ -325,27 +348,12 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 		 */
 		sensor->adev = adev;
 
-		ret = ipu_bridge_read_acpi_buffer(adev, "SSDB",
-						  &sensor->ssdb,
-						  sizeof(sensor->ssdb));
+		ret = ipu_bridge_parse_ssdb(adev, sensor);
 		if (ret)
 			goto err_put_adev;
 
 		snprintf(sensor->name, sizeof(sensor->name), "%s-%u",
-			 cfg->hid, sensor->ssdb.link);
-
-		if (sensor->ssdb.vcmtype > ARRAY_SIZE(ipu_vcm_types)) {
-			dev_warn(&adev->dev, "Unknown VCM type %d\n",
-				 sensor->ssdb.vcmtype);
-			sensor->ssdb.vcmtype = 0;
-		}
-
-		if (sensor->ssdb.lanes > IPU_MAX_LANES) {
-			dev_err(&adev->dev,
-				"Number of lanes in SSDB is invalid\n");
-			ret = -EINVAL;
-			goto err_put_adev;
-		}
+			 cfg->hid, sensor->link);
 
 		ipu_bridge_create_fwnode_properties(sensor, bridge, cfg);
 		ipu_bridge_create_connection_swnodes(bridge, sensor);
diff --git a/drivers/media/pci/intel/ipu-bridge.h b/drivers/media/pci/intel/ipu-bridge.h
index 907ca833a7c1..a8b89c4b95bc 100644
--- a/drivers/media/pci/intel/ipu-bridge.h
+++ b/drivers/media/pci/intel/ipu-bridge.h
@@ -5,6 +5,7 @@
 
 #include <linux/property.h>
 #include <linux/types.h>
+#include <media/v4l2-fwnode.h>
 
 struct i2c_client;
 
@@ -123,7 +124,12 @@ struct ipu_sensor {
 	struct software_node swnodes[SWNODE_COUNT];
 	struct ipu_node_names node_names;
 
-	struct ipu_sensor_ssdb ssdb;
+	u8 link;
+	u8 lanes;
+	u32 mclkspeed;
+	u32 rotation;
+	enum v4l2_fwnode_orientation orientation;
+	const char *vcm_type;
 
 	struct ipu_property_names prop_names;
 	struct property_entry ep_properties[5];
-- 
2.41.0

