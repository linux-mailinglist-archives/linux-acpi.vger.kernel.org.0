Return-Path: <linux-acpi+bounces-21286-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AaYFtw8pGlnawUAu9opvQ
	(envelope-from <linux-acpi+bounces-21286-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 14:19:24 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E75391CFDFB
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 14:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D21C300DCF3
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Mar 2026 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AF0329E5D;
	Sun,  1 Mar 2026 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9M3Hewd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F621EA7CE;
	Sun,  1 Mar 2026 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772371160; cv=none; b=F5qMFC13HS3k3J2GYMpc8jfgTYb4rq++wInTNmhDJ6vlX0MbFJiSy29LSHjFDoEt9JMCU13zlq1PKzX6cVJITLxfg0ruLvFzj0kFOQLUYEIYLPKW+WA7sTxoJtM/q9HDAHEOaKKQMFPffQ2Tj9NzjyhyHfqT4FJI0xEt5moVPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772371160; c=relaxed/simple;
	bh=QGCpsAa0CN0HrBsbqA9dj65xm4K4Kso4Z89urqXEalA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLZTOnVNZmSBlclGJxys4zNKRYYoU/5zbw43TqQXLKsyCB1Jb22SQ4yRbLDcFL2Qe7uh7VqykdeHdked3zzNC3ZkPM4aHi9k3p/VtcI/L4MlSprGwd664xBHP6nk61VD/E8V4FQNWvBQvxs67RcKwfmGAAP83O4t1R1/f0JAfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9M3Hewd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52595C116C6;
	Sun,  1 Mar 2026 13:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772371160;
	bh=QGCpsAa0CN0HrBsbqA9dj65xm4K4Kso4Z89urqXEalA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9M3Hewd5/mUpzxH6KJeI9ogtqwNmYHnY0bJqWkf75d6oU4nkINwnuOYYwpo5JCZr
	 vCbn5gUZCG96gQcJsKq65H54j16S54Qq/q1LumX6X/f9oybunwdKvjM581tBudSk2p
	 rv3nipgHnGey7cGLmMGwqK9MbfHF/ypJ9OKPc/ymjBQTninHSpQMQf9KArHT4aMnTw
	 fYiVZWS5cd+mejuEUmGbqA3W+yDZL6/qnIWVHEYMHR99h6A6TK51DDALLtGPMo0Z/K
	 QqQLnSAzNM0nUfoTF/S+bB50xAj7wDctpW7c2LAJaVgOHgKWslT8oWee4bfAh8qwMK
	 WoXaHbhJWJq3Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, linux-hwmon@vger.kernel.org
Subject:
 [PATCH v1 3/3] hwmon: (acpi_power_meter) Convert ACPI driver to a platform
 one
Date: Sun, 01 Mar 2026 14:18:49 +0100
Message-ID: <1952740.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5974797.DvuYhMxLoT@rafael.j.wysocki>
References: <5974797.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21286-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,oracle.com:email]
X-Rspamd-Queue-Id: E75391CFDFB
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the hwmon ACPI power meter driver to a
platform one.

After this change, the subordinate hwmon device will be registered
under the platform device representing the ACPI power meter, sysfs
notifications will trigger on that device, and diagnostic messages
will be printed relative to it instead of its ACPI companion.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/hwmon/acpi_power_meter.c | 76 ++++++++++++++++----------------
 1 file changed, 37 insertions(+), 39 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index c010f55f7c7b..be7f702dcde9 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -18,6 +18,7 @@
 #include <linux/time.h>
 #include <linux/err.h>
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 
 #define ACPI_POWER_METER_NAME		"power_meter"
 #define ACPI_POWER_METER_DEVICE_NAME	"Power Meter"
@@ -816,8 +817,8 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
 /* Handle ACPI event notifications */
 static void acpi_power_meter_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct acpi_power_meter_resource *resource = acpi_driver_data(device);
+	struct device *dev = data;
+	struct acpi_power_meter_resource *resource = dev_get_drvdata(dev);
 	int res;
 
 	guard(mutex)(&acpi_notify_lock);
@@ -833,43 +834,43 @@ static void acpi_power_meter_notify(acpi_handle handle, u32 event, void *data)
 		remove_domain_devices(resource);
 		res = read_capabilities(resource);
 		if (res)
-			dev_err_once(&device->dev, "read capabilities failed.\n");
+			dev_err_once(dev, "read capabilities failed.\n");
 		res = read_domain_devices(resource);
 		if (res && res != -ENODEV)
-			dev_err_once(&device->dev, "read domain devices failed.\n");
+			dev_err_once(dev, "read domain devices failed.\n");
 
 		mutex_unlock(&resource->lock);
 
 		resource->hwmon_dev =
-			hwmon_device_register_with_info(&device->dev,
+			hwmon_device_register_with_info(dev,
 							ACPI_POWER_METER_NAME,
 							resource,
 							&power_meter_chip_info,
 							power_extra_groups);
 		if (IS_ERR(resource->hwmon_dev))
-			dev_err_once(&device->dev, "register hwmon device failed.\n");
+			dev_err_once(dev, "register hwmon device failed.\n");
 
 		break;
 	case METER_NOTIFY_TRIP:
-		sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
+		sysfs_notify(&dev->kobj, NULL, POWER_AVERAGE_NAME);
 		break;
 	case METER_NOTIFY_CAP:
 		mutex_lock(&resource->lock);
 		res = update_cap(resource);
 		if (res)
-			dev_err_once(&device->dev, "update cap failed when capping value is changed.\n");
+			dev_err_once(dev, "update cap failed when capping value is changed.\n");
 		mutex_unlock(&resource->lock);
-		sysfs_notify(&device->dev.kobj, NULL, POWER_CAP_NAME);
+		sysfs_notify(&dev->kobj, NULL, POWER_CAP_NAME);
 		break;
 	case METER_NOTIFY_INTERVAL:
-		sysfs_notify(&device->dev.kobj, NULL, POWER_AVG_INTERVAL_NAME);
+		sysfs_notify(&dev->kobj, NULL, POWER_AVG_INTERVAL_NAME);
 		break;
 	case METER_NOTIFY_CAPPING:
 		mutex_lock(&resource->lock);
 		resource->power_alarm = true;
 		mutex_unlock(&resource->lock);
-		sysfs_notify(&device->dev.kobj, NULL, POWER_ALARM_NAME);
-		dev_info(&device->dev, "Capping in progress.\n");
+		sysfs_notify(&dev->kobj, NULL, POWER_ALARM_NAME);
+		dev_info(dev, "Capping in progress.\n");
 		break;
 	default:
 		WARN(1, "Unexpected event %d\n", event);
@@ -877,16 +878,15 @@ static void acpi_power_meter_notify(acpi_handle handle, u32 event, void *data)
 	}
 
 	acpi_bus_generate_netlink_event(ACPI_POWER_METER_CLASS,
-					dev_name(&device->dev), event, 0);
+					dev_name(&resource->acpi_dev->dev),
+					event, 0);
 }
 
-static int acpi_power_meter_add(struct acpi_device *device)
+static int acpi_power_meter_probe(struct platform_device *pdev)
 {
-	int res;
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_power_meter_resource *resource;
-
-	if (!device)
-		return -EINVAL;
+	int res;
 
 	resource = kzalloc_obj(*resource);
 	if (!resource)
@@ -897,7 +897,8 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	mutex_init(&resource->lock);
 	strscpy(acpi_device_name(device), ACPI_POWER_METER_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
-	device->driver_data = resource;
+
+	platform_set_drvdata(pdev, resource);
 
 #if IS_REACHABLE(CONFIG_ACPI_IPMI)
 	/*
@@ -910,7 +911,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
 		struct acpi_device *ipi_device = acpi_dev_get_first_match_dev("IPI0001", NULL, -1);
 
 		if (ipi_device && acpi_wait_for_acpi_ipmi())
-			dev_warn(&device->dev, "Waiting for ACPI IPMI timeout");
+			dev_warn(&pdev->dev, "Waiting for ACPI IPMI timeout");
 		acpi_dev_put(ipi_device);
 	}
 #endif
@@ -928,7 +929,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
 		goto exit_free_capability;
 
 	resource->hwmon_dev =
-		hwmon_device_register_with_info(&device->dev,
+		hwmon_device_register_with_info(&pdev->dev,
 						ACPI_POWER_METER_NAME, resource,
 						&power_meter_chip_info,
 						power_extra_groups);
@@ -938,7 +939,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	}
 
 	res = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-					      acpi_power_meter_notify, device);
+					      acpi_power_meter_notify, &pdev->dev);
 	if (res)
 		goto exit_hwmon;
 
@@ -957,11 +958,11 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	return res;
 }
 
-static void acpi_power_meter_remove(struct acpi_device *device)
+static void acpi_power_meter_remove(struct platform_device *pdev)
 {
-	struct acpi_power_meter_resource *resource = acpi_driver_data(device);
+	struct acpi_power_meter_resource *resource = platform_get_drvdata(pdev);
 
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+	acpi_dev_remove_notify_handler(resource->acpi_dev, ACPI_DEVICE_NOTIFY,
 				       acpi_power_meter_notify);
 
 	if (!IS_ERR(resource->hwmon_dev))
@@ -975,9 +976,7 @@ static void acpi_power_meter_remove(struct acpi_device *device)
 
 static int acpi_power_meter_resume(struct device *dev)
 {
-	struct acpi_power_meter_resource *resource;
-
-	resource = acpi_driver_data(to_acpi_device(dev));
+	struct acpi_power_meter_resource *resource = dev_get_drvdata(dev);
 
 	free_capabilities(resource);
 	read_capabilities(resource);
@@ -988,15 +987,14 @@ static int acpi_power_meter_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(acpi_power_meter_pm, NULL,
 				acpi_power_meter_resume);
 
-static struct acpi_driver acpi_power_meter_driver = {
-	.name = "power_meter",
-	.class = ACPI_POWER_METER_CLASS,
-	.ids = power_meter_ids,
-	.ops = {
-		.add = acpi_power_meter_add,
-		.remove = acpi_power_meter_remove,
-		},
-	.drv.pm = pm_sleep_ptr(&acpi_power_meter_pm),
+static struct platform_driver acpi_power_meter_driver = {
+	.probe = acpi_power_meter_probe,
+	.remove = acpi_power_meter_remove,
+	.driver = {
+		.name = "acpi-power-meter",
+		.acpi_match_table = power_meter_ids,
+		.pm = &acpi_power_meter_pm,
+	},
 };
 
 /* Module init/exit routines */
@@ -1025,7 +1023,7 @@ static int __init acpi_power_meter_init(void)
 
 	dmi_check_system(pm_dmi_table);
 
-	result = acpi_bus_register_driver(&acpi_power_meter_driver);
+	result = platform_driver_register(&acpi_power_meter_driver);
 	if (result < 0)
 		return result;
 
@@ -1034,7 +1032,7 @@ static int __init acpi_power_meter_init(void)
 
 static void __exit acpi_power_meter_exit(void)
 {
-	acpi_bus_unregister_driver(&acpi_power_meter_driver);
+	platform_driver_unregister(&acpi_power_meter_driver);
 }
 
 MODULE_AUTHOR("Darrick J. Wong <darrick.wong@oracle.com>");
-- 
2.51.0





