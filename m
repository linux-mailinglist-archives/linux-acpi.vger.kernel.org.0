Return-Path: <linux-acpi+bounces-7454-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA85A94C83F
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 03:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F48EB23F92
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 01:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331FD13FFC;
	Fri,  9 Aug 2024 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKKNDs0H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F399717BA5;
	Fri,  9 Aug 2024 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168136; cv=none; b=ia1Rbrr7fEmec+tgNfMD3KYHR5Yn2og2kVvsI7AcU3QejY92eDTomIHThV0fpNeSjeEkEQnAI76Z6GfuZnOsdMxUWR26tCDvW+bRYNglehFMusYv3aSd5szjkkhZ04vl8/ktekqN4BWpFCXZyYVNdK1AW7S7j46wExbRl8olx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168136; c=relaxed/simple;
	bh=0fKqCsWWpbfCCLE1iIRSftCHEdtnizXCVXho33kIM/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rGwOrQzWPPncv+J1kXzz3PQIi7yVxYDWNggKUkiAY30NnEJZw177SKNFkx2uZV3RtduKteWJEAtzD5YhBGbjox3ineUzI2GSMqmknzEOuseBca+bhzDUyDADS/BLwWNlNvMRY511ouqs0mhu0h8A4JbEz92IALWxw+ZFQl86Fbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKKNDs0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E13BC4AF14;
	Fri,  9 Aug 2024 01:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723168135;
	bh=0fKqCsWWpbfCCLE1iIRSftCHEdtnizXCVXho33kIM/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NKKNDs0HJ3Pi0SNmMmVXyHznoTQjGGVOPwGRbNYKBLtN5HfIYnc93iFm2upy3AZkM
	 6cOWfRlMUfjEIddYXSwtjj6a452eTovsVAWHPFDMIMvH51xIFqbm9vvsEVmoIKDSk/
	 qKyKb4uT65PaCZeEYSTaimcuNGnhXhdbwIHI39Q9M9uULligHvxNCYimf88DY9IOnu
	 SIbnOJj2b7gBFGcXKjbXztUnAw8WYBmxF49bu6PPkwKueR8v85BRm2ChoB+jg+8Dfm
	 YsQe9NHjjH/XFAvgik+LY8RrCLXyJS/7Cu4/xxYye8odABLo5Of8hKWzZH9jud5puW
	 BkMdH54RNnxHA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 09 Aug 2024 03:48:30 +0200
Subject: [PATCH 3/3] platform/surface: Add OF support
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-topic-sam-v1-3-05bca1932614@quicinc.com>
References: <20240809-topic-sam-v1-0-05bca1932614@quicinc.com>
In-Reply-To: <20240809-topic-sam-v1-0-05bca1932614@quicinc.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <quic_kdybcio@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723168110; l=14112;
 i=quic_kdybcio@quicinc.com; s=20230215; h=from:subject:message-id;
 bh=gJuth2n1/+wjM/7NKX0ZXU6diMwcIVq8G04Sm3KsKXI=;
 b=hRp/pRpZYs49tC5VIIYRzNiGy6vIjSYWuc4TmZE3qc5nltcAxTQdvFvx5PmAlJAZd1tkiHte3
 7i71hFog98fAqCJgKdu64SjW6vpnTxe4tKH6tuuceOch0cZr/I6IECM
X-Developer-Key: i=quic_kdybcio@quicinc.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <quic_kdybcio@quicinc.com>

Add basic support for registering the aggregator module on Device Tree-
based platforms. These include at least three generations of Qualcomm
Snapdragon-based Surface devices:

- SC8180X / SQ1 / SQ2: Pro X,
- SC8280XP / SQ3: Devkit 2023, Pro 9
- X Elite: Laptop 7 / Pro11

Thankfully, the aggregators on these seem to be configured in an
identical way, which allows for using these settings as defaults and
no DT properties need to be introduced (until that changes, anyway).

Based on the work done by Maximilian Luz, largely rewritten.

Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
---
 drivers/acpi/scan.c                                |  3 +-
 drivers/platform/surface/aggregator/bus.c          |  2 +
 drivers/platform/surface/aggregator/controller.c   | 72 +++++++++++++++----
 drivers/platform/surface/aggregator/core.c         | 80 ++++++++++++++++++----
 .../platform/surface/surface_aggregator_registry.c | 44 ++++++++++--
 5 files changed, 167 insertions(+), 34 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 59771412686b..6c3cad894648 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2444,7 +2444,8 @@ static int acpi_walk_dep_device_list(acpi_handle handle,
  */
 void acpi_dev_clear_dependencies(struct acpi_device *supplier)
 {
-	acpi_walk_dep_device_list(supplier->handle, acpi_scan_clear_dep, NULL);
+	if (supplier)
+		acpi_walk_dep_device_list(supplier->handle, acpi_scan_clear_dep, NULL);
 }
 EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies);
 
diff --git a/drivers/platform/surface/aggregator/bus.c b/drivers/platform/surface/aggregator/bus.c
index af8d573aae93..d68d231e716e 100644
--- a/drivers/platform/surface/aggregator/bus.c
+++ b/drivers/platform/surface/aggregator/bus.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/of.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
@@ -441,6 +442,7 @@ static int ssam_add_client_device(struct device *parent, struct ssam_controller
 
 	sdev->dev.parent = parent;
 	sdev->dev.fwnode = fwnode_handle_get(node);
+	sdev->dev.of_node = to_of_node(node);
 
 	status = ssam_device_add(sdev);
 	if (status)
diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 7fc602e01487..aea10e192140 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -1104,13 +1104,6 @@ int ssam_controller_caps_load_from_acpi(acpi_handle handle,
 	u64 funcs;
 	int status;
 
-	/* Set defaults. */
-	caps->ssh_power_profile = U32_MAX;
-	caps->screen_on_sleep_idle_timeout = U32_MAX;
-	caps->screen_off_sleep_idle_timeout = U32_MAX;
-	caps->d3_closes_handle = false;
-	caps->ssh_buffer_size = U32_MAX;
-
 	/* Pre-load supported DSM functions. */
 	status = ssam_dsm_get_functions(handle, &funcs);
 	if (status)
@@ -1149,6 +1142,57 @@ int ssam_controller_caps_load_from_acpi(acpi_handle handle,
 	return 0;
 }
 
+/**
+ * ssam_controller_caps_load_from_of() - Load controller capabilities from OF/DT.
+ * @device: The device from which to load the capabilities from.
+ * @caps:   Where to store the capabilities in.
+ *
+ * Return: Returns zero on success, a negative error code on failure.
+ */
+static int ssam_controller_caps_load_from_of(struct device *dev, struct ssam_controller_caps *caps)
+{
+	/*
+	 * Every device starting with Surface Pro X through Laptop 7 uses these
+	 * identical values, which makes them good defaults.
+	 */
+	caps->d3_closes_handle = true;
+	caps->screen_on_sleep_idle_timeout = 5000;
+	caps->screen_off_sleep_idle_timeout = 30;
+	caps->ssh_buffer_size = 48;
+	/* TODO: figure out power profile */
+
+	return 0;
+}
+
+/**
+ * ssam_controller_caps_load_from_acpi() - Load controller capabilities from
+ * ACPI _DSM.
+ * @handle: The handle of the ACPI controller/SSH device.
+ * @caps:   Where to store the capabilities in.
+ *
+ * Initializes the given controller capabilities with default values, then
+ * checks and, if the respective _DSM functions are available, loads the
+ * actual capabilities from the _DSM.
+ *
+ * Return: Returns zero on success, a negative error code on failure.
+ */
+static int ssam_controller_caps_load(struct device *dev, struct ssam_controller_caps *caps)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+
+	/* Set defaults. */
+	caps->ssh_power_profile = U32_MAX;
+	caps->screen_on_sleep_idle_timeout = U32_MAX;
+	caps->screen_off_sleep_idle_timeout = U32_MAX;
+	caps->d3_closes_handle = false;
+	caps->ssh_buffer_size = U32_MAX;
+
+	if (handle)
+		return ssam_controller_caps_load_from_acpi(handle, caps);
+	else
+		return ssam_controller_caps_load_from_of(dev, caps);
+}
+
 /**
  * ssam_controller_init() - Initialize SSAM controller.
  * @ctrl:   The controller to initialize.
@@ -1165,13 +1209,12 @@ int ssam_controller_caps_load_from_acpi(acpi_handle handle,
 int ssam_controller_init(struct ssam_controller *ctrl,
 			 struct serdev_device *serdev)
 {
-	acpi_handle handle = ACPI_HANDLE(&serdev->dev);
 	int status;
 
 	init_rwsem(&ctrl->lock);
 	kref_init(&ctrl->kref);
 
-	status = ssam_controller_caps_load_from_acpi(handle, &ctrl->caps);
+	status = ssam_controller_caps_load(&serdev->dev, &ctrl->caps);
 	if (status)
 		return status;
 
@@ -2715,11 +2758,12 @@ int ssam_irq_setup(struct ssam_controller *ctrl)
 	const int irqf = IRQF_ONESHOT | IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN;
 
 	gpiod = gpiod_get(dev, "ssam_wakeup-int", GPIOD_ASIS);
-	if (IS_ERR(gpiod))
-		return PTR_ERR(gpiod);
-
-	irq = gpiod_to_irq(gpiod);
-	gpiod_put(gpiod);
+	if (IS_ERR(gpiod)) {
+		irq = fwnode_irq_get(dev_fwnode(dev), 0);
+	} else {
+		irq = gpiod_to_irq(gpiod);
+		gpiod_put(gpiod);
+	}
 
 	if (irq < 0)
 		return irq;
diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 797d0645bd77..d39e0d7ce92b 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -17,9 +17,12 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/serdev.h>
 #include <linux/sysfs.h>
+#include <linux/units.h>
 
 #include <linux/surface_aggregator/controller.h>
 #include <linux/surface_aggregator/device.h>
@@ -299,7 +302,7 @@ static const struct attribute_group ssam_sam_group = {
 };
 
 
-/* -- ACPI based device setup. ---------------------------------------------- */
+/* -- Serial device setup. ---------------------------------------------- */
 
 static acpi_status ssam_serdev_setup_via_acpi_crs(struct acpi_resource *rsc,
 						  void *ctx)
@@ -352,13 +355,28 @@ static acpi_status ssam_serdev_setup_via_acpi_crs(struct acpi_resource *rsc,
 	return AE_CTRL_TERMINATE;
 }
 
-static acpi_status ssam_serdev_setup_via_acpi(acpi_handle handle,
-					      struct serdev_device *serdev)
+static int ssam_serdev_setup_via_acpi(struct serdev_device *serdev, acpi_handle handle)
 {
-	return acpi_walk_resources(handle, METHOD_NAME__CRS,
-				   ssam_serdev_setup_via_acpi_crs, serdev);
+	acpi_status status;
+
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+				     ssam_serdev_setup_via_acpi_crs, serdev);
+
+	return status ? -ENXIO : 0;
 }
 
+static int ssam_serdev_setup(struct acpi_device *ssh, struct serdev_device *serdev)
+{
+	if (ssh)
+		return ssam_serdev_setup_via_acpi(serdev, ssh->handle);
+
+	/* TODO: these values may differ per board/implementation */
+	serdev_device_set_baudrate(serdev, 4 * HZ_PER_MHZ);
+	serdev_device_set_flow_control(serdev, true);
+	serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+
+	return 0;
+}
 
 /* -- Power management. ----------------------------------------------------- */
 
@@ -624,13 +642,15 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 	acpi_status astatus;
 	int status;
 
-	status = gpiod_count(dev, NULL);
-	if (status < 0)
-		return dev_err_probe(dev, status, "no GPIO found\n");
+	if (ssh) {
+		status = gpiod_count(dev, NULL);
+		if (status < 0)
+			return dev_err_probe(dev, status, "no GPIO found\n");
 
-	status = devm_acpi_dev_add_driver_gpios(dev, ssam_acpi_gpios);
-	if (status)
-		return status;
+		status = devm_acpi_dev_add_driver_gpios(dev, ssam_acpi_gpios);
+		if (status)
+			return status;
+	}
 
 	/* Allocate controller. */
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
@@ -655,7 +675,7 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 		goto err_devopen;
 	}
 
-	astatus = ssam_serdev_setup_via_acpi(ssh->handle, serdev);
+	astatus = ssam_serdev_setup(ssh, serdev);
 	if (ACPI_FAILURE(astatus)) {
 		status = dev_err_probe(dev, -ENXIO, "failed to setup serdev\n");
 		goto err_devinit;
@@ -717,10 +737,31 @@ static int ssam_serial_hub_probe(struct serdev_device *serdev)
 	 *       For now let's thus default power/wakeup to false.
 	 */
 	device_set_wakeup_capable(dev, true);
+
+	/*
+	 * When using DT, we have to register the platform hub driver manually,
+	 * as it can't be matched based on top-level board compatible (like it
+	 * does the ACPI case).
+	 */
+	if (!ssh) {
+		struct platform_device *ph_pdev =
+			platform_device_register_simple("surface_aggregator_platform_hub",
+							0, NULL, 0);
+		if (IS_ERR(ph_pdev))
+			return dev_err_probe(dev, PTR_ERR(ph_pdev),
+					     "Failed to register the platform hub driver\n");
+	}
+
+	status = ssam_register_clients(&serdev->dev, ctrl);
+	if (status)
+		goto err_clients;
+
 	acpi_dev_clear_dependencies(ssh);
 
 	return 0;
 
+err_clients:
+	ssam_clear_controller();
 err_mainref:
 	ssam_irq_free(ctrl);
 err_irq:
@@ -782,18 +823,27 @@ static void ssam_serial_hub_remove(struct serdev_device *serdev)
 	device_set_wakeup_capable(&serdev->dev, false);
 }
 
-static const struct acpi_device_id ssam_serial_hub_match[] = {
+static const struct acpi_device_id ssam_serial_hub_acpi_match[] = {
 	{ "MSHW0084", 0 },
 	{ },
 };
-MODULE_DEVICE_TABLE(acpi, ssam_serial_hub_match);
+MODULE_DEVICE_TABLE(acpi, ssam_serial_hub_acpi_match);
+
+#ifdef CONFIG_OF
+static const struct of_device_id ssam_serial_hub_of_match[] = {
+	{ .compatible = "microsoft,surface-sam", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ssam_serial_hub_of_match);
+#endif
 
 static struct serdev_device_driver ssam_serial_hub = {
 	.probe = ssam_serial_hub_probe,
 	.remove = ssam_serial_hub_remove,
 	.driver = {
 		.name = "surface_serial_hub",
-		.acpi_match_table = ssam_serial_hub_match,
+		.acpi_match_table = ACPI_PTR(ssam_serial_hub_acpi_match),
+		.of_match_table = of_match_ptr(ssam_serial_hub_of_match),
 		.pm = &ssam_serial_hub_pm_ops,
 		.shutdown = ssam_serial_hub_shutdown,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 1c4d74db08c9..57787f2ff38b 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -12,6 +12,7 @@
 #include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/types.h>
@@ -273,6 +274,18 @@ static const struct software_node *ssam_node_group_sl5[] = {
 	NULL,
 };
 
+/* Devices for Surface Laptop 7. */
+static const struct software_node *ssam_node_group_sl7[] = {
+	&ssam_node_root,
+	&ssam_node_bat_ac,
+	&ssam_node_bat_main,
+	&ssam_node_tmp_perf_profile_with_fan,
+	&ssam_node_fan_speed,
+	&ssam_node_hid_sam_keyboard,
+	/* TODO: evaluate thermal sensors devices when we get a driver for that */
+	NULL,
+};
+
 /* Devices for Surface Laptop Studio. */
 static const struct software_node *ssam_node_group_sls[] = {
 	&ssam_node_root,
@@ -346,7 +359,7 @@ static const struct software_node *ssam_node_group_sp9[] = {
 
 /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
 
-static const struct acpi_device_id ssam_platform_hub_match[] = {
+static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
 	/* Surface Pro 4, 5, and 6 (OMBR < 0x10) */
 	{ "MSHW0081", (unsigned long)ssam_node_group_gen5 },
 
@@ -402,16 +415,39 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_match);
 
+#ifdef CONFIG_OF
+static const struct of_device_id ssam_platform_hub_of_match[] = {
+	/* Surface Laptop 7 */
+	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
+	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },
+	{ },
+};
+#endif
+
 static int ssam_platform_hub_probe(struct platform_device *pdev)
 {
 	const struct software_node **nodes;
+	const struct of_device_id *match;
+	struct device_node *fdt_root;
 	struct ssam_controller *ctrl;
 	struct fwnode_handle *root;
 	int status;
 
 	nodes = (const struct software_node **)acpi_device_get_match_data(&pdev->dev);
-	if (!nodes)
-		return -ENODEV;
+	if (!nodes) {
+		fdt_root = of_find_node_by_path("/");
+		if (!fdt_root)
+			return -ENODEV;
+
+		match = of_match_node(ssam_platform_hub_of_match, fdt_root);
+		of_node_put(fdt_root);
+		if (!match)
+			return -ENODEV;
+
+		nodes = (const struct software_node **)match->data;
+		if (!nodes)
+			return -ENODEV;
+	}
 
 	/*
 	 * As we're adding the SSAM client devices as children under this device
@@ -460,7 +496,7 @@ static struct platform_driver ssam_platform_hub_driver = {
 	.remove_new = ssam_platform_hub_remove,
 	.driver = {
 		.name = "surface_aggregator_platform_hub",
-		.acpi_match_table = ssam_platform_hub_match,
+		.acpi_match_table = ssam_platform_hub_acpi_match,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };

-- 
2.46.0


