Return-Path: <linux-acpi+bounces-21445-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKzaLqbnqWnuHQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21445-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:29:26 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EF3218264
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29A073017059
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 20:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7791338910;
	Thu,  5 Mar 2026 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kjnro/fn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52BD338593;
	Thu,  5 Mar 2026 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742557; cv=none; b=NdGjID66NW/gySGjWjEuoMkfUrq++izV8hlVQ73RZlUkcmEiSjAH5uU2UI3CNDGQb/aHLwH2VRsMdD0yFV7VGQcUR1Sj/mmS0uUqNeEbQo6S0a4zrnBgqTNpjozjLpRXITTxjFJnD+MaK3/du68o9+50N1x1qrDiISbzrPvSwTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742557; c=relaxed/simple;
	bh=qLJKrioQnPX5VZ/wGVlU14UUUIUo9xALx/nto8Fn21g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMJ3JEsk+9YJ4GQngkvSEkseDSdJjH5fY4ZRB8tgyxf0oggtbnvrRiq3v36PDyamXNdPp28/IHSVbkkNL+m1bQKbRCZxUMfJ9IIc0JG+NgAhpcls6vOdX2Wb4hn5ad9mYQ/+UmFY5rroGaW8JSBIvb/tNBXvGrX7J2u3y3NduWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kjnro/fn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B31C19422;
	Thu,  5 Mar 2026 20:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742557;
	bh=qLJKrioQnPX5VZ/wGVlU14UUUIUo9xALx/nto8Fn21g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kjnro/fnAcJPI2vXj6EvP46umALsRNoAwc80wQByNyKRO/0cc5EAn619VKRqjX6ZR
	 uoQAHqM4AJgIJiYSUtzG6xFLKuaYNpYRGEbw0ECZti1hUsSMrv8tsSgfX2QOrBtThk
	 1JUZv8ol8FcxJ1mxAgQt8F+iywE9senSJCmkjBaIatIqkGQP8S0d6ZPDBoUywMRQhQ
	 JcaxaHlVYJ3RANXmPGqcxAbiv/uSFMAymdY7UF7bi1ddRfjVvn3AEKWDYw2i3eSUxj
	 eK+zZ1V2takRTktEHye9q4/rQSF9j75OWUiXe8GeaJPPIIvl4l/BlYIWr6IhCDBS3w
	 6FNGR+Wgphwuw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 8/9] ACPI: driver: Do not set acpi_device_class() unnecessarily
Date: Thu, 05 Mar 2026 21:21:55 +0100
Message-ID: <1885919.TLkxdtWsSY@rafael.j.wysocki>
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
X-Rspamd-Queue-Id: 34EF3218264
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21445-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,rafael.j.wysocki:mid,intel.com:email]
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Several core ACPI device drivers set acpi_device_class() for the given
struct acpi_device to whatever they like, but that value is never used
unless the driver itself uses it and, sadly, they neglect to clear it on
remove.  Since the only one of them still using acpi_device_class()
after previous changes is the button driver, update the others to stop
setting it in vain.  Also drop the related device class sybmols that
become redundant.

Since the ACPI button driver continues to use acpi_device_class(), make
it clear the struct field represented by acpi_device_class() in its
remove callback.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ac.c               |    1 -
 drivers/acpi/acpi_memhotplug.c  |    2 --
 drivers/acpi/acpi_pad.c         |    5 +----
 drivers/acpi/acpi_processor.c   |    1 -
 drivers/acpi/acpi_video.c       |    3 ---
 drivers/acpi/battery.c          |    1 -
 drivers/acpi/button.c           |    2 ++
 drivers/acpi/ec.c               |    4 ----
 drivers/acpi/pci_link.c         |    2 --
 drivers/acpi/pci_root.c         |    2 --
 drivers/acpi/power.c            |    2 --
 drivers/acpi/processor_driver.c |    4 ++--
 drivers/acpi/sbs.c              |    2 --
 drivers/acpi/sbshc.c            |    4 ----
 drivers/acpi/thermal.c          |    1 -
 include/acpi/processor.h        |    1 -
 16 files changed, 5 insertions(+), 32 deletions(-)

--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -203,7 +203,6 @@ static int acpi_ac_probe(struct platform
 		return -ENOMEM;
 
 	ac->device = adev;
-	strscpy(acpi_device_class(adev), ACPI_AC_CLASS);
 
 	platform_set_drvdata(pdev, ac);
 
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -18,7 +18,6 @@
 
 #include "internal.h"
 
-#define ACPI_MEMORY_DEVICE_CLASS		"memory"
 #define ACPI_MEMORY_DEVICE_HID			"PNP0C80"
 
 static const struct acpi_device_id memory_device_ids[] = {
@@ -296,7 +295,6 @@ static int acpi_memory_device_add(struct
 	INIT_LIST_HEAD(&mem_device->res_list);
 	mem_device->device = device;
 	mem_device->mgid = -1;
-	sprintf(acpi_device_class(device), "%s", ACPI_MEMORY_DEVICE_CLASS);
 	device->driver_data = mem_device;
 
 	/* Get the range from the _CRS */
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -23,7 +23,6 @@
 #include <asm/mwait.h>
 #include <xen/xen.h>
 
-#define ACPI_PROCESSOR_AGGREGATOR_CLASS	"acpi_pad"
 #define ACPI_PROCESSOR_AGGREGATOR_NOTIFY 0x80
 
 #define ACPI_PROCESSOR_AGGREGATOR_STATUS_SUCCESS	0
@@ -413,7 +412,7 @@ static void acpi_pad_notify(acpi_handle
 	switch (event) {
 	case ACPI_PROCESSOR_AGGREGATOR_NOTIFY:
 		acpi_pad_handle_notify(handle);
-		acpi_bus_generate_netlink_event(ACPI_PROCESSOR_AGGREGATOR_CLASS,
+		acpi_bus_generate_netlink_event("acpi_pad",
 						dev_name(&adev->dev), event, 0);
 		break;
 	default:
@@ -426,8 +425,6 @@ static int acpi_pad_probe(struct platfor
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 
-	strscpy(acpi_device_class(adev), ACPI_PROCESSOR_AGGREGATOR_CLASS);
-
 	return acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
 					       acpi_pad_notify, adev);
 }
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -438,7 +438,6 @@ static int acpi_processor_add(struct acp
 	}
 
 	pr->handle = device->handle;
-	strscpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
 	device->driver_data = pr;
 
 	result = acpi_processor_get_info(device);
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1143,8 +1143,6 @@ static int acpi_video_bus_get_one_device
 		return -ENOMEM;
 	}
 
-	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
-
 	data->device_id = device_id;
 	data->video = video;
 	data->dev = device;
@@ -2020,7 +2018,6 @@ static int acpi_video_bus_probe(struct p
 	platform_set_drvdata(pdev, video);
 
 	video->device = device;
-	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
 	device->driver_data = video;
 
 	acpi_video_bus_find_cap(video);
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1228,7 +1228,6 @@ static int acpi_battery_probe(struct pla
 	platform_set_drvdata(pdev, battery);
 
 	battery->device = device;
-	strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 
 	result = devm_mutex_init(&pdev->dev, &battery->update_lock);
 	if (result)
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -697,6 +697,8 @@ static void acpi_button_remove(struct pl
 	acpi_button_remove_fs(button);
 	input_unregister_device(button->input);
 	kfree(button);
+
+	memset(acpi_device_class(adev), 0, sizeof(acpi_device_class));
 }
 
 static int param_set_lid_init_state(const char *val,
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -35,8 +35,6 @@
 
 #include "internal.h"
 
-#define ACPI_EC_CLASS			"embedded_controller"
-
 /* EC status register */
 #define ACPI_EC_FLAG_OBF	0x01	/* Output buffer full */
 #define ACPI_EC_FLAG_IBF	0x02	/* Input buffer full */
@@ -1680,8 +1678,6 @@ static int acpi_ec_probe(struct platform
 	struct acpi_ec *ec;
 	int ret;
 
-	strscpy(acpi_device_class(device), ACPI_EC_CLASS);
-
 	if (boot_ec && (boot_ec->handle == device->handle ||
 	    !strcmp(acpi_device_hid(device), ACPI_ECDT_HID))) {
 		/* Fast path: this device corresponds to the boot EC. */
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -29,7 +29,6 @@
 
 #include "internal.h"
 
-#define ACPI_PCI_LINK_CLASS		"pci_irq_routing"
 #define ACPI_PCI_LINK_MAX_POSSIBLE	16
 
 static int acpi_pci_link_add(struct acpi_device *device,
@@ -724,7 +723,6 @@ static int acpi_pci_link_add(struct acpi
 		return -ENOMEM;
 
 	link->device = device;
-	strscpy(acpi_device_class(device), ACPI_PCI_LINK_CLASS);
 	device->driver_data = link;
 
 	mutex_lock(&acpi_link_lock);
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -24,7 +24,6 @@
 #include <linux/platform_data/x86/apple.h>
 #include "internal.h"
 
-#define ACPI_PCI_ROOT_CLASS		"pci_bridge"
 static int acpi_pci_root_add(struct acpi_device *device,
 			     const struct acpi_device_id *not_used);
 static void acpi_pci_root_remove(struct acpi_device *device);
@@ -688,7 +687,6 @@ static int acpi_pci_root_add(struct acpi
 
 	root->device = device;
 	root->segment = segment & 0xFFFF;
-	strscpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	device->driver_data = root;
 
 	if (hotadd && dmar_device_add(handle)) {
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -37,7 +37,6 @@
 #include "sleep.h"
 #include "internal.h"
 
-#define ACPI_POWER_CLASS		"power_resource"
 #define ACPI_POWER_RESOURCE_STATE_OFF	0x00
 #define ACPI_POWER_RESOURCE_STATE_ON	0x01
 #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
@@ -954,7 +953,6 @@ struct acpi_device *acpi_add_power_resou
 	mutex_init(&resource->resource_lock);
 	INIT_LIST_HEAD(&resource->list_node);
 	INIT_LIST_HEAD(&resource->dependents);
-	strscpy(acpi_device_class(device), ACPI_POWER_CLASS);
 	device->power.state = ACPI_STATE_UNKNOWN;
 	device->flags.match_driver = true;
 
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -85,8 +85,8 @@ static void acpi_processor_notify(acpi_h
 		return;
 	}
 
-	acpi_bus_generate_netlink_event(ACPI_PROCESSOR_CLASS,
-					dev_name(&device->dev), event, ev_data);
+	acpi_bus_generate_netlink_event("processor", dev_name(&device->dev),
+					event, ev_data);
 }
 
 static int __acpi_processor_start(struct acpi_device *device);
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -26,7 +26,6 @@
 
 #include "sbshc.h"
 
-#define ACPI_SBS_CLASS			"sbs"
 #define ACPI_AC_CLASS			"ac_adapter"
 #define ACPI_SBS_DEVICE_NAME		"Smart Battery System"
 #define ACPI_BATTERY_DIR_NAME		"BAT%i"
@@ -648,7 +647,6 @@ static int acpi_sbs_probe(struct platfor
 
 	sbs->hc = dev_get_drvdata(pdev->dev.parent);
 	sbs->device = device;
-	strscpy(acpi_device_class(device), ACPI_SBS_CLASS);
 
 	result = acpi_charger_add(sbs);
 	if (result && result != -ENODEV)
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -18,8 +18,6 @@
 #include "sbshc.h"
 #include "internal.h"
 
-#define ACPI_SMB_HC_CLASS	"smbus_host_ctl"
-
 struct acpi_smb_hc {
 	struct acpi_ec *ec;
 	struct mutex lock;
@@ -250,8 +248,6 @@ static int acpi_smbus_hc_probe(struct pl
 		return -EIO;
 	}
 
-	strscpy(acpi_device_class(device), ACPI_SMB_HC_CLASS);
-
 	hc = kzalloc_obj(struct acpi_smb_hc);
 	if (!hc)
 		return -ENOMEM;
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -799,7 +799,6 @@ static int acpi_thermal_probe(struct pla
 
 	tz->device = device;
 	strscpy(tz->name, device->pnp.bus_id);
-	strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 
 	acpi_thermal_aml_dependency_fix(tz);
 
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -14,7 +14,6 @@
 
 #include <asm/acpi.h>
 
-#define ACPI_PROCESSOR_CLASS		"processor"
 #define ACPI_PROCESSOR_DEVICE_HID	"ACPI0007"
 #define ACPI_PROCESSOR_CONTAINER_HID	"ACPI0010"
 




