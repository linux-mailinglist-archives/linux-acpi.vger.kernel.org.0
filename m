Return-Path: <linux-acpi+bounces-7695-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B729577EC
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 00:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59A11F21CB5
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 22:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DCD2101AE;
	Mon, 19 Aug 2024 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JkQVma+Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19D20FABF
	for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107157; cv=none; b=N88YnW19PVvCqNeT4R6J54m6L7adFE4Mqk42+hSYVLBCj6hH8ZY8IKMQ3ZzclG+aiebT5Q0yqEZ/UQhfLP4eppKbYI6bDJ9KxDGO5Qv+pJee1nNkuUIK4pQz9SASdFwHE8tWvPTF7seOCXHki8KORCZnAQEeVoRuBQI4hav6Ss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107157; c=relaxed/simple;
	bh=ovt0XJ1mqNb5WMPAy+4sDJNNOziSSr2qxAdythLNoYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKXxGWvMp/R8o9fL5uSbZ3U051CvhiV9oZ8Gv/JL6DXdxZE9B0qU5zzaZM7jMthltDe2Ap44nDwfgSjASvieNuRic4npDhZEehxH5TmXbyZdat1CdvDSia35F/qTcUvbk59fLGyFNseHPXrMdd1KTPWkuU9a/ZirAA+JFu6PfjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JkQVma+Q; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3c5f769d6so3327797a91.3
        for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 15:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724107155; x=1724711955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqiNpgy6qhsHsbRqJzjRPUET6f40RWIPa40iMsEsB6U=;
        b=JkQVma+QxyD+qkrX8YofzuFJT6X5TKXDxRUgCAwtdXtzzLQKV7ajStIc8Zdt0ipM9t
         bkVSvvG9KgUygIXPTA5fXw6NBV99pyKFJCxkCJg/K5ttv/G2gH3ovH3bE/mtg9PeNzRi
         pqidocDUyh8BTBMQLVGdBkapGf7QAbeJi3L3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724107155; x=1724711955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqiNpgy6qhsHsbRqJzjRPUET6f40RWIPa40iMsEsB6U=;
        b=GETAiGeXhbtDoA/x+nmC6rbX+it0veOXNeaGuWLgw3Nm/KS5f7cq4pNGkhlPMfhnim
         ypJpFlL+cWRFhc4qyvVtlksXa3YNoePu6+D1FBBg+E2VuEre9CSNVR4KSIlcTB+cSQZg
         fQGWloWCf8/jpvey5H2ZuIPrazUVAWZIlh0PZzZuBdig1hirKKlcE46HmXZDCCaAufjs
         sbtbwFhg0DaDUZTSNg7Dn1Ld24Lb35PXWQY6GF14QTS2a8BXSK7KH4Y4gUhC0sW4C/EY
         2On8OkpH47t77dNKGtEZU6DeDZXRlX3SeXMctKcMDQKqO9CUy3ZE0sPaeylG6yDEvc5B
         qDYg==
X-Forwarded-Encrypted: i=1; AJvYcCXSxIYbk/gpV/VyPrxcSD8eD5kTgUv6o5FIKPdnywhhqBMvHjdf8nY7v6i9sZc1WPINYwLasqEqC3/p@vger.kernel.org
X-Gm-Message-State: AOJu0YxQK/K8ShF8GxItxALON5JRFpPTqx+58VyyqPmg6gQHMx9hmbgL
	l8WPGMfB7Kcwwj7gQjGJvL8pe8zCSCdZN8FtThPsuCiokUuyvQGzpVk5aJGsGg==
X-Google-Smtp-Source: AGHT+IGbD6wqCEPU07zp1VlQIl5l/bCLG6vLLJV+MCZulU1ILwbw1OtdCfW8oWf+Bxk7YL5dc7qdwQ==
X-Received: by 2002:a17:90a:a887:b0:2c9:81a2:e8da with SMTP id 98e67ed59e1d1-2d3e03e8cd8mr10769468a91.35.1724107154768;
        Mon, 19 Aug 2024 15:39:14 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d3eb68d82asm7555063a91.4.2024.08.19.15.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 15:39:14 -0700 (PDT)
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
Subject: [PATCH v3 17/17] platform/chrome: cros_ec_typec: Handle lack of HPD information
Date: Mon, 19 Aug 2024 15:38:31 -0700
Message-ID: <20240819223834.2049862-18-swboyd@chromium.org>
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

Some EC firmwares on Trogdor/Strongbad boards don't properly indicate
the state of DP HPD on a type-c port. Instead, the EC only indicates
that a type-c port has entered or exited DP mode. To make matters worse,
on these boards the DP signal is muxed between two USB type-c
connectors, so we can't use the DP entry of a port to figure out which
type-c port is actually displaying DP.

Stash the HPD state in this case whenever the drm_bridge is notified of
a connector status change and kick off the port worker so that the
type-c port state can be re-evaluated. If an analog mux is in use, read
the mux to figure out which type-c port signaled HPD. Once we know which
port is actually signaling HPD, inject that state into the message
received from the EC. This simplifies the rest of the logic as it can
all stay the same with respect to picking the first port to assert HPD,
etc.

Cc: Prashant Malani <pmalani@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 79 +++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index b32abd14825c..991361abbc31 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
@@ -28,6 +29,8 @@ struct cros_typec_dp_bridge {
 	struct cros_typec_data *typec_data;
 	struct drm_dp_typec_bridge_dev *dev;
 	struct cros_typec_port *active_port;
+	struct gpio_desc *mux_gpio;
+	bool hpd_asserted;
 };
 
 #define DP_PORT_VDO	(DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D)) | \
@@ -429,6 +432,18 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 	return ret;
 }
 
+static void cros_typec_dp_bridge_hpd_notify(void *data, enum drm_connector_status status)
+{
+	struct cros_typec_dp_bridge *dp_bridge = data;
+	struct cros_typec_data *typec = dp_bridge->typec_data;
+
+	/* Proxy the connector status as the HPD state to replay later. */
+	dp_bridge->hpd_asserted = status == connector_status_connected;
+
+	/* Refresh port state. */
+	schedule_work(&typec->port_work);
+}
+
 static int cros_typec_init_dp_bridge(struct cros_typec_data *typec)
 {
 	struct device *dev = typec->dev;
@@ -445,9 +460,19 @@ static int cros_typec_init_dp_bridge(struct cros_typec_data *typec)
 	typec->dp_bridge = dp_bridge;
 	dp_bridge->typec_data = typec;
 
+	dp_bridge->mux_gpio = devm_gpiod_get_optional(dev, "mux", GPIOD_ASIS);
+	if (IS_ERR(dp_bridge->mux_gpio))
+		return dev_err_probe(dev, PTR_ERR(dp_bridge->mux_gpio), "failed to get mux gpio\n");
+
 	dp_dev = devm_drm_dp_typec_bridge_alloc(dev, dev->of_node);
 	if (IS_ERR(dp_dev))
 		return PTR_ERR(dp_dev);
+
+	if (fwnode_property_read_bool(dev_fwnode(dev), "no-hpd")) {
+		drm_dp_typec_bridge_add_hpd_notify(dp_dev, cros_typec_dp_bridge_hpd_notify,
+						   dp_bridge);
+	}
+
 	dp_bridge->dev = dp_dev;
 
 	return devm_drm_dp_typec_bridge_add(dev, dp_dev);
@@ -648,6 +673,59 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
 	return typec_mux_set(port->mux, &port->state);
 }
 
+/* Inject HPD state into the EC's response if EC firmware is broken. */
+static void cros_typec_inject_hpd(struct ec_response_usb_pd_mux_info *resp,
+				  struct cros_typec_port *port,
+				  struct cros_typec_dp_bridge *dp_bridge)
+{
+	struct cros_typec_data *typec = port->typec_data;
+	struct gpio_desc *mux_gpio;
+	int val;
+
+	if (!dp_bridge)
+		return;
+
+	/* Don't need to inject HPD level when DP isn't enabled */
+	if (!(resp->flags & USB_PD_MUX_DP_ENABLED))
+		return;
+
+	/*
+	 * The default setting is HPD deasserted. Ignore if nothing to inject.
+	 */
+	if (!dp_bridge->hpd_asserted)
+		return;
+
+	/*
+	 * Some ECs don't notify AP when HPD goes high or low so we have to
+	 * read the EC GPIO that controls the mux to figure out which type-c
+	 * port is connected to DP by the EC.
+	 */
+	mux_gpio = dp_bridge->mux_gpio;
+	if (!mux_gpio)
+		return;
+
+	/*
+	 * Only read the mux GPIO setting if we need to change the active_port.
+	 * Otherwise, an active_port is already set and HPD going high or low
+	 * doesn't change the muxed port until DP mode is exited.
+	 */
+	if (!dp_bridge->active_port) {
+		val = gpiod_get_value_cansleep(mux_gpio);
+		if (val < 0) {
+			dev_err(typec->dev, "Failed to read mux gpio\n");
+			return;
+		}
+		if (typec->ports[val] != port)
+			return;
+	} else if (port != dp_bridge->active_port) {
+		return;
+	}
+
+	/* Inject HPD from the GPIO state if EC firmware is broken. */
+	if (dp_bridge->hpd_asserted)
+		resp->flags |= USB_PD_MUX_HPD_LVL;
+}
+
 static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 				struct ec_response_usb_pd_control_v2 *pd_ctrl)
 {
@@ -669,6 +747,7 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 			 port_num, ret);
 		return ret;
 	}
+	cros_typec_inject_hpd(&resp, port, dp_bridge);
 
 	/* No change needs to be made, let's exit early. */
 	if (port->mux_flags == resp.flags && port->role == pd_ctrl->role)
-- 
https://chromeos.dev


