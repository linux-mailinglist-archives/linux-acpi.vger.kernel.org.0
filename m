Return-Path: <linux-acpi+bounces-21571-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAHKOYYzr2kPQQIAu9opvQ
	(envelope-from <linux-acpi+bounces-21571-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 21:54:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 896452412C0
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 21:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 053C73021965
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 20:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2398B36D4F0;
	Mon,  9 Mar 2026 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WY2eAbHB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008C636CE0E;
	Mon,  9 Mar 2026 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089662; cv=none; b=XgvF7CIcVDHKiN9DSsMgnyRK/K6EP5Fbn/W5CN+TT+sDxgo24GhyTazJK+SfntbLO5JTMKK/xMrAlfjq4sm11+qdoP/d/2r+lUA3OraaWMiFe6PEcm3BnY9+/v3LPVGKXpLzknUp+rnHDfSeU8tups2gmB6TdXAVbjd8STUrHJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089662; c=relaxed/simple;
	bh=K8nj0ZvlkDs3rLoM2LZZlziwSN/f22Lwh4PTSQuQ3rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EMtb+V3b/S73REqQlRkn8uRHekMxcUHZSFlOSW0aVIeR0EvBh22LJVb5ZneHF5jszr7gdhCICq3peGpEh4o0YkSB69PfPTL1fsQVq06e9gaME+DBPjD4BUSPQMenfJn/HO8rPzvZ72CVZSJOxf96PN/j4ER/Fmi4lUFiM/4KNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WY2eAbHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54040C4CEF7;
	Mon,  9 Mar 2026 20:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773089661;
	bh=K8nj0ZvlkDs3rLoM2LZZlziwSN/f22Lwh4PTSQuQ3rc=;
	h=From:To:Cc:Subject:Date:From;
	b=WY2eAbHB9ModPQ72/iyD08AVM9Yxngj9WzNZaauC7ZX11I+7VdFAIbY02Js9e0qiG
	 JUI2SNl9qvp4Etw5N/ywYcL901RMmXlHb1J7C+sGNh7o4eNqAsYt4Cu3JkOVDMkyQI
	 LljovsXByc3Bln5APKajNkYcF2jbDSve5y0UqA58awMONGLFcaGCbuYawX3/RN3yYO
	 jJNM0O33+Qfl9WmOIXCgYpym3BzXOl8mpof2amNwDU1wWJWIcp5dYcfvpNUAOkwW7x
	 6/ctJZINYAVpU4oQW03USfag0f4Mov45j3rci4UKIRUI2+CCW6k4r01VlwWFH7VQEZ
	 3JZB96HefvU8Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Pratap Nirujogi <pratap.nirujogi@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] ACPI: video: Switch over to auxiliary bus type
Date: Mon, 09 Mar 2026 21:54:17 +0100
Message-ID: <5986516.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 896452412C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21571-lists,linux-acpi=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[amd.com,vger.kernel.org,kernel.org,gmx.de];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:email,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
switched over the ACPI video bus driver from an ACPI driver to a platform
driver, but that change introduced an unwanted and unexpected side effect.
Namely, on some systems, the ACPI device object of the ACPI video bus
device is an ACPI companion of multiple platform devices and, after
adding video_device_ids[] as an acpi_match_table to the acpi_video_bus
platform driver, all of those devices started to match that driver and
its probe callback is invoked for all of them (it fails, but it leaves
a confusing message in the log).  Moreover, the MODULE_DEVICE_TABLE()
of the ACPI video driver module matches all of the devices sharing the
ACPI companion with the ACPI video bus device.

To address this, make the core ACPI device enumeration code create an
auxiliary device for the ACPI video bus device object instead of a
platform device and switch over the ACPI video bus driver (once more)
to an auxiliary driver.

Auxiliary driver generally is a better match for ACPI video bus than
platform driver, among other things because the ACPI video bus device
does not require any resources to be allocated for it during
enumeration.  It also allows the ACPI video bus driver to stop abusing
device matching based on ACPI device IDs and it allows a special case
to be dropped from acpi_create_platform_device() because that function
need not worry about the ACPI video bus device any more.

Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform one")
Reported-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Link: https://lore.kernel.org/linux-acpi/007e3390-6b2b-457e-83c7-c794c5952018@amd.com/
Tested-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Added tags
   * Updated changelog (slightly)

---
 drivers/acpi/acpi_platform.c |    2 -
 drivers/acpi/acpi_video.c    |   45 ++++++++++++++++++++---------------------
 drivers/acpi/scan.c          |   47 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 24 deletions(-)

--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -135,7 +135,7 @@ struct platform_device *acpi_create_plat
 		}
 	}
 
-	if (adev->device_type == ACPI_BUS_TYPE_DEVICE && !adev->pnp.type.backlight) {
+	if (adev->device_type == ACPI_BUS_TYPE_DEVICE) {
 		LIST_HEAD(resource_list);
 
 		count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) "ACPI: video: " fmt
 
+#include <linux/auxiliary_bus.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -21,7 +22,6 @@
 #include <linux/sort.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
@@ -77,8 +77,9 @@ static int register_count;
 static DEFINE_MUTEX(register_count_mutex);
 static DEFINE_MUTEX(video_list_lock);
 static LIST_HEAD(video_bus_head);
-static int acpi_video_bus_probe(struct platform_device *pdev);
-static void acpi_video_bus_remove(struct platform_device *pdev);
+static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
+				const struct auxiliary_device_id *id);
+static void acpi_video_bus_remove(struct auxiliary_device *aux);
 static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data);
 
 /*
@@ -93,19 +94,16 @@ enum acpi_video_level_idx {
 	ACPI_VIDEO_FIRST_LEVEL,		/* actual supported levels begin here */
 };
 
-static const struct acpi_device_id video_device_ids[] = {
-	{ACPI_VIDEO_HID, 0},
-	{"", 0},
+static const struct auxiliary_device_id video_bus_auxiliary_id_table[] = {
+	{ .name = "acpi.video_bus" },
+	{},
 };
-MODULE_DEVICE_TABLE(acpi, video_device_ids);
+MODULE_DEVICE_TABLE(auxiliary, video_bus_auxiliary_id_table);
 
-static struct platform_driver acpi_video_bus = {
+static struct auxiliary_driver acpi_video_bus = {
 	.probe = acpi_video_bus_probe,
 	.remove = acpi_video_bus_remove,
-	.driver = {
-		.name = "acpi-video",
-		.acpi_match_table = video_device_ids,
-	},
+	.id_table = video_bus_auxiliary_id_table,
 };
 
 struct acpi_video_bus_flags {
@@ -1885,7 +1883,7 @@ static void acpi_video_dev_add_notify_ha
 }
 
 static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video,
-					     struct platform_device *pdev)
+					     struct device *parent)
 {
 	struct input_dev *input;
 	struct acpi_video_device *dev;
@@ -1908,7 +1906,7 @@ static int acpi_video_bus_add_notify_han
 	input->phys = video->phys;
 	input->id.bustype = BUS_HOST;
 	input->id.product = 0x06;
-	input->dev.parent = &pdev->dev;
+	input->dev.parent = parent;
 	input->evbit[0] = BIT(EV_KEY);
 	set_bit(KEY_SWITCHVIDEOMODE, input->keybit);
 	set_bit(KEY_VIDEO_NEXT, input->keybit);
@@ -1980,9 +1978,10 @@ static int acpi_video_bus_put_devices(st
 
 static int instance;
 
-static int acpi_video_bus_probe(struct platform_device *pdev)
+static int acpi_video_bus_probe(struct auxiliary_device *aux_dev,
+				const struct auxiliary_device_id *id_unused)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_device *device = ACPI_COMPANION(&aux_dev->dev);
 	struct acpi_video_bus *video;
 	bool auto_detect;
 	int error;
@@ -2019,7 +2018,7 @@ static int acpi_video_bus_probe(struct p
 		instance++;
 	}
 
-	platform_set_drvdata(pdev, video);
+	auxiliary_set_drvdata(aux_dev, video);
 
 	video->device = device;
 	strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
@@ -2068,7 +2067,7 @@ static int acpi_video_bus_probe(struct p
 	    !auto_detect)
 		acpi_video_bus_register_backlight(video);
 
-	error = acpi_video_bus_add_notify_handler(video, pdev);
+	error = acpi_video_bus_add_notify_handler(video, &aux_dev->dev);
 	if (error)
 		goto err_del;
 
@@ -2096,10 +2095,10 @@ err_free_video:
 	return error;
 }
 
-static void acpi_video_bus_remove(struct platform_device *pdev)
+static void acpi_video_bus_remove(struct auxiliary_device *aux_dev)
 {
-	struct acpi_video_bus *video = platform_get_drvdata(pdev);
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_video_bus *video = auxiliary_get_drvdata(aux_dev);
+	struct acpi_device *device = ACPI_COMPANION(&aux_dev->dev);
 
 	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
 				       acpi_video_bus_notify);
@@ -2163,7 +2162,7 @@ int acpi_video_register(void)
 
 	dmi_check_system(video_dmi_table);
 
-	ret = platform_driver_register(&acpi_video_bus);
+	ret = auxiliary_driver_register(&acpi_video_bus);
 	if (ret)
 		goto leave;
 
@@ -2183,7 +2182,7 @@ void acpi_video_unregister(void)
 {
 	mutex_lock(&register_count_mutex);
 	if (register_count) {
-		platform_driver_unregister(&acpi_video_bus);
+		auxiliary_driver_unregister(&acpi_video_bus);
 		register_count = 0;
 		may_report_brightness_keys = false;
 	}
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) "ACPI: " fmt
 
 #include <linux/async.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -2192,6 +2193,46 @@ static acpi_status acpi_bus_check_add_2(
 	return acpi_bus_check_add(handle, false, (struct acpi_device **)ret_p);
 }
 
+static void acpi_video_bus_device_release(struct device *dev)
+{
+	struct auxiliary_device *aux_dev = to_auxiliary_dev(dev);
+
+	kfree(aux_dev);
+}
+
+static void acpi_create_video_bus_device(struct acpi_device *adev,
+					 struct acpi_device *parent)
+{
+	struct auxiliary_device *aux_dev;
+	static unsigned int aux_dev_id;
+
+	aux_dev = kzalloc_obj(*aux_dev);
+	if (!aux_dev)
+		return;
+
+	aux_dev->id = aux_dev_id++;
+	aux_dev->name = "video_bus";
+	aux_dev->dev.parent = acpi_get_first_physical_node(parent);
+	if (!aux_dev->dev.parent)
+		goto err;
+
+	aux_dev->dev.release = acpi_video_bus_device_release;
+
+	if (auxiliary_device_init(aux_dev))
+		goto err;
+
+	ACPI_COMPANION_SET(&aux_dev->dev, adev);
+	if (__auxiliary_device_add(aux_dev, "acpi")) {
+		auxiliary_device_uninit(aux_dev);
+		goto err;
+	}
+
+	return;
+
+err:
+	kfree(aux_dev);
+}
+
 struct acpi_scan_system_dev {
 	struct list_head node;
 	struct acpi_device *adev;
@@ -2229,6 +2270,12 @@ static void acpi_default_enumeration(str
 			sd->adev = device;
 			list_add_tail(&sd->node, &acpi_scan_system_dev_list);
 		}
+	} else if (device->pnp.type.backlight) {
+		struct acpi_device *parent;
+
+		parent = acpi_dev_parent(device);
+		if (parent)
+			acpi_create_video_bus_device(device, parent);
 	} else {
 		/* For a regular device object, create a platform device. */
 		acpi_create_platform_device(device, NULL);




