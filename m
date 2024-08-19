Return-Path: <linux-acpi+bounces-7685-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D1D9577C4
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 00:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99478B2416C
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5981E7A21;
	Mon, 19 Aug 2024 22:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fxb+wBoV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A91E673A
	for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 22:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107135; cv=none; b=FWbBty1Rc3tQ+xVyzMLDjdkL4+Ss13mt9ePD138IwQLxbqvLGZT3Mfc+wubtfwmuvybi7pZGUAuUqLDqpIakGWT8Rt3a0z6WhlXxehKvv4YU90fS1KFZRp5+YRRCkCwpxLB0vh/KG/6mXAvzWneWrhlmHPjcqmXWJhQfVNgsI3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107135; c=relaxed/simple;
	bh=5K13Rr7Ye52MphZA4brc+qhak8CJv7kQslQnmneUWjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZMr9XvxNzhoAO2hC5XTA+Enx1cqdUtLMTZ4fmfe+OQKQ6ejysiBX+rfgRJ9jKyxjhgfubeY70eVimvcvToY2X5pXHQowQcY7jGIYK1xK7lRquwAs7YaOTP9cKtcCbPpC/9Pmm+I/adu7kWWnGjL4U+U5peojtQIS/FVPNpHsB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fxb+wBoV; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db145c8010so3131818b6e.3
        for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 15:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724107132; x=1724711932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbFRLEAP1yQ8phmhKg1xt4/PZ50JZmra4jTs/cBI9Fc=;
        b=fxb+wBoVYY9pJsjHGA4CAmK0CCV9eY3fvywPUff2C6rbNBNtbu8Os5ce82+072sL6W
         GyNOhQQymeg60fN/WdE9mxwa4JrEIiGgaNisGX4Fbii2mfBILkea2TE6uMWdhYFNfuxK
         g+LrCVRwWhl7VkWw2ciipweaPBU6aKmQfuNWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724107132; x=1724711932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbFRLEAP1yQ8phmhKg1xt4/PZ50JZmra4jTs/cBI9Fc=;
        b=imLwQ1Tvh243E8qrGgWvw8SN0N292aZpUx2uZ5maAK/Tdfmazcgr1YWXabWZLP0ud4
         Oh51ei53Xb/0uhN03pUW9NXiWvrzPyu1fuYUNsHeqgsV8kVZAYkJLsV12s7AOBrOpknO
         JsFXA1DBXdtfdEeNozOzHM+ibls1ITYTwjCm/8usFJAXGBN0Og++8pB647m/jNNid9Tx
         g44NXCdB8xTO5KnrLkG6Q1xuyYnPUMclkRU8NpL6SI1VvhFnXfmazpHgcSuGGrgrKYcM
         NF6C/HwEvISYInL6S3Odts1KCRNMw/D4W4FoxZWPCWzThpnZ56hGflCsEzv99Nsky2JU
         osRA==
X-Forwarded-Encrypted: i=1; AJvYcCX500AENijWTKjkQGgMToa6+5InNpcUQIGmxpDBE/1bzLM4Vpp2n1CWt77Ynhi9Hx+Le39skAK3XIgKVOuXpJ36CNLz0R5GhohdwA==
X-Gm-Message-State: AOJu0YxmsiFzR3WngHcceNQdZOQz24gwXNQeDMPeOmaDGFA7rs190PED
	NGFxppUmKgDwLxnpVSJy8blSMrM/a8WDG74U2a9Cq264+R4OR2lL8SsWDBhqFg==
X-Google-Smtp-Source: AGHT+IGU+fzlXtM8B7VTp6DiytUOY+YJu/MAdpU9aLNWJBc8EuVBU83rDKxEo/rTgqaOBZmzP3dSGw==
X-Received: by 2002:a05:6870:c1d0:b0:267:dfce:95eb with SMTP id 586e51a60fabf-2701c345f49mr14663404fac.5.1724107132395;
        Mon, 19 Aug 2024 15:38:52 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7c6b61c60f7sm8091519a12.22.2024.08.19.15.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 15:38:51 -0700 (PDT)
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
Subject: [PATCH v3 07/17] drm/bridge: dp_typec: Support USB Type-C orientation
Date: Mon, 19 Aug 2024 15:38:21 -0700
Message-ID: <20240819223834.2049862-8-swboyd@chromium.org>
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

Register an orientation switch for each type-c output node to support
flipping the lane mapping when the port is in reverse orientation. Only
do this when the orientation-switch property is present. This is mostly
useful for the case where the DP lanes are directly connected to the
usb-c-connector and the device doesn't have an orientation switch wired
down on the board between the connector and the DP controller.

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/bridge/aux-hpd-bridge.c | 74 +++++++++++++++++++++----
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
index 47315a8077a3..3d33f7936cbc 100644
--- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
@@ -47,12 +47,15 @@ struct drm_dp_typec_bridge_data;
 /**
  * struct drm_dp_typec_bridge_typec_port - USB type-c port associated with DP bridge
  * @lane_mapping: Physical (array index) to logical (array value) USB type-C lane mapping
+ * @orientation: Orientation of USB type-c port
  * @mode_switch: DP altmode switch
  * @typec_data: Back pointer to type-c bridge data
  */
 struct drm_dp_typec_bridge_typec_port {
 	u32 lane_mapping[NUM_USB_SS];
+	enum typec_orientation orientation;
 	struct typec_mux_dev *mode_switch;
+	struct typec_switch_dev *orientation_switch;
 	struct drm_dp_typec_bridge_data *typec_data;
 };
 
@@ -378,17 +381,35 @@ static int dp_lane_to_typec_lane(enum dp_lane lane)
 	return -EINVAL;
 }
 
-static int typec_to_dp_lane(enum usb_ss_lane lane)
+static int typec_to_dp_lane(enum usb_ss_lane lane,
+			    enum typec_orientation orientation)
 {
-	switch (lane) {
-	case USB_SSRX1:
-		return DP_ML3;
-	case USB_SSTX1:
-		return DP_ML2;
-	case USB_SSTX2:
-		return DP_ML0;
-	case USB_SSRX2:
-		return DP_ML1;
+	switch (orientation) {
+	case TYPEC_ORIENTATION_NONE:
+	case TYPEC_ORIENTATION_NORMAL:
+		switch (lane) {
+		case USB_SSRX1:
+			return DP_ML3;
+		case USB_SSTX1:
+			return DP_ML2;
+		case USB_SSTX2:
+			return DP_ML0;
+		case USB_SSRX2:
+			return DP_ML1;
+		}
+		break;
+	case TYPEC_ORIENTATION_REVERSE:
+		switch (lane) {
+		case USB_SSRX1:
+			return DP_ML0;
+		case USB_SSTX1:
+			return DP_ML1;
+		case USB_SSTX2:
+			return DP_ML3;
+		case USB_SSRX2:
+			return DP_ML2;
+		}
+		break;
 	}
 
 	return -EINVAL;
@@ -413,6 +434,7 @@ drm_dp_typec_bridge_assign_pins(struct drm_dp_typec_bridge_dev *typec_bridge_dev
 				u32 conf,
 				struct drm_dp_typec_bridge_typec_port *port)
 {
+	enum typec_orientation orientation = port->orientation;
 	enum usb_ss_lane *lane_mapping = port->lane_mapping;
 	struct auxiliary_device *adev = &typec_bridge_dev->adev;
 	struct drm_aux_hpd_bridge_data *hpd_data = auxiliary_get_drvdata(adev);
@@ -448,7 +470,7 @@ drm_dp_typec_bridge_assign_pins(struct drm_dp_typec_bridge_dev *typec_bridge_dev
 		typec_lane = lane_mapping[typec_lane];
 
 		/* Map logical type-c lane to logical DP lane */
-		dp_lanes[i] = typec_to_dp_lane(typec_lane);
+		dp_lanes[i] = typec_to_dp_lane(typec_lane, orientation);
 	}
 
 	return 0;
@@ -496,6 +518,23 @@ static const struct drm_bridge_funcs drm_dp_typec_bridge_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 };
 
+static int drm_dp_typec_bridge_orientation_set(struct typec_switch_dev *sw,
+					       enum typec_orientation orientation)
+{
+	struct drm_dp_typec_bridge_typec_port *port;
+
+	/*
+	 * Lane remapping is in drm_dp_typec_bridge_mode_switch_set(). Whenever
+	 * an orientation changes the mode will switch in and out of DP mode,
+	 * HPD will deassert and reassert so that
+	 * drm_dp_typec_bridge_atomic_check() sees the proper state.
+	 */
+	port = typec_switch_get_drvdata(sw);
+	port->orientation = orientation;
+
+	return 0;
+}
+
 static int
 drm_dp_typec_bridge_mode_switch_set(struct typec_mux_dev *mode_switch,
 				    struct typec_mux_state *state)
@@ -544,7 +583,9 @@ drm_dp_typec_bridge_probe_typec_ports(struct drm_dp_typec_bridge_data *typec_dat
 	struct drm_dp_typec_bridge_typec_port *port;
 	size_t num_ports = typec_bridge_dev->num_typec_ports;
 	struct typec_mux_desc mode_switch_desc = { };
+	struct typec_switch_desc orientation_switch_desc = { };
 	struct fwnode_handle *fwnode;
+	bool orientation = of_property_read_bool(np, "orientation-switch");
 
 	port = devm_kcalloc(dev, num_ports, sizeof(*port), GFP_KERNEL);
 	if (!port)
@@ -581,6 +622,17 @@ drm_dp_typec_bridge_probe_typec_ports(struct drm_dp_typec_bridge_data *typec_dat
 		if (IS_ERR(port->mode_switch))
 			return PTR_ERR(port->mode_switch);
 
+		if (orientation) {
+			orientation_switch_desc.set = drm_dp_typec_bridge_orientation_set,
+			orientation_switch_desc.fwnode = fwnode;
+			orientation_switch_desc.drvdata = port;
+			orientation_switch_desc.name = fwnode_get_name(fwnode);
+			port->orientation_switch = typec_switch_register(dev,
+									 &orientation_switch_desc);
+			if (IS_ERR(port->orientation_switch))
+				return PTR_ERR(port->orientation_switch);
+		}
+
 		port++;
 	}
 
-- 
https://chromeos.dev


