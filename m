Return-Path: <linux-acpi+bounces-21448-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOwSDVPoqWnuHQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21448-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:32:19 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EC72182F1
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF333314FFCE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 20:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A5D3358B9;
	Thu,  5 Mar 2026 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbWMLV0Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231471FF7B3;
	Thu,  5 Mar 2026 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742567; cv=none; b=spzuSOLSvFKbQLARd8pD9L4udl8Tp0oXABQVMd+miDNcFp7xR7MAlu79hg48PhtUvtNxw5kqIbz8YRo71ydltueDQV6QOgZKHwDVMAJEXRGx7yTBagry1/illbsGK8AEzHlCXWXlgOChKAt2+hW8Y76YWkGkXitdsapWYS1sH4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742567; c=relaxed/simple;
	bh=RXaqs47MrQfQyVF4vJvbGeQy6snXg1DCV2i9eDHpb2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIt/wwRHXUr4MVEGnNNZjEVAL4hZ4iby9XMNx3ylL7NJvJKVf09nWkL4IAgl3XvEq6Bm0nyJxghw3HJELUVxpy45Egc/dGWwJHSkjJZoKqdRU72TBPBkMf7xdNPKYTMekwd4KW/H0IPqf93yPZWOWb0MhEtjwGT3rM2ZFSkmVuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbWMLV0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1173C116C6;
	Thu,  5 Mar 2026 20:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742566;
	bh=RXaqs47MrQfQyVF4vJvbGeQy6snXg1DCV2i9eDHpb2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CbWMLV0Yke9F5S/plPMI4tEFRIEboRicdaRIMFLHt9ijBBl1ySZrpRVj9TUxGmxmp
	 3/zDavpnrnZd6wbCRpW7yj5vT/b6w3pXJBceP7eu3ZObwk3GXlBNG4b7RDZpRsh3/6
	 bT2Un62pZi68wO6umSRkKGJ2Hw6zTFF40AC4gfsbvr94lW5Qz5pInn8kY5LSPqWLmI
	 WL45YW0NTN2V+f8C2pQOV777XI8QRu2K7JXvy4MYB/5nqj3WnSLlGT+AItk6ZNZ/gT
	 Bqs0JFSfaOG8zq49gT+tcuyJ0lXP8ue9iQapit8wilguu0MrH6dv7MWZERaSZEPe/q
	 khWs1mT1MK5Ng==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 5/9] ACPI: driver: Do not set acpi_device_name() unnecessarily
Date: Thu, 05 Mar 2026 21:17:06 +0100
Message-ID: <2233836.OBFZWjSADL@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4505861.ejJDZkT8p0@rafael.j.wysocki>
References: <4505861.ejJDZkT8p0@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 88EC72182F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21448-lists,linux-acpi=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

ACPI drivers usually set acpi_device_name() for the given struct
acpi_device to whatever they like, but that value is never used unless
the driver itself uses it and, quite unfortunately, drivers neglect to
clear it on remove.  Some drivers use it for printing messages or
initializing the names of subordinate devices, but it is better to use
string literals for that, especially if the given one is used just once.

To eliminate unnecessary overhead related to acpi_device_name()
handling, rework multiple core ACPI device drivers to stop setting
acpi_device_name() for struct acpi_device objects manipulated
by them and use a string literal instead of it where applicable.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ac.c              |  6 ++----
 drivers/acpi/acpi_memhotplug.c |  2 --
 drivers/acpi/acpi_pad.c        |  2 --
 drivers/acpi/acpi_processor.c  |  1 -
 drivers/acpi/acpi_video.c      | 16 +++++-----------
 drivers/acpi/battery.c         |  3 ---
 drivers/acpi/button.c          |  7 +++----
 drivers/acpi/ec.c              |  2 --
 drivers/acpi/pci_link.c        |  2 --
 drivers/acpi/pci_root.c        |  7 ++-----
 drivers/acpi/power.c           |  2 --
 drivers/acpi/sbs.c             |  1 -
 drivers/acpi/sbshc.c           |  2 --
 drivers/acpi/thermal.c         |  6 ++----
 include/acpi/processor.h       |  1 -
 15 files changed, 14 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index e0560a2c71a0..4985c8890609 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -22,7 +22,6 @@
 #include <acpi/battery.h>
 
 #define ACPI_AC_CLASS			"ac_adapter"
-#define ACPI_AC_DEVICE_NAME		"AC Adapter"
 #define ACPI_AC_FILE_STATE		"state"
 #define ACPI_AC_NOTIFY_STATUS		0x80
 #define ACPI_AC_STATUS_OFFLINE		0x00
@@ -203,7 +202,6 @@ static int acpi_ac_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ac->device = adev;
-	strscpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
 	strscpy(acpi_device_class(adev), ACPI_AC_CLASS);
 
 	platform_set_drvdata(pdev, ac);
@@ -226,8 +224,8 @@ static int acpi_ac_probe(struct platform_device *pdev)
 		goto err_release_ac;
 	}
 
-	pr_info("%s [%s] (%s-line)\n", acpi_device_name(adev),
-		acpi_device_bid(adev), str_on_off(ac->state));
+	pr_info("AC Adapter [%s] (%s-line)\n", acpi_device_bid(adev),
+		str_on_off(ac->state));
 
 	ac->battery_nb.notifier_call = acpi_ac_battery_notify;
 	register_acpi_notifier(&ac->battery_nb);
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 02a472fa85fc..7f021e6d8b0e 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -20,7 +20,6 @@
 
 #define ACPI_MEMORY_DEVICE_CLASS		"memory"
 #define ACPI_MEMORY_DEVICE_HID			"PNP0C80"
-#define ACPI_MEMORY_DEVICE_NAME			"Hotplug Mem Device"
 
 static const struct acpi_device_id memory_device_ids[] = {
 	{ACPI_MEMORY_DEVICE_HID, 0},
@@ -297,7 +296,6 @@ static int acpi_memory_device_add(struct acpi_device *device,
 	INIT_LIST_HEAD(&mem_device->res_list);
 	mem_device->device = device;
 	mem_device->mgid = -1;
-	sprintf(acpi_device_name(device), "%s", ACPI_MEMORY_DEVICE_NAME);
 	sprintf(acpi_device_class(device), "%s", ACPI_MEMORY_DEVICE_CLASS);
 	device->driver_data = mem_device;
 
diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 407a0d68525c..1f735f77fd1a 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -24,7 +24,6 @@
 #include <xen/xen.h>
 
 #define ACPI_PROCESSOR_AGGREGATOR_CLASS	"acpi_pad"
-#define ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME "Processor Aggregator"
 #define ACPI_PROCESSOR_AGGREGATOR_NOTIFY 0x80
 
 #define ACPI_PROCESSOR_AGGREGATOR_STATUS_SUCCESS	0
@@ -427,7 +426,6 @@ static int acpi_pad_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 
-	strscpy(acpi_device_name(adev), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
 	strscpy(acpi_device_class(adev), ACPI_PROCESSOR_AGGREGATOR_CLASS);
 
 	return acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index b34a48068a8d..46020a49a7ed 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -438,7 +438,6 @@ static int acpi_processor_add(struct acpi_device *device,
 	}
 
 	pr->handle = device->handle;
-	strscpy(acpi_device_name(device), ACPI_PROCESSOR_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
 	device->driver_data = pr;
 
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 124e58eb9087..4fc2e52401a6 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -30,9 +30,6 @@
 #include <linux/uaccess.h>
 #include <linux/string_choices.h>
 
-#define ACPI_VIDEO_BUS_NAME		"Video Bus"
-#define ACPI_VIDEO_DEVICE_NAME		"Video Device"
-
 #define MAX_NAME_LEN	20
 
 MODULE_AUTHOR("Bruno Ducrot");
@@ -1146,7 +1143,6 @@ static int acpi_video_bus_get_one_device(struct acpi_device *device, void *arg)
 		return -ENOMEM;
 	}
 
-	strscpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
 
 	data->device_id = device_id;
@@ -1884,7 +1880,7 @@ static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video,
 	snprintf(video->phys, sizeof(video->phys),
 			"%s/video/input0", acpi_device_hid(video->device));
 
-	input->name = acpi_device_name(video->device);
+	input->name = "Video Bus";
 	input->phys = video->phys;
 	input->id.bustype = BUS_HOST;
 	input->id.product = 0x06;
@@ -2021,7 +2017,6 @@ static int acpi_video_bus_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, video);
 
 	video->device = device;
-	strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
 	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
 	device->driver_data = video;
 
@@ -2043,11 +2038,10 @@ static int acpi_video_bus_probe(struct platform_device *pdev)
 	 */
 	acpi_device_fix_up_power_children(device);
 
-	pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
-	       ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
-	       str_yes_no(video->flags.multihead),
-	       str_yes_no(video->flags.rom),
-	       str_yes_no(video->flags.post));
+	pr_info("Video Device [%s] (multi-head: %s  rom: %s  post: %s)\n",
+		acpi_device_bid(device), str_yes_no(video->flags.multihead),
+		str_yes_no(video->flags.rom), str_yes_no(video->flags.post));
+
 	mutex_lock(&video_list_lock);
 	list_add_tail(&video->entry, &video_bus_head);
 	mutex_unlock(&video_list_lock);
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 8fbad8bc4650..acf5dd2177a1 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -33,8 +33,6 @@
 #define ACPI_BATTERY_CAPACITY_VALID(capacity) \
 	((capacity) != 0 && (capacity) != ACPI_BATTERY_VALUE_UNKNOWN)
 
-#define ACPI_BATTERY_DEVICE_NAME	"Battery"
-
 /* Battery power unit: 0 means mW, 1 means mA */
 #define ACPI_BATTERY_POWER_UNIT_MA	1
 
@@ -1229,7 +1227,6 @@ static int acpi_battery_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, battery);
 
 	battery->device = device;
-	strscpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 
 	result = devm_mutex_init(&pdev->dev, &battery->update_lock);
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 97b05246efab..c57bd9c63057 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -558,27 +558,26 @@ static int acpi_button_probe(struct platform_device *pdev)
 		goto err_free_button;
 	}
 
-	name = acpi_device_name(device);
 	class = acpi_device_class(device);
 
 	if (!strcmp(hid, ACPI_BUTTON_HID_POWER) ||
 	    !strcmp(hid, ACPI_BUTTON_HID_POWERF)) {
 		button->type = ACPI_BUTTON_TYPE_POWER;
 		handler = acpi_button_notify;
-		strscpy(name, ACPI_BUTTON_DEVICE_NAME_POWER, MAX_ACPI_DEVICE_NAME_LEN);
+		name = ACPI_BUTTON_DEVICE_NAME_POWER;
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
 	} else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEP) ||
 		   !strcmp(hid, ACPI_BUTTON_HID_SLEEPF)) {
 		button->type = ACPI_BUTTON_TYPE_SLEEP;
 		handler = acpi_button_notify;
-		strscpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP, MAX_ACPI_DEVICE_NAME_LEN);
+		name = ACPI_BUTTON_DEVICE_NAME_SLEEP;
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
 	} else if (!strcmp(hid, ACPI_BUTTON_HID_LID)) {
 		button->type = ACPI_BUTTON_TYPE_LID;
 		handler = acpi_lid_notify;
-		strscpy(name, ACPI_BUTTON_DEVICE_NAME_LID, MAX_ACPI_DEVICE_NAME_LEN);
+		name = ACPI_BUTTON_DEVICE_NAME_LID;
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
 		input->open = acpi_lid_input_open;
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5f63ed120a2c..4b21279012a7 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -36,7 +36,6 @@
 #include "internal.h"
 
 #define ACPI_EC_CLASS			"embedded_controller"
-#define ACPI_EC_DEVICE_NAME		"Embedded Controller"
 
 /* EC status register */
 #define ACPI_EC_FLAG_OBF	0x01	/* Output buffer full */
@@ -1681,7 +1680,6 @@ static int acpi_ec_probe(struct platform_device *pdev)
 	struct acpi_ec *ec;
 	int ret;
 
-	strscpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_EC_CLASS);
 
 	if (boot_ec && (boot_ec->handle == device->handle ||
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 45bdfd06bd21..5745de24024c 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -30,7 +30,6 @@
 #include "internal.h"
 
 #define ACPI_PCI_LINK_CLASS		"pci_irq_routing"
-#define ACPI_PCI_LINK_DEVICE_NAME	"PCI Interrupt Link"
 #define ACPI_PCI_LINK_MAX_POSSIBLE	16
 
 static int acpi_pci_link_add(struct acpi_device *device,
@@ -725,7 +724,6 @@ static int acpi_pci_link_add(struct acpi_device *device,
 		return -ENOMEM;
 
 	link->device = device;
-	strscpy(acpi_device_name(device), ACPI_PCI_LINK_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_PCI_LINK_CLASS);
 	device->driver_data = link;
 
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 4a882e939525..f4aa5b624d9b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -25,7 +25,6 @@
 #include "internal.h"
 
 #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
-#define ACPI_PCI_ROOT_DEVICE_NAME	"PCI Root Bridge"
 static int acpi_pci_root_add(struct acpi_device *device,
 			     const struct acpi_device_id *not_used);
 static void acpi_pci_root_remove(struct acpi_device *device);
@@ -689,7 +688,6 @@ static int acpi_pci_root_add(struct acpi_device *device,
 
 	root->device = device;
 	root->segment = segment & 0xFFFF;
-	strscpy(acpi_device_name(device), ACPI_PCI_ROOT_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	device->driver_data = root;
 
@@ -698,9 +696,8 @@ static int acpi_pci_root_add(struct acpi_device *device,
 		goto end;
 	}
 
-	pr_info("%s [%s] (domain %04x %pR)\n",
-	       acpi_device_name(device), acpi_device_bid(device),
-	       root->segment, &root->secondary);
+	pr_info("PCI Root Bridge [%s] (domain %04x %pR)\n",
+		acpi_device_bid(device), root->segment, &root->secondary);
 
 	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
 
diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 4611159ee734..dcc9ad7790f0 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -38,7 +38,6 @@
 #include "internal.h"
 
 #define ACPI_POWER_CLASS		"power_resource"
-#define ACPI_POWER_DEVICE_NAME		"Power Resource"
 #define ACPI_POWER_RESOURCE_STATE_OFF	0x00
 #define ACPI_POWER_RESOURCE_STATE_ON	0x01
 #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
@@ -955,7 +954,6 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 	mutex_init(&resource->resource_lock);
 	INIT_LIST_HEAD(&resource->list_node);
 	INIT_LIST_HEAD(&resource->dependents);
-	strscpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_POWER_CLASS);
 	device->power.state = ACPI_STATE_UNKNOWN;
 	device->flags.match_driver = true;
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index bbd3938f7b52..7e789290c5ad 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -648,7 +648,6 @@ static int acpi_sbs_probe(struct platform_device *pdev)
 
 	sbs->hc = dev_get_drvdata(pdev->dev.parent);
 	sbs->device = device;
-	strscpy(acpi_device_name(device), ACPI_SBS_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_SBS_CLASS);
 
 	result = acpi_charger_add(sbs);
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 36850831910b..97eaa2fc31f2 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -19,7 +19,6 @@
 #include "internal.h"
 
 #define ACPI_SMB_HC_CLASS	"smbus_host_ctl"
-#define ACPI_SMB_HC_DEVICE_NAME	"ACPI SMBus HC"
 
 struct acpi_smb_hc {
 	struct acpi_ec *ec;
@@ -251,7 +250,6 @@ static int acpi_smbus_hc_probe(struct platform_device *pdev)
 		return -EIO;
 	}
 
-	strscpy(acpi_device_name(device), ACPI_SMB_HC_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_SMB_HC_CLASS);
 
 	hc = kzalloc_obj(struct acpi_smb_hc);
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 64356b004a57..6ccb364665d1 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -35,7 +35,6 @@
 #include "internal.h"
 
 #define ACPI_THERMAL_CLASS		"thermal_zone"
-#define ACPI_THERMAL_DEVICE_NAME	"Thermal Zone"
 #define ACPI_THERMAL_NOTIFY_TEMPERATURE	0x80
 #define ACPI_THERMAL_NOTIFY_THRESHOLDS	0x81
 #define ACPI_THERMAL_NOTIFY_DEVICES	0x82
@@ -800,7 +799,6 @@ static int acpi_thermal_probe(struct platform_device *pdev)
 
 	tz->device = device;
 	strscpy(tz->name, device->pnp.bus_id);
-	strscpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 
 	acpi_thermal_aml_dependency_fix(tz);
@@ -879,8 +877,8 @@ static int acpi_thermal_probe(struct platform_device *pdev)
 	mutex_init(&tz->thermal_check_lock);
 	INIT_WORK(&tz->thermal_check_work, acpi_thermal_check_fn);
 
-	pr_info("%s [%s] (%ld C)\n", acpi_device_name(device),
-		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temp_dk));
+	pr_info("Thermal Zone [%s] (%ld C)\n", acpi_device_bid(device),
+		deci_kelvin_to_celsius(tz->temp_dk));
 
 	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
 						 acpi_thermal_notify, tz);
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 7146a8e9e9c2..43fe4a85fc0f 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -15,7 +15,6 @@
 #include <asm/acpi.h>
 
 #define ACPI_PROCESSOR_CLASS		"processor"
-#define ACPI_PROCESSOR_DEVICE_NAME	"Processor"
 #define ACPI_PROCESSOR_DEVICE_HID	"ACPI0007"
 #define ACPI_PROCESSOR_CONTAINER_HID	"ACPI0010"
 
-- 
2.51.0





