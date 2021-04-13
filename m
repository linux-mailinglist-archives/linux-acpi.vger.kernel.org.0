Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2836535D82B
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Apr 2021 08:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244945AbhDMGl4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Apr 2021 02:41:56 -0400
Received: from gusto.metanet.ch ([80.74.154.155]:59979 "EHLO gusto.metanet.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244929AbhDMGlw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Apr 2021 02:41:52 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Apr 2021 02:41:52 EDT
Received: from localhost (localhost [127.0.0.1]) by gusto.metanet.ch (Postfix) with ESMTPSA id 6553B4F00FCF;
        Tue, 13 Apr 2021 08:35:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fabwu.ch; s=default;
        t=1618295703; bh=iotXkIv2YJ/3k9E4Li4H919pO46t2zI3WfkmxCkGTaY=;
        h=From:To:Subject;
        b=ztyA+qspkNC7f6xjuJPbST3gOIG58nwIBvhzG+SRfPwgcwZj2PUr22zpM5Ve5hADW
         3bEheDBgN3BTWcV6tvoLqvAE63FXBJff0I/ICxWvbNpnKAONp1/Ifi0+xxDegKn+RZ
         VrLOYpY3q8q5LxY2AgrrlGkQnWgin9ub0UAHNflc=
Authentication-Results: gusto.metanet.ch;
        spf=pass (sender IP is 2001:67c:10ec:574f:8000::55) smtp.mailfrom=me@fabwu.ch smtp.helo=localhost
Received-SPF: pass (gusto.metanet.ch: connection is authenticated)
From:   =?UTF-8?q?Fabian=20W=C3=BCthrich?= <me@fabwu.ch>
To:     linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Cc:     Jacopo Mondi <jacopo@jmondi.org>, Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?q?Fabian=20W=C3=BCthrich?= <me@fabwu.ch>
Subject: [PATCH v2] ipu3-cio2: Parse sensor orientation and rotation
Date:   Tue, 13 Apr 2021 08:34:35 +0200
Message-Id: <20210413063435.18111-1-me@fabwu.ch>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <2090a4ab-bb07-140a-f794-764f18969854@fabwu.ch>
References: <2090a4ab-bb07-140a-f794-764f18969854@fabwu.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The sensor orientation is read from the _PLC ACPI buffer and converted
to a v4l2 format.

See https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
page 351 for a definition of the Panel property.

The sensor rotation is read from the SSDB ACPI buffer and converted into
degrees.

Signed-off-by: Fabian Wüthrich <me@fabwu.ch>
Reviewed-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:
  - Move ACPI PLD constants to ACPI headers
  - Fix dev_properties size

 drivers/media/pci/intel/ipu3/cio2-bridge.c | 60 ++++++++++++++++++++--
 drivers/media/pci/intel/ipu3/cio2-bridge.h |  9 +++-
 include/acpi/acbuffer.h                    |  9 ++++
 3 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index c2199042d3db..926141e9a516 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -29,6 +29,7 @@ static const struct cio2_sensor_config cio2_supported_sensors[] = {
 static const struct cio2_property_names prop_names = {
 	.clock_frequency = "clock-frequency",
 	.rotation = "rotation",
+	.orientation = "orientation",
 	.bus_type = "bus-type",
 	.data_lanes = "data-lanes",
 	.remote_endpoint = "remote-endpoint",
@@ -72,11 +73,51 @@ static int cio2_bridge_read_acpi_buffer(struct acpi_device *adev, char *id,
 	return ret;
 }
 
+static u32 cio2_bridge_parse_rotation(struct cio2_sensor *sensor)
+{
+	switch (sensor->ssdb.degree) {
+	case CIO2_SENSOR_ROTATION_NORMAL:
+		return 0;
+	case CIO2_SENSOR_ROTATION_INVERTED:
+		return 180;
+	default:
+		dev_warn(&sensor->adev->dev,
+			 "Unknown rotation %d. Assume 0 degree rotation\n",
+			 sensor->ssdb.degree);
+		return 0;
+	}
+}
+
+static enum v4l2_fwnode_orientation cio2_bridge_parse_orientation(struct cio2_sensor *sensor)
+{
+	switch (sensor->pld->panel) {
+	case ACPI_PLD_PANEL_FRONT:
+		return V4L2_FWNODE_ORIENTATION_FRONT;
+	case ACPI_PLD_PANEL_BACK:
+		return V4L2_FWNODE_ORIENTATION_BACK;
+	case ACPI_PLD_PANEL_TOP:
+	case ACPI_PLD_PANEL_LEFT:
+	case ACPI_PLD_PANEL_RIGHT:
+	case ACPI_PLD_PANEL_UNKNOWN:
+		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
+	default:
+		dev_warn(&sensor->adev->dev, "Unknown _PLD panel value %d\n",
+			 sensor->pld->panel);
+		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
+	}
+}
+
 static void cio2_bridge_create_fwnode_properties(
 	struct cio2_sensor *sensor,
 	struct cio2_bridge *bridge,
 	const struct cio2_sensor_config *cfg)
 {
+	u32 rotation;
+	enum v4l2_fwnode_orientation orientation;
+
+	rotation = cio2_bridge_parse_rotation(sensor);
+	orientation = cio2_bridge_parse_orientation(sensor);
+
 	sensor->prop_names = prop_names;
 
 	sensor->local_ref[0].node = &sensor->swnodes[SWNODE_CIO2_ENDPOINT];
@@ -85,9 +126,12 @@ static void cio2_bridge_create_fwnode_properties(
 	sensor->dev_properties[0] = PROPERTY_ENTRY_U32(
 					sensor->prop_names.clock_frequency,
 					sensor->ssdb.mclkspeed);
-	sensor->dev_properties[1] = PROPERTY_ENTRY_U8(
+	sensor->dev_properties[1] = PROPERTY_ENTRY_U32(
 					sensor->prop_names.rotation,
-					sensor->ssdb.degree);
+					rotation);
+	sensor->dev_properties[2] = PROPERTY_ENTRY_U32(
+					sensor->prop_names.orientation,
+					orientation);
 
 	sensor->ep_properties[0] = PROPERTY_ENTRY_U32(
 					sensor->prop_names.bus_type,
@@ -159,6 +203,7 @@ static void cio2_bridge_unregister_sensors(struct cio2_bridge *bridge)
 	for (i = 0; i < bridge->n_sensors; i++) {
 		sensor = &bridge->sensors[i];
 		software_node_unregister_nodes(sensor->swnodes);
+		ACPI_FREE(sensor->pld);
 		acpi_dev_put(sensor->adev);
 	}
 }
@@ -170,6 +215,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 	struct fwnode_handle *fwnode;
 	struct cio2_sensor *sensor;
 	struct acpi_device *adev;
+	acpi_status status;
 	int ret;
 
 	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
@@ -193,11 +239,15 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 		if (ret)
 			goto err_put_adev;
 
+		status = acpi_get_physical_device_location(adev->handle, &sensor->pld);
+		if (ACPI_FAILURE(status))
+			goto err_put_adev;
+
 		if (sensor->ssdb.lanes > CIO2_MAX_LANES) {
 			dev_err(&adev->dev,
 				"Number of lanes in SSDB is invalid\n");
 			ret = -EINVAL;
-			goto err_put_adev;
+			goto err_free_pld;
 		}
 
 		cio2_bridge_create_fwnode_properties(sensor, bridge, cfg);
@@ -205,7 +255,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 
 		ret = software_node_register_nodes(sensor->swnodes);
 		if (ret)
-			goto err_put_adev;
+			goto err_free_pld;
 
 		fwnode = software_node_fwnode(&sensor->swnodes[
 						      SWNODE_SENSOR_HID]);
@@ -226,6 +276,8 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
 
 err_free_swnodes:
 	software_node_unregister_nodes(sensor->swnodes);
+err_free_pld:
+	ACPI_FREE(sensor->pld);
 err_put_adev:
 	acpi_dev_put(sensor->adev);
 err_out:
diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.h b/drivers/media/pci/intel/ipu3/cio2-bridge.h
index dd0ffcafa489..202c7d494f7a 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.h
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.h
@@ -12,6 +12,10 @@
 #define CIO2_MAX_LANES				4
 #define MAX_NUM_LINK_FREQS			3
 
+/* Values are educated guesses as we don't have a spec */
+#define CIO2_SENSOR_ROTATION_NORMAL		0
+#define CIO2_SENSOR_ROTATION_INVERTED		1
+
 #define CIO2_SENSOR_CONFIG(_HID, _NR, ...)	\
 	(const struct cio2_sensor_config) {	\
 		.hid = _HID,			\
@@ -80,6 +84,7 @@ struct cio2_sensor_ssdb {
 struct cio2_property_names {
 	char clock_frequency[16];
 	char rotation[9];
+	char orientation[12];
 	char bus_type[9];
 	char data_lanes[11];
 	char remote_endpoint[16];
@@ -106,9 +111,11 @@ struct cio2_sensor {
 	struct cio2_node_names node_names;
 
 	struct cio2_sensor_ssdb ssdb;
+	struct acpi_pld_info *pld;
+
 	struct cio2_property_names prop_names;
 	struct property_entry ep_properties[5];
-	struct property_entry dev_properties[3];
+	struct property_entry dev_properties[4];
 	struct property_entry cio2_properties[3];
 	struct software_node_ref_args local_ref[1];
 	struct software_node_ref_args remote_ref[1];
diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index 18197c16149f..d42e82a82852 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -207,4 +207,13 @@ struct acpi_pld_info {
 #define ACPI_PLD_GET_HORIZ_OFFSET(dword)        ACPI_GET_BITS (dword, 16, ACPI_16BIT_MASK)
 #define ACPI_PLD_SET_HORIZ_OFFSET(dword,value)  ACPI_SET_BITS (dword, 16, ACPI_16BIT_MASK, value)	/* Offset 128+16=144, Len 16 */
 
+/* Panel position defined in _PLD section of ACPI Specification 6.3 */
+#define ACPI_PLD_PANEL_TOP			0
+#define ACPI_PLD_PANEL_BOTTOM			1
+#define ACPI_PLD_PANEL_LEFT			2
+#define ACPI_PLD_PANEL_RIGHT			3
+#define ACPI_PLD_PANEL_FRONT			4
+#define ACPI_PLD_PANEL_BACK			5
+#define ACPI_PLD_PANEL_UNKNOWN			6
+
 #endif				/* ACBUFFER_H */
-- 
2.31.1

