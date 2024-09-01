Return-Path: <linux-acpi+bounces-8052-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E569674E0
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 06:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11301C209ED
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 04:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD460156C69;
	Sun,  1 Sep 2024 04:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dNqWQ8Fv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFF0156F33
	for <linux-acpi@vger.kernel.org>; Sun,  1 Sep 2024 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725163660; cv=none; b=ThxvI0aRG6u6BwTUjiQ/cMvf7HcjUwOfwr58EnXdm6SmXXgUDQ0NMTHDsmvZV0iR2TcGbPHcQWLmE41LsROx1vzUxYWtNsyd7gyX2NQjTHFpmG2LtKTQS6ycYUZcEfWExL4CETjGXfyXbPQ+9fqhX/YY/YSXxYmanpjWons1auo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725163660; c=relaxed/simple;
	bh=VrN82hoQt0wLVQI0aCC1SR5A2ibWGb0NJymP0pIp9xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2glKdOLKRpLq60cNccgoTNMirkbTv6pyBmG0Fim7dZVX4CPKNO1vFRfJ9+qcsnbslQohqsveJqZqxrtearcU0MROZaIcolGqIG85zFxNsi/UdlbP/YABbhbIMKC9Bv8iIuEvOh+ynBbupaCrZCXtOUgGDTk9TvpCj4MJki5nu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dNqWQ8Fv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-714262f1bb4so2431414b3a.3
        for <linux-acpi@vger.kernel.org>; Sat, 31 Aug 2024 21:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725163656; x=1725768456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lp4qb/KS90Tir3i25BqLGfP+MrbWuhnQKUX2LR6B8LU=;
        b=dNqWQ8FvRRcyt/vhqfHfNSL4Oo29DaIIRpF41DHFYeGRuH3GGDKyFx7zhZb1HOrFwk
         4sKlTE0zPdh1UrkpNx0C4bCgAdHE/9Ga+o7FTWGw6b8hsITjURZbh/X1wzJgw7XZI2KV
         lQv8L/B+otZvjhKkmR/nuWpq+Q6JFoUbpPUnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725163656; x=1725768456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lp4qb/KS90Tir3i25BqLGfP+MrbWuhnQKUX2LR6B8LU=;
        b=Bi1t3arv7deUqXPaoEVz9i94NnXDUv1vi9ccs/ftos1IHFjaRem/J+SMISs1Ugffrd
         heDuszQIiEQ1+B6hPcsd0F3965wVjz2akAFxzkfZXEgknWQBuYkVuvXcLXXR0s6FcOs2
         RloIL4PGm1/051oZaCI3cu5QAmMAdpuvXOMkMtsA6Tgas1HOAIOhu+7Y1NahUwVy6f7Q
         WQ6KelpexKX+yHigM60vw5lISuQF6k7PUQwU6hnKXty/DShmAgVuOyqKqU40M57QpxAZ
         f8JrqZSyYyoVikyD5W5YDrrZZ+zfZ82udlIyrrZ1X8bEv3AIilO+NOLikb0401cPMWsa
         nGJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzHCHwm6R/lYfXaZNs4fInX7qI1zy0gPsxdwSpIG39HtjpqJHQjXhol0YwCeHIDDD2ZlSHYE5cxb2s@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgnb2WiGgKZyiGdODT72Ciu5J2rRrhp/21JBJWin3IA3TQ+9P1
	p1bEFBWOtGQZtviGUIP31AFKbLmNxt2gMuOH7t1/5vBPouqXuEC8ehMM0rTHog==
X-Google-Smtp-Source: AGHT+IE8Kiz0yS+drOGbUHSHPEFKkSlIzC8nDgi3dGGbxuwIctLm8xLCZLhIj6Ez6yfo2U5IiO9Iyw==
X-Received: by 2002:a05:6a21:3a93:b0:1c0:e49a:6900 with SMTP id adf61e73a8af0-1cece4d7233mr3894641637.7.1725163656376;
        Sat, 31 Aug 2024 21:07:36 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d8445d5ea9sm9130058a91.8.2024.08.31.21.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 21:07:36 -0700 (PDT)
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
Subject: [PATCH v4 16/18] platform/chrome: cros_ec_typec: Add support for signaling DP HPD via drm_bridge
Date: Sat, 31 Aug 2024 21:06:54 -0700
Message-ID: <20240901040658.157425-17-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240901040658.157425-1-swboyd@chromium.org>
References: <20240901040658.157425-1-swboyd@chromium.org>
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
 drivers/platform/chrome/cros_ec_typec.c | 31 +++++++++++++++++++++++++
 drivers/platform/chrome/cros_ec_typec.h |  1 +
 3 files changed, 33 insertions(+)

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
index 4d305876ec08..a57053bdec18 100644
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
@@ -16,6 +17,8 @@
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_tbt.h>
 
+#include <drm/bridge/aux-bridge.h>
+
 #include "cros_ec_typec.h"
 #include "cros_typec_vdm.h"
 
@@ -334,6 +337,9 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 	u32 port_num = 0;
 
 	nports = device_get_child_node_count(dev);
+	/* Don't count any 'ports' child node */
+	if (of_graph_is_present(dev->of_node))
+		nports--;
 	if (nports == 0) {
 		dev_err(dev, "No port entries found.\n");
 		return -ENODEV;
@@ -347,6 +353,10 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
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
@@ -413,6 +423,23 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 	return ret;
 }
 
+static int cros_typec_init_dp_bridge(struct cros_typec_data *typec)
+{
+	struct device *dev = typec->dev;
+	struct drm_dp_typec_bridge_dev *dp_dev;
+
+	/* Not capable of DP altmode switching. Ignore. */
+	if (!fwnode_property_read_bool(dev_fwnode(dev), "mode-switch"))
+		return 0;
+
+	dp_dev = devm_drm_dp_typec_bridge_alloc(dev, dev->of_node);
+	if (IS_ERR(dp_dev))
+		return PTR_ERR(dp_dev);
+	typec->dp_bridge = dp_dev;
+
+	return devm_drm_dp_typec_bridge_add(dev, dp_dev);
+}
+
 static int cros_typec_usb_safe_state(struct cros_typec_port *port)
 {
 	int ret;
@@ -1257,6 +1284,10 @@ static int cros_typec_probe(struct platform_device *pdev)
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
index deda180a646f..eb816d30d880 100644
--- a/drivers/platform/chrome/cros_ec_typec.h
+++ b/drivers/platform/chrome/cros_ec_typec.h
@@ -35,6 +35,7 @@ struct cros_typec_data {
 	unsigned int pd_ctrl_ver;
 	/* Array of ports, indexed by port number. */
 	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
+	struct drm_dp_typec_bridge_dev *dp_bridge;
 	struct notifier_block nb;
 	struct work_struct port_work;
 	bool typec_cmd_supported;
-- 
https://chromeos.dev


