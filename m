Return-Path: <linux-acpi+bounces-21436-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFsaEVneqWm4GgEAu9opvQ
	(envelope-from <linux-acpi+bounces-21436-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 20:49:45 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4CA217C37
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 20:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1664130F9CD1
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 19:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FCB303A1E;
	Thu,  5 Mar 2026 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6fv/+UF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2411FBCA7;
	Thu,  5 Mar 2026 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740084; cv=none; b=rXMXZrjh/FyHaeWnrbTsywyyPc2tN5xsiDH62JHwZti0OC24cXLhmsYVoWQcZX6MRrgImvIC5TPX+L57lNIs07ltibU3p+HK6YthG5VW75amuz/5aMz7ZYbYquM+es8MFk9nNmheu4or3Xs4hEatqLLHUhTMiyuBxV0Titu+UvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740084; c=relaxed/simple;
	bh=wZTLuyIEzm0W/hvy9SmyHAmJORCVKTwCpy+lEu9Hxfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEOJjb7/qIts5WO9pe0/bk1oiStb9OtEusaSLlsQTGmvfaREGlkt5ujNUmtk3xDZ9wupZmE8Zoc6NMcsVByDsRTuaztVFFsi63aQMJ1PTCsmbullYUs4SVieiXD09BUQm9W49ZLBkfape4UXlcY5ubR0CiAysOAyiUTObsyL+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6fv/+UF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1860AC116C6;
	Thu,  5 Mar 2026 19:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772740083;
	bh=wZTLuyIEzm0W/hvy9SmyHAmJORCVKTwCpy+lEu9Hxfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6fv/+UF75GoUFJmF74hgsDzLXFIS6z5CTRJbvXHJ3Qi6dnVI9ZIZI15mMR1PBZbp
	 hPo6ckU1c0azIoJ0f4lT8pvUqO+jZrkKrGCYGnWpsxbTkMjxSSPIaihdConMSSy9Ex
	 95cDP/hjRfj9JVk9NGDOWaxXwD+wI17AdMl+SRO4LabN7mPSmTCGApI04oeGGp0/BF
	 IkuZ1GSs+ec9q/jV0/sNqZhjeR1eORpmPiEYe2DUMCWzMCfc7A4dWPTqJ/1hXb+mFZ
	 kx0DsiNRvA6ay/h3kqQkAEPMMNHXl1Bnn+YHZHXSWV3oa+MoDfg5pJGWWXnj/nOGTj
	 YUQnM69ICR1Vw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject:
 [PATCH v2 6/6] platform/chrome: wilco_ec: event: Convert to a platform driver
Date: Thu, 05 Mar 2026 20:46:19 +0100
Message-ID: <9600287.CDJkKcVGEf@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6259948.lOV4Wx5bFT@rafael.j.wysocki>
References: <6259948.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9E4CA217C37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21436-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the ChromeOS Wilco Embedded Controller event
ACPI driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/platform/chrome/wilco_ec/event.c | 66 ++++++++++++------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index f4500dd05f93..b6e935badc0e 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -38,6 +38,7 @@
 #include <linux/io.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
@@ -198,7 +199,7 @@ struct event_device_data {
 
 /**
  * enqueue_events() - Place EC events in queue to be read by userspace.
- * @adev: Device the events came from.
+ * @dev: Device the events came from.
  * @buf: Buffer of event data.
  * @length: Length of event data buffer.
  *
@@ -209,9 +210,9 @@ struct event_device_data {
  *
  * Return: 0 on success or negative error code on failure.
  */
-static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
+static int enqueue_events(struct device *dev, const u8 *buf, u32 length)
 {
-	struct event_device_data *dev_data = adev->driver_data;
+	struct event_device_data *dev_data = dev_get_drvdata(dev);
 	struct ec_event *event, *queue_event, *old_event;
 	size_t num_words, event_size;
 	u32 offset = 0;
@@ -222,14 +223,14 @@ static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
 		num_words = ec_event_num_words(event);
 		event_size = ec_event_size(event);
 		if (num_words > EC_ACPI_MAX_EVENT_WORDS) {
-			dev_err(&adev->dev, "Too many event words: %zu > %d\n",
+			dev_err(dev, "Too many event words: %zu > %d\n",
 				num_words, EC_ACPI_MAX_EVENT_WORDS);
 			return -EOVERFLOW;
 		}
 
 		/* Ensure event does not overflow the available buffer */
 		if ((offset + event_size) > length) {
-			dev_err(&adev->dev, "Event exceeds buffer: %zu > %d\n",
+			dev_err(dev, "Event exceeds buffer: %zu > %d\n",
 				offset + event_size, length);
 			return -EOVERFLOW;
 		}
@@ -262,12 +263,13 @@ static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
 static void event_device_notify(acpi_handle handle, u32 value, void *data)
 {
 	struct acpi_buffer event_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_device *adev = data;
+	struct device *dev = data;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	union acpi_object *obj;
 	acpi_status status;
 
 	if (value != EC_ACPI_NOTIFY_EVENT) {
-		dev_err(&adev->dev, "Invalid event: 0x%08x\n", value);
+		dev_err(dev, "Invalid event: 0x%08x\n", value);
 		return;
 	}
 
@@ -275,31 +277,31 @@ static void event_device_notify(acpi_handle handle, u32 value, void *data)
 	status = acpi_evaluate_object(adev->handle, EC_ACPI_GET_EVENT,
 				      NULL, &event_buffer);
 	if (ACPI_FAILURE(status)) {
-		dev_err(&adev->dev, "Error executing ACPI method %s()\n",
+		dev_err(dev, "Error executing ACPI method %s()\n",
 			EC_ACPI_GET_EVENT);
 		return;
 	}
 
 	obj = (union acpi_object *)event_buffer.pointer;
 	if (!obj) {
-		dev_err(&adev->dev, "Nothing returned from %s()\n",
+		dev_err(dev, "Nothing returned from %s()\n",
 			EC_ACPI_GET_EVENT);
 		return;
 	}
 	if (obj->type != ACPI_TYPE_BUFFER) {
-		dev_err(&adev->dev, "Invalid object returned from %s()\n",
+		dev_err(dev, "Invalid object returned from %s()\n",
 			EC_ACPI_GET_EVENT);
 		kfree(obj);
 		return;
 	}
 	if (obj->buffer.length < sizeof(struct ec_event)) {
-		dev_err(&adev->dev, "Invalid buffer length %d from %s()\n",
+		dev_err(dev, "Invalid buffer length %d from %s()\n",
 			obj->buffer.length, EC_ACPI_GET_EVENT);
 		kfree(obj);
 		return;
 	}
 
-	enqueue_events(adev, obj->buffer.pointer, obj->buffer.length);
+	enqueue_events(dev, obj->buffer.pointer, obj->buffer.length);
 	kfree(obj);
 }
 
@@ -434,8 +436,8 @@ static void hangup_device(struct event_device_data *dev_data)
 }
 
 /**
- * event_device_add() - Callback when creating a new device.
- * @adev: ACPI device that we will be receiving events from.
+ * event_device_probe() - Callback when creating a new device.
+ * @pdev: Platform device that we will be receiving events from.
  *
  * This finds a free minor number for the device, allocates and initializes
  * some device data, and creates a new device and char dev node.
@@ -447,7 +449,7 @@ static void hangup_device(struct event_device_data *dev_data)
  *
  * Return: 0 on success, negative error code on failure.
  */
-static int event_device_add(struct acpi_device *adev)
+static int event_device_probe(struct platform_device *pdev)
 {
 	struct event_device_data *dev_data;
 	int error, minor;
@@ -455,7 +457,7 @@ static int event_device_add(struct acpi_device *adev)
 	minor = ida_alloc_max(&event_ida, EVENT_MAX_DEV-1, GFP_KERNEL);
 	if (minor < 0) {
 		error = minor;
-		dev_err(&adev->dev, "Failed to find minor number: %d\n", error);
+		dev_err(&pdev->dev, "Failed to find minor number: %d\n", error);
 		return error;
 	}
 
@@ -466,7 +468,7 @@ static int event_device_add(struct acpi_device *adev)
 	}
 
 	/* Initialize the device data. */
-	adev->driver_data = dev_data;
+	platform_set_drvdata(pdev, dev_data);
 	dev_data->events = event_queue_new(queue_size);
 	if (!dev_data->events) {
 		kfree(dev_data);
@@ -492,8 +494,9 @@ static int event_device_add(struct acpi_device *adev)
 		goto free_dev_data;
 
 	/* Install an ACPI notify handler. */
-	error = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-						event_device_notify, adev);
+	error = acpi_dev_install_notify_handler(ACPI_COMPANION(&pdev->dev),
+						ACPI_DEVICE_NOTIFY,
+						event_device_notify, &pdev->dev);
 	if (error)
 		goto free_cdev;
 
@@ -508,12 +511,12 @@ static int event_device_add(struct acpi_device *adev)
 	return error;
 }
 
-static void event_device_remove(struct acpi_device *adev)
+static void event_device_remove(struct platform_device *pdev)
 {
-	struct event_device_data *dev_data = adev->driver_data;
+	struct event_device_data *dev_data = platform_get_drvdata(pdev);
 
-	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-				       event_device_notify);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, event_device_notify);
 	cdev_device_del(&dev_data->cdev, &dev_data->dev);
 	ida_free(&event_ida, MINOR(dev_data->dev.devt));
 	hangup_device(dev_data);
@@ -525,13 +528,12 @@ static const struct acpi_device_id event_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, event_acpi_ids);
 
-static struct acpi_driver event_driver = {
-	.name = DRV_NAME,
-	.class = DRV_NAME,
-	.ids = event_acpi_ids,
-	.ops = {
-		.add = event_device_add,
-		.remove = event_device_remove,
+static struct platform_driver event_driver = {
+	.probe = event_device_probe,
+	.remove = event_device_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.acpi_match_table = event_acpi_ids,
 	},
 };
 
@@ -554,7 +556,7 @@ static int __init event_module_init(void)
 	}
 	event_major = MAJOR(dev_num);
 
-	ret = acpi_bus_register_driver(&event_driver);
+	ret = platform_driver_register(&event_driver);
 	if (ret < 0) {
 		pr_err(DRV_NAME ": Failed registering driver: %d\n", ret);
 		goto unregister_region;
@@ -572,7 +574,7 @@ static int __init event_module_init(void)
 
 static void __exit event_module_exit(void)
 {
-	acpi_bus_unregister_driver(&event_driver);
+	platform_driver_unregister(&event_driver);
 	unregister_chrdev_region(MKDEV(event_major, 0), EVENT_MAX_DEV);
 	class_unregister(&event_class);
 	ida_destroy(&event_ida);
-- 
2.51.0





