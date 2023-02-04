Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433BE68AA1E
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Feb 2023 14:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjBDNcH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Feb 2023 08:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjBDNb5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Feb 2023 08:31:57 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C3D37F22
        for <linux-acpi@vger.kernel.org>; Sat,  4 Feb 2023 05:31:23 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t17so5570972pfj.0
        for <linux-acpi@vger.kernel.org>; Sat, 04 Feb 2023 05:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/UCw5L3OryAN31Ax/yQTRwKEsI+8ZNGFWTdAJWTPHk=;
        b=acq2I2gv0MOoVf8w+0Oe1TN4/8R+sumEPcQ6iYP0qcCf2/4jbAOPJlGybmhXsWIbVE
         IvEU8qRF9vPM0ob7Fg88nYCmq6KHNzgrEyEH1wuVtutC5AngwNb+ymGmjhIX2fap3KsZ
         30s6vnrQCWEliiYbOXFcyKkAK2LJMWrd2XjZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/UCw5L3OryAN31Ax/yQTRwKEsI+8ZNGFWTdAJWTPHk=;
        b=jR3BomfY+1YLaro5VXlcNUjyRBxYfMLHYPxZXm3zHa0Y4t+mSrHRmPA+43ePmdR0x8
         GjA9bpS7e96//VIcV4b08aqaAgRQQm+vpenDHeldzvPhh0jnOvYMY2VLDJva2vp0b2HZ
         JgHyyfLWjlqmQLYwMSUXvzj5JhmyqS4WAv8hmcOuS0oiypHqE32TLu/7xeAj3wLnQ/zX
         FYhPWauil2zG3rdb6VDVk/2YTMddZh4AJyhYB+5zCRCe1hY+IeFrSlMdllJQuXYLC2fM
         Ao+7ZKglv1qRGWWvMXzxHDxfaklZ4GX4eHQSdj/TanHIeESMpaAyh6f4Kup/FF7N4czv
         Z2ug==
X-Gm-Message-State: AO0yUKWF2848d6cDLKN3BHy0fCnjjIzz/UzvQdKTwBsP02S4nW41Vmxp
        SrmeM8N7ovbSPYHuLZ2ayJBNBQ==
X-Google-Smtp-Source: AK7set/kZtf8evW6ntULSPU2ZzT8kpFpt4gOXTjkd4Huews3RL5fh5Duq9H7uxMx2P9UV0B67sTGQg==
X-Received: by 2002:aa7:8b1a:0:b0:58d:e33b:d565 with SMTP id f26-20020aa78b1a000000b0058de33bd565mr11193220pfd.5.1675517482695;
        Sat, 04 Feb 2023 05:31:22 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:c1ad:2bdc:7b5a:72e3])
        by smtp.gmail.com with ESMTPSA id 144-20020a621596000000b00593ce7ebbaasm3655639pfv.184.2023.02.04.05.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 05:31:22 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
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
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
        devicetree@vger.kernel.org, Pin-yen Lin <treapking@chromium.org>,
        Allen Chen <allen.chen@ite.com.tw>,
        Lyude Paul <lyude@redhat.com>, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Xin Ji <xji@analogixsemi.com>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        chrome-platform@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v11 5/9] drm/bridge: anx7625: Check for Type-C during panel registration
Date:   Sat,  4 Feb 2023 21:30:36 +0800
Message-Id: <20230204133040.1236799-6-treapking@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230204133040.1236799-1-treapking@chromium.org>
References: <20230204133040.1236799-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

(no changes since v10)

Changes in v10:
- Collected Reviewed-by and Tested-by tags

Changes in v6:
- New in v6

 drivers/gpu/drm/bridge/analogix/anx7625.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index b375887e655d..1cf242130b91 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1649,7 +1649,7 @@ static int anx7625_get_swing_setting(struct device *dev,
 static int anx7625_parse_dt(struct device *dev,
 			    struct anx7625_platform_data *pdata)
 {
-	struct device_node *np = dev->of_node, *ep0;
+	struct device_node *np = dev->of_node, *ep0, *sw;
 	int bus_type, mipi_lanes;
 
 	anx7625_get_swing_setting(dev, pdata);
@@ -1688,6 +1688,17 @@ static int anx7625_parse_dt(struct device *dev,
 	if (of_property_read_bool(np, "analogix,audio-enable"))
 		pdata->audio_en = 1;
 
+	/*
+	 * Don't bother finding a panel if a Type-C `mode-switch` property is
+	 * present in one of the endpoints.
+	 */
+	for_each_endpoint_of_node(np, sw) {
+		if (of_property_read_bool(sw, "mode-switch")) {
+			of_node_put(sw);
+			return 0;
+		}
+	}
+
 	pdata->panel_bridge = devm_drm_of_get_bridge(dev, np, 1, 0);
 	if (IS_ERR(pdata->panel_bridge)) {
 		if (PTR_ERR(pdata->panel_bridge) == -ENODEV) {
-- 
2.39.1.519.gcb327c4b5f-goog

