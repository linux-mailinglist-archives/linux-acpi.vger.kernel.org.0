Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A796C482B
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Mar 2023 11:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjCVKtA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Mar 2023 06:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCVKsJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Mar 2023 06:48:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026516287F
        for <linux-acpi@vger.kernel.org>; Wed, 22 Mar 2023 03:47:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so18735005pjb.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Mar 2023 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679482047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4YiSH1IkJ0n1Hd2VWWavtDAOx8Cy0N2XlN60ziReaI=;
        b=HMoxZvWcxSqJHdCMgZLmXJJNIKvGaKv6dXzaLAo1QHugMoIP+unIbrgSH/h1m1qUBn
         /uH4OYpG7wd6VPDpkjPFEaPsm5usYw/9sOvF/3weGpy7UWUw1AlkgB3oqDcnEEL2SOBs
         nZlruRxQzeu7py18C0vst2G4EwuSi3B6eTglo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679482047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4YiSH1IkJ0n1Hd2VWWavtDAOx8Cy0N2XlN60ziReaI=;
        b=I+O4VyWpqdVjNDQrI39Kl8bQrMREosrZjMta9uM3Xw3o7mjnrgzPBD3iPJwPUtGP6a
         7KAgPmrDwCx4bC3xL2aQKlfnoxc4JAVb6g20/mExWbNJARbh5ypknvSxBm4i9YRhE6De
         MFOClFd3KuMZUE8Mtiznsz15rcL0B2kf8EJm0WYEV/1wKWuUqUscz2y63XvVMge8U9pd
         oFYTGx4Tm9fvWTS9lXRdE4NDTyKyudb2S57VW43U7QEWt+0nFBeXeTZm6SpqDFkr+LQ0
         hNBSqmUeTefOegP2eTaaAFPly/tNzWFAHnsbumtF9DYqVcsvoU3qU/WyCxQG/uQnkniB
         H6sw==
X-Gm-Message-State: AAQBX9dZX3s/VPXlzUNK1VN4sE7VriRP/Qb6TtC3lKCtgRCo0MN6ExwL
        Vgwi1BOSsk+H2492bev1YQLBlA==
X-Google-Smtp-Source: AKy350acyt4SddG6fs1i2fjAkJNKgW9ZrwnvAU1NQ7DrkddqYc3Aog+9Vpzqb544hX71L6aQYHg6zg==
X-Received: by 2002:a17:90b:3b90:b0:23d:27fc:8437 with SMTP id pc16-20020a17090b3b9000b0023d27fc8437mr1682775pjb.14.1679482047532;
        Wed, 22 Mar 2023 03:47:27 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:343d:79bf:55f9:1da5])
        by smtp.gmail.com with ESMTPSA id hg4-20020a17090b300400b002340d317f3esm9508742pjb.52.2023.03.22.03.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:47:27 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Xin Ji <xji@analogixsemi.com>, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-acpi@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Pin-yen Lin <treapking@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: [PATCH v14 07/10] drm/bridge: anx7625: Register Type C mode switches
Date:   Wed, 22 Mar 2023 18:46:36 +0800
Message-Id: <20230322104639.221402-8-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230322104639.221402-1-treapking@chromium.org>
References: <20230322104639.221402-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Register USB Type-C mode switches when the "mode-switch" property and
relevant ports are available in Device Tree. Configure the crosspoint
switch based on the entered alternate mode for a specific Type-C
connector.

Crosspoint switch can also be used for switching the output signal for
different orientations of a single USB Type-C connector, but the
orientation switch is not implemented yet. A TODO is added for this.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v14:
- Fix style issues

Changes in v12:
- Fixed style issues in anx7625 driver
- Fixed the inverted orientation setting in anx7625 driver
- Changed "&ctx->client->dev" to "ctx->dev"
- Fix style issues
- Updated the error logs when parsing data-lanes property

Changes in v11:
- Added back "data-lanes" parsing logics
- Removed Kconfig dependency
- Updated the usage of the private data
- Dropped Tested-by tag because of the new changes

Changes in v10:
- Added a TODO for implementing orientation switch for anx7625
- Updated the commit message for the absence of orientation switch
- Fixed typo in the commit message
- Collected Tested-by tag

Changes in v7:
- Fixed style issues in anx7625 driver
- Removed DT property validation in anx7625 driver.
- Extracted common codes to another commit.

Changes in v6:
- Squashed to a single patch

 drivers/gpu/drm/bridge/analogix/anx7625.c | 148 ++++++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/anx7625.h |  20 +++
 2 files changed, 168 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 76d46db3f8dc..9b259c07743f 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -15,6 +15,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
 #include <linux/workqueue.h>
 
 #include <linux/of_gpio.h>
@@ -2570,6 +2572,145 @@ static void anx7625_runtime_disable(void *data)
 	pm_runtime_disable(data);
 }
 
+static void anx7625_set_crosspoint_switch(struct anx7625_data *ctx,
+					  enum typec_orientation orientation)
+{
+	if (orientation == TYPEC_ORIENTATION_NORMAL) {
+		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
+				  SW_SEL1_SSRX_RX1 | SW_SEL1_DPTX0_RX2);
+		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
+				  SW_SEL2_SSTX_TX1 | SW_SEL2_DPTX1_TX2);
+	} else if (orientation == TYPEC_ORIENTATION_REVERSE) {
+		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_0,
+				  SW_SEL1_SSRX_RX2 | SW_SEL1_DPTX0_RX1);
+		anx7625_reg_write(ctx, ctx->i2c.tcpc_client, TCPC_SWITCH_1,
+				  SW_SEL2_SSTX_TX2 | SW_SEL2_DPTX1_TX1);
+	}
+}
+
+static void anx7625_typec_two_ports_update(struct anx7625_data *ctx)
+{
+	unsigned int i;
+
+	/* Check if both ports available and do nothing to retain the current one */
+	if (ctx->port_data[0].dp_connected && ctx->port_data[1].dp_connected)
+		return;
+
+	for (i = 0; i < 2; i++) {
+		if (ctx->port_data[i].dp_connected)
+			anx7625_set_crosspoint_switch(ctx,
+						      ctx->port_data[i].orientation);
+	}
+}
+
+static int anx7625_typec_mux_set(struct typec_mux_dev *mux,
+				 struct typec_mux_state *state)
+{
+	struct drm_dp_typec_port_data *port = typec_mux_get_drvdata(mux);
+	struct anx7625_data *ctx = port->data;
+	struct device *dev = ctx->dev;
+	struct drm_dp_typec_switch_desc switch_desc = ctx->switch_desc;
+	bool new_dp_connected, old_dp_connected;
+
+	if (switch_desc.num_typec_switches == 1)
+		return 0;
+
+	wait_for_completion(&ctx->mux_register);
+
+	old_dp_connected = ctx->port_data[0].dp_connected ||
+			   ctx->port_data[1].dp_connected;
+
+	ctx->port_data[port->port_num].dp_connected =
+		state->alt &&
+		state->alt->svid == USB_TYPEC_DP_SID &&
+		state->alt->mode == USB_TYPEC_DP_MODE;
+
+	dev_dbg(dev, "mux_set dp_connected: c0=%d, c1=%d\n",
+		ctx->port_data[0].dp_connected, ctx->port_data[1].dp_connected);
+
+	new_dp_connected = ctx->port_data[0].dp_connected ||
+			   ctx->port_data[1].dp_connected;
+
+	/* DP on, power on first */
+	if (!old_dp_connected && new_dp_connected)
+		pm_runtime_get_sync(dev);
+
+	anx7625_typec_two_ports_update(ctx);
+
+	/* DP off, power off last */
+	if (old_dp_connected && !new_dp_connected)
+		pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+static void anx7625_unregister_typec_switches(struct anx7625_data *ctx)
+{
+	drm_dp_unregister_typec_switches(&ctx->switch_desc);
+}
+
+static int anx7625_register_typec_switches(struct device *dev, struct anx7625_data *ctx)
+{
+	struct device_node *port_node = of_graph_get_port_by_id(dev->of_node, 1);
+	struct drm_dp_typec_switch_desc *switch_desc = &ctx->switch_desc;
+	int ret;
+	u32 dp_lanes[4];
+	unsigned int i, num_lanes;
+
+	/*
+	 * Currently, only mode switch is implemented.
+	 * TODO: Implement Type-C orientation switch for anx7625.
+	 */
+	ret = drm_dp_register_typec_switches(dev, &port_node->fwnode,
+					     &ctx->switch_desc, ctx,
+					     anx7625_typec_mux_set);
+	if (ret)
+		return ret;
+
+	ctx->port_data = devm_kcalloc(dev, switch_desc->num_typec_switches,
+				      sizeof(struct anx7625_typec_port_data),
+				      GFP_KERNEL);
+	if (!ctx->port_data) {
+		ret = -ENOMEM;
+		goto unregister_mux;
+	}
+
+	for (i = 0; i < switch_desc->num_typec_switches; i++) {
+		struct drm_dp_typec_port_data *port = &switch_desc->typec_ports[i];
+		struct fwnode_handle *fwnode = port->fwnode;
+
+		ret = fwnode_property_count_u32(fwnode, "data-lanes");
+		if (ret < 0) {
+			dev_err(dev,
+				"Error on getting data lanes count from %pfwP: %d\n",
+				fwnode, ret);
+			goto unregister_mux;
+		}
+		num_lanes = ret;
+
+		ret = fwnode_property_read_u32_array(fwnode, "data-lanes",
+						     dp_lanes, num_lanes);
+		if (ret) {
+			dev_err(dev,
+				"Failed to read the data-lanes variable: %d\n",
+				ret);
+			goto unregister_mux;
+		}
+
+		ctx->port_data[i].orientation = dp_lanes[0] < 2 ?
+			TYPEC_ORIENTATION_REVERSE : TYPEC_ORIENTATION_NORMAL;
+		ctx->port_data[i].dp_connected = false;
+	}
+	complete_all(&ctx->mux_register);
+
+	return 0;
+
+unregister_mux:
+	complete_all(&ctx->mux_register);
+	anx7625_unregister_typec_switches(ctx);
+	return ret;
+}
+
 static int anx7625_i2c_probe(struct i2c_client *client)
 {
 	struct anx7625_data *platform;
@@ -2607,6 +2748,7 @@ static int anx7625_i2c_probe(struct i2c_client *client)
 
 	mutex_init(&platform->lock);
 	mutex_init(&platform->hdcp_wq_lock);
+	init_completion(&platform->mux_register);
 
 	INIT_DELAYED_WORK(&platform->hdcp_work, hdcp_check_work_func);
 	platform->hdcp_workqueue = create_workqueue("hdcp workqueue");
@@ -2677,6 +2819,10 @@ static int anx7625_i2c_probe(struct i2c_client *client)
 	if (platform->pdata.intp_irq)
 		queue_work(platform->workqueue, &platform->work);
 
+	ret = anx7625_register_typec_switches(dev, platform);
+	if (ret && ret != -ENODEV)
+		dev_warn(dev, "Didn't register Type-C switches, err: %d\n", ret);
+
 	platform->bridge.funcs = &anx7625_bridge_funcs;
 	platform->bridge.of_node = client->dev.of_node;
 	if (!anx7625_of_panel_on_aux_bus(&client->dev))
@@ -2728,6 +2874,8 @@ static void anx7625_i2c_remove(struct i2c_client *client)
 
 	drm_bridge_remove(&platform->bridge);
 
+	anx7625_unregister_typec_switches(platform);
+
 	if (platform->pdata.intp_irq)
 		destroy_workqueue(platform->workqueue);
 
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index 5af819611ebc..5a200da34800 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -55,6 +55,18 @@
 #define HPD_STATUS_CHANGE 0x80
 #define HPD_STATUS 0x80
 
+#define TCPC_SWITCH_0 0xB4
+#define SW_SEL1_DPTX0_RX2 BIT(0)
+#define SW_SEL1_DPTX0_RX1 BIT(1)
+#define SW_SEL1_SSRX_RX2 BIT(4)
+#define SW_SEL1_SSRX_RX1 BIT(5)
+
+#define TCPC_SWITCH_1 0xB5
+#define SW_SEL2_DPTX1_TX2 BIT(0)
+#define SW_SEL2_DPTX1_TX1 BIT(1)
+#define SW_SEL2_SSTX_TX2 BIT(4)
+#define SW_SEL2_SSTX_TX1 BIT(5)
+
 /******** END of I2C Address 0x58 ********/
 
 /***************************************************************/
@@ -449,6 +461,11 @@ struct anx7625_i2c_client {
 	struct i2c_client *tcpc_client;
 };
 
+struct anx7625_typec_port_data {
+	bool dp_connected;
+	enum typec_orientation orientation;
+};
+
 struct anx7625_data {
 	struct anx7625_platform_data pdata;
 	struct platform_device *audio_pdev;
@@ -479,6 +496,9 @@ struct anx7625_data {
 	struct drm_connector *connector;
 	struct mipi_dsi_device *dsi;
 	struct drm_dp_aux aux;
+	struct completion mux_register;
+	struct drm_dp_typec_switch_desc switch_desc;
+	struct anx7625_typec_port_data *port_data;
 };
 
 #endif  /* __ANX7625_H__ */
-- 
2.40.0.rc1.284.g88254d51c5-goog

