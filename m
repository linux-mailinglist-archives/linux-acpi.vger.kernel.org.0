Return-Path: <linux-acpi+bounces-7679-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B068C95779D
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 00:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A44D2861BA
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 22:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139A71DF679;
	Mon, 19 Aug 2024 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VHqfJuv2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7461DD3BE
	for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107122; cv=none; b=OhD2qtJfq3OTQMhfeTe+O1UIbdJU+L3Ubwd74VkOF/rChBFQtg5sYrxcb5QOPosNp6ZjAcScrQJh8vC7H/8l8YdP26WXsDbisSYC7cROYVpCTU2fplO+H6UNKV6izI8qO+Gb2/wJQXM3wFVVIjxe4vYNbMAgO4uFoZ8jS27optE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107122; c=relaxed/simple;
	bh=oz72Q0doCA/TDcpGgSX5zcBpwt/SNMECwtIx/YvZSjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FODWNLxghI3Lc3augnqek4J1v+fMxx4GmcKGpu3rG7jCbmTiRKAd9zRGrXD74e1VSKWpByyJBTQ+4sJ920irjXlcp/CsMV3LbqpBnqVzLHTOdgNgiPWk2f4L4tcA+AfM4sBcKouOP+hBQsP4P93NaIsnWBnc+e89sx3DTG9Ahw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VHqfJuv2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201fba05363so30442105ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 15:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724107119; x=1724711919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4epShKXY+hj6izJiuYDlNYe3lRcBUUzUpZVsUSgXYg=;
        b=VHqfJuv2twSE2IYIgTqX5JksntLZppO1+TTou/OvHTcU5wMnXPMR+kCggyM7G9IIOZ
         idNhOXIidVOHWT8uK3NKNcKCEb1BepmJtUdLbJ9jRVUA9S+xLeLY25aKYzwRPid9KVL9
         tcqThN8rFStPpIrXT26E8HCX0i1VxAnM0YOas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724107119; x=1724711919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4epShKXY+hj6izJiuYDlNYe3lRcBUUzUpZVsUSgXYg=;
        b=XbzJy7Zm9+0ALODAfRP+BMbOEDrqc8CCieypE3KXtn5WdGbQ5wrLhbD9xMjAzZzeDO
         8eYNMEDuQ++wdK0yRToj0bWuxpcOjFkLf2KYXXxqnrbG4g6xanad5Yvu+xGtB+TwwOfl
         MQmRMjY753vKmAajxWe01L2/zfi1M2z896MB9lFEfIr+67vMVoSjdL3UL7xb0cEY+P8D
         rI7mqOuZBbYqJZOi2QL0nycJY4JHdmIZTK1wtexscdvIyKt+k8lxXlI3bRSQ+VJY2P4P
         sHw+HCN6dXtgdBJbdo/e/ScKFsxowdbOv0aW4wkPhqjJEsXzd5I0G3TaB4JsfNVUVu6n
         f83w==
X-Forwarded-Encrypted: i=1; AJvYcCXZaUIoO8GOe1tq8C5/5l2UoqlNyMyQ3Q493ZsNgT5E5YXwciG29hIt8jEI5vzc0KfqxruLP4d/hbDt@vger.kernel.org
X-Gm-Message-State: AOJu0YwdbluS4M2g1pC4s/RTKgM5W8Q/FHjeBlqRRGXhAOZFHgRmDWpR
	f7s54c30FKxVpfdtPc0j1mabEjPCYiX8/kpCsW/YCC3sLlk65LCp0hXBNzt9xA==
X-Google-Smtp-Source: AGHT+IGpA/LzfoLsEqsJMHJfcUpzeVMRHpRXXvAFjX+lnlP4tWIDSijdKOHcbbCm+Y0fYngKipaQHw==
X-Received: by 2002:a17:902:f547:b0:1fb:a077:a846 with SMTP id d9443c01a7336-20203e4f350mr122296765ad.3.1724107119275;
        Mon, 19 Aug 2024 15:38:39 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-201f02fff75sm67248655ad.13.2024.08.19.15.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 15:38:38 -0700 (PDT)
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
Subject: [PATCH v3 01/17] drm/atomic-helper: Introduce lane remapping support to bridges
Date: Mon, 19 Aug 2024 15:38:15 -0700
Message-ID: <20240819223834.2049862-2-swboyd@chromium.org>
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

Add support to the DRM atomic logic to support lane remapping between
bridges, encoders and connectors. Typically lane mapping is handled
statically in firmware, e.g. on DT we use the data-lanes property to
assign lanes when connecting display bridges. Lane assignment is dynamic
with USB-C DisplayPort altmodes, e.g. pin conf D assigns 2 lanes of DP
to pins on the USB-C connector while pin conf C assigns 4 lanes of DP to
pins on the USB-C connector. The lane assignment can't be set statically
because the DP altmode repurposes USB-C pins for the DP lanes while also
limiting the number of DP lanes or their pin assignment at runtime.

Bridge drivers should point their 'struct drm_bus_cfg::lanes' pointer to
an allocated array of 'struct drm_lane_cfg' structures and indicate the
size of this allocated array with 'struct drm_bus_cfg::num_lanes' in
their atomic_check() callback. The previous bridge in the bridge chain
can look at this information by calling
drm_bridge_next_bridge_lane_cfg() in their atomic_check() callback to
figure out what lanes need to be logically assigned to the physical
output lanes to satisfy the next bridge's lane assignment.

Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: <dri-devel@lists.freedesktop.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c |  2 ++
 drivers/gpu/drm/drm_bridge.c              | 34 +++++++++++++++++++++++
 include/drm/drm_atomic.h                  | 31 +++++++++++++++++++++
 include/drm/drm_bridge.h                  |  4 +++
 4 files changed, 71 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 519228eb1095..12d574458e7b 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -779,6 +779,8 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_duplicate_state);
 void drm_atomic_helper_bridge_destroy_state(struct drm_bridge *bridge,
 					    struct drm_bridge_state *state)
 {
+	kfree(state->input_bus_cfg.lanes);
+	kfree(state->output_bus_cfg.lanes);
 	kfree(state);
 }
 EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index d44f055dbe3e..bd18c1e91dee 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -822,6 +822,40 @@ void drm_atomic_bridge_chain_enable(struct drm_bridge *bridge,
 }
 EXPORT_SYMBOL(drm_atomic_bridge_chain_enable);
 
+/**
+ * drm_bridge_next_bridge_lane_cfg - get the lane configuration of the next bridge
+ * @bridge: bridge control structure
+ * @state: new atomic state
+ * @num_lanes: will contain the size of the returned array
+ *
+ * This function is typically called from &drm_bridge_funcs.atomic_check().
+ * The @bridge driver calls this function to determine what the next bridge in
+ * the bridge chain requires for the physical to logical lane assignments.
+ *
+ * Return: Lane configuration array of size @num_lanes for the next bridge
+ * after @bridge in the bridge chain, or NULL if the lane configuration is
+ * unchanged from the default.
+ */
+const struct drm_lane_cfg *
+drm_bridge_next_bridge_lane_cfg(struct drm_bridge *bridge,
+				struct drm_atomic_state *state,
+				u8 *num_lanes)
+{
+	const struct drm_bridge_state *next_bridge_state;
+	struct drm_bridge *next_bridge = drm_bridge_get_next_bridge(bridge);
+
+	next_bridge_state = drm_atomic_get_new_bridge_state(state, next_bridge);
+	if (!next_bridge_state) {
+		*num_lanes = 0;
+		return NULL;
+	}
+
+	*num_lanes = next_bridge_state->input_bus_cfg.num_lanes;
+
+	return next_bridge_state->input_bus_cfg.lanes;
+}
+EXPORT_SYMBOL(drm_bridge_next_bridge_lane_cfg);
+
 static int drm_atomic_bridge_check(struct drm_bridge *bridge,
 				   struct drm_crtc_state *crtc_state,
 				   struct drm_connector_state *conn_state)
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 4d7f4c5f2001..e1a38d0742f1 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1122,6 +1122,27 @@ drm_atomic_crtc_effectively_active(const struct drm_crtc_state *state)
 	return state->active || state->self_refresh_active;
 }
 
+/**
+ * struct drm_lane_cfg - lane configuration
+ *
+ * This structure stores the lane configuration of a physical bus between
+ * two components in an output pipeline, usually between two bridges, an
+ * encoder and a bridge, or a bridge and a connector.
+ *
+ * The lane configuration is stored in &drm_bus_cfg.
+ */
+struct drm_lane_cfg {
+	/**
+	 * @logical: Logical lane number
+	 */
+	u8 logical;
+
+	/**
+	 * @inverted: True if lane polarity is inverted, false otherwise
+	 */
+	bool inverted;
+};
+
 /**
  * struct drm_bus_cfg - bus configuration
  *
@@ -1152,6 +1173,16 @@ struct drm_bus_cfg {
 	 * @flags: DRM_BUS_* flags used on this bus
 	 */
 	u32 flags;
+
+	/**
+	 * @lanes: Lane mapping for this bus
+	 */
+	struct drm_lane_cfg *lanes;
+
+	/**
+	 * @num_lanes: Number of lanes in @lanes
+	 */
+	u8 num_lanes;
 };
 
 /**
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 75019d16be64..064d3c8600a9 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -963,6 +963,10 @@ drm_atomic_helper_bridge_propagate_bus_fmt(struct drm_bridge *bridge,
 					struct drm_connector_state *conn_state,
 					u32 output_fmt,
 					unsigned int *num_input_fmts);
+const struct drm_lane_cfg *
+drm_bridge_next_bridge_lane_cfg(struct drm_bridge *bridge,
+				struct drm_atomic_state *state,
+				u8 *num_lanes);
 
 enum drm_connector_status drm_bridge_detect(struct drm_bridge *bridge);
 int drm_bridge_get_modes(struct drm_bridge *bridge,
-- 
https://chromeos.dev


