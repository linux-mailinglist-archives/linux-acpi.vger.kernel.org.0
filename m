Return-Path: <linux-acpi+bounces-7693-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066E69577E7
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 00:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D171C212F3
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 22:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA711DF665;
	Mon, 19 Aug 2024 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hP75vm6s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6B8205E2C
	for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107153; cv=none; b=Q5HX5SAFAsfa5EzL8LCV1FmOmgveTaUNVTnf8VCxWfYBMuMABvs4elo4c7DmIs/4uFK/oecYv7+tIbUDVH5dyrsSgCk+x88UZqa1u2dSPcHP/FgsHnDYAYWtdYQQxB/wVf0AXsahXio82Nd0uWSgml+vt/IdqSosprqLjrAiLuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107153; c=relaxed/simple;
	bh=Ocf0y9DeKbCb8IMstpuVVIk9CB4egB4AGDfEpk9BFL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVfaaQuDScpr64SI5q4fTcc2/LIYOzufr5VRz+cdwQVn8yHrNeBe8/oJ9M4dOBL1QvCDnmECu7v6X6pG4hOKGKixA6dBHmLEUQW6k+F2bDxL6ihr7VOwPDqDeJB2SDaiw1tZqUfzpCkC/9AM3pHHldcZFtkg2o601mzxO1tZ6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hP75vm6s; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20202df1c2fso23463765ad.1
        for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724107150; x=1724711950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRhGj4hsOpK3/zAD4jYvBQOmMIjTi8ZAOWRNwE6QbdU=;
        b=hP75vm6snTHsL4MI6Br+9x0d0pHUznMKpQNtyUXk8x9ZLNuQB4uu6RJFv/R37RbYBf
         iMsSd5MzCk/GN3CqVeGOZCdZCTUx3xPBTHXo6l3SjmT+7YbaVNcJZw0nqoLNiizX3hKl
         vjIKMgwgiEDv0dCzRBP6cziTa2wcO1AwyLInU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724107150; x=1724711950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRhGj4hsOpK3/zAD4jYvBQOmMIjTi8ZAOWRNwE6QbdU=;
        b=YW05YIqdcPaUeierZF7PRhkFjR4Q4evZ3JCjpMSYuU1v0ovk11Uw2dREqdG91dgSdH
         0wHN43zbZ6/9GlXZY3gLEWsRsLwf3s6LTxAZjWQrFcaXX2Hor1DveG5VZoknixGkVjWy
         C0JwQKyV4puwG9kl2QEFostWkaWVZ8H1krr2gA3zPhZAkd3tcw2JP+hIC8dbJFOqnFOK
         nEtWJNZpbm2UxKT/WsV9tdhVSPSUDQWgDyFstrp7jzQQG6inOgi3K8Pd+oTxgDgVdrK1
         DkJsPp71ohQdppO6KkIna1WmzS1OYe/kqZLn+7DcPpup50nM/24Wafx5ouMddoSHNY6Y
         QARA==
X-Forwarded-Encrypted: i=1; AJvYcCUDJwXAnc498fPIFiNL0BIx6KltXF4bB6lE5O8Tb3xuarEeoGloeh1d1qNgKS8qjBpe5BTlp/4lmgfa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4adu6lzgXdbupBfkW/11wKRxcNkQ+2MYavN81UJU3vnOCLJgO
	wAQc7sopLVk8jclBIHjJV/ZqlIWGscsGURs9VgZyCD/xQoP4HvaXyZ9ryes5aw==
X-Google-Smtp-Source: AGHT+IECpg6q1pCGPOMeMy+hTlNtV0xfAl6tYuUPEYeVGiewuEEqh9SQLvKFnnMAaBqBbmDZNTygmg==
X-Received: by 2002:a17:902:e80f:b0:201:f2bc:7784 with SMTP id d9443c01a7336-2025f08c087mr16594445ad.11.1724107149758;
        Mon, 19 Aug 2024 15:39:09 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201f03a587csm67150675ad.290.2024.08.19.15.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 15:39:09 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Benson Leung <bleung@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Guenter Roeck <groeck@chromium.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Lee Jones <lee@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Robert Foss <rfoss@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 15/17] platform/chrome: cros_ec_typec: Add support for signaling DP HPD via drm_bridge
Date: Mon, 19 Aug 2024 15:38:29 -0700
Message-ID: <20240819223834.2049862-16-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240819223834.2049862-1-swboyd@chromium.org>
References: <20240819223834.2049862-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can imagine that logically the EC is a device that has some number of
DisplayPort (DP) connector inputs, some number of USB3 connector inputs,
and some number of USB type-c connector outputs. If you squint enough it
looks like a USB type-c dock. Logically there's a crossbar pin
assignment capability within the EC that can assign USB and DP lanes to
USB type-c lanes in the connector (i.e. USB type-c pin configurations).
In reality, the EC is a microcontroller that has some TCPCs and
redrivers connected to it over something like i2c and DP/USB from the AP
is wired directly to those ICs, not the EC.

This design allows the EC to abstract many possible USB and DP hardware
configurations away from the AP (kernel) so that the AP can largely deal
with USB and DP without thinking about USB Type-C much at all. The DP
and USB data originate in the AP, not the EC, so it helps to think that
the EC takes the DP and USB data as input to mux onto USB type-c ports
even if it really doesn't do that. With this split design, the EC
forwards the DP HPD state to the DP hardware via a GPIO that's connected
to the DP phy.

Having that HPD state signaled directly to the DP phy uses precious
hardware resources, a pin or two and a wire, and it also forces the TCPM
to live on the EC. If we want to save costs and move more control of USB
type-c to the kernel it's in our interest to get rid of the HPD pin
entirely and signal HPD to the DP phy some other way. Luckily, the EC
already exposes information about the USB Type-C stack to the kernel via
the host command interface in the "google,cros-ec-typec" compatible
driver, which parses EC messages related to USB type-c and effectively
"replays" those messages to the kernel's USB typec subsystem. This
includes the state of HPD, which can be interrogated and acted upon by
registering a 'struct typec_mux_dev' with the typec subsystem or by
hooking directly into this cros_ec_typec driver.

On DT based systems, the DP display pipeline is abstracted via a 'struct
drm_bridge'. If we want to signal HPD state from within the kernel we
need to hook into the drm_bridge framework somehow to call
drm_bridge_hpd_notify() when HPD state changes in the typec framework.
Use the newly added drm_dp_typec_bridge code to do this. When the EC
notifies AP of a type-c event, look at the port state and set the
connector state to connected or disconnected based on the HPD level when
the port is in DP mode.

Luckily all this logic is already handled by the drm_dp_typec bridge.
Register a bridge when this DT node has the 'mode-switch' property. When
cros_typec_configure_mux() puts a port into DP mode, the mode switch
registered in the drm_dp_typec bridge driver will signal HPD state to
the drm_bridge chain because the typec subsystem will configure the usbc
switches connected to the port with the data this driver provides.

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/Kconfig         |  1 +
 drivers/platform/chrome/cros_ec_typec.c | 43 +++++++++++++++++++++++++
 drivers/platform/chrome/cros_ec_typec.h |  3 ++
 3 files changed, 47 insertions(+)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 7dbeb786352a..0aee8a77f1d6 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -231,6 +231,7 @@ config CROS_EC_TYPEC
 	depends on MFD_CROS_EC_DEV && TYPEC
 	depends on CROS_USBPD_NOTIFY
 	depends on USB_ROLE_SWITCH
+	select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
 	default MFD_CROS_EC_DEV
 	help
 	  If you say Y here, you get support for accessing Type C connector
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 4d305876ec08..f7e184fa90c5 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_usbpd_notify.h>
 #include <linux/platform_device.h>
@@ -16,11 +17,18 @@
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_tbt.h>
 
+#include <drm/bridge/aux-bridge.h>
+
 #include "cros_ec_typec.h"
 #include "cros_typec_vdm.h"
 
 #define DRV_NAME "cros-ec-typec"
 
+struct cros_typec_dp_bridge {
+	struct cros_typec_data *typec_data;
+	struct drm_dp_typec_bridge_dev *dev;
+};
+
 #define DP_PORT_VDO	(DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D)) | \
 				DP_CAP_DFP_D | DP_CAP_RECEPTACLE)
 
@@ -334,6 +342,9 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 	u32 port_num = 0;
 
 	nports = device_get_child_node_count(dev);
+	/* Don't count any 'ports' child node */
+	if (of_graph_is_present(dev->of_node))
+		nports--;
 	if (nports == 0) {
 		dev_err(dev, "No port entries found.\n");
 		return -ENODEV;
@@ -347,6 +358,10 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 	/* DT uses "reg" to specify port number. */
 	port_prop = dev->of_node ? "reg" : "port-number";
 	device_for_each_child_node(dev, fwnode) {
+		/* An OF graph isn't a connector */
+		if (fwnode_name_eq(fwnode, "ports"))
+			continue;
+
 		if (fwnode_property_read_u32(fwnode, port_prop, &port_num)) {
 			ret = -EINVAL;
 			dev_err(dev, "No port-number for port, aborting.\n");
@@ -413,6 +428,30 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 	return ret;
 }
 
+static int cros_typec_init_dp_bridge(struct cros_typec_data *typec)
+{
+	struct device *dev = typec->dev;
+	struct cros_typec_dp_bridge *dp_bridge;
+	struct drm_dp_typec_bridge_dev *dp_dev;
+
+	/* Not capable of DP altmode switching. Ignore. */
+	if (!fwnode_property_read_bool(dev_fwnode(dev), "mode-switch"))
+		return 0;
+
+	dp_bridge = devm_kzalloc(dev, sizeof(*dp_bridge), GFP_KERNEL);
+	if (!dp_bridge)
+		return -ENOMEM;
+	typec->dp_bridge = dp_bridge;
+	dp_bridge->typec_data = typec;
+
+	dp_dev = devm_drm_dp_typec_bridge_alloc(dev, dev->of_node);
+	if (IS_ERR(dp_dev))
+		return PTR_ERR(dp_dev);
+	dp_bridge->dev = dp_dev;
+
+	return devm_drm_dp_typec_bridge_add(dev, dp_dev);
+}
+
 static int cros_typec_usb_safe_state(struct cros_typec_port *port)
 {
 	int ret;
@@ -1257,6 +1296,10 @@ static int cros_typec_probe(struct platform_device *pdev)
 		typec->num_ports = EC_USB_PD_MAX_PORTS;
 	}
 
+	ret = cros_typec_init_dp_bridge(typec);
+	if (ret < 0)
+		return ret;
+
 	ret = cros_typec_init_ports(typec);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/platform/chrome/cros_ec_typec.h b/drivers/platform/chrome/cros_ec_typec.h
index deda180a646f..73d300427140 100644
--- a/drivers/platform/chrome/cros_ec_typec.h
+++ b/drivers/platform/chrome/cros_ec_typec.h
@@ -27,6 +27,8 @@ struct cros_typec_altmode_node {
 	struct list_head list;
 };
 
+struct cros_typec_dp_bridge;
+
 /* Platform-specific data for the Chrome OS EC Type C controller. */
 struct cros_typec_data {
 	struct device *dev;
@@ -35,6 +37,7 @@ struct cros_typec_data {
 	unsigned int pd_ctrl_ver;
 	/* Array of ports, indexed by port number. */
 	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
+	struct cros_typec_dp_bridge *dp_bridge;
 	struct notifier_block nb;
 	struct work_struct port_work;
 	bool typec_cmd_supported;
-- 
https://chromeos.dev


