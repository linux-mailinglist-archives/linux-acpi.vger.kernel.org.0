Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82227748FEA
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 23:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjGEVd2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 17:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjGEVc4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 17:32:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBD61BF1
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688592657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSqASa8pWzSX8YcB0FKAlv2fqALtO9nK20MxF/GRN5Y=;
        b=Q5xp04XLA5eX6lwa6HVEplwfDA8yfF0ExrmlwlA3fiBX3XqQ9YRBVZYJdvrjHysvexeaM1
        X5ehT/1zJoHcYwBSgcmeoVL6tqmCCpGggs8+d059m5ySqnywOr8yff+ZN0LasfNxjBDQ6V
        UWTQf8xcBeBwvOH0bE8bKv6OJ8OB3F0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-oFGKyKaMPGylev5LZvMvFg-1; Wed, 05 Jul 2023 17:30:54 -0400
X-MC-Unique: oFGKyKaMPGylev5LZvMvFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99C03101A529;
        Wed,  5 Jul 2023 21:30:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15A8640C2063;
        Wed,  5 Jul 2023 21:30:51 +0000 (UTC)
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
Subject: [PATCH v3 18/18] media: atomisp: csi2-bridge: Add support for VCM I2C-client instantiation
Date:   Wed,  5 Jul 2023 23:30:10 +0200
Message-ID: <20230705213010.390849-19-hdegoede@redhat.com>
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

Fill sensor->vcm_type and call intel_cio2_bridge_instantiate_vcm() from
the v4l2-async bound op so that an I2C-client will be instatiated for
the VCM.

Note unfortunately on atomisp the _DSM to get the VCM type sometimes
returns a VCM even though there is none. Since VCMs are typically only
used together with certain sensors, work around this by adding a vcm
field to atomisp_sensor_config and only check for a VCM when that is set.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../media/atomisp/pci/atomisp_csi2_bridge.c   | 44 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c b/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c
index 8124be486e2e..92693206e4ca 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c
@@ -66,15 +66,25 @@ static const guid_t atomisp_dsm_guid =
 	GUID_INIT(0xdc2f6c4f, 0x045b, 0x4f1d,
 		  0x97, 0xb9, 0x88, 0x2a, 0x68, 0x60, 0xa4, 0xbe);
 
+/*
+ * 75c9a639-5c8a-4a00-9f48-a9c3b5da789f
+ * This _DSM GUID returns a string giving the VCM type e.g. "AD5823".
+ */
+static const guid_t vcm_dsm_guid =
+	GUID_INIT(0x75c9a639, 0x5c8a, 0x4a00,
+		  0x9f, 0x48, 0xa9, 0xc3, 0xb5, 0xda, 0x78, 0x9f);
+
 struct atomisp_sensor_config {
 	int lanes;
+	bool vcm;
 };
 
-#define ATOMISP_SENSOR_CONFIG(_HID, _LANES)				\
+#define ATOMISP_SENSOR_CONFIG(_HID, _LANES, _VCM)			\
 {									\
 	.id = _HID,							\
 	.driver_data = (long)&((const struct atomisp_sensor_config) {	\
 		.lanes = _LANES,					\
+		.vcm = _VCM,						\
 	})								\
 }
 
@@ -490,8 +500,28 @@ static int atomisp_csi2_add_gpio_mappings(struct acpi_device *adev)
 	return ret;
 }
 
+static char *atomisp_csi2_get_vcm_type(struct acpi_device *adev)
+{
+	union acpi_object *obj;
+	char *vcm_type;
+
+	obj = acpi_evaluate_dsm_typed(adev->handle, &vcm_dsm_guid, 0, 0,
+				      NULL, ACPI_TYPE_STRING);
+	if (!obj)
+		return NULL;
+
+	vcm_type = kstrdup(obj->string.pointer, GFP_KERNEL);
+	ACPI_FREE(obj);
+
+	if (!vcm_type)
+		return NULL;
+
+	string_lower(vcm_type, vcm_type);
+	return vcm_type;
+}
+
 static const struct acpi_device_id atomisp_sensor_configs[] = {
-	ATOMISP_SENSOR_CONFIG("INT33BE", 2),	/* OV5693 */
+	ATOMISP_SENSOR_CONFIG("INT33BE", 2, true),	/* OV5693 */
 	{}
 };
 
@@ -500,6 +530,7 @@ static int atomisp_csi2_parse_sensor_fwnode(struct acpi_device *adev,
 {
 	const struct acpi_device_id *id;
 	int ret, clock_num;
+	bool vcm = false;
 	int lanes = 1;
 
 	id = acpi_match_acpi_device(atomisp_sensor_configs, adev);
@@ -508,6 +539,7 @@ static int atomisp_csi2_parse_sensor_fwnode(struct acpi_device *adev,
 			(struct atomisp_sensor_config *)id->driver_data;
 
 		lanes = cfg->lanes;
+		vcm = cfg->vcm;
 	}
 
 	/*
@@ -545,6 +577,9 @@ static int atomisp_csi2_parse_sensor_fwnode(struct acpi_device *adev,
 	sensor->orientation = (sensor->link == 1) ?
 		V4L2_FWNODE_ORIENTATION_BACK : V4L2_FWNODE_ORIENTATION_FRONT;
 
+	if (vcm)
+		sensor->vcm_type = atomisp_csi2_get_vcm_type(adev);
+
 	return 0;
 }
 
@@ -583,6 +618,7 @@ static int atomisp_notifier_bound(struct v4l2_async_notifier *notifier,
 {
 	struct atomisp_device *isp = notifier_to_atomisp(notifier);
 	struct sensor_async_subdev *s_asd = to_sensor_asd(asd);
+	int ret;
 
 	if (s_asd->port >= ATOMISP_CAMERA_NR_PORTS) {
 		dev_err(isp->dev, "port %d not supported\n", s_asd->port);
@@ -594,6 +630,10 @@ static int atomisp_notifier_bound(struct v4l2_async_notifier *notifier,
 		return -EBUSY;
 	}
 
+	ret = ipu_bridge_instantiate_vcm(sd->dev);
+	if (ret)
+		return ret;
+
 	isp->sensor_subdevs[s_asd->port] = sd;
 	return 0;
 }
-- 
2.41.0

