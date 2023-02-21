Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D041869DD4F
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Feb 2023 10:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjBUJwI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Feb 2023 04:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjBUJwF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Feb 2023 04:52:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDE625E28
        for <linux-acpi@vger.kernel.org>; Tue, 21 Feb 2023 01:51:46 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id i1-20020a17090ad34100b00234463de251so4143591pjx.3
        for <linux-acpi@vger.kernel.org>; Tue, 21 Feb 2023 01:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG6QSJbypzUGB5xaZ21VNAzG0yHFxcV/96+5oqf9BzQ=;
        b=KuyVVTOClmKqZW8WOr08nnolQpZRXrV9mpvaydXdCafjx1XTd8QTNHjiB6gl3bvV25
         QWfK8U/aSXWzvNTZptHA30lkxH1wnE0LxABcxEY5W4WJu6VRbDTmZeJKsL4ONKDDtqhp
         q0gLLqrqiv/v6yV2v9NMuou9AOS9KoGQEq8ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG6QSJbypzUGB5xaZ21VNAzG0yHFxcV/96+5oqf9BzQ=;
        b=g41S1a4/C/VJ8B1G7PhQJM3HF6b/MYMjl/Xyp5/zTK0Pe2t6PEpIQyfyty6qItNem3
         CBLLzxWkbqCrwGs9EeolfxNBtEpLLPhIv5Fu0LiT14k6naDYW6RO3pzz+rhxWCY+zSs0
         4bGZhONMQf/x+GEZXXCvCfMVVvB3bXBRgyUn7Umhna1OAeNmSEfMqymCF+X8Ue5Qcdq7
         UOY19pU5KAQhb6oF+u6M9fm2NwhJGDOE6gpwr48QEwfH1bF8MqpielIznNOJvWjqoJeV
         d7lKbm6Nw/d2KjBzGU9pVA9bp8JFvGNqg/szQyd9L6V3kpSdfy6n1F+15epA5rqSSL06
         GW1Q==
X-Gm-Message-State: AO0yUKU5t8i5GhFACYFdbs6WZBALenjNmKBodgM7N57ARFPa37rckfqZ
        W+3vOA/Y4+aHmlNgrAH3afJBJg==
X-Google-Smtp-Source: AK7set83merWWBZBGuzCzPIekx2EVTUiErZDikE4N3fOkXMpulNW3ufMoGkyxAWm4YPtCanMcw6blA==
X-Received: by 2002:a05:6a20:914a:b0:be:d368:5c7f with SMTP id x10-20020a056a20914a00b000bed3685c7fmr15892164pzc.41.1676973105963;
        Tue, 21 Feb 2023 01:51:45 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:a1f5:f58d:584e:5906])
        by smtp.gmail.com with ESMTPSA id t25-20020a656099000000b004eca54eab50sm3524918pgu.28.2023.02.21.01.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 01:51:45 -0800 (PST)
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
Cc:     Pin-yen Lin <treapking@chromium.org>, linux-kernel@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Marek Vasut <marex@denx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Xin Ji <xji@analogixsemi.com>,
        Lyude Paul <lyude@redhat.com>,
        Allen Chen <allen.chen@ite.com.tw>, devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, chrome-platform@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-acpi@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v12 05/10] drm/bridge: anx7625: Check for Type-C during panel registration
Date:   Tue, 21 Feb 2023 17:50:49 +0800
Message-Id: <20230221095054.1868277-6-treapking@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230221095054.1868277-1-treapking@chromium.org>
References: <20230221095054.1868277-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The output port endpoints can be connected to USB-C connectors.
Running drm_of_find_panel_or_bridge() with such endpoints leads to
a continuous return value of -EPROBE_DEFER, even though there is
no panel present.

To avoid this, check for the existence of a "mode-switch" property in
the port endpoint, and skip panel registration completely if so.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v12:
- Updated to use fwnode_for_each_typec_mode_switch macro
- Dropped collected tags

Changes in v10:
- Collected Reviewed-by and Tested-by tags

Changes in v6:
- New in v6

 drivers/gpu/drm/bridge/analogix/anx7625.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 6846199a2ee1..486b5099f5dd 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1648,7 +1648,8 @@ static int anx7625_get_swing_setting(struct device *dev,
 static int anx7625_parse_dt(struct device *dev,
 			    struct anx7625_platform_data *pdata)
 {
-	struct device_node *np = dev->of_node, *ep0;
+	struct device_node *np = dev->of_node, *ep0, *port_node;
+	struct fwnode_handle *fwnode;
 	int bus_type, mipi_lanes;
 
 	anx7625_get_swing_setting(dev, pdata);
@@ -1687,6 +1688,16 @@ static int anx7625_parse_dt(struct device *dev,
 	if (of_property_read_bool(np, "analogix,audio-enable"))
 		pdata->audio_en = 1;
 
+	/*
+	 * Don't bother finding a panel if a Type-C `mode-switch` property is
+	 * present in one of the endpoints in the output port.
+	 */
+	port_node = of_graph_get_port_by_id(np, 1);
+	fwnode_for_each_typec_mode_switch(&port_node->fwnode, fwnode) {
+		fwnode_handle_put(fwnode);
+		return 0;
+	}
+
 	pdata->panel_bridge = devm_drm_of_get_bridge(dev, np, 1, 0);
 	if (IS_ERR(pdata->panel_bridge)) {
 		if (PTR_ERR(pdata->panel_bridge) == -ENODEV) {
-- 
2.39.2.637.g21b0678d19-goog

