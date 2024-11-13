Return-Path: <linux-acpi+bounces-9537-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A0A9C6B31
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 10:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AD5281156
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5121BDA89;
	Wed, 13 Nov 2024 09:07:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908B81BD9E4;
	Wed, 13 Nov 2024 09:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488865; cv=none; b=caiuaYibQoXHw7jIFi3RrGQ3IkeA4g4YKnAPmqMb10lOHnFtvuCsxaaCWE+hb2Ug5NVfusU0zp7ZS0MQgNlpyGIQZ04yHLQcXQSpPi+hDGOk5d7zLkMx9ZFDDRhdzFyRo8OvE+kUjcIi8/CaFi6MbOtcYNd6rPj0KiCqua2fZek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488865; c=relaxed/simple;
	bh=BUoTlu4Rs4KpZfhOPbZHy2u0VzbK0xTwUYTf8we/JTs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DPGu7E6Q7Jq/UXjTABCVPAtNZroytwxQX3U4K/Oi7d/Rvu1xLIUfTnYAGzFNocmrYgMS14O0AWTrzL6hB4/Dl+9JmoiRpcASVz0gulA0qtQq4QmKtPI+tk25PcTgPKQobNgWVA//RvtZYH1ax4MHKXx8/OBaRDHKZVzPBdzMTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XpHSZ1PM2z1jy8C;
	Wed, 13 Nov 2024 17:05:50 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E98DF140203;
	Wed, 13 Nov 2024 17:07:39 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 17:07:39 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 17:07:39 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
	<liuyonglong@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2] ACPI: thermal: Support for linking devices associated with the thermal zone
Date: Wed, 13 Nov 2024 16:56:34 +0800
Message-ID: <20241113085634.7657-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemn100009.china.huawei.com (7.202.194.112)

There are many 'cdevX' files which link cooling devices under
'/sys/class/thermal/thermal_zoneX/'. These devices contain active cooling
devices and passive cooling devices. And user cann't directly know which
devices temperature is represented by the thermal zone.

However, ACPI spec provides a '_TZD' object which evaluates to a package
of device names. Each name corresponds to a device in the ACPI namespace
that is associated with the thermal zone. The temperature reported by the
thermal zone is roughly correspondent to that of each of the devices.

User can get all devices a thermal zone measured by the 'measures'
directory under the thermal zone device.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
v2: fix commitlog based on Rafael's comment.
---
 drivers/acpi/thermal.c | 114 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 78db38c7076e..398195a5d42f 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -119,6 +119,9 @@ struct acpi_thermal {
 	struct work_struct thermal_check_work;
 	struct mutex thermal_check_lock;
 	refcount_t thermal_check_count;
+	int num_domain_devices;
+	struct acpi_device **domain_devices;
+	struct kobject *holders_dir;
 };
 
 /* --------------------------------------------------------------------------
@@ -589,6 +592,103 @@ static const struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 	.critical = acpi_thermal_zone_device_critical,
 };
 
+static void acpi_thermal_remove_domain_devices(struct acpi_thermal *tz)
+{
+	int i;
+
+	if (!tz->num_domain_devices)
+		return;
+
+	for (i = 0; i < tz->num_domain_devices; i++) {
+		struct acpi_device *obj = tz->domain_devices[i];
+
+		if (!obj)
+			continue;
+
+		sysfs_remove_link(tz->holders_dir,
+				  kobject_name(&obj->dev.kobj));
+		acpi_dev_put(obj);
+	}
+
+	kfree(tz->domain_devices);
+	kobject_put(tz->holders_dir);
+	tz->num_domain_devices = 0;
+}
+
+static int acpi_thermal_read_domain_devices(struct acpi_thermal *tz)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *pss;
+	acpi_status status;
+	int ret = 0;
+	int i;
+
+	status = acpi_evaluate_object(tz->device->handle, "_TZD", NULL,
+				      &buffer);
+	if (ACPI_FAILURE(status)) {
+		acpi_evaluation_failure_warn(tz->device->handle, "_TZD",
+					     status);
+		return -ENODEV;
+	}
+
+	pss = buffer.pointer;
+	if (!pss ||
+	    pss->type != ACPI_TYPE_PACKAGE) {
+		dev_err(&tz->device->dev, "Thermal zone invalid _TZD data\n");
+		ret = -EFAULT;
+		goto end;
+	}
+
+	if (!pss->package.count)
+		goto end;
+
+	tz->domain_devices = kcalloc(pss->package.count,
+				     sizeof(struct acpi_device *), GFP_KERNEL);
+	if (!tz->domain_devices) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	tz->holders_dir = kobject_create_and_add("measures",
+						 &tz->device->dev.kobj);
+	if (!tz->holders_dir) {
+		ret = -ENOMEM;
+		goto exit_free;
+	}
+
+	tz->num_domain_devices = pss->package.count;
+	for (i = 0; i < pss->package.count; i++) {
+		struct acpi_device *obj;
+		union acpi_object *element = &pss->package.elements[i];
+
+		/* Refuse non-references */
+		if (element->type != ACPI_TYPE_LOCAL_REFERENCE)
+			continue;
+
+		/* Create a symlink to domain objects */
+		obj = acpi_get_acpi_dev(element->reference.handle);
+		tz->domain_devices[i] = obj;
+		if (!obj)
+			continue;
+
+		ret = sysfs_create_link(tz->holders_dir, &obj->dev.kobj,
+					kobject_name(&obj->dev.kobj));
+		if (ret) {
+			acpi_dev_put(obj);
+			tz->domain_devices[i] = NULL;
+		}
+	}
+
+	ret = 0;
+	goto end;
+
+exit_free:
+	kfree(tz->domain_devices);
+end:
+	kfree(buffer.pointer);
+	return ret;
+}
+
 static int acpi_thermal_zone_sysfs_add(struct acpi_thermal *tz)
 {
 	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
@@ -602,8 +702,19 @@ static int acpi_thermal_zone_sysfs_add(struct acpi_thermal *tz)
 	ret = sysfs_create_link(&tzdev->kobj,
 				   &tz->device->dev.kobj, "device");
 	if (ret)
-		sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
+		goto remove_thermal_zone;
 
+	/* _TZD method is optional. */
+	ret = acpi_thermal_read_domain_devices(tz);
+	if (ret != -ENODEV)
+		goto remove_device;
+
+	return 0;
+
+remove_device:
+	sysfs_remove_link(&tz->device->dev.kobj, "device");
+remove_thermal_zone:
+	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
 	return ret;
 }
 
@@ -611,6 +722,7 @@ static void acpi_thermal_zone_sysfs_remove(struct acpi_thermal *tz)
 {
 	struct device *tzdev = thermal_zone_device(tz->thermal_zone);
 
+	acpi_thermal_remove_domain_devices(tz);
 	sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
 	sysfs_remove_link(&tzdev->kobj, "device");
 }
-- 
2.22.0


