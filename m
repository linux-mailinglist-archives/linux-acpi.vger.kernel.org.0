Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F25748FDF
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjGEVdE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjGEVcv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150411BE1
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688592649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuycwQIbQv4zQ1e3iiac5dBA5o1BwGsaBEGm1OquG7I=;
        b=WGz9CTtGBatHph8BA3B2pP0OynIv08x7pdPI+Eugt6PGjy+vpS7GCsB4k/UJu0UVZ6h3IO
        tEXr1hemGnmSo8hof82S2Y0Y5hpiq2UMFSugpqZh6ANEoMEL3nJq7xPEipxvVD3fIL0Ngx
        kACibXxipCbqoC6yAeqpe2s2t0Hcxm8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-CcbCNYOhOhGkTOfu2GCNSw-1; Wed, 05 Jul 2023 17:30:45 -0400
X-MC-Unique: CcbCNYOhOhGkTOfu2GCNSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82BD43814956;
        Wed,  5 Jul 2023 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F18CD40C2063;
        Wed,  5 Jul 2023 21:30:42 +0000 (UTC)
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
Subject: [PATCH v3 13/18] media: ipu-bridge: Add a runtime-pm device-link between VCM and sensor
Date:   Wed,  5 Jul 2023 23:30:05 +0200
Message-ID: <20230705213010.390849-14-hdegoede@redhat.com>
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

In most cases when a VCM is used there is a single integrated module
with the sensor + VCM + lens. This means that the sensor and VCM often
share regulators and possibly also something like a powerdown pin.

In the ACPI tables this is modelled as a single ACPI device with
multiple I2cSerialBus resources.

On atomisp devices the regulators and clks are modelled as ACPI
power-resources, which are controlled by the (ACPI) power state
of the sensor. So the sensor must be in D0 power state for the VCM
to work.

To make this work add a device-link with DL_FLAG_PM_RUNTIME flag
so that the sensor will automatically be runtime-resumed whenever
the VCM is runtime-resumed.

This requires the probing of the VCM and thus the creation of the VCM
I2C-client to be delayed till after the sensor driver has bound.

Move the instantiation of the VCM I2C-client to the v4l2_async_notifier
bound op, so that it is done after the sensor driver has bound; and
add code to add the device-link.

This fixes the problem with the shared ACPI power-resources on atomisp2
and this avoids the need for VCM related workarounds on IPU3 / IPU6.

E.g. until now the dw9719 driver needed to get and control a Vsio
(V sensor IO) regulator since that needs to be enabled to enable I2C
pass-through on the PMIC on the sensor module. So the driver was
controlling this regulator even though the actual dw9719 chip has no
Vsio pin / power-plane.

This also removes the need for ipu_bridge_init() to return
-EPROBE_DEFER since the VCM is now instantiated later.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Tested-by: Daniel Scally <dan.scally@ideasonboard.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-Rename local variables named work to data to avoid having
 work->work (now data->work)
-Use snprintf "%pfwP" to set type to fwnode name
---
 drivers/media/pci/intel/ipu-bridge.c     | 159 +++++++++++++++--------
 drivers/media/pci/intel/ipu3/ipu3-cio2.c |   5 +
 include/media/ipu-bridge.h               |   5 +-
 3 files changed, 109 insertions(+), 60 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 6f7650a3a199..0e506ab541e8 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -4,7 +4,10 @@
 #include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/string.h>
+#include <linux/workqueue.h>
 
 #include <media/ipu-bridge.h>
 #include <media/v4l2-fwnode.h>
@@ -289,29 +292,111 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 	ipu_bridge_init_swnode_group(sensor);
 }
 
-static void ipu_bridge_instantiate_vcm_i2c_client(struct ipu_sensor *sensor)
-{
-	struct i2c_board_info board_info = { };
+/*
+ * The actual instantiation must be done from a workqueue to avoid
+ * a deadlock on taking list_lock from v4l2-async twice.
+ */
+struct ipu_bridge_instantiate_vcm_work_data {
+	struct work_struct work;
+	struct device *sensor;
 	char name[16];
+	struct i2c_board_info board_info;
+};
 
-	if (!sensor->vcm_type)
-		return;
+static void ipu_bridge_instantiate_vcm_work(struct work_struct *work)
+{
+	struct ipu_bridge_instantiate_vcm_work_data *data =
+		container_of(work, struct ipu_bridge_instantiate_vcm_work_data,
+			     work);
+	struct acpi_device *adev = ACPI_COMPANION(data->sensor);
+	struct i2c_client *vcm_client;
+	bool put_fwnode = true;
+	int ret;
 
-	snprintf(name, sizeof(name), "%s-VCM", acpi_dev_name(sensor->adev));
-	board_info.dev_name = name;
-	strscpy(board_info.type, sensor->vcm_type, ARRAY_SIZE(board_info.type));
-	board_info.swnode = &sensor->swnodes[SWNODE_VCM];
-
-	sensor->vcm_i2c_client =
-		i2c_acpi_new_device_by_fwnode(acpi_fwnode_handle(sensor->adev),
-					      1, &board_info);
-	if (IS_ERR(sensor->vcm_i2c_client)) {
-		dev_warn(&sensor->adev->dev, "Error instantiation VCM i2c-client: %ld\n",
-			 PTR_ERR(sensor->vcm_i2c_client));
-		sensor->vcm_i2c_client = NULL;
+	/*
+	 * The client may get probed before the device_link gets added below
+	 * make sure the sensor is powered-up during probe.
+	 */
+	ret = pm_runtime_get_sync(data->sensor);
+	if (ret < 0) {
+		dev_err(data->sensor, "Error %d runtime-resuming sensor, cannot instantiate VCM\n",
+			ret);
+		goto out_pm_put;
 	}
+
+	/*
+	 * Note the client is created only once and then kept around
+	 * even after a rmmod, just like the software-nodes.
+	 */
+	vcm_client = i2c_acpi_new_device_by_fwnode(acpi_fwnode_handle(adev),
+						   1, &data->board_info);
+	if (IS_ERR(vcm_client)) {
+		dev_err(data->sensor, "Error instantiating VCM client: %ld\n",
+			PTR_ERR(vcm_client));
+		goto out_pm_put;
+	}
+
+	device_link_add(&vcm_client->dev, data->sensor, DL_FLAG_PM_RUNTIME);
+
+	dev_info(data->sensor, "Instantiated %s VCM\n", data->board_info.type);
+	put_fwnode = false; /* Ownership has passed to the i2c-client */
+
+out_pm_put:
+	pm_runtime_put(data->sensor);
+	put_device(data->sensor);
+	if (put_fwnode)
+		fwnode_handle_put(data->board_info.fwnode);
+	kfree(data);
 }
 
+int ipu_bridge_instantiate_vcm(struct device *sensor)
+{
+	struct ipu_bridge_instantiate_vcm_work_data *data;
+	struct fwnode_handle *vcm_fwnode;
+	struct i2c_client *vcm_client;
+	struct acpi_device *adev;
+	char *sep;
+
+	adev = ACPI_COMPANION(sensor);
+	if (!adev)
+		return 0;
+
+	vcm_fwnode = fwnode_find_reference(dev_fwnode(sensor), "lens-focus", 0);
+	if (IS_ERR(vcm_fwnode))
+		return 0;
+
+	/* When reloading modules the client will already exist */
+	vcm_client = i2c_find_device_by_fwnode(vcm_fwnode);
+	if (vcm_client) {
+		fwnode_handle_put(vcm_fwnode);
+		put_device(&vcm_client->dev);
+		return 0;
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		fwnode_handle_put(vcm_fwnode);
+		return -ENOMEM;
+	}
+
+	INIT_WORK(&data->work, ipu_bridge_instantiate_vcm_work);
+	data->sensor = get_device(sensor);
+	snprintf(data->name, sizeof(data->name), "%s-VCM",
+		 acpi_dev_name(adev));
+	data->board_info.dev_name = data->name;
+	data->board_info.fwnode = vcm_fwnode;
+	snprintf(data->board_info.type, sizeof(data->board_info.type),
+		 "%pfwP", vcm_fwnode);
+	/* Strip "-<link>" postfix */
+	sep = strchrnul(data->board_info.type, '-');
+	*sep = 0;
+
+	queue_work(system_long_wq, &data->work);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ipu_bridge_instantiate_vcm, INTEL_IPU_BRIDGE);
+
 static void ipu_bridge_unregister_sensors(struct ipu_bridge *bridge)
 {
 	struct ipu_sensor *sensor;
@@ -321,7 +406,6 @@ static void ipu_bridge_unregister_sensors(struct ipu_bridge *bridge)
 		sensor = &bridge->sensors[i];
 		software_node_unregister_node_group(sensor->group);
 		acpi_dev_put(sensor->adev);
-		i2c_unregister_device(sensor->vcm_i2c_client);
 	}
 }
 
@@ -371,8 +455,6 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 		primary = acpi_fwnode_handle(adev);
 		primary->secondary = fwnode;
 
-		ipu_bridge_instantiate_vcm_i2c_client(sensor);
-
 		dev_info(bridge->dev, "Found supported sensor %s\n",
 			 acpi_dev_name(adev));
 
@@ -409,40 +491,6 @@ static int ipu_bridge_connect_sensors(struct ipu_bridge *bridge)
 	return ret;
 }
 
-/*
- * The VCM cannot be probed until the PMIC is completely setup. We cannot rely
- * on -EPROBE_DEFER for this, since the consumer<->supplier relations between
- * the VCM and regulators/clks are not described in ACPI, instead they are
- * passed as board-data to the PMIC drivers. Since -PROBE_DEFER does not work
- * for the clks/regulators the VCM i2c-clients must not be instantiated until
- * the PMIC is fully setup.
- *
- * The sensor/VCM ACPI device has an ACPI _DEP on the PMIC, check this using the
- * acpi_dev_ready_for_enumeration() helper, like the i2c-core-acpi code does
- * for the sensors.
- */
-static int ipu_bridge_sensors_are_ready(void)
-{
-	struct acpi_device *adev;
-	bool ready = true;
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
-		const struct ipu_sensor_config *cfg =
-			&ipu_supported_sensors[i];
-
-		for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
-			if (!adev->status.enabled)
-				continue;
-
-			if (!acpi_dev_ready_for_enumeration(adev))
-				ready = false;
-		}
-	}
-
-	return ready;
-}
-
 int ipu_bridge_init(struct device *dev,
 		    ipu_parse_sensor_fwnode_t parse_sensor_fwnode)
 {
@@ -451,9 +499,6 @@ int ipu_bridge_init(struct device *dev,
 	unsigned int i;
 	int ret;
 
-	if (!ipu_bridge_sensors_are_ready())
-		return -EPROBE_DEFER;
-
 	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
 	if (!bridge)
 		return -ENOMEM;
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 51a6d7cc44d2..690fc1c919af 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1388,10 +1388,15 @@ static int cio2_notifier_bound(struct v4l2_async_notifier *notifier,
 	struct cio2_device *cio2 = to_cio2_device(notifier);
 	struct sensor_async_subdev *s_asd = to_sensor_asd(asd);
 	struct cio2_queue *q;
+	int ret;
 
 	if (cio2->queue[s_asd->csi2.port].sensor)
 		return -EBUSY;
 
+	ret = ipu_bridge_instantiate_vcm(sd->dev);
+	if (ret)
+		return ret;
+
 	q = &cio2->queue[s_asd->csi2.port];
 
 	q->csi2 = s_asd->csi2;
diff --git a/include/media/ipu-bridge.h b/include/media/ipu-bridge.h
index 7d84b22b2111..ceda2a801948 100644
--- a/include/media/ipu-bridge.h
+++ b/include/media/ipu-bridge.h
@@ -7,8 +7,6 @@
 #include <linux/types.h>
 #include <media/v4l2-fwnode.h>
 
-struct i2c_client;
-
 #define IPU_HID				"INT343E"
 #define IPU_MAX_LANES				4
 #define IPU_MAX_PORTS				4
@@ -117,7 +115,6 @@ struct ipu_sensor {
 	/* append ssdb.link(u8) in "-%u" format as suffix of HID */
 	char name[ACPI_ID_LEN + 4];
 	struct acpi_device *adev;
-	struct i2c_client *vcm_i2c_client;
 
 	/* SWNODE_COUNT + 1 for terminating NULL */
 	const struct software_node *group[SWNODE_COUNT + 1];
@@ -157,9 +154,11 @@ struct ipu_bridge {
 int ipu_bridge_init(struct device *dev,
 		    ipu_parse_sensor_fwnode_t parse_sensor_fwnode);
 int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor);
+int ipu_bridge_instantiate_vcm(struct device *sensor);
 #else
 /* Use a define to avoid the @parse_sensor_fwnode argument getting evaluated */
 #define ipu_bridge_init(dev, parse_sensor_fwnode)	(0)
+static inline int ipu_bridge_instantiate_vcm(struct device *s) { return 0; }
 #endif
 
 #endif
-- 
2.41.0

