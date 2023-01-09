Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993BF662045
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jan 2023 09:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbjAIImA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 9 Jan 2023 03:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbjAIIlT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2023 03:41:19 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1D613F8D
        for <linux-acpi@vger.kernel.org>; Mon,  9 Jan 2023 00:41:16 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o13so4518118pjg.2
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2023 00:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbxRbyImpevpLcgNpmQRY5xjXofgzVP7nhTUY2hiItA=;
        b=JTe1mK8GkkIlmmdn3zdW5Zhz8+tYp6rDTDe7qfwfWgAIPBtzdSsCHsOV1Nbm+8zBsw
         8tI5IoTY+/uiECZQbLoMs4vXnTjvxlQQYuVpVavOAPFMv0OzkqlaOjQjOw4sIM5XuGIu
         Cz+yvra84/M3rWGvLOTPgVyRjkiQE6K+4GO8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbxRbyImpevpLcgNpmQRY5xjXofgzVP7nhTUY2hiItA=;
        b=ny5P8kM0C1s7cu2fFZslq3kubnRbDbG3nwfvn8y7PvKWevuSUVgezGv9xrtSM+2O35
         jTLQ0AsWqsdlGr3Hx+w8sE4oBKc7bqDf3zewmZUUnq4Jpb/ofSpKfBLYjitXmmeFMTBj
         LuNuT7GNRsEaaQQNkyg/9VPhs3+glT5E2ArALbmfnWxl/7o84XTDcgnOO/68KakRn+B3
         fQnkTG8vBvfwnTRCq1o/TpLhnv08SVZVQDA4BZm2aTUzzxbCUh9CLbT9QScyo5z6TIpC
         nN9vcitAn8XxsjXgrhIfAtabBmdQX7Raewvr9QlvuH90nUom/ejHUQgkAgt+31fqkGJQ
         JidA==
X-Gm-Message-State: AFqh2koDw2oQ5mHiY6PMzOFbBOz8j9bgq21AOnP1VL6d/h/rm3ttYzQ3
        5dzCoCCMf2sS1YemdOCK2puLlA==
X-Google-Smtp-Source: AMrXdXuz7m3m2JrRAQuDNVFugi2raUnWnT3EDgHYDhtNliIvVLaFk/uDfqb/xzWYq7EGj/RGX5i+Hg==
X-Received: by 2002:a17:902:7c07:b0:193:bec:2122 with SMTP id x7-20020a1709027c0700b001930bec2122mr10562144pll.32.1673253676037;
        Mon, 09 Jan 2023 00:41:16 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:801:a736:715:9a15])
        by smtp.gmail.com with ESMTPSA id c14-20020a170902d48e00b00186acb14c4asm5568119plg.67.2023.01.09.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:41:15 -0800 (PST)
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
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Stephen Boyd <swboyd@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Xin Ji <xji@analogixsemi.com>, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Allen Chen <allen.chen@ite.com.tw>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/9] device property: Add remote endpoint to devcon matcher
Date:   Mon,  9 Jan 2023 16:40:53 +0800
Message-Id: <20230109084101.265664-2-treapking@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230109084101.265664-1-treapking@chromium.org>
References: <20230109084101.265664-1-treapking@chromium.org>
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

From: Prashant Malani <pmalani@chromium.org>

When searching the device graph for device matches, check the
remote-endpoint itself for a match.

Some drivers register devices for individual endpoints. This allows
the matcher code to evaluate those for a match too, instead
of only looking at the remote parent devices. This is required when a
device supports two mode switches in its endpoints, so we can't simply
register the mode switch with the parent node.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

(no changes since v6)

Changes in v6:
- New in v6

 drivers/base/property.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 2a5a37fcd998..48877af4e444 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1223,6 +1223,21 @@ static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
 			break;
 		}
 
+		/*
+		 * Some drivers may register devices for endpoints. Check
+		 * the remote-endpoints for matches in addition to the remote
+		 * port parent.
+		 */
+		node = fwnode_graph_get_remote_endpoint(ep);
+		if (fwnode_device_is_available(node)) {
+			ret = match(node, con_id, data);
+			if (ret) {
+				if (matches)
+					matches[count] = ret;
+				count++;
+			}
+		}
+
 		node = fwnode_graph_get_remote_port_parent(ep);
 		if (!fwnode_device_is_available(node)) {
 			fwnode_handle_put(node);
-- 
2.39.0.314.g84b9a713c41-goog

