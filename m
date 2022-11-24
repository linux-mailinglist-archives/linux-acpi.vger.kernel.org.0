Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442D16377BA
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Nov 2022 12:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiKXLdb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Nov 2022 06:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKXLd3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Nov 2022 06:33:29 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C58950CE
        for <linux-acpi@vger.kernel.org>; Thu, 24 Nov 2022 03:33:27 -0800 (PST)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NHwpY6v7yz15Mm7;
        Thu, 24 Nov 2022 19:32:53 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 19:33:26 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 24 Nov
 2022 19:33:25 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <airlied@gmail.com>, <daniel@ffwll.ch>
CC:     <liaoyu15@huawei.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <bskeggs@redhat.com>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <robert.moore@intel.com>, <liwei391@huawei.com>
Subject: [PATCH] drm/nouveau/acpi: Fix memory leak in nouveau_acpi_edid()
Date:   Thu, 24 Nov 2022 19:30:23 +0800
Message-ID: <20221124113023.4121023-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI buffer memory 'edid' should be freed as the buffer is not used
after kmemdup(). But we can't free 'edid' directly because it doesn't
point to acpi_object which should be passed to kfree(). Make
acpi_video_get_edid() get the address of acpi_object instead, so we can
free it to prevent memory leak.

Fixes: 24b102d3488c ("drm/nouveau: we can't free ACPI EDID, so make a copy that we can")
Reported-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/acpi/acpi_video.c              | 4 ++--
 drivers/gpu/drm/nouveau/nouveau_acpi.c | 8 ++++++--
 include/acpi/video.h                   | 5 +++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 32953646caeb..f050a755efef 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1441,7 +1441,7 @@ acpi_video_switch_brightness(struct work_struct *work)
 }
 
 int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
-			void **edid)
+			union acpi_object **edid)
 {
 	struct acpi_video_bus *video;
 	struct acpi_video_device *video_device;
@@ -1500,7 +1500,7 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
 			}
 		}
 
-		*edid = buffer->buffer.pointer;
+		*edid = buffer;
 		return length;
 	}
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index 8cf096f841a9..075ecad31572 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -365,7 +365,8 @@ nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
 {
 	struct acpi_device *acpidev;
 	int type, ret;
-	void *edid;
+	union acpi_object *edid;
+	void *ptr;
 
 	switch (connector->connector_type) {
 	case DRM_MODE_CONNECTOR_LVDS:
@@ -384,7 +385,10 @@ nouveau_acpi_edid(struct drm_device *dev, struct drm_connector *connector)
 	if (ret < 0)
 		return NULL;
 
-	return kmemdup(edid, EDID_LENGTH, GFP_KERNEL);
+	ptr = kmemdup(edid->buffer.pointer, EDID_LENGTH, GFP_KERNEL);
+	kfree(edid);
+
+	return ptr;
 }
 
 bool nouveau_acpi_video_backlight_use_native(void)
diff --git a/include/acpi/video.h b/include/acpi/video.h
index a275c35e5249..868749f95a34 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -19,6 +19,7 @@ struct acpi_video_device_brightness {
 };
 
 struct acpi_device;
+union acpi_object;
 
 #define ACPI_VIDEO_CLASS	"video"
 
@@ -57,7 +58,7 @@ extern int acpi_video_register(void);
 extern void acpi_video_unregister(void);
 extern void acpi_video_register_backlight(void);
 extern int acpi_video_get_edid(struct acpi_device *device, int type,
-			       int device_id, void **edid);
+			       int device_id, union acpi_object **edid);
 extern enum acpi_backlight_type acpi_video_get_backlight_type(void);
 extern bool acpi_video_backlight_use_native(void);
 /*
@@ -73,7 +74,7 @@ static inline int acpi_video_register(void) { return -ENODEV; }
 static inline void acpi_video_unregister(void) { return; }
 static inline void acpi_video_register_backlight(void) { return; }
 static inline int acpi_video_get_edid(struct acpi_device *device, int type,
-				      int device_id, void **edid)
+				      int device_id, union acpi_object **edid)
 {
 	return -ENODEV;
 }
-- 
2.25.1

